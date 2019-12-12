package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 10/7/2014.
 */
public enum AlertsTableActions {
    VIEW("VIEW_ONLY"),
    ACKNOWLEDGE_SELECTED_ALERTS("acknowledge"),
    UNACKNOWLEDGE_SELECTED_ALERTS("unacknowledge"),
    ACKNOWLEDGE_ALL_ALERTS("ackall"),
    CLEAR_ALL_ALERTS("clearall"),
    CLEAR_SELECTED_ALERTS("clear"),
    ALERT_FILTER("null"),
    AUTOMATIC_REFRESH_BUTTON("AutoRefreshButton");

    private String tableAction;

    private AlertsTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}

