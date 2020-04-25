package com.radware.vision.tests.visionsettings.dashboards;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.tests.visionsettings.VisionSettingsBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 9/6/2015.
 */
public class Dashboards extends VisionSettingsBase {

    public final static String subMenuOption = "dashboards";

    @Test
    @TestProperties(name = "Dashboards", paramsInclude = {})
    public void clickDashboards() {
        if(!clickMenu("gwt-debug-TopicsStack_am.dashboards.tab")) {
            BaseTestUtils.reporter.report("Failed to click 'Dashboards' menu option.");
        }
    }
}
