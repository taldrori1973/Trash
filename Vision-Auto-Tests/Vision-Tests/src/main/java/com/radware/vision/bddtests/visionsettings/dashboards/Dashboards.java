package com.radware.vision.bddtests.visionsettings.dashboards;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.bddtests.visionsettings.VisionSettingsBase;
import cucumber.api.java.en.Given;

public class Dashboards extends VisionSettingsBase {

    public Dashboards() throws Exception {
    }

    @Given("^UI Click vision dashboards$")
    public void clickDashboards() {
        if(!clickMenu("gwt-debug-Dashboards")) {
            BaseTestUtils.report("Failed to click 'Dashboards' menu option.", Reporter.FAIL);
        }
    }

    @Given("^UI click application SLA dashboard")
    public void clickApplicationSLADashboard() {
        if(!clickMenu("gwt-debug-TopicsNode_sc-dashboard-content")) {
            BaseTestUtils.report("Failed to click 'Application SLA Dashboard' menu option.",Reporter.FAIL);
        }
    }

    @Given("^UI Click security control center")
    public void clickSecurityControlCenter() {
        if(!clickMenu("gwt-debug-TopicsNode_SecurityControlCenter-content")) {
            BaseTestUtils.report("Failed to click 'Security Control Center' menu option.",Reporter.FAIL);
        }
    }
}
