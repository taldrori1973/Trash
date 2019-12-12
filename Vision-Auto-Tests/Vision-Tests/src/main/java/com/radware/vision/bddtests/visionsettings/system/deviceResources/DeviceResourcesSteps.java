package com.radware.vision.bddtests.visionsettings.system.deviceResources;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.RBACHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import cucumber.api.java.en.When;

public class DeviceResourcesSteps {

    @When("^UI Device Resources , Visible: \"([^\"]*)\"$")
    public void uiDeviceResourcesVisible(boolean visible) {

        if (RBACHandler.deviceResourcesIsVisible(visible)) {
            ReportsUtils.reportAndTakeScreenShot("Security Control Center, visibility : " + visible + " does not match", Reporter.FAIL);

        }
    }
}
