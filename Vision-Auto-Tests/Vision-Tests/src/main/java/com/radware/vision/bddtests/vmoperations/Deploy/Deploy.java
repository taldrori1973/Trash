package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.utils.AutoDBUtils;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.enums.VisionDeployType;
import com.radware.vision.thirdPartyAPIs.jFrog.JFrogAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.RepositoryService;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.models.JFrogFileModel;
import com.radware.vision.vision_handlers.system.upgrade.visionserver.VisionDeployment;
import cucumber.runtime.junit.FeatureRunner;
import lombok.Data;
import lombok.Getter;

import java.io.IOException;

import static com.radware.vision.bddtests.vmoperations.VMOperationsSteps.getVisionSetupAttributeFromSUT;
import static com.radware.vision.bddtests.vmoperations.VMOperationsSteps.readVisionVersionFromPomFile;

@Getter
public abstract class Deploy {
    //    FileType type;
    boolean isExtended;
    boolean isAPM;
    String build;
    String version;
    String featureBranch;
    String repositoryName;
    JFrogFileModel buildFileInfo;
    public boolean isSetupNeeded;

    public Deploy(boolean isExtended, boolean isAPM, String build, String version, String featureBranch, String repositoryName) {
//        this.type = type;
        this.isExtended = isExtended;
        this.build = build;
        this.version = readVisionVersionFromPomFile();
        this.featureBranch = featureBranch;
        this.repositoryName = repositoryName;
        this.isAPM = getVisionSetupAttributeFromSUT("isAPM") != null && Boolean.parseBoolean(getVisionSetupAttributeFromSUT("isAPM"));
        isSetupneeded();
        updateIsExtended();
    }

    abstract public void deploy();

    public void buildFileInfo(FileType type) {
        try {
            if (isExtended) {
                buildFileInfo = JFrogAPI.getLastExtendedBuildFromFeatureBranch(type, repositoryName, featureBranch);
            } else {
                buildFileInfo = JFrogAPI.getBuild(type, Integer.parseInt(this.build), repositoryName, featureBranch);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get build file info", Reporter.FAIL);
            e.printStackTrace();
        }
    }

    public void updateIsExtended() {
        if (this.build == null || build == "") isExtended = true;
    }

    public void isSetupneeded() {
        try {
            RepositoryService repositoryService = new RepositoryService(this.repositoryName);
            String build = BaseTestUtils.getRuntimeProperty("BUILD", null); //get build from portal
            if (build == null || build.equals("") || build.equals("0")) {
                BaseTestUtils.report("No build was supplied. Going for latest", Reporter.PASS);
                this.build = String.valueOf(repositoryService.getLastExtendedBuildNumberFromBranch(this.featureBranch));
//                isExtended = true;
            } else {
                this.build = build;
            }
            String currentBuild = FeatureRunner.getBuild();
            String currentVersion = FeatureRunner.getVersion();
            String currentFeatureBranch = "xxx";  ///////////////// should be handled
            isSetupNeeded = !currentVersion.equals(version) || !currentBuild.equals(build) || !currentFeatureBranch.equals(this.featureBranch);
            if (isSetupNeeded) {
                BaseTestUtils.report("Current Build: " + currentBuild, Reporter.PASS);
                BaseTestUtils.report("Current Version: " + currentVersion, Reporter.PASS);
                BaseTestUtils.report("Current Feature Branch: " + currentFeatureBranch, Reporter.PASS);
                BaseTestUtils.report("Needed Build: " + this.build, Reporter.PASS);
                BaseTestUtils.report("Needed Version: " + this.version, Reporter.PASS);
                BaseTestUtils.report("Needed Feature Branch: " + this.featureBranch, Reporter.PASS);
            }
            //Lock the build
            AutoDBUtils.updateTaskBuild(this.build);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


}
