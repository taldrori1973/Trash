package com.radware.vision.infra.base.pages.defensepro;

/**
 * Created by stanislava on 12/17/2015.
 */
public enum DeviceStatus {
    Up("Up"),
    Down("Down");

    String status;

    private DeviceStatus(String status) {
        this.status = status;
    }

    public String getStatus() {
        return  this.status;
    }
}
