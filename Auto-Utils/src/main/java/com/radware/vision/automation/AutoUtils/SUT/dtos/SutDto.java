package com.radware.vision.automation.AutoUtils.SUT.dtos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.DevicesRepository;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Devices;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Setup;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.SUTPojo;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;

import java.lang.reflect.Type;
import java.util.List;

public class SutDto {
    private String setupId;
    private VisionConfiguration visionConfiguration;
    private List<Site> sites;
    private List<DeviceDto> treeDevices;
    private ModelMapper modelMapper;
    private DevicesRepository devicesRepository;

    public SutDto(Devices allDevices, SUTPojo sutPojo, Setup setup) {
        this.modelMapper = new ModelMapper();
        this.devicesRepository = new DevicesRepository();
        this.setupId = setup.getSetupId();
        this.visionConfiguration = modelMapper.map(sutPojo.getVisionConfiguration(), VisionConfiguration.class);
        this.sites = setup.getSites();
        Type listType = new TypeToken<List<DeviceDto>>() {
        }.getType();

        this.treeDevices = modelMapper.map(devicesRepository.findAllDevices(), listType);
        this.treeDevices = modelMapper.map(setup.getDevices(), listType);
    }
}
