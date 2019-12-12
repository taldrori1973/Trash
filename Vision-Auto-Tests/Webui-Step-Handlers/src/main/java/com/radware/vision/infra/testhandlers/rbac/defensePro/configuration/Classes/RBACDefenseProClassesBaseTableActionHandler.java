package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.Classes;

import com.radware.automation.webui.webpages.dp.configuration.classes.applications.Applications;
import com.radware.automation.webui.webpages.dp.configuration.classes.macaddresses.MACAddresses;
import com.radware.automation.webui.webpages.dp.configuration.classes.networks.Networks;
import com.radware.automation.webui.webpages.dp.configuration.classes.physicalports.PhysicalPorts;
import com.radware.automation.webui.webpages.dp.configuration.classes.vlantags.VLANTags;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProClassesBaseTableActionHandler extends RBACHandlerBase {

    public static boolean verifyNetworksTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        Networks networks = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mClasses().mNetworks();
        networks.openPage();

        WebUITable table = networks.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("networksTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyPhysicalPortsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        PhysicalPorts physicalPorts = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mClasses().mPhysicalPorts();
        physicalPorts.openPage();

        WebUITable table = physicalPorts.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("physicalPortsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyVLANTagsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        VLANTags vlanTags = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mClasses().mVLANTags();
        vlanTags.openPage();

        WebUITable table = vlanTags.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("vlanTagsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyApplicationsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        Applications applications = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mClasses().mApplications();
        applications.openPage();

        WebUITable table = applications.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("applicationsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyMACAddressesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        MACAddresses macAddresses = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mClasses().mMACAddresses();
        macAddresses.openPage();

        WebUITable table = macAddresses.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("macAddressesTableAction"), expectedResultRBAC);
        return result;
    }

}
