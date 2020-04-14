package com.radware.vision.automation.AutoUtils.SUT.dtos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.DeviceConfiguration;
import lombok.Data;

@Data
public class DeviceDto {
    private String deviceId;
    private String deviceSetId;
    private String parentSite;
    private DeviceConfiguration configurations;


}
