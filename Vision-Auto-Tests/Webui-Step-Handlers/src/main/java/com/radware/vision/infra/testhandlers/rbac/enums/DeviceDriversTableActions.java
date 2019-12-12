package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 9/4/2014.
 */
public enum DeviceDriversTableActions {
    UPDATE_DEVICE_DRIVER("updateDeviceDriver"),
    UPDATE_TO_LATEST_DRIVER("updatetolatest"),
    REVERT_TO_BASELINE_DRIVER("reverttobaseline"),
    UPLOAD_DEVICE_DRIVER("uploadDeviceDriver"),
    UPDATE_ALL_DRIVERS_TO_LATEST("updatealltolatest");


    private String tableAction;

    private DeviceDriversTableActions(String tableAction) {
        this.tableAction = tableAction;
    }

    public String getTableAction() {
        return this.tableAction;
    }
}
