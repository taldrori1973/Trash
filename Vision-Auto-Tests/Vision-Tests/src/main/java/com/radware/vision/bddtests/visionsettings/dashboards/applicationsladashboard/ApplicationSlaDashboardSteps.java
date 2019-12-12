package com.radware.vision.bddtests.visionsettings.dashboards.applicationsladashboard;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.visionsettings.dashboards.applicationsladashboard.ApplicationSlaDashboardHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import cucumber.api.java.en.Then;

public class ApplicationSlaDashboardSteps {

    @Then("^UI Application SLA Dashboard visible : \"([^\"]*)\"$")
    public void uiSecurityControlCenterVisible(boolean visible) {
        if (!ApplicationSlaDashboardHandler.IsPageVisible(visible)) {
            ReportsUtils.reportAndTakeScreenShot("Application SLA Dashboard, visibility : " + visible + " does not match", Reporter.FAIL);
        }
    }

}
