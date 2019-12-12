package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 10/2/2014.
 */
public enum PortsAndTrunksTableActions {
    VIEW("VIEW_ONLY"),
    ENABLE_SELECTED_PORTS("Enable Selected Ports"),
    DISABLE_SELECTED_PORTS("Disable Selected Ports");

    private String tableAction;

    private PortsAndTrunksTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
