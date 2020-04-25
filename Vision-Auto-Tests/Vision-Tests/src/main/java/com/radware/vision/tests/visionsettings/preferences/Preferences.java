package com.radware.vision.tests.visionsettings.preferences;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.tests.visionsettings.VisionSettingsBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 5/19/2015.
 */
public class Preferences extends VisionSettingsBase {

    @Test
    @TestProperties(name = "User Preferences", paramsInclude = {})
    public void clickUserPreferences() {
        if(!clickMenu("gwt-debug-TopicsStack_am.preferences.tab")) {
            BaseTestUtils.reporter.report("Failed to click 'User Preferences' menu option.");
        }
    }

}
