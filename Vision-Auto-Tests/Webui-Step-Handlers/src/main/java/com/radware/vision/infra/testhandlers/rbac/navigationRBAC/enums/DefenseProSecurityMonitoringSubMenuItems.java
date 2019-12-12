package com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums;

/**
 * Created by stanislava on 1/8/2015.
 */
public enum DefenseProSecurityMonitoringSubMenuItems {
    DASHBOARD_VIEW("DashboardView"),
    TRAFFIC_MONITORING("TrafficMonitoring"),
    PROTECTION_MONITORING("ProtectionMonitoring"),
    HTTP_REPORTS("HTTPReports");

    private String subMenu;

    private DefenseProSecurityMonitoringSubMenuItems(String subMenu) {
        this.subMenu = subMenu;
    }

    public String getSubMenu() {
        return this.subMenu;
    }
}
