package com.radware.vision.infra.testhandlers.topologytree.enums;

/**
 * Created by stanislava on 12/28/2014.
 */
public enum FilterByType {
    ALTEON("Alteon"),
    DEFENSE_PRO("DefensePro"),
    NONE("None");


    private String type;

    private FilterByType(String type) {
        this.type = type;
    }

    public String getType() {
        return this.type;
    }
}
