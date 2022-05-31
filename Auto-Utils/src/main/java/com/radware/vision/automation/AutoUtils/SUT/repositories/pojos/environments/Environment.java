package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.environments;

import com.radware.vision.automation.AutoUtils.SUT.dtos.NetworkDto;
import lombok.Data;

import java.util.List;

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
    private String resourcePool;
    private String url;
    private String networkName;
    private String dataStores;
    private List<NetworkDto> networks;
}
