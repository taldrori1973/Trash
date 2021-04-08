package com.radware.vision.bddtests.alteon.userManagement;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.Users.LocalUsersHandler;
import cucumber.api.java.en.Then;

import java.io.IOException;

public class LocalUserForAlteonSteps extends VisionUITestBase {
    @Then("^UI Verify User Existence with userId (\\d+) \"(.*)\" device with index (\\d+)( negative)?$")
    public void verifyUserExistence(int userId, String elementType, int index, String negative) throws IOException {
        try {
            SUTDeviceType sutDeviceType = SUTDeviceType.valueOf(elementType);
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(sutDeviceType, index);
            setDeviceName(deviceInfo.getDeviceName());
            if (!LocalUsersHandler.checkIfUserExist(userId, getDeviceName())) {
                BaseTestUtils.report("the user not exist", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }
}
