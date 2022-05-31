package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.vision.automation.AutoUtils.SUT.dtos.InterfaceDto;
import com.radware.vision.automation.Deploy.NewVmHandler;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;

import java.util.List;

public class FreshInstallQCow2 extends FreshInstall {

    public FreshInstallQCow2() {
        super(TestBase.restTestBase.getVisionRestClient().getDeviceIp(), FileType.QCOW2);
    }

    @Override
    public void deploy() {
        NewVmHandler vmHandler = new NewVmHandler();
        try {
            List<InterfaceDto> interfacesList = TestBase.getSutManager().getInterfaces();
            vmHandler.firstTimeWizardQCow2(version, build, buildFileInfo.getDownloadUri().toString(), interfacesList, buildFileInfo.getChecksums().getMd5());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
