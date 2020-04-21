package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.DeviceDto;

import java.util.List;

public interface SUTManager {

    String getSetupId();

    ClientConfigurationDto getClientConfigurations();

    List<String> getVisionSetupTreeSites();

    List<DeviceDto> getVisionSetupTreeDevices();
}
