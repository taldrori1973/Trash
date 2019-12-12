package com.radware.vision.infra.testhandlers.topologytree.enums;

/**
 * Created by stanislava on 12/28/2014.
 */
public enum FilterByStatus {
    UP("Up"),
    DOWN("Down"),
    MAINTENANCE("Maintenance"),
    UNKNOWN("Unknown"),
    NONE("None");



    private String status;

    private FilterByStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }
}
