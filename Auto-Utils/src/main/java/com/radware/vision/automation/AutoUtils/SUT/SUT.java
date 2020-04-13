package com.radware.vision.automation.AutoUtils.SUT;

import lombok.Data;

import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.util.List;

@Data
public class SUT {

    private static RuntimeMXBean runtimeMXBean = ManagementFactory.getRuntimeMXBean();
    private static final SUT instance = new SUT();


    private SUT() {
        List<String> arguments = runtimeMXBean.getInputArguments();
    }

    public static SUT getInstance() {
        return instance;
    }
}
