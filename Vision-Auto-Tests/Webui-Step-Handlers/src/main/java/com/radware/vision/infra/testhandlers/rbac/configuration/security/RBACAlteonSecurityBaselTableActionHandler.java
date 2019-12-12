package com.radware.vision.infra.testhandlers.rbac.configuration.security;

import com.radware.automation.webui.webpages.configuration.security.portProtection.PortProtection;
import com.radware.automation.webui.webpages.configuration.security.udpBlast.UDPBlast;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/23/2014.
 */
public class RBACAlteonSecurityBaselTableActionHandler extends RBACHandlerBase {

    public static boolean verifyPortProtectionTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortProtection portProtection = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSecurity().mPortProtection();
        portProtection.openPage();

        WebUITable table = portProtection.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("portProtectionTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyUDPBlastTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        UDPBlast udpBlast = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSecurity().mUDPBlast();
        udpBlast.openPage();

        WebUITable table = udpBlast.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("udpBlastTableAction"), expectedResultRBAC);
        return result;
    }
}
