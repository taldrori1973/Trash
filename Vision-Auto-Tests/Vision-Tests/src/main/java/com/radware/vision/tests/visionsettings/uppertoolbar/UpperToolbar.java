package com.radware.vision.tests.visionsettings.uppertoolbar;

import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.tests.visionsettings.VisionSettingsBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by StanislavA on 5/20/2015.
 */
public class UpperToolbar extends VisionSettingsBase {

    @Test
    @TestProperties(name = "Open Settings", paramsInclude = {})
    public void openSettings() {
        BasicOperationsHandler.settings();
    }
}
