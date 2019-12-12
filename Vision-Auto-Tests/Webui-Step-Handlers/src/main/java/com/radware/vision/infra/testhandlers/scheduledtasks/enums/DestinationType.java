package com.radware.vision.infra.testhandlers.scheduledtasks.enums;

/**
 * Created by urig on 3/19/2015.
 */
public enum DestinationType {

    DeviceList("Device List"),
    Destination("Destination");

    private String destinationType;

    private DestinationType(String destinationType) {
        this.destinationType = destinationType;
    }

    public String getDestinationType() {
        return this.destinationType;
    }
}
