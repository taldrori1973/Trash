package com.radware.vision.infra.testhandlers.rbac.enums;

public enum EditDeleteTableActions {
    EDIT("EDIT"),
    DELETE("DELETE");

    private String tableAction;

    private EditDeleteTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
