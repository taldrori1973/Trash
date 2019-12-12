package com.radware.vision.infra.testhandlers.dptemplates.enums;

/**
 * Created by stanislava on 1/4/2015.
 */
public enum PolicyWebQuarantine {

    ENABLE("Enable"),
    DISABLE("Disable");

    String webQuarantineState;

    private PolicyWebQuarantine(String webQuarantineState) {
        this.webQuarantineState = webQuarantineState;
    }

    public String getPolicyWebQuarantineState() {
        return this.webQuarantineState;
    }
}
