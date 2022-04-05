package com.radware.vision.infra.testhandlers.rbac.configuration.network;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.configuration.network.proxyIp.ProxyIp;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonNetworkBaseTableActionHandler extends RBACHandlerBase {
    public static boolean verifyProxyIPTableAction(HashMap<String, String> testProperties) {
        DeviceVisionWebUIUtils.init();
        initLockDevice(testProperties);
        WebUITable table = new WebUITable();
        ProxyIp proxyIp = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mProxyIp();
        proxyIp.openPage();


        if (testProperties.get("managementNetwork").equalsIgnoreCase(ManagementNetworks.IPV4.getNetwork())) {
            proxyIp.mProxyIpv4().openTab();
            table = proxyIp.mProxyIpv4().getTableIpV4();
        } else if (testProperties.get("managementNetwork").equalsIgnoreCase(ManagementNetworks.IPV6.getNetwork())) {
            proxyIp.mProxyIpv6().openTab();
            table = proxyIp.mProxyIpv6().getTableIpV6();
        } else {
            BaseTestUtils.report("incorrect network Type was provided: " + testProperties.get("managementNetwork") + "\n.", Reporter.FAIL);
        }

        if (table.getRowsNumber() > 0 && Boolean.valueOf(testProperties.get("clickOnRow"))) {
            table.clickOnRow(0);
        }
        boolean result = table.isTableActionDisabled(testProperties.get("proxyIPTableAction"), expectedResultRBAC);
        return result;
    }

}
