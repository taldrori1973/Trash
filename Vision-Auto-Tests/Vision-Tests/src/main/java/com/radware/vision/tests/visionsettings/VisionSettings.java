package com.radware.vision.tests.visionsettings;

import com.radware.automation.tools.basetest.BaseTestUtils;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 5/19/2015.
 */
public class VisionSettings extends VisionSettingsBase {

    protected final static String subMenuOption = "";

    @Test
    @TestProperties(name = "System", paramsInclude = {})
    public void clickSystem() {
        if(!clickMenu("gwt-debug-System")) {
            BaseTestUtils.reporter.report("Failed to click 'System' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Dashboards", paramsInclude = {})
    public void clickDashboards() {
        if(!clickMenu("gwt-debug-Dashboards")) {
            BaseTestUtils.reporter.report("Failed to click 'Dashboards' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Preferences", paramsInclude = {})
    public void clickPreferences() {
        if(!clickMenu("gwt-debug-Preferences")) {
            BaseTestUtils.reporter.report("Failed to click 'Preferences' menu option.");
        }
    }

}
