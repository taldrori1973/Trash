package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/21/2014.
 */
public enum AppShapeTableActions {
    EDIT("EDIT"),
    DELETE("DELETE"),
    IMPORT("Import"),
    EXPORT("Export"),;

    private String tableAction;

    private AppShapeTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
