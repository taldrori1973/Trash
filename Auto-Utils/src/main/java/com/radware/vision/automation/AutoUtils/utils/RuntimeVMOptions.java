package com.radware.vision.automation.AutoUtils.utils;

import java.lang.management.ManagementFactory;
import java.lang.management.RuntimeMXBean;
import java.util.Map;
import java.util.Objects;

/**
 * Muhamad Igbaria (MohamadI)
 * This is a utility class for getting the runtime VM Options
 */
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

    public String getSUTFileName(String sutKey) {
        return this.getValueByKey(sutKey);
    }

    public String getResourcesPath(String name) {
        return Objects.requireNonNull(getClass().getClassLoader().getResource(name)).getPath();
    }
}
