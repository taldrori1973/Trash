package com.radware.vision.automation.AutoUtils.SUT.enums;

public enum DeviceType {

    ALTEON("Alteon"),
    LINK_PROOF("LinkProof"),
    DEFENSE_PRO("DefensePro"),
    APPWALL("AppWall");


    private String type;

    DeviceType(String type) {

    }

    public String getType() {
        return type;
    }
}
