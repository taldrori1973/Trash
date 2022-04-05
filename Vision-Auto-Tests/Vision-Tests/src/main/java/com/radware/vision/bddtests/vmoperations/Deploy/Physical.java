package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.Deploy.NewVmHandler;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.bddtests.rest.BasicRestOperationsSteps;
import com.radware.vision.thirdPartyAPIs.jFrog.JFrogAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.models.JFrogFileModel;

public class Physical extends Deploy {
    JFrogFileModel buildFileInfoISO;
    JFrogFileModel buildFileInfoTar;

    public Physical(boolean isExtended, String build) {
        super(isExtended, build, TestBase.restTestBase.getVisionRestClient().getDeviceIp());
        buildFileInfo();
    }

    @Override
    public void deploy() {
        //todo: isAPM relevant?
        try {
            String[] path = buildFileInfoTar.getPath().toString().split("/");
            NewVmHandler newVmHandler = new NewVmHandler();
//            TODO Kvision
//            newVmHandler.firstTimeWizardIso(version, build, buildFileInfoISO.getDownloadUri().getPath(), buildFileInfoTar.getDownloadUri().toString(), path[path.length - 1]);
            BasicRestOperationsSteps basicRestOperationsSteps = new BasicRestOperationsSteps();
            basicRestOperationsSteps.loginWithActivation("radware", "radware");
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            e.printStackTrace();
        }
    }

    public void buildFileInfo() {
        try {
            if (isExtended) {
                buildFileInfoISO = JFrogAPI.getLastExtendedBuildFromFeatureBranch(FileType.ISO_USB, repositoryName, featureBranch);
                buildFileInfoTar = JFrogAPI.getLastExtendedBuildFromFeatureBranch(FileType.ODSVL2, repositoryName, featureBranch);
            } else {
                buildFileInfoISO = JFrogAPI.getBuild(FileType.ISO_SERIAL, Integer.parseInt(this.build), repositoryName, featureBranch);
                buildFileInfoTar = JFrogAPI.getBuild(FileType.ODSVL2, Integer.parseInt(this.build), repositoryName, featureBranch);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Artifactory: Failed to get build file info:\n" + e.getMessage(), Reporter.FAIL);
            e.printStackTrace();
        }
    }
}
