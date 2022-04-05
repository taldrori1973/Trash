package com.radware.vision.automation.AutoUtils.SUT.dtos;

import lombok.Data;

@Data
public class EnvironmentDto {
    private String name;
    private String hostIp;
    private String user;
    private String password;
    private String dnsServerIp;
    private String netMask;
    private String gateWay;
    private String physicalManagement;
    private String resourcePool;
    private String networkName;
    private String dataStores;
    private String url;
}
