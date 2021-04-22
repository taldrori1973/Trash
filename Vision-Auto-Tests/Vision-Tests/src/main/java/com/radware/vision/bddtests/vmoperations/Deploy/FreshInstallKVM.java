package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.vision.automation.AutoUtils.vision_handlers.NewVmHandler;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
//import com.radware.vision.vision_handlers.NewVmHandler;

import static com.radware.vision.bddtests.vmoperations.VMOperationsSteps.getVisionSetupAttributeFromSUT;

public class FreshInstallKVM extends Deploy {
    private boolean isAPM;

    public FreshInstallKVM(boolean isExtended, String build) {
        super(isExtended, build, VisionUITestBase.getVisionRestClient().getDeviceIp());
        initIsAPM();
        buildFileInfo(FileType.ISO_SERIAL);
    }

    public void initIsAPM() {
        String attr = getVisionSetupAttributeFromSUT("serverType");
        this.isAPM = attr != null && "apm".equals(attr.toLowerCase().trim());
    }


    @Override
    public void deploy() {
        NewVmHandler vmHandler = new NewVmHandler();
        try {
            vmHandler.firstTimeWizardKVM(isAPM, version, build, buildFileInfo.getDownloadUri().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}