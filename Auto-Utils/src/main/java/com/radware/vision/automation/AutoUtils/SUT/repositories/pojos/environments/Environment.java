package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.environments;

import lombok.Data;

@Data
public class Environment {
    private String name;
    private String hostIp;
    private String user;
    private String password;
    private String dnsServerIp;
    private String netMask;
    private String gateWay;
    private String physicalManagement;
    private String vCenterURL;
    private String resourcePool;
}
