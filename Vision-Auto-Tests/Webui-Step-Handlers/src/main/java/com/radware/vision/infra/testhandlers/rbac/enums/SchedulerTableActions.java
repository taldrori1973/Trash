package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/3/2014.
 */
public enum SchedulerTableActions {

    NEW("NEW"),
    EDIT("EDIT"),
    DELETE("DELETE"),
    RUN_NOW("runNow");

    private String tableAction;

    private SchedulerTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
