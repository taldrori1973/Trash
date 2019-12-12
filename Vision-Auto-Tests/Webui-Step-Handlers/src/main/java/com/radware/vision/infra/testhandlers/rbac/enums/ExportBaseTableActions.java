package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 10/2/2014.
 */
public enum ExportBaseTableActions {
    NEW("NEW"),
    EDIT("EDIT"),
    DELETE("DELETE"),
    EXPORT("Export");

    private String tableAction;

    private ExportBaseTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
