package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.radware.vision.automation.AutoUtils.SUT.dtos.DeviceDto;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;
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


    }

    @Override
    public String getSetupId() {
        return this.sutService.getSetupId();
    }

    @Override
    public VisionConfiguration getVisionConfiguration() {
        return this.sutDto.getVisionConfiguration();
    }


    @Override
    public List<Site> getVisionSetupSites() {
        return this.sutDto.getSites();
    }

    @Override
    public List<DeviceDto> getVisionSetupTreeDevices() {
        return this.sutDto.getTreeDevices();
    }


    //Utilities

    public static SUTManager getInstance() {
        return instance;
    }
}
