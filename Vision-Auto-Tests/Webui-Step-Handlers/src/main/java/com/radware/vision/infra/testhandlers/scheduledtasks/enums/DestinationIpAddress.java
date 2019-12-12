package com.radware.vision.infra.testhandlers.scheduledtasks.enums;

/**
 * Created by stanislava on 11/23/2014.
 */
public enum DestinationIpAddress {
    LINUX_FILE_SERVER_IP("172.17.164.100");


    String ipAddress;

    private DestinationIpAddress(String ipAddress) {
        this.ipAddress = ipAddress;
    }

    public String getIpAddress() {
        return this.ipAddress;
    }
}
