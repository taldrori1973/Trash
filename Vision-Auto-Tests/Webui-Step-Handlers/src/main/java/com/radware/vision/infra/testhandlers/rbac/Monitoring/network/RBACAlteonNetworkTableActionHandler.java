package com.radware.vision.infra.testhandlers.rbac.Monitoring.network;

import com.radware.automation.webui.webpages.monitoring.Network.Layer3.vrrpVirtualRouters.VRRPVirtualRouters;
import com.radware.automation.webui.webpages.monitoring.Network.physicalPort.physicalPorts;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/23/2014.
 */
public class RBACAlteonNetworkTableActionHandler extends RBACHandlerBase {

    public static boolean verifyPhysicalPortsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        physicalPorts physicalports = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mMonitoring().mNetwork().mPhysicalPorts();
        physicalports.openPage();

        WebUITable table = physicalports.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("physicalPortsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyVRRPVirtualRoutersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        VRRPVirtualRouters vrrpVirtualRouters = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mMonitoring().mNetwork().mLayer3().mVRRPVirtualRouters();
        vrrpVirtualRouters.openPage();

        WebUITable table = vrrpVirtualRouters.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("vrrpVirtualRoutersTableAction"), expectedResultRBAC);
        return result;
    }

}
