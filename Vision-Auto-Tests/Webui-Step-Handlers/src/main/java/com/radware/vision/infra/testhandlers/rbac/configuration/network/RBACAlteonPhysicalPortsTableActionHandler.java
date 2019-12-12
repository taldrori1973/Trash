package com.radware.vision.infra.testhandlers.rbac.configuration.network;

import com.radware.automation.webui.webpages.configuration.network.phPorts.portMirroring.PortMirroring;
import com.radware.automation.webui.webpages.configuration.network.phPorts.portSettings.PortSettings;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonPhysicalPortsTableActionHandler extends RBACHandlerBase {
    public static boolean verifyPortSettingsTableAction(HashMap<String, String> testProperties) {
        DeviceVisionWebUIUtils.init();
        initLockDevice(testProperties);
        PortSettings portSettings = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mPhysicalPorts().mPortSettings();
        portSettings.openPage();

        WebUITable table = portSettings.getTable();

        if (table.getRowsNumber() > 0 && Boolean.valueOf(testProperties.get("clickOnRow"))) {
            table.clickOnRow(0);
        }
        boolean result = table.isTableActionDisabled(testProperties.get("portSettingsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyPortMirroringTableAction(HashMap<String, String> testProperties) {
        DeviceVisionWebUIUtils.init();
        initLockDevice(testProperties);
        PortMirroring portMirroring = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mPhysicalPorts().mPortMirroring();
        portMirroring.openPage();

        WebUITable table = portMirroring.getTable();

        if (table.getRowsNumber() > 0 && Boolean.valueOf(testProperties.get("clickOnRow"))) {
            table.clickOnRow(0);
        }
        boolean result = table.isTableActionDisabled(testProperties.get("portMirroringTableAction"), expectedResultRBAC);
        return result;
    }
}
