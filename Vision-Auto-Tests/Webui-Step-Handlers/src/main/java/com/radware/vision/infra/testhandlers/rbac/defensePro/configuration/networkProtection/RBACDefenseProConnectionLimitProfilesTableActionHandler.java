package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.networkProtection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.connectionlimitprofiles.ConnectionLimitProfiles;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.connectionlimitprofiles.connectionlimitprotections.ConnectionLimitProtections;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProConnectionLimitProfilesTableActionHandler extends RBACHandlerBase {

    public static boolean verifyConnectionLimitProfilesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ConnectionLimitProfiles connectionLimitProfiles = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mConnectionLimitProfiles();
        connectionLimitProfiles.openPage();

        WebUITable table = connectionLimitProfiles.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("connectionLimitProfilesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyConnectionLimitProtectionsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ConnectionLimitProtections connectionLimitProtections = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mConnectionLimitProfiles().mConnectionLimitProtections();
        connectionLimitProtections.openPage();

        WebUITable table = connectionLimitProtections.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("connectionLimitProtectionsTableAction"), expectedResultRBAC);
        return result;
    }
}
