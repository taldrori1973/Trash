package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.radware.vision.automation.AutoUtils.SUT.dtos.DeviceDto;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;

import java.util.List;

public interface SUTManager {

    String getSetupId();

    VisionConfiguration getVisionConfiguration();

    List<Site> getVisionSetupSites();

    List<DeviceDto> getVisionSetupTreeDevices();
}
