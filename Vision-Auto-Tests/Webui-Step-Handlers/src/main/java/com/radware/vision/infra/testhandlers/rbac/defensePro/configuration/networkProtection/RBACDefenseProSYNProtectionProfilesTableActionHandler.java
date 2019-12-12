package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.networkProtection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.synprotectionprofiles.SYNProtectionProfiles;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.synprotectionprofiles.profilesparameters.ProfilesParameters;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.synprotectionprofiles.sslmitigationpolicies.SSLMitigationPolicies;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.synprotectionprofiles.synprotections.SYNProtections;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProSYNProtectionProfilesTableActionHandler extends RBACHandlerBase {

    public static boolean verifySYNProtectionProfilesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        SYNProtectionProfiles synProtectionProfiles = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSYNProtectionProfiles();
        synProtectionProfiles.openPage();

        WebUITable table = synProtectionProfiles.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("synProtectionProfilesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySYNProtectionsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        SYNProtections synProtections = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSYNProtectionProfiles().mSYNProtections();
        synProtections.openPage();

        WebUITable table = synProtections.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("synProtectionsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyProfilesParametersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ProfilesParameters profilesParameters = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSYNProtectionProfiles().mProfilesParameters();
        profilesParameters.openPage();

        WebUITable table = profilesParameters.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("profilesParametersTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySSLMitigationPoliciesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        SSLMitigationPolicies sslMitigationPolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSYNProtectionProfiles().mSSLMitigationPolicies();
        sslMitigationPolicies.openPage();

        WebUITable table = sslMitigationPolicies.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("sslMitigationPoliciesTableAction"), expectedResultRBAC);
        return result;
    }

}
