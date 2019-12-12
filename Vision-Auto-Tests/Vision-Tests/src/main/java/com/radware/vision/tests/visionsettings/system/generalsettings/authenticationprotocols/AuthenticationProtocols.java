package com.radware.vision.tests.visionsettings.system.generalsettings.authenticationprotocols;

import com.radware.vision.tests.visionsettings.VisionSettingsBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by urig on 5/19/2015.
 */
public class AuthenticationProtocols extends VisionSettingsBase {

    protected final static String subMenuOption = "system" + "." +  "tree" + "." + "generalSettings" + "." + "authenticationProtocols";

    @Test
    @TestProperties(name = "RADIUS Settings", paramsInclude = {})
    public void clickRADIUSSettings() {
        if(!clickMenu(subMenuOption, "radiusSettings_3_00")) {
            report.report("Failed to click 'RADIUS Settings' menu option.");
        }
    }

    @Test
    @TestProperties(name = "TACACS+ Settings", paramsInclude = {})
    public void clickTacacsSettings() {
        if(!clickMenu(subMenuOption, "tacacs")) {
            report.report("Failed to click 'TACACS+ Settings' menu option.");
        }
    }
}
