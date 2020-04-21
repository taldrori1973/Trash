package com.radware.vision.automation.AutoUtils.SUT.dtos;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import lombok.Data;

import java.util.List;

@Data
public class SutDto {
    private ClientConfigurationDto clientConfiguration;
    private List<Site> sites;
    private List<DeviceDto> treeDevices;

}
