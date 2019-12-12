package com.radware.vision.infra.enums;

/**
 * Created by urig on 10/8/2014.
 */
public enum AlertsTableColumns {
    Acknowledged("Ack"),
    Severity("Severity"),
    TimeAndData("Time and Date"),
    DeviceName("Device Name"),
    DeviceIP("Device IP"),
    Module("Module"),
    UserName("User Name"),
    Message("Message");


    private String column;

    AlertsTableColumns(String column) {
        this.column = column;
    }

    public String toString() {
        return this.column;
    }
}
