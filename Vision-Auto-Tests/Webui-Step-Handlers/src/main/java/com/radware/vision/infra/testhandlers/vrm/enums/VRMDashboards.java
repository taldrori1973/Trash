package com.radware.vision.infra.testhandlers.vrm.enums;

public enum VRMDashboards {
    DP_ANALYTICS("DP Analytics"),
    DP_MONITORING_DASHBOARD("DP Monitoring Dashboard"),
    DP_BASE_LINE("DP Base Line"),
    DP_BASELINE_BDOS("DP Baseline BDoS"),
    DP_BASELINE_DNS("DP Baseline DNS");


    private String label;

    VRMDashboards(String label) {
        this.label = label;
    }

    public String getLabel() {
        return this.label;
    }
}
