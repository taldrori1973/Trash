package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/23/2014.
 */
public enum ImportBaseTableActions {
    NEW("NEW"),
    EDIT("EDIT"),
    DELETE("DELETE"),
    IMPORT("Import");

    private String tableAction;

    private ImportBaseTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
