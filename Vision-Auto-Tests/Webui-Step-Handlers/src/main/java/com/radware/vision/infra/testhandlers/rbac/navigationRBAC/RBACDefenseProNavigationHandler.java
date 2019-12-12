package com.radware.vision.infra.testhandlers.rbac.navigationRBAC;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.dp.configuration.Configuration;
import com.radware.automation.webui.webpages.dp.monitoring.Monitoring;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 1/8/2015.
 */
public class RBACDefenseProNavigationHandler extends RBACHandlerBase {

    public static boolean verifyDefenseProConfigurationSubMenuExistence(String item, String deviceName, String parentTree) {
        initLockDevice(deviceName, parentTree, DeviceState.Lock.getDeviceState());
        Configuration configuration = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration();
        configuration.openPage();
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getDefenceProConfigurationSubMenuItem(item));
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }

    public static boolean verifyDefenseProMonitoringSubMenuExistence(String item, String deviceName, String parentTree) {
        initLockDevice(deviceName, parentTree, DeviceState.Lock.getDeviceState());
        Monitoring monitoring = DeviceVisionWebUIUtils.dpUtils.dpProduct.mMonitoring();
        monitoring.openPage();
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getDefenceProMonitoringSubMenuItem(item));
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }

    public static boolean verifyDefenseProSecurityMonitoringSubMenuExistence(String item, String deviceName, String parentTree) {
        initLockDevice(deviceName, parentTree, DeviceState.Lock.getDeviceState());
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        menuPane.openSecurityMonitoringPane();

        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getDefenceProSecurityMonitoringSubMenuItem(item));
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }

    public static void initLockDevice(String deviceName, String parentTree, String deviceState) {
        DeviceOperationsHandler.lockUnlockDevice(deviceName, parentTree, deviceState, true);
    }
}
