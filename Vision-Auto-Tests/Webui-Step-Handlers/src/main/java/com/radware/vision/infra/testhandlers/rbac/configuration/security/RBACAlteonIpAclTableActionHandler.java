package com.radware.vision.infra.testhandlers.rbac.configuration.security;

import com.radware.automation.webui.webpages.configuration.security.ipAcl.blockedDestinationAddresses.BlockedDestinationAddresses;
import com.radware.automation.webui.webpages.configuration.security.ipAcl.blockedSourceAddresses.BlockedSourceAddresses;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/23/2014.
 */
public class RBACAlteonIpAclTableActionHandler extends RBACHandlerBase {

    public static boolean verifyBlockedSourceAddressesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        BlockedSourceAddresses blockedSourceAddresses = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSecurity().mIpAcl().mBlockedSrcAddresses();
        blockedSourceAddresses.openPage();

        WebUITable table = blockedSourceAddresses.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("blockedSourceAddressesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyBlockedDestinationAddressesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        BlockedDestinationAddresses blockedDestinationAddresses = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSecurity().mIpAcl().mBlockedDestAddresses();
        blockedDestinationAddresses.openPage();

        WebUITable table = blockedDestinationAddresses.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("blockedDestinationAddressesTableAction"), expectedResultRBAC);
        return result;
    }

}
