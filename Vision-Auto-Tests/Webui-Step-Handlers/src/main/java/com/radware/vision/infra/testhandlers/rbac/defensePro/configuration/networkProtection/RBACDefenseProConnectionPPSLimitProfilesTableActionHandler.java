package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.networkProtection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.connectionppslimitprofiles.ConnectionPPSLimitProfiles;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.connectionppslimitprofiles.connectionPPSLimitProtections.ConnectionPPSLimitProtections;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProConnectionPPSLimitProfilesTableActionHandler extends RBACHandlerBase {

    public static boolean verifyConnectionPPSLimitProfilesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ConnectionPPSLimitProfiles connectionPPSLimitProfiles = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mConnectionPPSLimitProfiles();
        connectionPPSLimitProfiles.openPage();

        WebUITable table = connectionPPSLimitProfiles.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("connectionPPSLimitProfilesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyConnectionPPSLimitProtectionsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ConnectionPPSLimitProtections connectionPPSLimitProtections = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mConnectionPPSLimitProfiles().mConnectionPPSLimitProtections();
        connectionPPSLimitProtections.openPage();

        WebUITable table = connectionPPSLimitProtections.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("connectionPPSLimitProtectionsTableAction"), expectedResultRBAC);
        return result;
    }

}
