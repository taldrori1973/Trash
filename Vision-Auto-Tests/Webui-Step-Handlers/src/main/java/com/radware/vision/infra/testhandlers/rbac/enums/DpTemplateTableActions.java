package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/3/2014.
 */
public enum DpTemplateTableActions {

    NEW("NEW"),
    DELETE("DELETE"),
    DOWNLOAD_SELECTED_FILE("download"),
    SEND_TO_DEVICES("null");


    private String tableAction;

    private DpTemplateTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
