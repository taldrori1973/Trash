package com.radware.vision.tests.visionsettings.system.generalsettings.apmsettings;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.tests.visionsettings.VisionSettingsBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 5/19/2015.
 */
public class ApmSettings extends VisionSettingsBase {

    protected final static String subMenuOption = "system" + "." +  "tree" + "." + "generalSettings";

    @Test
    @TestProperties(name = "APM Enable Devices", paramsInclude = {})
    public void clickAPMEnableDevices() {
        if(!clickMenu(subMenuOption, "apmInstances")) {
            BaseTestUtils.reporter.report("Failed to click 'APM Enable Devices' menu option.");
        }
    }
}
