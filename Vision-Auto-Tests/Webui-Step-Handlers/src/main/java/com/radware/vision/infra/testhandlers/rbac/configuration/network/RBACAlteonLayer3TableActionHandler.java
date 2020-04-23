package com.radware.vision.infra.testhandlers.rbac.configuration.network;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.bgp.aggregations.Aggregations;
import com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.bgp.peers.Peers;
import com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.networkFilters.NetworkFilters;
import com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.ospf.areas.Areas;
import com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.ospf.hosts.Hosts;
import com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.ospf.interfaces.Interfaces;
import com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.ospf.md5Key.MD5Key;
import com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.ospf.summaryRanges.SummaryRanges;
import com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.ospf.virtualLinks.VirtualLinks;
import com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.routeMaps.RouteMaps;
import com.radware.automation.webui.webpages.configuration.network.layer3.gateways.Gateways;
import com.radware.automation.webui.webpages.configuration.network.layer3.ipInterfaces.IPInterfaces;
import com.radware.automation.webui.webpages.configuration.network.layer3.staticARP.StaticARP;
import com.radware.automation.webui.webpages.configuration.network.layer3.staticRoutes.StaticRoutes;
import com.radware.automation.webui.webpages.configuration.network.proxyIp.ProxyIp;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonLayer3TableActionHandler extends RBACHandlerBase {
    public static boolean verifyIPInterfacesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        IPInterfaces ipInterfaces = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mIPInterfaces();
        ipInterfaces.openPage();

        WebUITable table = ipInterfaces.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ipInterfacesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyGatewaysTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Gateways gateways = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mGateways();
        gateways.openPage();

        WebUITable table = gateways.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("gatewaysTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyStaticRoutesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        StaticRoutes staticRoutes = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mStaticRoutes();
        staticRoutes.openPage();
        WebUITable table = new WebUITable();
        if (testProperties.get("managementNetwork").equalsIgnoreCase(ManagementNetworks.IPV4.getNetwork())) {
            table = staticRoutes.getTableIpV4();
        } else if (testProperties.get("managementNetwork").equalsIgnoreCase(ManagementNetworks.IPV6.getNetwork())) {
            table = staticRoutes.getTableIpV6();
        } else {
            BaseTestUtils.report("incorrect network Type was provided: " + testProperties.get("managementNetwork") + "\n.", Reporter.FAIL);
        }

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("staticRoutesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyPeersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Peers peers = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mBGP().mPeers();
        peers.openPage();

        WebUITable table = peers.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("peersTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyAggregationsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Aggregations aggregations = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mBGP().mAggregations();
        aggregations.openPage();

        WebUITable table = aggregations.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("aggregationsTableAction"), expectedResultRBAC);
        return result;
    }

    //================= OSPF ===============
    public static boolean verifyOSPFAreasTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Areas ospfAreas = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mOSPF().mAreas();
        ospfAreas.openPage();

        WebUITable table = ospfAreas.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ospfAreasTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyOSPFInterfacesTableAction(HashMap<String, String> testProperties) {
        DeviceVisionWebUIUtils.init();
        initLockDevice(testProperties);

        Interfaces ospfInterfaces = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mOSPF().mInterfaces();
        ospfInterfaces.openPage();

        WebUITable table = ospfInterfaces.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ospfInterfacesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyOSPFHostsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Hosts ospfHosts = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mOSPF().mHosts();
        ospfHosts.openPage();

        WebUITable table = ospfHosts.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ospfHostsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyOSPFVirtualLinksTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        VirtualLinks ospfVirtualLinks = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mOSPF().mVirtualLinks();
        ospfVirtualLinks.openPage();

        WebUITable table = ospfVirtualLinks.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ospfVirtualLinksTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyOSPFSummeryRangesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        SummaryRanges ospfSummaryRanges = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mOSPF().mSummaryRanges();
        ospfSummaryRanges.openPage();

        WebUITable table = ospfSummaryRanges.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ospfSummaryRangesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyOSPFMD5KeyTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        MD5Key ospfMD5Key = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mOSPF().mMD5Key();
        ospfMD5Key.openPage();

        WebUITable table = ospfMD5Key.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ospfMD5KeyTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyOSPFV3AreasTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.ospfV3.areas.Areas ospfV3Areas = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mOSPFv3().mAreas();
        ospfV3Areas.openPage();

        WebUITable table = ospfV3Areas.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ospfV3AreasTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyOSPFV3InterfacesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.ospfV3.interfaces.Interfaces ospfV3Interfaces = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mOSPFv3().mInterfaces();
        ospfV3Interfaces.openPage();

        WebUITable table = ospfV3Interfaces.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ospfV3InterfacesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyOSPFV3HostsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.ospfV3.hosts.Hosts ospfV3Hosts = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mOSPFv3().mHosts();
        ospfV3Hosts.openPage();

        WebUITable table = ospfV3Hosts.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ospfV3HostsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyOSPFV3VirtualLinksTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.ospfV3.virtualLinks.VirtualLinks ospfV3VirtualLinks = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mOSPFv3().mVirtualLinks();
        ospfV3VirtualLinks.openPage();

        WebUITable table = ospfV3VirtualLinks.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ospfV3VirtualLinksTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyOSPFV3SummeryRangesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.ospfV3.summaryRanges.SummaryRanges ospfV3SummaryRanges = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mOSPFv3().mSummaryRanges();
        ospfV3SummaryRanges.openPage();

        WebUITable table = ospfV3SummaryRanges.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ospfV3SummaryRangesTableAction"), expectedResultRBAC);
        return result;
    }

    //=================
    public static boolean verifyRIPInterfacesTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        com.radware.automation.webui.webpages.configuration.network.layer3.dynamicRouting.rip.interfaces.Interfaces ripInterfaces = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mRIP().mInterfaces();
        ripInterfaces.openPage();

        WebUITable table = ripInterfaces.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("ripInterfacesTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyNetworkFiltersTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        NetworkFilters networkFilters = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mNetworkFilters();
        networkFilters.openPage();

        WebUITable table = networkFilters.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("networkFiltersTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyRouteMapsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        RouteMaps routeMaps = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mDynamicRouting().mRouteMaps();
        routeMaps.openPage();

        WebUITable table = routeMaps.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("routeMapsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyStaticARPTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        StaticARP staticARP = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer3().mStaticARP();
        staticARP.openPage();

        WebUITable table = staticARP.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("staticARPTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyProxyIPTableAction(HashMap<String, String> testProperties) {
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
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("proxyIPTableAction"), expectedResultRBAC);
        return result;
    }
}
