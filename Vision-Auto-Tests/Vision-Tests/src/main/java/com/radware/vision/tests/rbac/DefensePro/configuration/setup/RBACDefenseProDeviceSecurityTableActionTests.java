package com.radware.vision.tests.rbac.DefensePro.configuration.setup;

import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.setup.RBACDefenseProDeviceSecurityTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.infra.testhandlers.rbac.enums.ViewBaseTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import com.radware.automation.tools.basetest.Reporter;;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 9/30/2014.
 */
public class RBACDefenseProDeviceSecurityTableActionTests extends RBACTestBase {

    BaseTableActions snmpUserTableTableAction = BaseTableActions.NEW;
    BaseTableActions communityTableAction = BaseTableActions.NEW;
    BaseTableActions groupTableTableAction = BaseTableActions.NEW;
    BaseTableActions accessTableAction = BaseTableActions.NEW;
    BaseTableActions notifyTableAction = BaseTableActions.NEW;
    BaseTableActions viewTableAction = BaseTableActions.NEW;
    ViewBaseTableActions targetParametersTableTableAction = ViewBaseTableActions.NEW;
    BaseTableActions targetAddressTableAction = BaseTableActions.NEW;
    BaseTableActions usersTableTableAction = BaseTableActions.NEW;
    EditTableActions advancedTableAction = EditTableActions.EDIT;
    EditTableActions pingPortsTableAction = EditTableActions.EDIT;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify SNMPUserTable Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "snmpUserTableTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySNMPUserTableDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("snmpUserTableTableAction", snmpUserTableTableAction.getTableAction().toString());

            if (!(RBACDefenseProDeviceSecurityTableActionHandler.verifySNMPUserTableTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + snmpUserTableTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify SNMPUserTable Disabled Table Action failed: " + snmpUserTableTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Community Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "communityTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyCommunityDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("communityTableAction", communityTableAction.getTableAction().toString());

            if (!(RBACDefenseProDeviceSecurityTableActionHandler.verifyCommunityTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + communityTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify Community Disabled Table Action failed: " + communityTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify GroupTable Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "groupTableTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyGroupTableDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("groupTableTableAction", groupTableTableAction.getTableAction().toString());

            if (!(RBACDefenseProDeviceSecurityTableActionHandler.verifyGroupTableTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + groupTableTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify GroupTable Disabled Table Action failed: " + groupTableTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Access Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "accessTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyAccessDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("accessTableAction", accessTableAction.getTableAction().toString());

            if (!(RBACDefenseProDeviceSecurityTableActionHandler.verifyAccessTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + accessTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify Access Disabled Table Action failed: " + accessTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Notify Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "notifyTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyNotifyDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("notifyTableAction", notifyTableAction.getTableAction().toString());

            if (!(RBACDefenseProDeviceSecurityTableActionHandler.verifyNotifyTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + notifyTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify Notify Disabled Table Action failed: " + notifyTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify View Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "viewTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyViewDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("viewTableAction", viewTableAction.getTableAction().toString());

            if (!(RBACDefenseProDeviceSecurityTableActionHandler.verifyViewTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + viewTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify View Disabled Table Action failed: " + viewTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify TargetParametersTable Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "targetParametersTableTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyTargetParametersTableDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("targetParametersTableTableAction", targetParametersTableTableAction.getTableAction().toString());

            if (!(RBACDefenseProDeviceSecurityTableActionHandler.verifyTargetParametersTableTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + targetParametersTableTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify TargetParametersTable Disabled Table Action failed: " + targetParametersTableTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify TargetAddress Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "targetAddressTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyTargetAddressDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("targetAddressTableAction", targetAddressTableAction.getTableAction().toString());

            if (!(RBACDefenseProDeviceSecurityTableActionHandler.verifyTargetAddressTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + targetAddressTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify TargetAddress Disabled Table Action failed: " + targetAddressTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify UsersTable Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "usersTableTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyUsersTableDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("usersTableTableAction", usersTableTableAction.getTableAction().toString());

            if (!(RBACDefenseProDeviceSecurityTableActionHandler.verifyUsersTableTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + usersTableTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify UsersTable Disabled Table Action failed: " + usersTableTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Advanced Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "advancedTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyAdvancedDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("advancedTableAction", advancedTableAction.getTableAction().toString());

            if (!(RBACDefenseProDeviceSecurityTableActionHandler.verifyAdvancedTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + advancedTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify Advanced Disabled Table Action failed: " + advancedTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify PingPorts Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "pingPortsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPingPortsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("pingPortsTableAction", pingPortsTableAction.getTableAction().toString());

            if (!(RBACDefenseProDeviceSecurityTableActionHandler.verifyPingPortsTableAction(testProperties))) {
                report.report("The specified Table action is in an incorrect state: " + pingPortsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("verify PingPorts Disabled Table Action failed: " + pingPortsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getCommunityTableAction() {
        return communityTableAction;
    }

    public void setCommunityTableAction(BaseTableActions communityTableAction) {
        this.communityTableAction = communityTableAction;
    }

    public BaseTableActions getGroupTableTableAction() {
        return groupTableTableAction;
    }

    public void setGroupTableTableAction(BaseTableActions groupTableTableAction) {
        this.groupTableTableAction = groupTableTableAction;
    }

    public BaseTableActions getAccessTableAction() {
        return accessTableAction;
    }

    public void setAccessTableAction(BaseTableActions accessTableAction) {
        this.accessTableAction = accessTableAction;
    }

    public ViewBaseTableActions getTargetParametersTableTableAction() {
        return targetParametersTableTableAction;
    }

    public void setTargetParametersTableTableAction(ViewBaseTableActions targetParametersTableTableAction) {
        this.targetParametersTableTableAction = targetParametersTableTableAction;
    }

    public BaseTableActions getUsersTableTableAction() {
        return usersTableTableAction;
    }

    public void setUsersTableTableAction(BaseTableActions usersTableTableAction) {
        this.usersTableTableAction = usersTableTableAction;
    }

    public EditTableActions getPingPortsTableAction() {
        return pingPortsTableAction;
    }

    public void setPingPortsTableAction(EditTableActions pingPortsTableAction) {
        this.pingPortsTableAction = pingPortsTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

    public EditTableActions getAdvancedTableAction() {
        return advancedTableAction;
    }

    public void setAdvancedTableAction(EditTableActions advancedTableAction) {
        this.advancedTableAction = advancedTableAction;
    }

    public BaseTableActions getTargetAddressTableAction() {
        return targetAddressTableAction;
    }

    public void setTargetAddressTableAction(BaseTableActions targetAddressTableAction) {
        this.targetAddressTableAction = targetAddressTableAction;
    }

    public BaseTableActions getViewTableAction() {
        return viewTableAction;
    }

    public void setViewTableAction(BaseTableActions viewTableAction) {
        this.viewTableAction = viewTableAction;
    }

    public BaseTableActions getNotifyTableAction() {
        return notifyTableAction;
    }

    public void setNotifyTableAction(BaseTableActions notifyTableAction) {
        this.notifyTableAction = notifyTableAction;
    }

    public BaseTableActions getSnmpUserTableTableAction() {
        return snmpUserTableTableAction;
    }

    public void setSnmpUserTableTableAction(BaseTableActions snmpUserTableTableAction) {
        this.snmpUserTableTableAction = snmpUserTableTableAction;
    }
}
