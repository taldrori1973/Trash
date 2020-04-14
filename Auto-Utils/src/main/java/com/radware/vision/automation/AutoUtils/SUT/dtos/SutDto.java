package com.radware.vision.automation.AutoUtils.SUT.dtos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.DevicesRepository;
import com.radware.vision.automation.AutoUtils.SUT.repositories.SetupRepository;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Device;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Devices;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Setup;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.SUTPojo;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;
import lombok.Getter;
import org.modelmapper.ModelMapper;
import org.modelmapper.TypeToken;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class SutDto {
    @Getter
    private String setupId;
    @Getter
    private VisionConfiguration visionConfiguration;
    @Getter
    private List<Site> sites;
    @Getter
    private List<DeviceDto> treeDevices;


    private ModelMapper modelMapper;
    private DevicesRepository devicesRepository;
    private SetupRepository setupRepository;

    public SutDto(Devices allDevices, SUTPojo sutPojo, Setup setup) {
        List<Device> currentSutDevices = new ArrayList<>();

        this.modelMapper = new ModelMapper();
        this.devicesRepository = new DevicesRepository(allDevices);
        this.setupRepository = new SetupRepository(setup);

        this.setupId = setup.getSetupId();
        this.visionConfiguration = modelMapper.map(sutPojo.getVisionConfiguration(), VisionConfiguration.class);
        this.sites = setup.getSites();

        currentSutDevices = devicesRepository.findAllDevices().stream().filter(device -> setupRepository.isDeviceExistById(device.getDeviceId())).collect(Collectors.toList());

        Type listType = new TypeToken<List<DeviceDto>>() {
        }.getType();

        this.treeDevices = modelMapper.map(currentSutDevices, listType);
        this.treeDevices.forEach(deviceDto -> {
            deviceDto.setParentSite(setupRepository.findDeviceById(deviceDto.getDeviceId()).get().getParentSite());
        });

    }
}
