package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.accessControl;

import com.radware.automation.webui.webpages.dp.configuration.accesscontrol.bwm.activePolicies.ActivePolicies;
import com.radware.automation.webui.webpages.dp.configuration.accesscontrol.bwm.modifyPolicies.ModifyPolicies;
import com.radware.automation.webui.webpages.dp.configuration.accesscontrol.bwm.portsBandwidthTable.PortsBandwidthTable;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/2/2014.
 */
public class RBACDefenseProBWMTableActionHandler extends RBACHandlerBase {

    public static boolean verifyModifyPoliciesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ModifyPolicies modifyPolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mAccessControl().mBWM().mModifyPolicies();
        modifyPolicies.openPage();

        WebUITable table = modifyPolicies.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("modifyPoliciesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyActivePoliciesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ActivePolicies activePolicies = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mAccessControl().mBWM().mActivePolicies();
        activePolicies.openPage();

        WebUITable table = activePolicies.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("activePoliciesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyPortsBandwidthTableTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        PortsBandwidthTable portsBandwidthTable = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mAccessControl().mBWM().mPortsBandwidthTable();
        portsBandwidthTable.openPage();

        WebUITable table = portsBandwidthTable.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("portsBandwidthTableTableAction"), expectedResultRBAC);
        return result;
    }

}
