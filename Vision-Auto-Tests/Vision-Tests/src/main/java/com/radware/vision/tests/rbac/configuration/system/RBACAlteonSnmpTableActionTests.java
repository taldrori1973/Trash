package com.radware.vision.tests.rbac.configuration.system;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.system.snmp.RBACAlteonSNMPv3TableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.infra.testhandlers.rbac.enums.ViewBaseTableActions;
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
public class RBACAlteonSnmpTableActionTests extends RBACTestBase {

    ViewBaseTableActions snmpUsmUsersTableAction = ViewBaseTableActions.NEW;
    BaseTableActions snmpViewTreesTableAction = BaseTableActions.NEW;
    BaseTableActions snmpGroupsTableAction = BaseTableActions.NEW;
    ViewBaseTableActions snmpAccessTableAction = ViewBaseTableActions.NEW;
    ViewBaseTableActions snmpCommunitiesTableAction = ViewBaseTableActions.NEW;
    ViewBaseTableActions snmpTargetParametersTableAction = ViewBaseTableActions.NEW;
    ViewBaseTableActions snmpNotifyTagsTableAction = ViewBaseTableActions.NEW;
    BaseTableActions snmpTargetAddressesTableAction = BaseTableActions.NEW;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify SNMP USM Users Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "snmpUsmUsersTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySnmpUSMUsersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("snmpUsmUsersTableAction", snmpUsmUsersTableAction.getTableAction().toString());

            if (!(RBACAlteonSNMPv3TableActionHandler.verifySnmpUSMUsersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + snmpUsmUsersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify SnmpUSMUsers Disabled Table Action failed: " + snmpUsmUsersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SNMP ViewTrees Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "snmpViewTreesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySnmpViewTreesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("snmpViewTreesTableAction", snmpViewTreesTableAction.getTableAction().toString());

            if (!(RBACAlteonSNMPv3TableActionHandler.verifySnmpViewTreesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + snmpViewTreesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ViewTrees Disabled Table Action failed: " + snmpViewTreesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SNMP Groups Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "snmpGroupsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySnmpGroupsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("snmpGroupsTableAction", snmpGroupsTableAction.getTableAction().toString());

            if (!(RBACAlteonSNMPv3TableActionHandler.verifySnmpGroupsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + snmpGroupsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Groups Disabled Table Action failed: " + snmpGroupsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SNMP Access Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "snmpAccessTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySnmpAccessDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("snmpAccessTableAction", snmpAccessTableAction.getTableAction().toString());

            if (!(RBACAlteonSNMPv3TableActionHandler.verifySnmpAccessTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + snmpAccessTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Access Disabled Table Action failed: " + snmpAccessTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SNMP Communities Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "snmpCommunitiesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySnmpCommunitiesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("snmpCommunitiesTableAction", snmpCommunitiesTableAction.getTableAction().toString());

            if (!(RBACAlteonSNMPv3TableActionHandler.verifySnmpCommunitiesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + snmpCommunitiesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Communities Disabled Table Action failed: " + snmpCommunitiesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SNMP TargetParameters Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "snmpTargetParametersTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySnmpTargetParametersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("snmpTargetParametersTableAction", snmpTargetParametersTableAction.getTableAction().toString());

            if (!(RBACAlteonSNMPv3TableActionHandler.verifySnmpTargetParametersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + snmpTargetParametersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify TargetParameters Disabled Table Action failed: " + snmpTargetParametersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SNMP TargetAddresses Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "snmpTargetAddressesTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySnmpTargetAddressesDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("snmpTargetAddressesTableAction", snmpTargetAddressesTableAction.getTableAction().toString());

            if (!(RBACAlteonSNMPv3TableActionHandler.verifySnmpTargetAddressesTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + snmpTargetAddressesTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify TargetAddresses Disabled Table Action failed: " + snmpTargetAddressesTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SNMP NotifyTags Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "snmpNotifyTagsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySnmpNotifyTagsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("snmpNotifyTagsTableAction", snmpNotifyTagsTableAction.getTableAction().toString());

            if (!(RBACAlteonSNMPv3TableActionHandler.verifySnmpNotifyTagsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + snmpNotifyTagsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify NotifyTags Disabled Table Action failed: " + snmpNotifyTagsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public ViewBaseTableActions getSnmpUsmUsersTableAction() {
        return snmpUsmUsersTableAction;
    }

    public void setSnmpUsmUsersTableAction(ViewBaseTableActions snmpUsmUsersTableAction) {
        this.snmpUsmUsersTableAction = snmpUsmUsersTableAction;
    }

    public BaseTableActions getSnmpViewTreesTableAction() {
        return snmpViewTreesTableAction;
    }

    public void setSnmpViewTreesTableAction(BaseTableActions snmpViewTreesTableAction) {
        this.snmpViewTreesTableAction = snmpViewTreesTableAction;
    }

    public BaseTableActions getSnmpGroupsTableAction() {
        return snmpGroupsTableAction;
    }

    public void setSnmpGroupsTableAction(BaseTableActions snmpGroupsTableAction) {
        this.snmpGroupsTableAction = snmpGroupsTableAction;
    }

    public ViewBaseTableActions getSnmpAccessTableAction() {
        return snmpAccessTableAction;
    }

    public void setSnmpAccessTableAction(ViewBaseTableActions snmpAccessTableAction) {
        this.snmpAccessTableAction = snmpAccessTableAction;
    }

    public ViewBaseTableActions getSnmpCommunitiesTableAction() {
        return snmpCommunitiesTableAction;
    }

    public void setSnmpCommunitiesTableAction(ViewBaseTableActions snmpCommunitiesTableAction) {
        this.snmpCommunitiesTableAction = snmpCommunitiesTableAction;
    }

    public ViewBaseTableActions getSnmpTargetParametersTableAction() {
        return snmpTargetParametersTableAction;
    }

    public void setSnmpTargetParametersTableAction(ViewBaseTableActions snmpTargetParametersTableAction) {
        this.snmpTargetParametersTableAction = snmpTargetParametersTableAction;
    }

    public ViewBaseTableActions getSnmpNotifyTagsTableAction() {
        return snmpNotifyTagsTableAction;
    }

    public void setSnmpNotifyTagsTableAction(ViewBaseTableActions snmpNotifyTagsTableAction) {
        this.snmpNotifyTagsTableAction = snmpNotifyTagsTableAction;
    }

    public BaseTableActions getSnmpTargetAddressesTableAction() {
        return snmpTargetAddressesTableAction;
    }

    public void setSnmpTargetAddressesTableAction(BaseTableActions snmpTargetAddressesTableAction) {
        this.snmpTargetAddressesTableAction = snmpTargetAddressesTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

}
