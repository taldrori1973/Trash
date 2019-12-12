package com.radware.vision.infra.testhandlers.DefencePro.enums;

/**
 * Created by stanislava on 3/24/2015.
 */
public enum UpdateFromSource {
    UPDATE_FROM_RADWARE("UpdateFromRadware"),
    UPDATE_FROM_CLIENT("UpdateFromClient");

    private String source;

    private UpdateFromSource(String source) {
        this.source = source;
    }

    public String getSource() {
        return this.source;
    }
}
