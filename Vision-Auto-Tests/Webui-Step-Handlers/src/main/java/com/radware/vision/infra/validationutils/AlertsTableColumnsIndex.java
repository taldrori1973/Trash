package com.radware.vision.infra.validationutils;

/**
 * Created by urig on 11/3/2014.
 */
public enum AlertsTableColumnsIndex {
    Ack(0),
    Severity(1),
    TimeandDate(2),
    DeviceName(3),
    DeviceIP(4),
    Module(5),
    ProductName(6),
    UserName(7),
    Message(8);

    int colIndex;

    private AlertsTableColumnsIndex(int colIndex) {
        this.colIndex = colIndex;
    }

    public int getIndex() {
        return this.colIndex;
    }

}
