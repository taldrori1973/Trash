package com.radware.vision.tests.visionsettings.system.usermanagement;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.tests.visionsettings.VisionSettingsBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 5/19/2015.
 */
public class UserManagement extends VisionSettingsBase {

    protected final static String subMenuOption = "system" + "." +  "tree" + "." + "userManagement";

    @Test
    @TestProperties(name = "Local Users", paramsInclude = {})
    public void clickLocalUsers() {
        if(!clickMenu(subMenuOption, "localUsers")) {
            BaseTestUtils.reporter.report("Failed to click 'Local Users' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Roles", paramsInclude = {})
    public void clickRoles() {
        if(!clickMenu(subMenuOption, "roles")) {
            BaseTestUtils.reporter.report("Failed to click 'Roles' menu option.");
        }
    }

    @Test
    @TestProperties(name = "User Statistics", paramsInclude = {})
    public void clickUserStatistics() {
        if(!clickMenu(subMenuOption, "userStatistics")) {
            BaseTestUtils.reporter.report("Failed to click 'User Statistics' menu option.");
        }
    }

    @Test
    @TestProperties(name = "User Management Settings", paramsInclude = {})
    public void clickUserManagementSettings() {
        if(!clickMenu(subMenuOption, "userSettings")) {
            BaseTestUtils.reporter.report("Failed to click 'User Management Settings' menu option.");
        }
    }
}
