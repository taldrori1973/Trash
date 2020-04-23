package com.radware.vision.tests.rbac.configuration.network;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.network.RBACAlteonPhysicalPortsTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonPhysicalPortsTableActionTests extends RBACTestBase {

    BaseTableActions portMirroringTableAction = BaseTableActions.NEW;
    EditTableActions portSettingsTableAction = EditTableActions.EDIT;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify PortSettings Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "portSettingsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPortSettingsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("portSettingsTableAction", portSettingsTableAction.getTableAction().toString());
            if (!(RBACAlteonPhysicalPortsTableActionHandler.verifyPortSettingsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + portSettingsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PortSettings Disabled Table Action failed: " + portSettingsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify PortMirroring Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "portMirroringTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPortMirroringDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("portMirroringTableAction", portMirroringTableAction.getTableAction().toString());

            if (!(RBACAlteonPhysicalPortsTableActionHandler.verifyPortMirroringTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + portMirroringTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PortMirroring Disabled Table Action failed: " + portMirroringTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    public BaseTableActions getPortMirroringTableAction() {
        return portMirroringTableAction;
    }

    public void setPortMirroringTableAction(BaseTableActions portMirroringTableAction) {
        this.portMirroringTableAction = portMirroringTableAction;
    }

    public EditTableActions getPortSettingsTableAction() {
        return portSettingsTableAction;
    }

    public void setPortSettingsTableAction(EditTableActions portSettingsTableAction) {
        this.portSettingsTableAction = portSettingsTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

}
