package com.radware.vision.infra.testhandlers.topologytree;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.vision.infra.base.pages.VisionServerInfoPane;
import com.radware.vision.infra.base.pages.topologytree.DeviceProperties;
import com.radware.vision.infra.base.pages.topologytree.StandardDeviceProperties;
import com.radware.vision.infra.base.pages.topologytree.TreeSelection;
import com.radware.vision.infra.base.pages.topologytree.dynamicview.DynamicView;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.topologytree.dynamicViewUtils.DynamicViewFilter;
import com.radware.vision.infra.testhandlers.topologytree.enums.DynamicViewFilters;
import com.radware.vision.infra.testhandlers.topologytree.enums.FilterByStatus;
import com.radware.vision.infra.testhandlers.topologytree.enums.FilterByType;
import org.openqa.selenium.WebElement;

import java.util.List;

/**
 * Created by stanislava on 12/28/2014.
 */
public class DynamicViewHandler {

    public static String nodesShouldNotBeSeen = "";
    public static TopologyTreeTabs topologyTreeTab;

    public boolean setDynamicViewSitesAndClusters(FilterByStatus filterByStatus, String filterByName, String filterByIp, FilterByType filterByType) {
        boolean isValid;
        List<WebElement> nodes = TopologyTreeHandler.getNodes();
        TreeSelection treeSelection = new TreeSelection();
        treeSelection.openSitesAndClustersTree();
        int expectedDevicesCount = getNodesAmount(nodes, filterByStatus, filterByName, filterByIp, filterByType, false);

        if (filterByStatus != FilterByStatus.NONE) {
            DynamicView.setDynamicViewFilter(DynamicViewFilters.FILTER_BY_STATUS, filterByStatus.getStatus());
        }
        DynamicView.setDynamicViewFilter(DynamicViewFilters.FILTER_BY_NAME, filterByName);
        DynamicView.setDynamicViewFilter(DynamicViewFilters.FILTER_BY_IP, filterByIp);

        if (filterByType != FilterByType.NONE) {
            DynamicView.setDynamicViewFilter(DynamicViewFilters.FILTER_BY_TYPE, filterByType.getType());
        }

        isValid = validateSearch(filterByStatus, filterByName, filterByIp, filterByType, expectedDevicesCount);
        DynamicView.searchButtonClick();
        return isValid;
    }

    public boolean setDynamicViewPhysicalContainers(FilterByStatus filterByStatus, String filterByName, String filterByIp) {
        boolean isValid;
        List<WebElement> nodes = TopologyTreeHandler.getNodes();
        TreeSelection treeSelection = new TreeSelection();
        treeSelection.openPhysicalContainersTree();
        int expectedDevicesCount = getNodesAmount(nodes, filterByStatus, filterByName, filterByIp, null, false);

        if (filterByStatus != FilterByStatus.NONE) {
            DynamicView.setDynamicViewFilter(DynamicViewFilters.FILTER_BY_STATUS, filterByStatus.getStatus());
        }
        DynamicView.setDynamicViewFilter(DynamicViewFilters.FILTER_BY_NAME, filterByName);
        DynamicView.setDynamicViewFilter(DynamicViewFilters.FILTER_BY_IP, filterByIp);
        DynamicView.searchButtonClick();
        isValid = validateSearch(filterByStatus, filterByName, filterByIp, null, expectedDevicesCount);

        DynamicView.searchButtonClick();
        return isValid;
    }

    public boolean validateSearch(FilterByStatus filterByStatus, String filterByName, String filterByIp, FilterByType filterByType, int expectedDevicesCount) {
        boolean isFilterValid = false;
        List<WebElement> nodes = TopologyTreeHandler.getNodes();
        int actualDevicesCount = getNodesAmount(nodes, filterByStatus, filterByName, filterByIp, filterByType, true);
        if (!nodesShouldNotBeSeen.equals("")) {
            BaseTestUtils.report("Nodes should not be seen: " + nodesShouldNotBeSeen + "\n.", Reporter.FAIL);
        } else {
            if (actualDevicesCount == expectedDevicesCount) {
                isFilterValid = true;
            }
        }
        return isFilterValid;
    }

    public int getNodesAmount(List<WebElement> nodes, FilterByStatus filterByStatus, String filterByName, String filterByIp, FilterByType filterByType, boolean isActual) {
        int devicesCount = 0;
        String actualFilterByType = null;

        DynamicViewFilter expectedFilter = setExpectedFilter(filterByStatus, filterByName, filterByIp, filterByType);
        DynamicViewFilter actualFilter;
        for (int i = 0; i < nodes.size(); i++) {
            actualFilter = setActualFilteredLeaf(nodes.get(i));
            if (!TopologyTreeTabs.PhysicalContainers.equals(topologyTreeTab)) {
                actualFilterByType = actualFilter.getFilterByType();
            }
            nodes = TopologyTreeHandler.getNodes();
            if (!nodes.get(i).getAttribute("id").contains(WebUIStrings.getDeviceTreeNode("Default"))) {
                if (expectedFilter.compareFilter(actualFilter.getFilterByStatus(), actualFilter.getFilterByName(), actualFilter.getFilterByIP(), actualFilterByType)) {
                    devicesCount++;
                } else {
                    if (isActual) {
                        nodesShouldNotBeSeen = nodesShouldNotBeSeen.concat(nodes.get(i).getAttribute("id").concat(", "));
                    }
                }
            }
        }
        return devicesCount;
    }

    public DynamicViewFilter setExpectedFilter(FilterByStatus filterByStatus, String filterByName, String filterByIp, FilterByType filterByType) {
        DynamicViewFilter filter = new DynamicViewFilter();
        filter.setFilterByStatus(filterByStatus.getStatus());
        filter.setFilterByName(filterByName);
        filter.setFilterByIP(filterByIp);
        if (filterByType != null) {
            filter.setFilterByType(filterByType.getType());
        }
        return filter;
    }

    public DynamicViewFilter setActualFilteredLeaf(WebElement node) {
        DynamicViewFilter filter = new DynamicViewFilter();
        DeviceProperties deviceProperties;
        if (node.getAttribute("class").contains("alteon") || node.getAttribute("class").contains("dp")) {
            node.click();
            deviceProperties = new StandardDeviceProperties();
            deviceProperties.viewDevice();
            VisionServerInfoPane infoPane = new VisionServerInfoPane();
            filter.setFilterByStatus(infoPane.getDeviceStatus());
            filter.setFilterByType(infoPane.getDeviceType());
            filter.setFilterByIP(infoPane.getDeviceHost());
            filter.setFilterByName(infoPane.getDeviceNameWithOutType());
        }
        return filter;
    }
}
