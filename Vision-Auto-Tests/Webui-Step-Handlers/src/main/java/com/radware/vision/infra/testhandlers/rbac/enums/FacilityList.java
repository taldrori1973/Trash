package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by alexeys on 5/31/2015.
 */
public enum FacilityList {
    LOCAL0("Local0"),
    LOCAL1("Local1"),
    LOCAL2("Local2"),
    LOCAL3("Local3"),
    LOCAL4("Local4"),
    LOCAL5("Local5"),
    LOCAL6("Local6"),
    LOCAL7("Local7");

    String facility;
    FacilityList(String facility) {
        this.facility = facility;
    }

    public String getFacility() {
        return this.facility;
    }
}
