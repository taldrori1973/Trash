package com.radware.vision.infra.enums;

import com.radware.automation.webui.utils.WebUIStrings;

/**
 * Created by stanislava on 9/17/2015.
 */
public enum DeviceInfoPaneProperties {

    SELECT_RELEVANT_PROPERTY(""),
    STATUS(WebUIStrings.getInfoPaneDeviceStatus()),
    LOCKED_BY(WebUIStrings.getInfoPaneDeviceLockedBy()),
    TYPE(WebUIStrings.getInfoPaneDeviceType()),
    MGMT_IP(WebUIStrings.getInfoPaneDevicehoHost()),
    VERSION(WebUIStrings.getInfoPaneDeviceVersion()),
    MAC(WebUIStrings.getInfoPaneMAC()),
    APM_LICENSE(WebUIStrings.getInfoPaneAPMLicense()),
    DEVICE_DRIVER(WebUIStrings.getInfoPaneDeviceDriverVersion());

    private String deviceInfoPaneProperty;

    private DeviceInfoPaneProperties(String deviceInfoPaneProperty) {
        this.deviceInfoPaneProperty = deviceInfoPaneProperty;
    }

    public String getDeviceInfoPaneProperties() {
        return this.deviceInfoPaneProperty;
    }
}
