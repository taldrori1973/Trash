package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.radware.vision.automation.AutoUtils.SUT.dtos.DeviceDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.VisionConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;

import java.util.List;

public interface SUTManager {

    String getSetupId();

    VisionConfigurationDto getVisionConfigurations();

    List<Site> getVisionSetupSites();

    List<DeviceDto> getVisionSetupTreeDevices();
}
