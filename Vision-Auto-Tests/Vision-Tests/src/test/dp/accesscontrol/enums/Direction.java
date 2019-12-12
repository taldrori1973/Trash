package com.radware.vision.tests.dp.accesscontrol.enums;

/**
 * Created by stanislava on 4/13/2015.
 */
public enum Direction {
    BI_DIRECTIONAL("Bi-directional"),
    ONE_DIRECTIONAL("One-directional");

    private String direction;

    private Direction(String direction) {
        this.direction = direction;
    }

    public String getDirection() {
        return this.direction;
    }
}
