package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/18/2014.
 */
public enum ViewTableActions {
    VIEW("VIEW_ONLY");


    private String tableAction;

    private ViewTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
