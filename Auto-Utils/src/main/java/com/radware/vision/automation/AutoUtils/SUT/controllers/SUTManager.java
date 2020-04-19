package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.radware.vision.automation.AutoUtils.SUT.dtos.DeviceDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.VisionConfigurationDto;

import java.util.List;

public interface SUTManager {

    String getSetupId();

    VisionConfigurationDto getVisionConfigurations();

    List<String> getVisionSetupTreeSites();

    List<DeviceDto> getVisionSetupTreeDevices();
}
