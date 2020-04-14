package com.radware.vision.automation.AutoUtils.SUT.dtos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Device;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Devices;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Setup;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.SUTPojo;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;
import org.modelmapper.ModelMapper;

import java.util.List;

public class SutDto {
    private String setupId;
    private VisionConfiguration visionConfiguration;
    private List<Site> sites;
    private List<Device> treeDevices;
    private ModelMapper modelMapper;

    public SutDto(Devices allDevices, SUTPojo sutPojo, Setup setup) {
        this.modelMapper = new ModelMapper();

        this.setupId = setup.getSetupId();
        this.visionConfiguration = modelMapper.map(sutPojo.getVisionConfiguration(), VisionConfiguration.class);
    }
}
