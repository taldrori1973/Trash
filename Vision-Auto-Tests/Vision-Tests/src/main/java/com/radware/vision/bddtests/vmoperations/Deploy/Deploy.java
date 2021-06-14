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

import java.util.HashMap;
import java.util.Map;

import static com.radware.vision.bddtests.vmoperations.VMOperationsSteps.readVisionVersionFromPomFile;

@Getter
public abstract class Deploy {
    boolean isExtended;
    String build;
    String version;
    String featureBranch;
    String repositoryName;
    JFrogFileModel buildFileInfo;
    public boolean isSetupNeeded;
    private String ipaddress;
    private static final Map<String, String> Respository_types = new HashMap<String, String>() {{
        put("Snapshot", "vision-snapshot-local");
        put("Release", "vision-release-local");
    }};

    public Deploy(boolean isExtended, String build, String ipaddress) {
        this.isExtended = isExtended;
        this.build = build;
        this.version = readVisionVersionFromPomFile();
//        this.featureBranch = "4.81.00";
        this.featureBranch = BaseTestUtils.getRuntimeProperty("PRDCT_BRANCH", "master"); // default branch master
        this.repositoryName =Respository_types.get(BaseTestUtils.getRuntimeProperty("BuildType", "Snapshot"));
//        this.repositoryName = "vision-release-local";
        this.ipaddress = ipaddress;
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
            VisionInfo visionInfo = new VisionInfo(this.ipaddress);
            String currentBuild = visionInfo.getVisionBuild();
            String currentVersion = visionInfo.getVisionVersion();
            String currentFeatureBranch = visionInfo.getVisionBranch();

            //Version compare need to take under consideration hot fixes, such as 4.80.xx.
            // there is a corner case if same build will appear on both 4.80.00 and 4.80.xx
            String cutCurrentVersion = currentVersion.substring(0, currentVersion.lastIndexOf('.'));
            String cutNeededVersion = version.substring(0, version.lastIndexOf('.'));

            isSetupNeeded = !cutCurrentVersion.equals(cutNeededVersion) ||
                    !currentBuild.equals(this.build) ||
                    !currentFeatureBranch.equals(this.featureBranch.toLowerCase());
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
