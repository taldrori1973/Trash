package com.radware.vision.tests.rbac.configuration.security;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.security.RBACAlteonIpAclTableActionHandler;
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
public class RBACAlteonIpAclTableActionTests extends RBACTestBase {

    ViewBaseTableActions blockedSourceAddressesTableAction = ViewBaseTableActions.NEW;
    ViewBaseTableActions blockedDestinationAddressesTableAction = ViewBaseTableActions.NEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify BlockedSourceAddresses  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "blockedSourceAddressesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyBlockedSourceAddressesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("blockedSourceAddressesTableAction", blockedSourceAddressesTableAction.getTableAction().toString());

            if (!(RBACAlteonIpAclTableActionHandler.verifyBlockedSourceAddressesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + blockedSourceAddressesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify BlockedSourceAddresses Disabled Table Action failed: " + blockedSourceAddressesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify BlockedDestinationAddresses  Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "blockedDestinationAddressesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyBlockedDestinationAddressesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("blockedDestinationAddressesTableAction", blockedDestinationAddressesTableAction.getTableAction().toString());

            if (!(RBACAlteonIpAclTableActionHandler.verifyBlockedDestinationAddressesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + blockedDestinationAddressesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify BlockedDestinationAddresses Disabled Table Action failed: " + blockedDestinationAddressesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public ViewBaseTableActions getBlockedSourceAddressesTableAction() {
        return blockedSourceAddressesTableAction;
    }

    public void setBlockedSourceAddressesTableAction(ViewBaseTableActions blockedSourceAddressesTableAction) {
        this.blockedSourceAddressesTableAction = blockedSourceAddressesTableAction;
    }

    public ViewBaseTableActions getBlockedDestinationAddressesTableAction() {
        return blockedDestinationAddressesTableAction;
    }

    public void setBlockedDestinationAddressesTableAction(ViewBaseTableActions blockedDestinationAddressesTableAction) {
        this.blockedDestinationAddressesTableAction = blockedDestinationAddressesTableAction;
    }

}
