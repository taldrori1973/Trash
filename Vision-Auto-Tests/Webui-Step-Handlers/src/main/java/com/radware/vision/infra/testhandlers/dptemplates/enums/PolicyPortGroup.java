package com.radware.vision.infra.testhandlers.dptemplates.enums;

/**
 * Created by stanislava on 1/4/2015.
 */
public enum PolicyPortGroup {
    NO_SELECTION(""),
    MANAGEMENT_PORTS("Management Ports"),
    OUTBOUND_PORT_GROUP("Outbound Port Group"),
    INBOUND_PORT_GROUP("Inbound Port Group");

    String portGroup;

    private PolicyPortGroup(String portGroup) {
        this.portGroup = portGroup;
    }

    public String getPolicyPortGroup() {
        return this.portGroup;
    }
}
