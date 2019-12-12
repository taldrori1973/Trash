package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.networkProtection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.bdosprofiles.BDoSProfiles;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.dnsprotectionprofiles.DNSProtectionProfiles;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.networkprotectionrules.NetworkProtectionPolicies;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.outofstateprotectionprofiles.OutOfStateProtectionProfiles;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProNetworkProtectionBaseTableActionHandler extends RBACHandlerBase {

    public static boolean verifyNetworkProtectionPoliciesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        NetworkProtectionPolicies networkProtectionPolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mNetworkProtectionPolicies();
        networkProtectionPolicies.openPage();

        WebUITable table = networkProtectionPolicies.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("networkProtectionPoliciesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyBDoSProfilesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        BDoSProfiles bdosProfiles = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mBDoSProfiles();
        bdosProfiles.openPage();

        WebUITable table = bdosProfiles.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("bdosProfilesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyDNSProtectionProfilesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        DNSProtectionProfiles dnsProtectionProfiles = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mDNSProtectionProfiles();
        dnsProtectionProfiles.openPage();

        WebUITable table = dnsProtectionProfiles.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("dnsProtectionProfilesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyOutOfStateProtectionProfilesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        OutOfStateProtectionProfiles outOfStateProtectionProfiles = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mOutOfStateProtectionProfiles();
        outOfStateProtectionProfiles.openPage();

        WebUITable table = outOfStateProtectionProfiles.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("outOfStateProtectionProfilesTableAction"), expectedResultRBAC);
        return result;
    }

}
