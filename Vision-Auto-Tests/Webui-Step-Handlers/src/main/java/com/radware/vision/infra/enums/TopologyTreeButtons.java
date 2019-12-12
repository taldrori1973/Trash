package com.radware.vision.infra.enums;

/**
 * Created by stanislava on 9/10/2015.
 */
public enum TopologyTreeButtons {

    SELECT_TOPOLOGY_TREE_BUTTON(""),
    ADD("gwt-debug-DeviceTreeAdd"),
    EDIT("gwt-debug-DeviceTreeEdit"),
    DELETE("gwt-debug-DeviceTreeDelete"),
    CREATE_CLUSTER("gwt-debug-ClusterDPs"),
    BREAK_CLUSTER("gwt-debug-BreakClusterDPs"),
    EXPORT_DEVICE_LIST("gwt-debug-DeviceTreeExport"),
    VIEW("gwt-debug-DeviceView");


    private String treeButton;

    private TopologyTreeButtons(String treeButton) {
        this.treeButton = treeButton;
    }

    public String getTreeButton() {
        return this.treeButton;
    }

    public static TopologyTreeButtons getTopologyTreeButtonsEnum(String treeButton){
        switch (treeButton){
            case "gwt-debug-DeviceTreeAdd":
                return ADD;
            case "gwt-debug-DeviceTreeEdit":
                return EDIT;
            case "gwt-debug-DeviceTreeDelete":
                return DELETE;
            case "gwt-debug-ClusterDPs":
                return CREATE_CLUSTER;
            case "gwt-debug-BreakClusterDPs":
                return BREAK_CLUSTER;
            case "gwt-debug-DeviceTreeExport":
                return VIEW;
            case "gwt-debug-DeviceView":
        }
        return null;
    }
}
