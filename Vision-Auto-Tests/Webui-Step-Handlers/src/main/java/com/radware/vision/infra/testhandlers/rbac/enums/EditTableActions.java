package com.radware.vision.infra.testhandlers.rbac.enums;

public enum EditTableActions {

    EDIT("EDIT");
	 

	    private String tableAction;

    private EditTableActions(String tableAction) {
        this.tableAction = tableAction;
	    }

	    public String getTableAction() {
	        return this.tableAction;
	    }
}
