package com.radware.vision.infra.testhandlers.dptemplates.enums;

/**
 * Created by stanislava on 1/4/2015.
 */
public enum PolicyAction {

    BLOCK_AND_REPORT("Block and Report"),
    REPORT_ONLY("Report Only");

    String action;

    private PolicyAction(String action) {
        this.action = action;
    }

    public String getPolicyAction() {
        return this.action;
    }
}
