package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/21/2014.
 */
public enum ContentClassesTableActions {
    NEW("NEW"),
    EDIT("EDIT"),
    DELETE("DELETE"),
    COPY_RULE("CopyRule"),;

    private String tableAction;

    private ContentClassesTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
