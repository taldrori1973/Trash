package com.radware.vision.bddtests.vmoperations.Deploy;

import com.radware.vision.automation.base.TestBase;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;

import static com.radware.vision.bddtests.vmoperations.VMOperationsSteps.getVisionSetupAttributeFromSUT;

public class FreshInstallSerialISO extends FreshInstall {

    public FreshInstallSerialISO(boolean isExtended, String build) {
        super(isExtended, build, TestBase.restTestBase.getVisionRestClient().getDeviceIp(), FileType.ISO_SERIAL);
    }

    @Override
    public void deploy() {
        // ToDo - take care after finishing Serial ISO
    }
}
