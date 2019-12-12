package com.radware.vision.infra.testhandlers.rbac.navigationRBAC;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.configuration.Configuration;
import com.radware.automation.webui.webpages.monitoring.Monitoring;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 1/8/2015.
 */
public class RBACAlteonNavigationHandler extends RBACHandlerBase {

    public static boolean verifyAlteonConfigurationSubMenuExistence(String item, String deviceName, String parentTree) {
        initLockDevice(deviceName, parentTree, DeviceState.Lock.getDeviceState());
        Configuration configuration = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration();
        configuration.openPage();
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getAlteonConfigurationSubMenuItem(item));
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }

    public static boolean verifyAlteonMonitoringSubMenuExistence(String item, String deviceName, String parentTree) {
        initLockDevice(deviceName, parentTree, DeviceState.Lock.getDeviceState());
        Monitoring monitoring = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mMonitoring();
        monitoring.openPage();
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getAlteonMonitoringSubMenuItem(item));
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }
}
