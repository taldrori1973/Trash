package com.radware.vision.automation.AutoUtils.SUT.dtos;

import lombok.Data;

@Data
public class TreeDeviceManagementDto {
    private String deviceId;
    private String deviceSetId;
    private String deviceName;
    private String deviceType;
    private String cliUsername;
    private String cliPassword;
    private String cliPort;
    private String httpUsername;
    private String httpPassword;
    private String httpsUsername;
    private String httpsPassword;
    private String managementIp;
    private String snmpV2ReadCommunity;
    private String snmpV2WriteCommunity;

}
