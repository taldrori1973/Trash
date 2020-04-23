package com.radware.vision.tests.visionsettings.system.generalsettings.alertsettings;

import com.radware.vision.tests.visionsettings.VisionSettingsBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 5/19/2015.
 */
public class AlertSettings extends VisionSettingsBase {

    protected final static String subMenuOption = "system" + "." +  "tree" + "." + "generalSettings";

    @Test
    @TestProperties(name = "Alert Browser", paramsInclude = {})
    public void clickAlertBrowser() {
        if(!clickMenu(subMenuOption, "alertBrowser")) {
            BaseTestUtils.report("Failed to click 'Alert Browser' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Security Alerts", paramsInclude = {})
    public void clickSecurityAlerts() {
        if(!clickMenu(subMenuOption, "securityalertbrowser")) {
            BaseTestUtils.report("Failed to click 'Security Alerts' menu option.");
        }
    }

}
