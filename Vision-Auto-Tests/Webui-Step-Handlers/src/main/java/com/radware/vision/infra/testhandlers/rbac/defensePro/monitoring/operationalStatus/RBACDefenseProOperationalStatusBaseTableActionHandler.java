package com.radware.vision.infra.testhandlers.rbac.defensePro.monitoring.operationalStatus;

import com.radware.automation.webui.webpages.dp.monitoring.operationalstatus.portsAndTrunks.PortsAndTrunks;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/2/2014.
 */
public class RBACDefenseProOperationalStatusBaseTableActionHandler extends RBACHandlerBase {

    public static boolean verifyPortsAndTrunksTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        PortsAndTrunks portsAndTrunks = DeviceVisionWebUIUtils.dpUtils.dpProduct.mMonitoring().mOperationalStatus().mPortsAndTrunks();
        portsAndTrunks.openPage();

        WebUITable table = portsAndTrunks.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("portsAndTrunksTableAction"), expectedResultRBAC);
        return result;
    }

}
