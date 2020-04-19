package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.radware.vision.automation.AutoUtils.SUT.dtos.DeviceDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.VisionConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.services.SutService;

import java.util.List;

/**
 * By Muhamad Igbaria (mohamadi) April 2020
 */

public class SUTManagerImpl implements SUTManager {

    //    Singleton Instance
    private static final SUTManager instance = new SUTManagerImpl();


    private SutService sutService;


    private SUTManagerImpl() {
        this.sutService = new SutService();
    }

    public static SUTManager getInstance() {
        return instance;
    }

    @Override
    public String getSetupId() {
        return this.sutService.getSetupId();
    }

    @Override
    public VisionConfigurationDto getVisionConfigurations() {
        return this.sutService.getVisionConfigurations();
    }


    @Override
    public List<DeviceDto> getVisionSetupTreeDevices() {
        return this.sutService.getVisionSetupTreeDevices();
    }
}
