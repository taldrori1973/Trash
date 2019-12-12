package com.radware.vision.infra.testhandlers.DefencePro.enums;

/**
 * Created by urig on 4/27/2015.
 */
public enum DPVersion {

    DP_6_09_01("6.09.01"),
    DP_6_11_00("6.11.00"),
    DP_6_11_01("6.11.01"),
    DP_6_11_02("6.11.02"),
    DP_6_12_00("6.12.00"),
    DP_6_12_01("6.12.01"),
    DP_6_13_00("6.13.00"),
    DP_6_14_00("6.14.00"),
    DP_7_30_00("7.30.00"),
    DP_7_32_00("7.32.00"),
    DP_7_32_01("7.32.01"),
    DP_7_32_02("7.32.02"),
    DP_7_40_00("7.40.00"),
    DP_7_41_00("7.41.00"),
    DP_7_41_01("7.41.01"),
    DP_1_00_00("1.00.00"),
    Non_DP(null);

    String version;
    private DPVersion(String dpVersion) {
        this.version = dpVersion;
    }

    public String getVersion() {
        return this.version;
    }

    public boolean isVersion_6_Family() {
        return getVersion().startsWith("6.");
    }

}
