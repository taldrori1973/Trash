package com.radware.vision.tests.visionsettings.system;

import com.radware.vision.tests.visionsettings.VisionSettingsBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 5/19/2015.
 */
public class System extends VisionSettingsBase {

    public final static String subMenuOption = "system";

    @Test
    @TestProperties(name = "General Settings", paramsInclude = {})
    public void clickGeneralSettings() {
        if(!clickMenu("gwt-debug-TopicsStack_am.system.generalSettings")) {
            report.report("Failed to click 'General Settings' menu option.");
        }
    }

    @Test
    @TestProperties(name = "User Management", paramsInclude = {})
    public void clickUserManagement() {
        if(!clickMenu("gwt-debug-TopicsStack_am.system.tree.userManagement")) {
            report.report("Failed to click 'User Management' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Device Resources", paramsInclude = {})
    public void clickDeviceResources() {
        if(!clickMenu("gwt-debug-TopicsStack_am.system.tree.additional")) {
            report.report("Failed to click 'Device Resources' menu option.");
        }
    }
}
