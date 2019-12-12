package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/23/2014.
 */
public enum AddDeleteTableActions {
    NEW("NEW"),
    DELETE("DELETE");

    private String tableAction;

    private AddDeleteTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
