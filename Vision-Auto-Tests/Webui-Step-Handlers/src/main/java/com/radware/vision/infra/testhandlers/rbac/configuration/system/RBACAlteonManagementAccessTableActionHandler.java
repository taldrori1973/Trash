package com.radware.vision.infra.testhandlers.rbac.configuration.system;

import basejunit.RestTestBase;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.configuration.system.managementAccess.accessControls.AccessControl;
import com.radware.automation.webui.webpages.configuration.system.managementAccess.managementPorts.ManagementPorts;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonManagementAccessTableActionHandler extends RBACHandlerBase {
    public static boolean verifyExternalMonitoringTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        ManagementPorts managementPorts = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mManagementPorts();
        managementPorts.openPage();
        managementPorts.mExternalMonitoring().openTab();
        WebUITable table = managementPorts.mExternalMonitoring().getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("externalMonitoringTableAction"), expectedResultRBAC);
        return result;
    }


    public static boolean verifyDataPortAccessTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        AccessControl accessControl = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mAccessControl();
        accessControl.openPage();

        accessControl.mDataPortAccessForManagementTraffic().openTab();
        WebUITable table = accessControl.mDataPortAccessForManagementTraffic().getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("dataPortAccessActions"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyAllowedProtocolPerNetworkTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        AccessControl accessControl = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mAccessControl();
        accessControl.openPage();

        accessControl.mAllowedProtocolsPerNetwork().openTab();
        WebUITable table = new WebUITable();
        if ((testProperties.get("managementNetwork")).equalsIgnoreCase(ManagementNetworks.IPV4.toString())) {
            table = accessControl.mAllowedProtocolsPerNetwork().getTableIpV4();
        } else if ((testProperties.get("managementNetwork")).equalsIgnoreCase(ManagementNetworks.IPV6.toString())) {
            table = accessControl.mAllowedProtocolsPerNetwork().getTableIpV6();
        } else {
            RestTestBase.report.report("incorrect Management network was provided: " + testProperties.get("managementNetwork") + "\n.", Reporter.FAIL);
        }

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("allowedProtocolPerNetworkActions"), expectedResultRBAC);
        return result;
    }

}
