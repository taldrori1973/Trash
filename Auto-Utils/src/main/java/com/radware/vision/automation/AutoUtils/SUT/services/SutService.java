package com.radware.vision.automation.AutoUtils.SUT.services;

import com.radware.vision.automation.AutoUtils.SUT.dtos.VisionConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.DevicesDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.SetupDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.SutDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;
import org.modelmapper.ModelMapper;


public class SutService {

    private ModelMapper modelMapper;

    private DevicesDao devicesDao;
    private SetupDao setupDao;
    private SutDao sutDao;

    public SutService() {
        this.modelMapper = new ModelMapper();
        this.devicesDao = DevicesDao.get_instance();
        this.sutDao = SutDao.get_instance();
        this.setupDao = SetupDao.get_instance(sutDao.getSetupFileName());
    }


    public String getSetupId() {
        return setupDao.getSetupId();
    }

    public VisionConfigurationDto getVisionConfigurations() {
        VisionConfiguration visionConfiguration = this.sutDao.findVisionConfiguration();
        VisionConfigurationDto visionConfigurationDto = modelMapper.map(visionConfiguration, VisionConfigurationDto.class);
        return visionConfigurationDto;
    }
}
