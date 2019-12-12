package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.accessControl;

import com.radware.automation.webui.webpages.dp.configuration.accesscontrol.blackandwhitelists.blacklist.BlackList;
import com.radware.automation.webui.webpages.dp.configuration.accesscontrol.blackandwhitelists.whitelist.WhiteList;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/2/2014.
 */
public class RBACDefenseProBlackListsAndWhiteListsTableActionHandler extends RBACHandlerBase {

    public static boolean verifyWhiteListTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        WhiteList whiteList = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mAccessControl().mBlackAndWhiteLists().mWhiteList();
        whiteList.openPage();

        WebUITable table = whiteList.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("whiteListTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyBlackListTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        BlackList blackList = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mAccessControl().mBlackAndWhiteLists().mBlackList();
        blackList.openPage();

        WebUITable table = blackList.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("blackListTableAction"), expectedResultRBAC);
        return result;
    }

}
