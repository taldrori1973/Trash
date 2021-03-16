package com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums;

/**
 * Created by ashrafa on 9/27/2017.
 */
public enum ExporterConfigurationEnum {
    STATE("Exporter"),
    SYSLOGHOST("syslogHost"),
    SYSLOGPORT("syslogPort"),
    DPSECURITYATTACK("DPSecurityAttack"),
    DFSECURITYATTACK("DFSecurityAttack"),
    DPTRAFFICUTILIZATION("DPTrafficUtilization"),
    DFTRAFFICUTILIZATION("DFTrafficUtilization");

    private String configuration;

    ExporterConfigurationEnum(String configuration) {
        this.configuration = configuration;
    }

    public String getConfiguration() {
        return this.configuration;
    }
}
