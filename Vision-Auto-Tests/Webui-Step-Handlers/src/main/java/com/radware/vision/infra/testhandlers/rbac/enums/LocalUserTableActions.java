package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/4/2014.
 */
public enum LocalUserTableActions {

    NEW("NEW"),
    EDIT("EDIT"),
    DELETE("DELETE"),
    ENABLE_SELECTED_USERS("enable"),
    REVOKE_SELECTED_USERS("revoke"),
    UNLOCK_SELECTED_USERS("unlock"),
    RESET_SELECTED_USER_PASSWORD("resetpwd");

    private String tableAction;

    private LocalUserTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
