package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by alexeys on 5/31/2015.
 */
public enum SeverityList {
    ALERT("Alert"),
    CRITICAL("Critical"),
    DEBUG("Debug"),
    EMERGENCY("Emergency"),
    ERROR("Error"),
    INFO("Info"),
    NOTICE("Notice"),
    WARNING("Warning");

    private String severity;

    private SeverityList(String severity) {
        this.severity = severity;
    }

    public String getSeverity() {
        return this.severity;
    }
}
