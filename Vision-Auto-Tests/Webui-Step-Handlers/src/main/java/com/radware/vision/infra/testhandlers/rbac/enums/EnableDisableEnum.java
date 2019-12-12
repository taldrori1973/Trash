package com.radware.vision.infra.testhandlers.rbac.enums;

public enum EnableDisableEnum {

    ENABLE("Enable"),
    DISABLE("Disable"),
    ENABLED("Enabled"),
    DISABLED("Disabled");

    String mEnableDisable;

    EnableDisableEnum(String value) {
        mEnableDisable = value;

    }

    public String getmEnableDisable() {
        return mEnableDisable;
    }
}