package com.radware.vision.infra.testhandlers.topologytree.enums;

/**
 * Created by stanislava on 12/28/2014.
 */
public enum DynamicViewFilters {
    FILTER_BY_STATUS("filterByStatus"),
    FILTER_BY_NAME("filterByName"),
    FILTER_BY_IP("filterByIP"),
    FILTER_BY_TYPE("filterByType");


    private String filter;

    private DynamicViewFilters(String filter) {
        this.filter = filter;
    }

    public String getFilter() {
        return this.filter;
    }
}
