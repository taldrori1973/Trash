package com.radware.vision.automation.AutoUtils.SUT.controllers;

import com.radware.vision.automation.AutoUtils.SUT.dtos.DeviceDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.SutDto;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;
import com.radware.vision.automation.AutoUtils.SUT.services.SutService;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.automation.AutoUtils.utils.RuntimeVMOptions;

import java.util.List;

/**
 * By Muhamad Igbaria (mohamadi) April 2020
 */

public class SUTManagerImpl implements SUTManager {

    //    Singleton Instance
    private static final SUTManager instance = new SUTManagerImpl();

    //    Constants

    private static final String SUT_SETUPS_FILES_PATH_PROPERTY = "SUT.setups.path";


    private ApplicationPropertiesUtils applicationPropertiesUtils;
    private RuntimeVMOptions runtimeVMOptions;

    private SutService sutService;
    private SutDto sutDto;

    private SUTManagerImpl() {

        this.applicationPropertiesUtils = new ApplicationPropertiesUtils("environment/application.properties");
        this.runtimeVMOptions = new RuntimeVMOptions();


//        Devices devicesPojo = loadJsonFile(SUT_DEVICES_FILES_PATH_PROPERTY, DEVICES_FILE_NAME, Devices.class);
//
//        SUTPojo sutPojo = loadJsonFile(SUT_FILES_PATH_PROPERTY, sutFileName, SUTPojo.class);
//
//        Setup setupPojo = loadJsonFile(SUT_SETUPS_FILES_PATH_PROPERTY, sutPojo.getSetupFile(), Setup.class);
//
//        this.sutService = new SutService(devicesPojo, sutPojo, setupPojo);
//        this.sutDto = new SutDto(devicesPojo, sutPojo, setupPojo);

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
