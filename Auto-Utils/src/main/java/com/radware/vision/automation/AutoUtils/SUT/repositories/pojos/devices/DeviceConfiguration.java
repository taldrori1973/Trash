package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices;

import lombok.Data;

@Data
public class DeviceConfiguration {

    private String name;
    private String type;
    private String parentOrmID;
    private DeviceSetup deviceSetup;
}
