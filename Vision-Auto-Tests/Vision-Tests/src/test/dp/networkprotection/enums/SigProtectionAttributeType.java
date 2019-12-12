package com.radware.vision.tests.dp.networkprotection.enums;

/**
 * Created by urig on 4/21/2015.
 */
public enum SigProtectionAttributeType {

    Risk("Risk"),
    Groups("Groups"),
    Target("Target"),
    Services("Services"),
    Platforms("Platforms"),
    Complexity("Complexity"),
    Confidence("Confidence"),
    ThreatType("Threat Type"),
    Applications("Applications");

    String attrType;

    private SigProtectionAttributeType(String attrType) {
        this.attrType = attrType;
    }

    public String getAttrType() {
        return this.attrType;
    }

}
