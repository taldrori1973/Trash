package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.vision_handlers.NewVmHandler;

public class FreshInstallKVM extends Deploy {
    public FreshInstallKVM(boolean isExtended, String build) {
        super(isExtended, build);
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