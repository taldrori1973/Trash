package com.radware.vision.tests.rbac.configuration.security;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.security.RBACAlteonSecurityBaselTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ViewBaseTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 9/23/2014.
 */
public class RBACAlteonSecurityBaseTableActionTests extends RBACTestBase {

    EditTableActions portProtectionTableAction = EditTableActions.EDIT;
    ViewBaseTableActions udpBlastTableAction = ViewBaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify PortProtection  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "portProtectionTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPortProtectionDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("portProtectionTableAction", portProtectionTableAction.getTableAction().toString());

            if (!(RBACAlteonSecurityBaselTableActionHandler.verifyPortProtectionTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + portProtectionTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PortProtection Disabled Table Action failed: " + portProtectionTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify UDPBlast  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "udpBlastTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyUDPBlastDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("udpBlastTableAction", udpBlastTableAction.getTableAction().toString());

            if (!(RBACAlteonSecurityBaselTableActionHandler.verifyUDPBlastTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + udpBlastTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify UDPBlast Disabled Table Action failed: " + udpBlastTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }



    public EditTableActions getPortProtectionTableAction() {
        return portProtectionTableAction;
    }

    public void setPortProtectionTableAction(EditTableActions portProtectionTableAction) {
        this.portProtectionTableAction = portProtectionTableAction;
    }

    public ViewBaseTableActions getUdpBlastTableAction() {
        return udpBlastTableAction;
    }

    public void setUdpBlastTableAction(ViewBaseTableActions udpBlastTableAction) {
        this.udpBlastTableAction = udpBlastTableAction;
    }

}
