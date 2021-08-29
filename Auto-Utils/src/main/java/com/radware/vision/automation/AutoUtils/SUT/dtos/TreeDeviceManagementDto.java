package com.radware.vision.automation.AutoUtils.SUT.dtos;

import lombok.Data;

import java.util.HashMap;

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
    private String snmpV1ReadCommunity;
    private String snmpV1WriteCommunity;
    private String snmpV2ReadCommunity;
    private String snmpV2WriteCommunity;
    private String snmpV3AuthenticationProtocol;
    private String snmpV3PrivacyProtocol;
    private String snmpVersion;
    private String verifyHttpCredentials;
    private String verifyHttpsCredentials;
    private String visionMgtPort;

    public HashMap<String, String> getDeviceSetupData()
    {
        HashMap<String, String> deviceSetupData = new HashMap<>();

        deviceSetupData.put("cliUsername", getCliUsername());
        deviceSetupData.put("cliPassword", getCliPassword());
        deviceSetupData.put("httpPassword", getHttpPassword());
        deviceSetupData.put("httpsPassword", getHttpsPassword());
        deviceSetupData.put("httpsUsername", getHttpsUsername());
        deviceSetupData.put("httpUsername", getHttpUsername());
        deviceSetupData.put("visionMgtPort", getVisionMgtPort());
        deviceSetupData.put("snmpV1ReadCommunity", getSnmpV1ReadCommunity());
        deviceSetupData.put("snmpV1WriteCommunity", getSnmpV1WriteCommunity());
        deviceSetupData.put("snmpV2ReadCommunity", getSnmpV2ReadCommunity());
        deviceSetupData.put("snmpV2WriteCommunity", getSnmpV2WriteCommunity());

        return deviceSetupData;
    }
}
