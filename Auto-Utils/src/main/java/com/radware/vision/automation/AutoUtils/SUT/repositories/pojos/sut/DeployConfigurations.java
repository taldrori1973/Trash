package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut;

import com.radware.vision.automation.AutoUtils.SUT.dtos.InterfaceDto;
import lombok.Data;

import java.util.List;

@Data
public class DeployConfigurations {
    private String setupMode;
    private String snapshot;
    private String environment;
    private List<InterfaceDto> interfaces;
}
