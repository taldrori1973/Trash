package com.radware.vision.tests.visionsettings.dashboards.dashboards.Dashboards;

import com.radware.vision.tests.visionsettings.VisionSettingsBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 9/6/2015.
 */
public class Dashboards extends VisionSettingsBase {

    @Test
    @TestProperties(name = "Application SLA Dashboard", paramsInclude = {})
    public void clickApplicationSLADashboard() {
        if(!clickMenu("gwt-debug-TopicsNode_sc-dashboard-content")) {
            report.report("Failed to click 'Application SLA Dashboard' menu option.");
        }
    }

    @Test
    @TestProperties(name = "Security Control Center", paramsInclude = {})
    public void clickSecurityControlCenter() {
        if(!clickMenu("gwt-debug-TopicsNode_SecurityControlCenter-content")) {
            report.report("Failed to click 'Security Control Center' menu option.");
        }
    }
}
