package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.setup;

import com.radware.automation.webui.webpages.dp.configuration.setup.advancedparameters.eventScheduler.EventScheduler;
import com.radware.automation.webui.webpages.dp.configuration.setup.advancedparameters.outOfPath.OutOfPath;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProAdvancedParametersTableActionHandler extends RBACHandlerBase {

    public static boolean verifyOutOfPathTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        OutOfPath outOfPath = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mAdvancedParameters().mOutOfPath();
        outOfPath.openPage();

        WebUITable table = outOfPath.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("outOfPathTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyEventSchedulerTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        EventScheduler eventScheduler = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mAdvancedParameters().mEventScheduler();
        eventScheduler.openPage();

        WebUITable table = eventScheduler.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("eventSchedulerTableAction"), expectedResultRBAC);
        return result;
    }
}
