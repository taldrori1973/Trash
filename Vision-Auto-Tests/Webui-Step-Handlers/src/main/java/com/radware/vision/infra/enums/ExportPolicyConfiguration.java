package com.radware.vision.infra.enums;

/**
 * Created by urig on 10/29/2014.
 */
public enum ExportPolicyConfiguration {
    Configuration("Configuration"),
    DNSBaseline("DNSBaseline"),
    BDOSBaseline("BDOSBaseline");

    String configuration;

    private ExportPolicyConfiguration(String configuration) {
        this.configuration = configuration;
    }

    public String getConfiguration() {
        return this.configuration;
    }
}
