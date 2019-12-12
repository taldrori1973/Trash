package com.radware.vision.infra.testhandlers.rbac.defensePro.monitoring.networking;

import com.radware.automation.webui.webpages.dp.monitoring.networking.mplsrd.MplsRD;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/2/2014.
 */
public class RBACDefenseProNetworkingBaseTableActionHandler extends RBACHandlerBase {

    public static boolean verifyMplsRDTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        MplsRD mplsRD = DeviceVisionWebUIUtils.dpUtils.dpProduct.mMonitoring().mNetworking().mMplsRD();
        mplsRD.openPage();

        WebUITable table = mplsRD.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("mplsRDTableAction"), expectedResultRBAC);
        return result;
    }

}
