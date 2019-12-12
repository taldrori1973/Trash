package com.radware.vision.tests.dp.accesscontrol.enums;

/**
 * Created by stanislava on 4/13/2015.
 */
public enum Hours {
    _0("0"),
    _1("1"),
    _2("2");

    private String hours;

    private Hours(String hours) {
        this.hours = hours;
    }

    public String getHours() {
        return this.hours;
    }
}
