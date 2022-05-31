package com.radware.vision.automation.AutoUtils.SUT.dtos;

import lombok.Data;

import java.util.List;

@Data
public class DeployConfigurationsDto {
    private String setupMode;
    private String snapshot;
    private String environment;
    private List<InterfaceDto> interfacesList;
}
