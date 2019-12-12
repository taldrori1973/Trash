package com.radware.vision.infra.testhandlers.rbac.configuration.network;

import com.radware.automation.webui.webpages.configuration.network.bandwidthManagement.contractGroups.ContractGroups;
import com.radware.automation.webui.webpages.configuration.network.bandwidthManagement.trafficContracts.TrafficContracts;
import com.radware.automation.webui.webpages.configuration.network.bandwidthManagement.trafficPolicies.TrafficPolicies;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonBandwidthManagementTableActionHandler extends RBACHandlerBase {

    public static boolean verifyTrafficPoliciesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        TrafficPolicies trafficPolicies = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mBandwidthManagement().mTrafficPolicies();
        trafficPolicies.openPage();

        WebUITable table = trafficPolicies.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("trafficPoliciesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyTrafficContractsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        TrafficContracts trafficContracts = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mBandwidthManagement().mTrafficContracts();
        trafficContracts.openPage();

        WebUITable table = trafficContracts.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("trafficContractsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyContractGroupsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        ContractGroups contractGroups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mBandwidthManagement().mContractGroups();
        contractGroups.openPage();

        WebUITable table = contractGroups.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("contractGroupsTableAction"), expectedResultRBAC);
        return result;
    }
}
