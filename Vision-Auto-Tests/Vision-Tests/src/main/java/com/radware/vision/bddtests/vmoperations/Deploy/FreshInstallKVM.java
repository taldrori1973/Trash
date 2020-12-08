package com.radware.vision.bddtests.vmoperations.Deploy;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.vision_handlers.NewVmHandler;

import static com.radware.vision.bddtests.vmoperations.VMOperationsSteps.getVisionSetupAttributeFromSUT;

public class FreshInstallKVM extends Deploy {
    public FreshInstallKVM(boolean isExtended, String build) {
        super(isExtended, build, WebUITestBase.getVisionRestClient().getDeviceIp());
        this.isAPM = getVisionSetupAttributeFromSUT("isAPM") != null && Boolean.parseBoolean(getVisionSetupAttributeFromSUT("isAPM"));
        buildFileInfo(FileType.ISO_SERIAL);
    }

    public void deploy() {
        NewVmHandler vmHandler = new NewVmHandler();
        try {
            vmHandler.firstTimeWizardKVM(isAPM, version, build, buildFileInfo.getDownloadUri().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}