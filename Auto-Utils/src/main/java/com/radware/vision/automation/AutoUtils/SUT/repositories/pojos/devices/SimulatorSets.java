package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices;

import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class SimulatorSets {
    private String id;
    private List<String> ips;
    private String type;

}
