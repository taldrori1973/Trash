package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.vision.automation.Deploy.NewVmHandler;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;

import java.io.File;

public class FreshInstallQCow2 extends FreshInstall {

    public FreshInstallQCow2(boolean isExtended, String build) {
        super(isExtended, build, TestBase.restTestBase.getVisionRestClient().getDeviceIp(), FileType.QCOW2);
    }

    @Override
    public void deploy() {
        NewVmHandler vmHandler = new NewVmHandler();
        try {
            vmHandler.firstTimeWizardQCow2(version, build, buildFileInfo.getDownloadUri().toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
