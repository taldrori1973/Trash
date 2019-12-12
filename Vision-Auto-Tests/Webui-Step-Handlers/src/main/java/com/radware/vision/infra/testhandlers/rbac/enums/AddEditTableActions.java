package com.radware.vision.infra.testhandlers.rbac.enums;

public enum AddEditTableActions {
	NEW("NEW"),
    EDIT("EDIT");

    private String tableAction;

    private AddEditTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
