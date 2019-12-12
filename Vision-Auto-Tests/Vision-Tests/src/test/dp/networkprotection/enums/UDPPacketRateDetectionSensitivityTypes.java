package com.radware.vision.tests.dp.networkprotection.enums;

/**
 * Created by stanislava on 4/1/2015.
 */
public enum UDPPacketRateDetectionSensitivityTypes {
    IGNORE_OR_DISABLE("Ignore or Disable"),
    LOW("Low"),
    MEDIUM("Medium"),
    HIGH("High");

    private String type;

    private UDPPacketRateDetectionSensitivityTypes(String type) {
        this.type = type;
    }

    public String getType() {
        return this.type;
    }
}
