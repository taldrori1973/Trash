package com.radware.vision.automation.AutoUtils.utils;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.DeviceAccess;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.DeviceConfiguration;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.DeviceSetup;

public class DevicesUtils {

    public static DeviceConfiguration getDeviceConfigurationFromTemplate(DeviceConfiguration deviceConfiguration) {
        DeviceConfiguration configuration = new DeviceConfiguration();
        configuration.setName(deviceConfiguration.getName());
        configuration.setType(deviceConfiguration.getType());
        configuration.setParentOrmID(deviceConfiguration.getParentOrmID());
        DeviceSetup deviceSetup = new DeviceSetup();
        DeviceAccess deviceAccess = new DeviceAccess();
        deviceAccess.setManagementIp(deviceConfiguration.getDeviceSetup().getDeviceAccess().getManagementIp());
        deviceAccess.setCliPassword(deviceConfiguration.getDeviceSetup().getDeviceAccess().getCliPassword());
        deviceAccess.setCliPort(deviceConfiguration.getDeviceSetup().getDeviceAccess().getCliPort());
        deviceAccess.setCliUsername(deviceConfiguration.getDeviceSetup().getDeviceAccess().getCliUsername());
        deviceAccess.setExclusivelyReceiveDeviceEvents(deviceConfiguration.getDeviceSetup().getDeviceAccess().getExclusivelyReceiveDeviceEvents());
        deviceAccess.setHttpPassword(deviceConfiguration.getDeviceSetup().getDeviceAccess().getHttpPassword());
        deviceAccess.setHttpsPassword(deviceConfiguration.getDeviceSetup().getDeviceAccess().getHttpsPassword());
        deviceAccess.setHttpsUsername(deviceConfiguration.getDeviceSetup().getDeviceAccess().getHttpsUsername());
        deviceAccess.setHttpUsername(deviceConfiguration.getDeviceSetup().getDeviceAccess().getHttpUsername());
        deviceAccess.setRegisterDeviceEvents(deviceConfiguration.getDeviceSetup().getDeviceAccess().getRegisterDeviceEvents());
        deviceAccess.setSnmpV1ReadCommunity(deviceConfiguration.getDeviceSetup().getDeviceAccess().getSnmpV1ReadCommunity());
        deviceAccess.setSnmpV1WriteCommunity(deviceConfiguration.getDeviceSetup().getDeviceAccess().getSnmpV1WriteCommunity());
        deviceAccess.setSnmpV2ReadCommunity(deviceConfiguration.getDeviceSetup().getDeviceAccess().getSnmpV2ReadCommunity());
        deviceAccess.setSnmpV2WriteCommunity(deviceConfiguration.getDeviceSetup().getDeviceAccess().getSnmpV2WriteCommunity());
        deviceAccess.setSnmpV3AuthenticationProtocol(deviceConfiguration.getDeviceSetup().getDeviceAccess().getSnmpV3AuthenticationProtocol());
        deviceAccess.setSnmpV3PrivacyProtocol(deviceConfiguration.getDeviceSetup().getDeviceAccess().getSnmpV3PrivacyProtocol());
        deviceAccess.setSnmpVersion(deviceConfiguration.getDeviceSetup().getDeviceAccess().getSnmpVersion());
        deviceAccess.setVerifyHttpCredentials(deviceConfiguration.getDeviceSetup().getDeviceAccess().getVerifyHttpCredentials());
        deviceAccess.setVerifyHttpsCredentials(deviceConfiguration.getDeviceSetup().getDeviceAccess().getVerifyHttpsCredentials());
        deviceAccess.setVisionMgtPort(deviceConfiguration.getDeviceSetup().getDeviceAccess().getVisionMgtPort());
        deviceSetup.setDeviceAccess(deviceAccess);
        configuration.setDeviceSetup(deviceSetup);

        return configuration;
    }
}
