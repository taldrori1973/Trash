package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.utils.AutoDBUtils;
import com.radware.vision.bddtests.visionsettings.VisionInfo;
import com.radware.vision.thirdPartyAPIs.jFrog.JFrogAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.RepositoryService;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.models.JFrogFileModel;
import lombok.Getter;

import static com.radware.vision.bddtests.vmoperations.VMOperationsSteps.readVisionVersionFromPomFile;

@Getter
public abstract class Deploy {
    boolean isExtended;
    boolean isAPM;
    String build;
    String version;
    String featureBranch;
    String repositoryName;
    JFrogFileModel buildFileInfo;
    public boolean isSetupNeeded;

    public Deploy(boolean isExtended, String build) {
        this.isExtended = isExtended;
        this.build = build;
        this.version = readVisionVersionFromPomFile();
        this.featureBranch = "master";
//        this.featureBranch = BaseTestUtils.getRuntimeProperty("BRANCH","master");
        this.repositoryName = "vision-snapshot-local";
        isSetupNeeded();
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
            BaseTestUtils.report("Artifactory: Failed to get build file info:\n" + e.getMessage(), Reporter.FAIL);
            e.printStackTrace();
        }
    }

    public void updateIsExtended() {
        if (this.build == null || build.equals("")) isExtended = true;
    }

    public void isSetupNeeded() {
        try {
            RepositoryService repositoryService = new RepositoryService(this.repositoryName);
            String build = BaseTestUtils.getRuntimeProperty("BUILD", null); //get build from portal
            if (build == null || build.equals("") || build.equals("0")) {
                BaseTestUtils.report("No build was supplied. Going for latest", Reporter.PASS);
                this.build = String.valueOf(repositoryService.getLastExtendedBuildNumberFromBranch(this.featureBranch));
                isExtended = true;
            } else {
                this.build = build;
                this.isExtended = false;
            }

            String currentBuild = VisionInfo.getVisionBuild();
            String currentVersion = VisionInfo.getVisionVersion();
            String currentFeatureBranch = VisionInfo.getVisionBranch();
            isSetupNeeded = !currentVersion.equals(version) || !currentBuild.equals(this.build) || !currentFeatureBranch.equals(this.featureBranch);
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
