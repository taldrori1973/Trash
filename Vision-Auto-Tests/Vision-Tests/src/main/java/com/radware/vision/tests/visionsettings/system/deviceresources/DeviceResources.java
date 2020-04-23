package com.radware.vision.tests.visionsettings.system.deviceresources;

import com.radware.vision.tests.visionsettings.VisionSettingsBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 5/19/2015.
 */
public class DeviceResources extends VisionSettingsBase {

    final static String subMenuOption = com.radware.vision.tests.visionsettings.system.System.subMenuOption + "." + "tree" + "." + "additional";

    @Test
    @TestProperties(name = "Click Device Backups", paramsInclude = {})
    public void clickDeviceBackups() {
       if(!clickMenu(subMenuOption, "deviceBackups")) {
           BaseTestUtils.report("Failed to click 'Device Backups' menu option.");
       }
    }
}
