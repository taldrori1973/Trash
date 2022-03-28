package com.radware.vision.system;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import jsystem.framework.report.Reporter;

public class HttpReporting {

    public static final String SYSTEM_HTTP_REPORTING_MODE_SUBMENU = "get                      Provides the status of the new http-reporting mode.\n" +
            "set-on                   Switches to the new http-reporting mode. After switching to the new http-reporting mode, reverting to the old mode is not permitted.\n" +
            "validate                 Validates that the devices meet the requirements for switching to the new http-reporting mode.\n";

    public static void httpReportingModeSubMenuCheck(RadwareServerCli radwareServer) throws Exception {
        CliOperations.checkSubMenu(radwareServer, Menu.system().httpReporting().mode().build(), SYSTEM_HTTP_REPORTING_MODE_SUBMENU);
    }

    public static boolean validateHttpReportingModeOnDevices(RadwareServerCli radwareServerCli) throws Exception {
        BaseTestUtils.reporter.startLevel("Validating http reporting mode on all devices");
        try {
            CliOperations.runCommand(radwareServerCli, Menu.system().httpReporting().mode().validate().build());
            if (CliOperations.lastOutput.contains("Validation that all devices support the new http-reporting mode succeeded.")) {
                BaseTestUtils.reportInfoMessage("Validation succeeded for all devices");
                return true;
            } else {
                BaseTestUtils.reportInfoMessage("Some devices does not support new http-reporting mode");
                return false;
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
        BaseTestUtils.report("Validation of Http reporting mode on all devices failed", Reporter.FAIL);
        return false;
    }

    public static boolean validateVisionHttpReportingMode(RadwareServerCli radwareServerCli) throws Exception {
        BaseTestUtils.reporter.startLevel("Validating http reporting mode on vision");
        try {
            CliOperations.runCommand(radwareServerCli, Menu.system().httpReporting().mode().get().build());
            if (CliOperations.lastOutput.contains("The new http-reporting mode is set to  'On'.")) {
                BaseTestUtils.reportInfoMessage("Http reporting mode is on");
                return true;
            } else {
                BaseTestUtils.reportInfoMessage("Http reporting mode is off");
                return false;
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
        BaseTestUtils.report("Vision http reporting mode validation failed", Reporter.FAIL);
        return false;
    }

    public static void visionHttpReportingModeSetOn(RadwareServerCli radwareServerCli) throws Exception {
        BaseTestUtils.reporter.startLevel("Setting vision http reporting mode on");
        try {
            CliOperations.runCommand(radwareServerCli, Menu.system().httpReporting().mode().setOn().build());
            if (CliOperations.lastOutput.contains("The new http-reporting mode is set to  'On'.")) {
                BaseTestUtils.report("Setting vision new http reporting mode on completed successfully", Reporter.PASS);
            } else {
                BaseTestUtils.report("Setting vision new http reporting mode on failed", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

}