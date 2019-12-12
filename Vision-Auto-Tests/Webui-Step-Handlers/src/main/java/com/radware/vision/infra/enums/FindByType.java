package com.radware.vision.infra.enums;

/**
 * Created by stanislava on 3/15/2016.
 */
public enum FindByType {
    BY_NAME("name"),
    BY_ID("id");

    private String byType;

    private FindByType(String byType) {
        this.byType = byType;
    }

    public String getByType() {
        return this.byType;
    }
}
