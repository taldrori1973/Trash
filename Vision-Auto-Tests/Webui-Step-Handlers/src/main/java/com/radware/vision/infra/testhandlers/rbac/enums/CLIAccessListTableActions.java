package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/4/2014.
 */
public enum CLIAccessListTableActions {
    NEW("NEW"),
    VIEW("VIEW_ONLY"),
    DELETE("DELETE");

    private String tableAction;

    private CLIAccessListTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
