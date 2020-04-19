package com.radware.vision.automation.AutoUtils.SUT.dtos;

import lombok.Data;

@Data
public class VisionConfigurationDto {

    private String hostIp;
    private String userName;
    private String password;
    private String restConnectionDefaultPort;
    private String restConnectionDefaultProtocol;

}
