package com.radware.vision.automation.AutoUtils.SUT.dtos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.DevicesDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.daos.SetupDao;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.DevicesPojo;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.SetupPojo;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.SUTPojo;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;
import lombok.Getter;
import org.modelmapper.ModelMapper;

import java.util.List;

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
    private DevicesDao devicesDao;
    private SetupDao setupRepository;

    public SutDto(DevicesPojo allDevices, SUTPojo sutPojo, SetupPojo setup) {
//        List<Device> currentSutDevices = new ArrayList<>();
//
//        this.modelMapper = new ModelMapper();
//        this.devicesDao = new DevicesDao(allDevices);
//        this.setupRepository = new SetupDao(setup);
//
//        this.setupId = setup.getSetupId();
//        this.visionConfiguration = modelMapper.map(sutPojo.getVisionConfiguration(), VisionConfiguration.class);
//        this.sites = setup.getTree().getSites();
//
//        currentSutDevices = devicesDao.findAllDevices().stream().filter(device -> setupRepository.isDeviceExistById(device.getDeviceId())).collect(Collectors.toList());
//
//        Type listType = new TypeToken<List<DeviceDto>>() {
//        }.getType();
//
//        this.treeDevices = modelMapper.map(currentSutDevices, listType);
//        this.treeDevices.forEach(deviceDto -> {
//            deviceDto.setParentSite(setupRepository.findDeviceById(deviceDto.getDeviceId()).get().getParentSite());
//        });

    }
}
