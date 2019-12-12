package com.radware.vision.infra.testhandlers.dptemplates.enums;

/**
 * Created by stanislava on 1/4/2015.
 */
public enum PolicyNetworkInput {

    FROM_LIST("From List"),
    USER_DEFINED_VALUE("User-Defined Value");

    String networkInput;

    private PolicyNetworkInput(String networkInput) {
        this.networkInput = networkInput;
    }

    public String getPolicyNetworkInput() {
        return this.networkInput;
    }
}
