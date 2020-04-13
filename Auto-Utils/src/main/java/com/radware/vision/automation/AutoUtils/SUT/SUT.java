package com.radware.vision.automation.AutoUtils.SUT;

import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;

import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.util.List;

public class SUT {

    private static SUT instance = new SUT();

    private String setup;
    private VisionConfiguration visionConfiguration;

    private SUT() {
        RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
        List<String> arguments = runtimeMXBean.getInputArguments();
    }

    public static SUT getInstance() {
        return instance;
    }
}
