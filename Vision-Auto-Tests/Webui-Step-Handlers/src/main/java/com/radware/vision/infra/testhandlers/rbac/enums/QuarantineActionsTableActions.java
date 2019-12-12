package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 10/2/2014.
 */
public enum QuarantineActionsTableActions {
    NEW("NEW"),
    EDIT("EDIT"),
    DELETE("DELETE"),
    UPLOAD_CUSTOM_HTML_PAGE("Upload Custom HTML Page"),
    SHOW_CUSTOM_HTML_PAGE("Show Custom HTML Page");

    private String tableAction;

    private QuarantineActionsTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
