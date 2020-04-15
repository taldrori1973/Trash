package com.radware.vision.automation.AutoUtils.SUT.utils;

import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.util.Map;

public class RuntimeVMOptions {

    private RuntimeMXBean runtimeMXBean;

    private Map<String, String> vmOptions;


    public RuntimeVMOptions() {
        this.runtimeMXBean = ManagementFactory.getRuntimeMXBean();
        this.vmOptions = runtimeMXBean.getSystemProperties();
    }

    public String getValueByKey(String key) {
        return this.vmOptions.get(key);
    }
}
