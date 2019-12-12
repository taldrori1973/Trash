package com.radware.vision.infra.enums;

/**
 * Created by AviH on 30-Oct-16.
 */

public enum DeviceType4Group {
    Alteon("Alteon"),
    DefensePro("DefensePro"),
    LinkProof("LinkProof"),
    AppWall("AppWall"),
    NOT_DEFAULT("");

    private String deviceType;

    private DeviceType4Group(String deviceType) {
        this.deviceType = deviceType;
    }

    public String getDeviceType() {
        return this.deviceType;
    }
}
