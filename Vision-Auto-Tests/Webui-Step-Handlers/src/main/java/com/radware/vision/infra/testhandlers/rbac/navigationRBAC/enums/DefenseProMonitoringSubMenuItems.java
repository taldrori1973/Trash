package com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums;

/**
 * Created by stanislava on 1/8/2015.
 */
public enum DefenseProMonitoringSubMenuItems {
    OPERATIONAL_STATUS("OperationalStatus"),
    STATISTICS("Statistics"),
    NETWORKING("Networking");

    private String subMenu;

    private DefenseProMonitoringSubMenuItems(String subMenu) {
        this.subMenu = subMenu;
    }

    public String getSubMenu() {
        return this.subMenu;
    }
}
