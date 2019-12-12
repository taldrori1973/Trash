package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 10/1/2015.
 */
public enum CommonTableActions {

    NEW("_NEW"),
    EDIT("_EDIT"),
    DELETE("_DELETE");

    private String tableAction;

    private CommonTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
