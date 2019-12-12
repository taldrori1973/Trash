package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.networkProtection;

import com.radware.automation.webui.webpages.dp.configuration.networkprotection.signatureprotection.attributes.Attributes;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.signatureprotection.attributes.attributeTypeProperties.AttributeTypeProperties;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.signatureprotection.profiles.Profiles;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.signatureprotection.signatures.Signatures;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.signatureprotection.webquarantine.quarantineActions.QuarantineActions;
import com.radware.automation.webui.webpages.dp.configuration.networkprotection.signatureprotection.webquarantine.quarantinedSources.QuarantinedSources;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProSignatureProtectionTableActionHandler extends RBACHandlerBase {

    public static boolean verifyProfilesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        Profiles profiles = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSignatureProtection().mProfiles();
        profiles.openPage();

        WebUITable table = profiles.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("profilesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySignaturesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        Signatures signatures = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSignatureProtection().mSignatures();
        signatures.openPage();

        WebUITable table = signatures.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("signaturesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyAttributesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        Attributes attributes = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSignatureProtection().mAttributes();
        attributes.openPage();

        WebUITable table = attributes.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("attributesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyAttributeTypePropertiesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        AttributeTypeProperties attributeTypeProperties = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSignatureProtection().mAttributes().mAttributeTypeProperties();
        attributeTypeProperties.openPage();

        WebUITable table = attributeTypeProperties.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("attributeTypePropertiesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyQuarantineActionsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        QuarantineActions quarantineActions = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSignatureProtection().mWebQuarantine().mQuarantineActions();
        quarantineActions.openPage();

        WebUITable table = quarantineActions.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("quarantineActionsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyQuarantinedSourcesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        QuarantinedSources quarantinedSources = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mNetworkProtection().mSignatureProtection().mWebQuarantine().mQuarantinedSources();
        quarantinedSources.openPage();

        WebUITable table = quarantinedSources.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("quarantinedSourcesTableAction"), expectedResultRBAC);
        return result;
    }

}
