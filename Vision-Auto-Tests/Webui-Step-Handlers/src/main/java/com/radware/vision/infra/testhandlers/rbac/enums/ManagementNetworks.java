package com.radware.vision.infra.testhandlers.rbac.enums;

public enum ManagementNetworks {
    IPV4("IPV4"),
    IPV6("IPV6");

    private String network;

    private ManagementNetworks(String network) {
        this.network = network;
    }

    public String getNetwork() {
        return this.network;
    }
}
