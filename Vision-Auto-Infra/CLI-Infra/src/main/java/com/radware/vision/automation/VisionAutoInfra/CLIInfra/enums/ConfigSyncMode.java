package com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums;

/**
 * Created by moaada on 4/13/2017.
 */
public enum ConfigSyncMode {

    ACTIVE("active"),
    STANDBY("standby"),
    DISABLED("disabled");

    private String mode;

    ConfigSyncMode(String mode) {
        this.mode = mode;
    }

    public String getMode() {
        return this.mode;
    }

    public static ConfigSyncMode getConstant(String mode){
        mode = mode.toLowerCase();
        switch (mode){
            case "standby": return STANDBY;
            case "active": return ACTIVE;
            case "disabled": return DISABLED;
            default:return null;
        }
    }
}
