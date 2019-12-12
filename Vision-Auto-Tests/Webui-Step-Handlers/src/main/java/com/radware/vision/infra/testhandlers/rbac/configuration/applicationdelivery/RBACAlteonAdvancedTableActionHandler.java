package com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery;

import com.radware.automation.webui.webpages.configuration.appDelivery.advanced.inboundLinkLB.InboundLinkLB;
import com.radware.automation.webui.webpages.configuration.appDelivery.advanced.serverInitiatedConnections.ServerInitiatedConnections;
import com.radware.automation.webui.webpages.configuration.appDelivery.advanced.workloadManager.WorkloadManager;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonAdvancedTableActionHandler extends RBACHandlerBase {

    public static boolean verifyInboundLinkLBTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        InboundLinkLB inboundLinkLB = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mAdvanced().mInboundLinkLB();
        inboundLinkLB.openPage();

        WebUITable table = inboundLinkLB.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("inboundLinkLBTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyWorkloadManagerTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        WorkloadManager workloadManager = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mAdvanced().mWorkloadManager();
        workloadManager.openPage();

        WebUITable table = workloadManager.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("workloadManagerTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyServerInitiatedConnectionsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        ServerInitiatedConnections serverInitiatedConnections = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mAdvanced().mServerInitiatedConnections();
        serverInitiatedConnections.openPage();

        WebUITable table = serverInitiatedConnections.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("serverInitiatedConnectionsTableAction"), expectedResultRBAC);
        return result;
    }
}
