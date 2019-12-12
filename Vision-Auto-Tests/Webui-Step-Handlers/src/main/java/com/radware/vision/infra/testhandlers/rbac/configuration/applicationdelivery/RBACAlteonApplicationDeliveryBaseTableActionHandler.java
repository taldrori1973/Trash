package com.radware.vision.infra.testhandlers.rbac.configuration.applicationdelivery;

import com.radware.automation.webui.webpages.configuration.appDelivery.dataClass.DataClasses;
import com.radware.automation.webui.webpages.configuration.appDelivery.networkClasses.NetworkClasses;
import com.radware.automation.webui.webpages.configuration.appDelivery.portProcessing.PortProcessing;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonApplicationDeliveryBaseTableActionHandler extends RBACHandlerBase {

    public static boolean verifyPortProcessingTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortProcessing portProcessing = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mPortProcessing();
        portProcessing.openPage();

        WebUITable table = portProcessing.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("basePortProcessingTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyNetworkClassesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        NetworkClasses networkClasses = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mNetworkAppDelClasses();
        networkClasses.openPage();

        WebUITable table = networkClasses.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("baseNetworkClassesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyDataClassesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        DataClasses dataClasses = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mAppD().mDataClasses();
        dataClasses.openPage();

        WebUITable table = dataClasses.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("baseDataClassesTableAction"), expectedResultRBAC);
        return result;
    }
}
