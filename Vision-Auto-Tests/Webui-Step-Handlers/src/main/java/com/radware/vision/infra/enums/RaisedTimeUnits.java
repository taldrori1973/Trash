package com.radware.vision.infra.enums;

/**
 * Created by stanislava on 10/6/2014.
 */
public enum RaisedTimeUnits {
    HOURS("Hour/s"),
    MINUTES("Minute/s");

    private String timeUnites;

    private RaisedTimeUnits(String timeUnites) {
        this.timeUnites = timeUnites;
    }

    public String getTimeUnits() {
        return this.timeUnites;
    }
}
