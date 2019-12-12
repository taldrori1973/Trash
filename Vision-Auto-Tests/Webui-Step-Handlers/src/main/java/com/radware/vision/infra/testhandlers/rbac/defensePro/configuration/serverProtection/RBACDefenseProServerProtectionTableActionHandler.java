package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.serverProtection;

import com.radware.automation.webui.webpages.dp.configuration.serverprotection.httpfloodprofiles.HTTPFloodProfiles;
import com.radware.automation.webui.webpages.dp.configuration.serverprotection.servercrackingprofiles.ServerCrackingProfiles;
import com.radware.automation.webui.webpages.dp.configuration.serverprotection.servercrackingprofiles.servercrackingprotections.ServerCrackingProtections;
import com.radware.automation.webui.webpages.dp.configuration.serverprotection.serverprotectionpolicy.ServerProtectionPolicy;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/2/2014.
 */
public class RBACDefenseProServerProtectionTableActionHandler extends RBACHandlerBase {

    public static boolean verifyServerProtectionPoliciesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ServerProtectionPolicy serverProtectionPolicy = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mServerProtection().mServerProtectionPolicy();
        serverProtectionPolicy.openPage();

        WebUITable table = serverProtectionPolicy.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("serverProtectionPoliciesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyServerCrackingProfilesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ServerCrackingProfiles serverCrackingProfiles = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mServerProtection().mServerCrackingProfiles();
        serverCrackingProfiles.openPage();

        WebUITable table = serverCrackingProfiles.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("serverCrackingProfilesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyServerCrackingProtectionsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ServerCrackingProtections serverCrackingProtections = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mServerProtection().mServerCrackingProfiles().mServerCrackingProtections();
        serverCrackingProtections.openPage();

        WebUITable table = serverCrackingProtections.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("serverCrackingProtectionsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyHTTPFloodProfilesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        HTTPFloodProfiles httpFloodProfiles = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mServerProtection().mHTTPFloodProfiles();
        httpFloodProfiles.openPage();

        WebUITable table = httpFloodProfiles.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("httpFloodProfilesTableAction"), expectedResultRBAC);
        return result;
    }

}
