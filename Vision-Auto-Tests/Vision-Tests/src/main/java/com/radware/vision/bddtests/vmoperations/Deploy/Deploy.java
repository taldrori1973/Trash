package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.utils.AutoDBUtils;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.visionsettings.VisionInfo;
import com.radware.vision.bddtests.vmoperations.VMOperationsSteps;
import com.radware.vision.thirdPartyAPIs.jFrog.JFrogAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.RepositoryService;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.models.JFrogFileModel;
import lombok.Getter;

import java.util.HashMap;
import java.util.Map;
import java.util.StringJoiner;

import static com.radware.vision.automation.base.TestBase.connectOnInit;
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
    private final String ipaddress;
    protected FileType type;
    private static final Map<String, String> Repository_types = new HashMap<String, String>() {{
        put("Snapshot", "kvision-images-snapshot-local");
        put("Release", "kvision-images-release-local");
    }};

    public Deploy(String ipaddress) {
        this.version = readVisionVersionFromPomFile();
        setBranch();
        setRepository();
        this.ipaddress = ipaddress;
        isSetupNeeded();
    }

    public Deploy(String ipaddress, FileType type) {
        this.version = readVisionVersionFromPomFile();
        this.type = type;
        setBranch();
        setRepository();
        this.ipaddress = ipaddress;
        isSetupNeeded();
    }

    abstract public void deploy();

    public void afterDeploy(){
        VMOperationsSteps.updateVersionVar();
    }

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
        RepositoryService repositoryService;
        try {
            repositoryService = new RepositoryService(this.repositoryName);
            this.build = String.valueOf(BaseTestUtils.getRuntimeProperty("BUILD", null)); //get build from user
            if (build == null || build.equals("") || build.equals("0") || build.equals("null")) {
                BaseTestUtils.report("No build was supplied. Going for latest", Reporter.PASS_NOR_FAIL);
                this.build = String.valueOf(repositoryService.getLastExtendedDeployNumberFromBranch(this.featureBranch, type.toString()));
            }
            if (build.equals(""))
                isExtended = true;
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public void isSetupNeeded() {
        String currentBuild = "NA";
        String currentVersion = "NA";
        String currentFeatureBranch ="NA";

        try {
            if (!TestBase.connectOnInit()) {
                BaseTestUtils.report("Server is fresh deployed setup is needed", Reporter.PASS_NOR_FAIL);
                isSetupNeeded = true;
            }


            updateIsExtended();
            if (connectOnInit()) {
                VisionInfo visionInfo = new VisionInfo(this.ipaddress);
                currentBuild = visionInfo.getVisionBuild();
                currentVersion = visionInfo.getVisionVersion();
                currentFeatureBranch = visionInfo.getVisionBranch();
                //Version compare need to take under consideration hot fixes, such as 4.80.xx.
                // there is a corner case if same build will appear on both 4.80.00 and 4.80.xx
                String cutCurrentVersion = currentVersion.substring(0, currentVersion.lastIndexOf('.'));
                String cutNeededVersion = version.substring(0, version.lastIndexOf('.'));
                isSetupNeeded = !cutCurrentVersion.equals(cutNeededVersion) ||
                        !currentBuild.equals(this.build) ||
                        !currentFeatureBranch.equals(this.featureBranch.toLowerCase());
            }

           if (isSetupNeeded) {
                StringJoiner deployInfo = new StringJoiner("\n");
                deployInfo.add("Current Build: " + currentBuild);
                deployInfo.add("Current Version: " + currentVersion);
                deployInfo.add("Current Feature Branch: " + currentFeatureBranch);
                deployInfo.add("Needed Build: " + this.build);
                deployInfo.add("Needed Version: " + this.version);
                deployInfo.add("Needed Feature Branch: " + this.featureBranch);
                BaseTestUtils.report(deployInfo.toString(), Reporter.PASS_NOR_FAIL);
            }
            //Lock the build
            AutoDBUtils.updateTaskBuild(this.build);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void setBranch() {
        //        this.featureBranch = "4.81.00";
        this.featureBranch = BaseTestUtils.getRuntimeProperty("PRDCT_BRANCH", "dev"); // default branch master
    }

    private void setRepository() {
        this.repositoryName = Repository_types.get(BaseTestUtils.getRuntimeProperty("BuildType", "Snapshot"));
//        this.repositoryName = "vision-release-local";
    }
}
