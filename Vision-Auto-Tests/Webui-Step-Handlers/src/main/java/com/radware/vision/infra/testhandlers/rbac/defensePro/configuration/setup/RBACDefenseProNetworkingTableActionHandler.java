package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.setup;

import com.radware.automation.webui.webpages.dp.configuration.setup.networking.dns.DNS;
import com.radware.automation.webui.webpages.dp.configuration.setup.networking.ipManagement.IPManagement;
import com.radware.automation.webui.webpages.dp.configuration.setup.networking.ipManagement.arpTable.ARPTable;
import com.radware.automation.webui.webpages.dp.configuration.setup.networking.ipManagement.icmp.ICMP;
import com.radware.automation.webui.webpages.dp.configuration.setup.networking.ipManagement.ipRouting.IPRouting;
import com.radware.automation.webui.webpages.dp.configuration.setup.networking.portConfiguration.PortConfiguration;
import com.radware.automation.webui.webpages.dp.configuration.setup.networking.portConfiguration.linkAggregation.LinkAggregation;
import com.radware.automation.webui.webpages.dp.configuration.setup.networking.portConfiguration.portMirroring.PortMirroring;
import com.radware.automation.webui.webpages.dp.configuration.setup.networking.portPairs.PortPairs;
import com.radware.automation.webui.webpages.dp.configuration.setup.networking.sslInspection.SSLInspection;
import com.radware.automation.webui.webpages.dp.configuration.setup.networking.sslInspection.l4Ports.L4Ports;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/29/2014.
 */
public class RBACDefenseProNetworkingTableActionHandler extends RBACHandlerBase {

    public static boolean verifyPortPairsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        PortPairs portPairs = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mNetworking().mPortPairs();
        portPairs.openPage();

        WebUITable table = portPairs.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("portPairsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyLinkAggregationTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        LinkAggregation linkAggregation = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mNetworking().mPortConfiguration().mLinkAggregation();
        linkAggregation.openPage();

        WebUITable table = linkAggregation.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("linkAggregationTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyPortMirroringTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        PortMirroring portMirroring = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mNetworking().mPortConfiguration().mPortMirroring();
        portMirroring.openPage();

        WebUITable table = portMirroring.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("portMirroringTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyPortConfigurationTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        PortConfiguration portConfiguration = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mNetworking().mPortConfiguration();
        portConfiguration.openPage();

        WebUITable table = portConfiguration.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("portConfigurationTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySSLInspectionTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        SSLInspection sslInspection = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mNetworking().mSSLInspection();
        sslInspection.openPage();

        WebUITable table = sslInspection.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("sslInspectionTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyL4PortsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        L4Ports l4Ports = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mNetworking().mSSLInspection().mL4Ports();
        l4Ports.openPage();

        WebUITable table = l4Ports.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("l4PortsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyIpManagementTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        IPManagement ipManagement = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mNetworking().mIPManagement();
        ipManagement.openPage();

        WebUITable table = ipManagement.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ipManagementTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyIpRoutingTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        IPRouting ipRouting = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mNetworking().mIPManagement().mIPRouting();
        ipRouting.openPage();

        WebUITable table = ipRouting.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ipRoutingTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyICMPTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ICMP icmp = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mNetworking().mIPManagement().mICMP();
        icmp.openPage();

        WebUITable table = icmp.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("icmpTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyARPTableTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        ARPTable arpTable = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mNetworking().mIPManagement().mARPTable();
        arpTable.openPage();

        WebUITable table = arpTable.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("arpTableTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyDNSTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        DNS dns = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mNetworking().mDNS();
        dns.openPage();

        WebUITable table = dns.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("dnsTableAction"), expectedResultRBAC);
        return result;
    }

}
