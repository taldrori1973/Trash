package com.radware.vision.infra.testhandlers.topologytree.dynamicViewUtils;

/**
 * Created by stanislava on 12/31/2014.
 */
public class DynamicViewFilter {

    String filterByStatus;
    String filterByName;
    String filterByIP;
    String filterByType;

    public DynamicViewFilter() {
    }

    public String getFilterByName() {
        return filterByName;
    }

    public void setFilterByName(String filterByName) {
        this.filterByName = filterByName;
    }

    public String getFilterByIP() {
        return filterByIP;
    }

    public void setFilterByIP(String filterByIP) {
        this.filterByIP = filterByIP;
    }

    public String getFilterByStatus() {
        return filterByStatus;
    }

    public void setFilterByStatus(String filterByStatus) {
        this.filterByStatus = filterByStatus;
    }

    public String getFilterByType() {
        return filterByType;
    }

    public void setFilterByType(String filterByType) {
        this.filterByType = filterByType;
    }

    public boolean compareFilter(String byStatusLeaf, String byNameLeaf, String byIPLeaf, String byTypeLeaf) {
        boolean validFilterByStatus = true;
        boolean validFilterByName = true;
        boolean validFilterByIP = true;
        boolean validFilterByType = true;

        if (filterByStatus == null || byStatusLeaf == null) {
            validFilterByStatus = false;
        }
        if (filterByName == null || byNameLeaf == null) {
            validFilterByName = false;
        }
        if (filterByIP == null || byIPLeaf == null) {
            validFilterByIP = false;
        }
        if (filterByType == null || byTypeLeaf == null) {
            validFilterByType = false;
        }

        if (((validFilterByStatus && filterByStatus.contains(byStatusLeaf)) || filterByStatus == null) && ((validFilterByName && filterByName.contains(byNameLeaf)) || filterByName == null) && ((validFilterByIP && filterByIP.contains(byIPLeaf)) || filterByIP == null) && ((validFilterByType && filterByType.contains(byTypeLeaf)) || filterByType == null)) {
            return true;
        }
        return false;
    }
}
