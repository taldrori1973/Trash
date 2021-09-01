package com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.devices;

import lombok.Data;

import java.util.List;
import java.util.Map;

@Data
public class SimulatorPojo {
    private Map<String, List<String>> simulatorSets;
    private DeviceConfiguration configurations;
}
