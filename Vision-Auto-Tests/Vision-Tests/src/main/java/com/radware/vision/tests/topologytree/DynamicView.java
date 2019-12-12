package com.radware.vision.tests.topologytree;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.topologytree.DynamicViewHandler;
import com.radware.vision.infra.testhandlers.topologytree.enums.FilterByStatus;
import com.radware.vision.infra.testhandlers.topologytree.enums.FilterByType;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by stanislava on 12/28/2014.
 */
public class DynamicView extends WebUITestBase {

    FilterByStatus filterByStatus;
    String filterByName;
    String filterByIp;
    FilterByType filterByType;

    @Test
    @TestProperties(name = "Dynamic View for Sites and Clusters", paramsInclude = {"qcTestId", "filterByStatus", "filterByName", "filterByIp", "filterByType"})
    public void dynamicViewSitesAndClusters() throws Exception {
        try {
            DynamicViewHandler.topologyTreeTab = TopologyTreeTabs.SitesAndClusters;
            DynamicViewHandler dynamicViewHandler = new DynamicViewHandler();
            if (!dynamicViewHandler.setDynamicViewSitesAndClusters(filterByStatus, filterByName, filterByIp, filterByType)) {
                report.report("Dynamic view filtered incorrectly: ", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("The dynamic view may not be fully functional :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Dynamic View for Physical Containers", paramsInclude = {"qcTestId", "filterByStatus", "filterByName", "filterByIp"})
    public void dynamicViewPhysicalContainers() throws Exception {
        try {
            DynamicViewHandler.topologyTreeTab = TopologyTreeTabs.PhysicalContainers;
            DynamicViewHandler dynamicViewHandler = new DynamicViewHandler();
            if (!dynamicViewHandler.setDynamicViewPhysicalContainers(filterByStatus, filterByName, filterByIp)) {
                report.report("Dynamic view filtered incorrectly: ", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("The dynamic view may not be fully functional :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    public String getFilterByName() {
        return filterByName;
    }

    public void setFilterByName(String filterByName) {
        this.filterByName = filterByName;
    }

    public String getFilterByIp() {
        return filterByIp;
    }

    public void setFilterByIp(String filterByIp) {
        this.filterByIp = filterByIp;
    }

    public FilterByStatus getFilterByStatus() {
        return filterByStatus;
    }

    public void setFilterByStatus(FilterByStatus filterByStatus) {
        this.filterByStatus = filterByStatus;
    }

    public FilterByType getFilterByType() {
        return filterByType;
    }

    public void setFilterByType(FilterByType filterByType) {
        this.filterByType = filterByType;
    }
}
