package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/4/2014.
 */
public enum DeviceBackupsTableActions {
    EDIT("EDIT"),
    DELETE("DELETE"),
    DOWNlOAD_SELECTED_FILE("download");

    private String tableAction;

    private DeviceBackupsTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
