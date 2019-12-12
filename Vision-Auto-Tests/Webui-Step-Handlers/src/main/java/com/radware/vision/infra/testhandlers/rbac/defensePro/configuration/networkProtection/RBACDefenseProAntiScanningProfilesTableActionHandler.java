package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.networkProtection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.antiscanningprofiles.AntiScanningProfiles;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.antiscanningprofiles.antiScanningTrustedPorts.AntiScanningTrustedPorts;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProAntiScanningProfilesTableActionHandler extends RBACHandlerBase {

    public static boolean verifyAntiScanningProfilesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        AntiScanningProfiles antiScanningProfiles = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mAntiScanningProfiles();
        antiScanningProfiles.openPage();

        WebUITable table = antiScanningProfiles.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("antiScanningProfilesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyAntiScanningTrustedPortsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        AntiScanningTrustedPorts antiScanningTrustedPorts = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mAntiScanningProfiles().mAntiScanningTrustedPorts();
        antiScanningTrustedPorts.openPage();

        WebUITable table = antiScanningTrustedPorts.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("antiScanningTrustedPortsTableAction"), expectedResultRBAC);
        return result;
    }
}
