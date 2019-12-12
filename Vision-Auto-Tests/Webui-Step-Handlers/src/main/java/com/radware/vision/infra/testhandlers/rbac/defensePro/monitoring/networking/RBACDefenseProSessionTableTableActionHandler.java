package com.radware.vision.infra.testhandlers.rbac.defensePro.monitoring.networking;

import com.radware.automation.webui.webpages.dp.monitoring.networking.sessionTable.sessionTableFilters.SessionTableFilters;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/2/2014.
 */
public class RBACDefenseProSessionTableTableActionHandler extends RBACHandlerBase {

    public static boolean verifySessionTableFiltersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        SessionTableFilters sessionTableFilters = DeviceVisionWebUIUtils.dpUtils.dpProduct.mMonitoring().mNetworking().mSessionTable().mSessionTableFilters();
        sessionTableFilters.openPage();

        WebUITable table = sessionTableFilters.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("sessionTableFiltersTableAction"), expectedResultRBAC);
        return result;
    }

}
