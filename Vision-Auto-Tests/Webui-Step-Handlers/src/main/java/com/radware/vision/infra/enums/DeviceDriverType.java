package com.radware.vision.infra.enums;

import com.radware.automation.webui.WebUIUtils;

/**
 * Created by stanislava on 3/15/2016.
 */
public enum DeviceDriverType {
    VISION(WebUIUtils.VISION_DEVICE_DRIVER_ID),
    DEVICE(WebUIUtils.selectedDeviceDriverId);

    private String ddType;

    private DeviceDriverType(String ddType) {
        this.ddType = ddType;
    }

    public String getDDType() {
        if (this.ddType != null) {
            return this.ddType;
        } else {
            return WebUIUtils.selectedDeviceDriverId;
        }
    }
}
