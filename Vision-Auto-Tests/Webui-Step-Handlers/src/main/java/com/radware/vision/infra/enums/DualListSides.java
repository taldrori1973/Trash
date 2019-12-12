package com.radware.vision.infra.enums;

/**
 * Created by stanislava on 9/7/2015.
 */
public enum DualListSides {

    SELECT_SIDE_TO_SELECT_FROM(""),
    LEFT("left"),
    RIGHT("right");

    private String dualListSide;

    private DualListSides(String dualListSide) {
        this.dualListSide = dualListSide;
    }

    public String getDualListSide() {
        return this.dualListSide;
    }

}
