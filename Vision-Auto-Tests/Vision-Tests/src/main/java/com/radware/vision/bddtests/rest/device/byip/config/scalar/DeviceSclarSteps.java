package com.radware.vision.bddtests.rest.device.byip.config.scalar;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.VisionRestClient;
import com.radware.utils.device.DeviceScalarUtils;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.BddRestTestBase;
import cucumber.api.java.en.When;

public class DeviceSclarSteps extends BddRestTestBase {
    @When("^REST Put Scalar on \"(.*)\" (\\d+) values \"(.*)\"$")
    public void putScalar(SUTDeviceType deviceType, int deviceIndex, String propsValuesGroup) {
        String deviceIp = "";
        try{
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceScalarUtils.putScalar(visionRestClient, deviceIp, propsValuesGroup);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "putScalar may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }
}
