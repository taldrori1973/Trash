package com.radware.vision.tests.rbac.configuration.network;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.network.RBACAlteonLayer2TableActionHandler;
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
public class RBACAlteonLayer2TableActionTests extends RBACTestBase {

    BaseTableActions staticTrunkGroupsTableAction = BaseTableActions.NEW;
    EditTableActions lacpGroupTableAction = EditTableActions.EDIT;
    BaseTableActions portTeamsTableAction = BaseTableActions.NEW;
    BaseTableActions vlanTableAction = BaseTableActions.NEW;
    EditTableActions spanningTreeGroupTableAction = EditTableActions.EDIT;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify SpanningTreeGroup Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "spanningTreeGroupTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySpanningTreeGroupDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("spanningTreeGroupTableAction", spanningTreeGroupTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer2TableActionHandler.verifySpanningTreeGroupTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + spanningTreeGroupTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify SpanningTreeGroup Disabled Table Action failed: " + spanningTreeGroupTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify StaticTrunkGroups Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "staticTrunkGroupsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyStaticTrunkGroupsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("staticTrunkGroupsTableAction", staticTrunkGroupsTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer2TableActionHandler.verifyStaticTrunkGroupsTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + staticTrunkGroupsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify StaticTrunkGroups Disabled Table Action failed: " + staticTrunkGroupsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify LACPGroup Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "lacpGroupTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyLACPGroupDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("lacpGroupTableAction", lacpGroupTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer2TableActionHandler.verifyLACPGroupTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + lacpGroupTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify LACPGroup Disabled Table Action failed: " + lacpGroupTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify PortTeams Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "portTeamsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPortTeamsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("portTeamsTableAction", portTeamsTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer2TableActionHandler.verifyPortTeamsTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + portTeamsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify PortTeams Disabled Table Action failed: " + portTeamsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify VLAN Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "vlanTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyVLANDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("vlanTableAction", vlanTableAction.getTableAction().toString());

            if (!(RBACAlteonLayer2TableActionHandler.verifyVLANTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + vlanTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify VLAN Disabled Table Action failed: " + vlanTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getStaticTrunkGroupsTableAction() {
        return staticTrunkGroupsTableAction;
    }

    public void setStaticTrunkGroupsTableAction(BaseTableActions staticTrunkGroupsTableAction) {
        this.staticTrunkGroupsTableAction = staticTrunkGroupsTableAction;
    }

    public EditTableActions getLacpGroupTableAction() {
        return lacpGroupTableAction;
    }

    public void setLacpGroupTableAction(EditTableActions lacpGroupTableAction) {
        this.lacpGroupTableAction = lacpGroupTableAction;
    }

    public BaseTableActions getPortTeamsTableAction() {
        return portTeamsTableAction;
    }

    public void setPortTeamsTableAction(BaseTableActions portTeamsTableAction) {
        this.portTeamsTableAction = portTeamsTableAction;
    }

    public BaseTableActions getVlanTableAction() {
        return vlanTableAction;
    }

    public void setVlanTableAction(BaseTableActions vlanTableAction) {
        this.vlanTableAction = vlanTableAction;
    }

    public EditTableActions getSpanningTreeGroupTableAction() {
        return spanningTreeGroupTableAction;
    }

    public void setSpanningTreeGroupTableAction(EditTableActions spanningTreeGroupTableAction) {
        this.spanningTreeGroupTableAction = spanningTreeGroupTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

}
