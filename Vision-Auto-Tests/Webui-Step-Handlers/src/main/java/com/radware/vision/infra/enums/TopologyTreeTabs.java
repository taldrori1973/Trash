package com.radware.vision.infra.enums;

public enum TopologyTreeTabs {
    SitesAndClusters("Sites And Devices"),
    PhysicalContainers("Physical Containers"),
    LOGICAL_GROUPS("Logical Groups");

    private String TopologyTreeTab;


    private TopologyTreeTabs(String TopologyTreeTab) {
        this.TopologyTreeTab = TopologyTreeTab;
    }

    //support old & new values of enum
    public static TopologyTreeTabs getEnum(String enumValue) {

        if ( enumValue == null || enumValue.equals("SitesAndClusters") || enumValue.equals("Sites And Devices")  || enumValue.equals("null")) {
            return SitesAndClusters;
        } else if (enumValue.equals("PhysicalContainers") || enumValue.equals("Physical Containers")) {
            return PhysicalContainers;
        } else {
            return LOGICAL_GROUPS;
        }
    }

    public String getTopologyTreeTab() {
        return this.TopologyTreeTab;
    }
}
