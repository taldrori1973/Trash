package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos;

import lombok.Data;

@Data
public class DeviceConfiguration {

    private String name;
    private String type;
    private String parentOrmID;
    private DeviceSetup deviceSetup;
}
