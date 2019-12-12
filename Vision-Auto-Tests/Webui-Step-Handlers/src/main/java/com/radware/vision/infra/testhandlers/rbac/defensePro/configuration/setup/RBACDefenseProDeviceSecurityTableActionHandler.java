package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.setup;

import com.radware.automation.webui.webpages.dp.configuration.setup.devicesecurity.advanced.Advanced;
import com.radware.automation.webui.webpages.dp.configuration.setup.devicesecurity.advanced.pingPorts.PingPorts;
import com.radware.automation.webui.webpages.dp.configuration.setup.devicesecurity.snmp.access.Access;
import com.radware.automation.webui.webpages.dp.configuration.setup.devicesecurity.snmp.community.Community;
import com.radware.automation.webui.webpages.dp.configuration.setup.devicesecurity.snmp.groupTable.GroupTable;
import com.radware.automation.webui.webpages.dp.configuration.setup.devicesecurity.snmp.notify.Notify;
import com.radware.automation.webui.webpages.dp.configuration.setup.devicesecurity.snmp.snmpUserTable.SNMPUserTable;
import com.radware.automation.webui.webpages.dp.configuration.setup.devicesecurity.snmp.targetAddress.TargetAddress;
import com.radware.automation.webui.webpages.dp.configuration.setup.devicesecurity.snmp.targetParametersTable.TargetParametersTable;
import com.radware.automation.webui.webpages.dp.configuration.setup.devicesecurity.snmp.view.View;
import com.radware.automation.webui.webpages.dp.configuration.setup.devicesecurity.usersTable.UsersTable;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/30/2014.
 */
public class RBACDefenseProDeviceSecurityTableActionHandler extends RBACHandlerBase {

    public static boolean verifySNMPUserTableTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        SNMPUserTable snmpUserTable = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mDeviceSecurity().mSNMP().mSNMPUserTable();
        snmpUserTable.openPage();

        WebUITable table = snmpUserTable.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("snmpUserTableTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyAccessTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        Access access = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mDeviceSecurity().mSNMP().mAccess();
        access.openPage();

        WebUITable table = access.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("accessTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyCommunityTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        Community community = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mDeviceSecurity().mSNMP().mCommunity();
        community.openPage();

        WebUITable table = community.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("communityTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyGroupTableTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        GroupTable groupTable = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mDeviceSecurity().mSNMP().mGroupTable();
        groupTable.openPage();

        WebUITable table = groupTable.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("groupTableTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyNotifyTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        Notify notify = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mDeviceSecurity().mSNMP().mNotify();
        notify.openPage();

        WebUITable table = notify.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("notifyTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyTargetAddressTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        TargetAddress targetAddress = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mDeviceSecurity().mSNMP().mTargetAddress();
        targetAddress.openPage();

        WebUITable table = targetAddress.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("targetAddressTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyTargetParametersTableTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        TargetParametersTable targetParametersTable = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mDeviceSecurity().mSNMP().mTargetParametersTable();
        targetParametersTable.openPage();

        WebUITable table = targetParametersTable.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("targetParametersTableTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyViewTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        View view = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mDeviceSecurity().mSNMP().mView();
        view.openPage();

        WebUITable table = view.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("viewTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyUsersTableTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        UsersTable usersTable = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mDeviceSecurity().mUsersTable();
        usersTable.openPage();

        WebUITable table = usersTable.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("usersTableTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyAdvancedTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        Advanced advanced = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mDeviceSecurity().mAdvanced();
        advanced.openPage();

        WebUITable table = advanced.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("advancedTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyPingPortsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        PingPorts pingPorts = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mDeviceSecurity().mAdvanced().mPingPorts();
        pingPorts.openPage();

        WebUITable table = pingPorts.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("pingPortsTableAction"), expectedResultRBAC);
        return result;
    }

}
