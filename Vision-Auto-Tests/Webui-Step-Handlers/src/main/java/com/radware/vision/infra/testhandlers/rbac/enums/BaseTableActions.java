package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/4/2014.
 */
public enum BaseTableActions {
    NEW("NEW"),
    EDIT("EDIT"),
    DELETE("DELETE");

    private String tableAction;

    private BaseTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
