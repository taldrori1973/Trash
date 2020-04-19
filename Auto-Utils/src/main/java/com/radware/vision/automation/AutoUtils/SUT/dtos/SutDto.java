package com.radware.vision.automation.AutoUtils.SUT.dtos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;
import lombok.Getter;

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

}
