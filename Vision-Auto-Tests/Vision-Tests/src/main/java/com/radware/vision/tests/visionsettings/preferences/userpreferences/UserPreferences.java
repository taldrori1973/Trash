package com.radware.vision.tests.visionsettings.preferences.userpreferences;

import com.radware.vision.tests.visionsettings.VisionSettingsBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 9/6/2015.
 */
public class UserPreferences extends VisionSettingsBase {

    protected final static String subMenuOption = "system" + "." +  "tree" + "." + "preferences";

    @Test
    @TestProperties(name = "User Password Settings", paramsInclude = {})
    public void clickUserPasswordSettings() {
        if(!clickMenu(subMenuOption, "userPasswordSettings")) {
            report.report("Failed to click 'User Password Settings' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Display", paramsInclude = {})
    public void clickDisplay() {
        if(!clickMenu(subMenuOption, "languageAndDisplay")) {
            report.report("Failed to click 'Display' menu option.");
        }
    }
}
