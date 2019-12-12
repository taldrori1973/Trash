package com.radware.vision.infra.testhandlers.rbac.configuration.system.snmp;

import com.radware.automation.webui.webpages.configuration.system.snmp.snmpv3.*;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonSNMPv3TableActionHandler extends RBACHandlerBase {
    public static boolean verifySnmpUSMUsersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        USMUsers usmUsers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mUSMUsers();
        usmUsers.openPage();

        WebUITable table = usmUsers.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("snmpUsmUsersTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySnmpViewTreesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        ViewTrees viewTrees = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mViewTrees();
        viewTrees.openPage();

        WebUITable table = viewTrees.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("snmpViewTreesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySnmpGroupsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Groups groups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mGroups();
        groups.openPage();

        WebUITable table = groups.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("snmpGroupsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySnmpAccessTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Access access = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mAccess();
        access.openPage();

        WebUITable table = access.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("snmpAccessTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySnmpCommunitiesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Communities communities = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mCommunities();
        communities.openPage();

        WebUITable table = communities.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("snmpCommunitiesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySnmpTargetParametersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        TargetParameters targetParameters = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mTargetParameters();
        targetParameters.openPage();

        WebUITable table = targetParameters.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("snmpTargetParametersTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySnmpTargetAddressesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        TargetAddresses targetAddresses = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mTargetAddresses();
        targetAddresses.openPage();

        WebUITable table = targetAddresses.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("snmpTargetAddressesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySnmpNotifyTagsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        NotifyTags notifyTags = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp().mSNMPv3().mNotifyTags();
        notifyTags.openPage();

        WebUITable table = notifyTags.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("snmpNotifyTagsTableAction"), expectedResultRBAC);
        return result;
    }
}
