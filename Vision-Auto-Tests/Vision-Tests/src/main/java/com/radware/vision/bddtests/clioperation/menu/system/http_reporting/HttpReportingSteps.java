package com.radware.vision.bddtests.clioperation.menu.system.http_reporting;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.system.HttpReporting;
import cucumber.api.java.en.Given;

public class HttpReportingSteps extends TestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();

    @Given("^CLI Operations - validate system http-reporting mode status \"(on|off)\"")
    public void systemHttpReportingModeGet(String isOnOff) {
        try {
            boolean mode = HttpReporting.validateVisionHttpReportingMode(radwareServerCli);
            if (isOnOff.equals("on") && mode) {
                BaseTestUtils.report("Http Reporting mode is on as expected", Reporter.PASS);
            } else if (isOnOff.equals("off") && !mode) {
                BaseTestUtils.report("Http Reporting mode is off as expected", Reporter.PASS);
            } else {
                BaseTestUtils.report("Http Reporting mode is not as expected", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI Operations - system http-reporting mode validate devices \"(on|off)\"$")
    public void systemHttpReportingModeValidate(String isOnOff) {
        try {
            boolean modeOn = HttpReporting.validateHttpReportingModeOnDevices(radwareServerCli);
            if (isOnOff.equals("on") && modeOn) {
                BaseTestUtils.report("Http Reporting mode is on for all devices as expected", Reporter.PASS);
            } else if (isOnOff.equals("off") && !modeOn) {
                BaseTestUtils.report("Http Reporting mode is off for some devices as expected", Reporter.PASS);
            } else {
                BaseTestUtils.report("Http Reporting mode for all devices is not as expected", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

//    @Given("^CLI Operations - system http-reporting mode set-on")
//    public void systemHttpReportingModeSetOn() {
//        try {
//            HttpReporting.visionHttpReportingModeSetOn(radwareServerCli);
//        } catch (Exception e) {
//            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
//        }
//    }
//
//    @Given("^CLI Operations - system http-reporting mode set-on")
//    public void systemHttpReportingModeCheckSunMenu() {
//        try {
//            HttpReporting.httpReportingModeSubMenuCheck(radwareServerCli);
//        } catch (Exception e) {
//            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
//        }
//    }
}
