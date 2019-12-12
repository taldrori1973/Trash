package com.radware.vision.infra.testhandlers.rbac.configuration.network;

import com.radware.automation.webui.webpages.configuration.network.highAvailability.peerTrafficForwarding.PeerTrafficForwarding;
import com.radware.automation.webui.webpages.configuration.network.highAvailability.portProcessing.PortProcessing;
import com.radware.automation.webui.webpages.configuration.network.highAvailability.sync.Sync;
import com.radware.automation.webui.webpages.configuration.network.highAvailability.virtualRouterGroups.VirtualRouterGroups;
import com.radware.automation.webui.webpages.configuration.network.highAvailability.virtualRouters.VirtualRouters;
import com.radware.automation.webui.webpages.configuration.network.highAvailability.vrrpAuthentication.VrrpAuthentication;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonHighAvailabilityTableActionHandler extends RBACHandlerBase {
    public static boolean verifyVirtualRoutersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        VirtualRouters virtualRouters = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mHighAvailability().mVirtualRouters();
        virtualRouters.openPage();

        WebUITable table = virtualRouters.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("virtualRoutersTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyServiceBasedTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        VirtualRouterGroups virtualRouterGroups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mHighAvailability().mVirtualRouterGroups();
        virtualRouterGroups.openPage();

        virtualRouterGroups.mServiceBased().openTab();
        WebUITable table = virtualRouterGroups.mServiceBased().getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("serviceBasedTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyVRRPAuthenticationTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        VrrpAuthentication vrrpAuthentication = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mHighAvailability().mVrrpAuthentication();
        vrrpAuthentication.openPage();

        WebUITable table = vrrpAuthentication.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("vrrpAuthenticationTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySyncTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Sync sync = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mHighAvailability().mSync();
        sync.openPage();

        WebUITable table = sync.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("syncTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyPeerTrafficForwardingTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PeerTrafficForwarding peerTrafficForwarding = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mHighAvailability().mPeerTrafficForwarding();
        peerTrafficForwarding.openPage();

        WebUITable table = peerTrafficForwarding.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("peerTrafficForwardingTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyPortProcessingTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortProcessing portProcessing = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mHighAvailability().mPortProcessing();
        portProcessing.openPage();

        WebUITable table = portProcessing.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("portProcessingTableAction"), expectedResultRBAC);
        return result;
    }

}
