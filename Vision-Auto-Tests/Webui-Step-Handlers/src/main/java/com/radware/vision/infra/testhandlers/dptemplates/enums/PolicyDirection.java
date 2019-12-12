package com.radware.vision.infra.testhandlers.dptemplates.enums;

/**
 * Created by stanislava on 1/4/2015.
 */
public enum PolicyDirection {

    ONE_WAY("One Way"),
    TWO_WAY("Two Way");

    String direction;

    private PolicyDirection(String direction) {
        this.direction = direction;
    }

    public String getPolicyDirection() {
        return this.direction;
    }
}
