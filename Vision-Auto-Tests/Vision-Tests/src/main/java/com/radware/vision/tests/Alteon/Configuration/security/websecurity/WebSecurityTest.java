package com.radware.vision.tests.Alteon.Configuration.security.websecurity;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.configuration.system.security.SecurityEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.security.websecurity.WebSecurityHandler;
import com.radware.vision.tests.Alteon.AlteonTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by alexeys on 6/15/2015.
 */
public class WebSecurityTest extends AlteonTestBase {

    SecurityEnums.State enableAppWallChkBox;
    SecurityEnums.State enableAuthGatewayChkBox;


    @Test
    @TestProperties(name = "Edit WEB Security Settings",
            paramsInclude = {"qcTestId", "enableAppWallChkBox", "enableAuthGatewayChkBox"})
    public void testEditWebSecuritySettings() throws Exception {
        try {
            testProperties.put("enableAppWallChkBox", enableAppWallChkBox.getState());
            testProperties.put("enableAuthGatewayChkBox", enableAuthGatewayChkBox.getState());

            WebSecurityHandler.editWebSecuritySettings(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }

    }

    public SecurityEnums.State getEnableAppWallChkBox() {
        return enableAppWallChkBox;
    }

    public void setEnableAppWallChkBox(SecurityEnums.State enableAppWallChkBox) {
        this.enableAppWallChkBox = enableAppWallChkBox;
    }

    public SecurityEnums.State getEnableAuthGatewayChkBox() {
        return enableAuthGatewayChkBox;
    }

    public void setEnableAuthGatewayChkBox(SecurityEnums.State enableAuthGatewayChkBox) {
        this.enableAuthGatewayChkBox = enableAuthGatewayChkBox;
    }
}
