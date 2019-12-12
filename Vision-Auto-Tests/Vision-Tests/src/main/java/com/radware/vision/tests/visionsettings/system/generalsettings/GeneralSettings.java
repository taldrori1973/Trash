package com.radware.vision.tests.visionsettings.system.generalsettings;

import com.radware.vision.tests.visionsettings.VisionSettingsBase;
import jsystem.framework.TestProperties;
import org.junit.Test;


/**
 * Created by urig on 5/19/2015.
 */
public class GeneralSettings extends VisionSettingsBase {

    protected final static String subMenuOption = "system" + "." +  "tree" + "." + "generalSettings";

    @Test
    @TestProperties(name = "Basic Parameters", paramsInclude = {})
    public void clickBasicParameters() {
        if(!clickMenu(subMenuOption, "basicParameters")) {
            report.report("Failed to click 'Basic Parameters' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Connectivity", paramsInclude = {})
    public void clickConnectivity() {
        if(!clickMenu(subMenuOption, "connectivity")) {
            report.report("Failed to click 'Connectivity' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Alert Settings", paramsInclude = {})
    public void clickAlertSettings() {
        if(!clickMenu(subMenuOption, "alertsettings")) {
            report.report("Failed to click 'Alert Settings' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Monitoring", paramsInclude = {})
    public void clickMonitoring() {
        if(!clickMenu(subMenuOption, "monitoring")) {
            report.report("Failed to click 'Monitoring' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Server Alarm", paramsInclude = {})
    public void clickServerAlarm() {
        if(!clickMenu(subMenuOption, "warningThresholds")) {
            report.report("Failed to click 'Server Alarm' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Authentication Protocols", paramsInclude = {})
    public void clickAuthenticationProtocols() {
        if(!clickMenu(subMenuOption, "authenticationProtocols")) {
            report.report("Failed to click 'Authentication Protocols' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Device Drivers", paramsInclude = {})
    public void clickDeviceDrivers() {
        if(!clickMenu(subMenuOption, "deviceDrivers")) {
            report.report("Failed to click 'Device Drivers' menu option.");
        }
    }

    @Test
    @TestProperties(name = "APSolute Vision Reporter", paramsInclude = {})
    public void clickAPSoluteVisionReporter() {
        if(!clickMenu(subMenuOption, "eiqConfig")) {
            report.report("Failed to click 'APsolute Vision Reporter' menu option.");
        }
    }

    @Test
    @TestProperties(name = "License Management", paramsInclude = {})
    public void clickLicenseManagement() {
        if(!clickMenu(subMenuOption, "licenseManagement")) {
            report.report("Failed to click 'License Management' menu option.");
        }
    }

    @Test
    @TestProperties(name = "APM Settings", paramsInclude = {})
    public void clickAPMSettings() {
        if(!clickMenu(subMenuOption, "apmSettings")) {
            report.report("Failed to click 'APM Settings' menu option.");
        }
    }

    @Test
    @TestProperties(name = "DefensePipe Settings", paramsInclude = {})
    public void clickDefensePipeSettings() {
        if(!clickMenu(subMenuOption, "defensePipeSettings")) {
            report.report("Failed to click 'DefensePipe Settings' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Advanced", paramsInclude = {})
    public void clickAdvanced() {
        if(!clickMenu(subMenuOption, "advanced")) {
            report.report("Failed to click 'Advanced' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Display", paramsInclude = {})
    public void clickDisplay() {
        if(!clickMenu(subMenuOption, "display")) {
            report.report("Failed to click 'Display' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Maintenance Files", paramsInclude = {})
    public void clickMaintenanceFiles() {
        if(!clickMenu(subMenuOption, "maintenance")) {
            report.report("Failed to click 'Maintenance Files' menu option.");
        }
    }

    @Test
    @TestProperties(name = "AppWall Filter", paramsInclude = {})
    public void clickAppWallFilter() {
        if(!clickMenu(subMenuOption, "AppWallFilter")) {
            report.report("Failed to click 'AppWall Filter' menu option.");
        }
    }
}


