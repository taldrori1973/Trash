package com.radware.vision.automation.AutoUtils.SUT.dtos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices.Device;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;

import java.util.List;

public class SutDto {
    private VisionConfiguration visionConfiguration;
    private String setupId;
    private List<Site> sites;
    private List<Device> treeDevices;


}
