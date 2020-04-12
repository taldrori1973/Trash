package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos;

import lombok.Data;

@Data
public class Device {

    private String deviceId;
    private String deviceSetId;
    private DeviceConfiguration configurations;
}
