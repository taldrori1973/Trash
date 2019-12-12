package com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums;

/**
 * Created by stanislava on 1/8/2015.
 */
public enum AlteonMonitoringSubMenuItems {
    SYSTEM("System"),
    NETWORK("Network"),
    APPLICATION_DELIVERY("Application Delivery");

    private String subMenu;

    private AlteonMonitoringSubMenuItems(String subMenu) {
        this.subMenu = subMenu;
    }

    public String getSubMenu() {
        return this.subMenu;
    }
}
