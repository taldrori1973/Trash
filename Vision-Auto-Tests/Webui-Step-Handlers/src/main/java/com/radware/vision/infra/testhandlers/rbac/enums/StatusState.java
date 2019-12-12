package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by alexeys on 5/31/2015.
 */
public enum StatusState {
    ENABLE("Enable"),
    DISABLE("Disable");

    String status;


    StatusState(String status) {
        this.status = status;
    }

    public String getStatus() {
        return this.status;
    }
}
