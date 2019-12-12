package com.radware.vision.infra.testhandlers.rbac.enums;

public enum ViewBaseTableActions {
	NEW("NEW"),
	VIEW("VIEW_ONLY"),
    DELETE("DELETE");

    private String tableAction;

    private ViewBaseTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
