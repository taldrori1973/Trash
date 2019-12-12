package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.accessControl;

import com.radware.automation.webui.webpages.dp.configuration.accesscontrol.aclpolicy.activepolicy.ActivePolicy;
import com.radware.automation.webui.webpages.dp.configuration.accesscontrol.aclpolicy.modifypolicy.ModifyPolicy;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/2/2014.
 */
public class RBACDefenseProACLPolicyTableActionHandler extends RBACHandlerBase {

    public static boolean verifyModifyPolicyTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ModifyPolicy modifyPolicy = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mAccessControl().mACLPolicy().mModifyPolicy();
        modifyPolicy.openPage();

        WebUITable table = modifyPolicy.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("modifyPolicyTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyActivePolicyTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ActivePolicy activePolicy = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mAccessControl().mACLPolicy().mActivePolicy();
        activePolicy.openPage();

        WebUITable table = activePolicy.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("activePolicyTableAction"), expectedResultRBAC);
        return result;
    }

}
