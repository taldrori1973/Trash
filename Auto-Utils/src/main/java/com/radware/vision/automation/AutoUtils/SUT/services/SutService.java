package com.radware.vision.automation.AutoUtils.SUT.services;

import com.radware.vision.automation.AutoUtils.SUT.dtos.DeviceDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.VisionConfigurationDto;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.DevicesDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.SetupDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.SutDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Device;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.TreeDeviceNode;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;

import java.lang.reflect.Type;
import java.util.List;
import java.util.stream.Collectors;


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

    public List<String> getVisionSetupTreeSites() {
        List<Site> allSites = this.setupDao.findAllSites();
        return allSites.stream().map(Site::getName).collect(Collectors.toList());
    }

    public List<DeviceDto> getVisionSetupTreeDevices() {
        List<DeviceDto> deviceDtos;
        List<Device> allDevices = this.devicesDao.findAllDevices();
        List<TreeDeviceNode> allSetupDevices = this.setupDao.findAllDevices();

//        find the current setup devices
        List<Device> setupDevices = allDevices.stream().filter(device -> this.setupDao.isDeviceExistById(device.getDeviceId())).collect(Collectors.toList());

        Type listType = new TypeToken<List<DeviceDto>>() {
        }.getType();

        deviceDtos = modelMapper.map(setupDevices, listType);

        this.setupDao.getDeviceParentSite();
        return null;
    }
}
