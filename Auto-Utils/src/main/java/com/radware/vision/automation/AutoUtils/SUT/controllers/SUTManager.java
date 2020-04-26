package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.DeviceDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ServerDto;

import java.util.List;
import java.util.Optional;

public interface SUTManager {

    String getSetupId();

    ClientConfigurationDto getClientConfigurations();

    List<String> getVisionSetupTreeSites();

    List<DeviceDto> getVisionSetupTreeDevices();

    Optional<DeviceDto> getDeviceBySetId(String setId);

    Optional<ServerDto> getServerById(String serverId);
}
