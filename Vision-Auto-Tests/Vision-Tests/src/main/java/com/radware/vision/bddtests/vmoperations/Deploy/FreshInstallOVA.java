package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.sutsystemobjects.VisionVMs;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.bddtests.vmoperations.VMOperationsSteps;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.vision_handlers.NewVmHandler;

import java.util.Arrays;

import static com.radware.vision.bddtests.vmoperations.VMOperationsSteps.getVisionSetupAttributeFromSUT;

public class FreshInstallOVA extends Deploy {
    private FileType ovaType;

    public FreshInstallOVA(boolean isExtended, String build) {
        super(isExtended, build, WebUITestBase.getVisionRestClient().getDeviceIp());
        this.initFileType();
        buildFileInfo(this.ovaType);
    }


    /**
     * initialize the right FileType according to SUT for deploy.
     */
    private void initFileType() {
        String ovaType = getVisionSetupAttributeFromSUT("serverType");
        // if there is no attribute name fileType in SUT -- the default is ova
        if (ovaType == null) {
            this.ovaType = FileType.OVA;
            return;
        }
        switch (ovaType.toLowerCase().trim()) {
            case "ova":
            case "":
                this.ovaType = FileType.OVA;
                break;
            case "apm":
                this.ovaType = FileType.OVA_APM;
                break;
            case "highscale":
                this.ovaType = FileType.OVA_HIGHSCALE;
                break;
            default:
                this.ovaType = FileType.OVA;
                BaseTestUtils.report(ovaType + " is invalid for fresh install ova. Suppose to be ova | apm | highscale. Installing with fileType ova", Reporter.PASS_NOR_FAIL);
        }
    }

    public FileType getOvaType() {
        return ovaType;
    }

    @Override
    public void deploy() {
        VisionVMs visionVMs = WebUITestBase.getRestTestBase().getVisionVMs();
        // init firstTimeWizardOva parameters
        String vmName = getVisionSetupAttributeFromSUT("vmPrefix");
        if (vmName == null) {
            BaseTestUtils.report("Can't find \"vmPrefix\" at SUT File", Reporter.FAIL);
        }
        boolean isAPM = this.ovaType.isContained("APM");
        String vCenterUser = visionVMs.getUserName();
        String vCenterPassword = visionVMs.getPassword();
        String vCenterURL = visionVMs.getvCenterURL();
        String hostIp = visionVMs.getvCenterIP();
        String networkName = visionVMs.getNetworkName();
        String resourcePool = visionVMs.getResourcePool();
        String dataStores = visionVMs.getDataStores();
        NewVmHandler vmHandler = new NewVmHandler();
        try {
            vmHandler.firstTimeWizardOva(super.getBuildFileInfo().getDownloadUri().toString(), isAPM, vCenterURL, vCenterUser, vCenterPassword, hostIp,
                    super.getBuild(), vmName, null, networkName, resourcePool, null, dataStores);
        } catch (Exception e) {
            BaseTestUtils.report("Setup Failed changing server to OFFLINE", Reporter.FAIL);
            BaseTestUtils.report("Failed to Create NewVm: " + vmName + " failed with the following error: \n" +
                    "Message: " + e.getMessage() + "\n" +
                    "Cause: " + e.getCause() + "\n" +
                    "Stack Trace: " + Arrays.asList(e.getStackTrace()), Reporter.FAIL);
        }
    }
}
