package com.radware.vision.infra.testhandlers.alteon.securitymonitoring.dashboardview.sslinspection.enums;

public enum SslInspectionTabs {

    DASHBOARD("Dashboard", "Dashboard"),
    REPORTS_SETTINGS("Report Settings", "Reports"),
    REPORTS("Reports", "Logs");

    private String tabName;
    private String dataDebugId;


    SslInspectionTabs(String tabName, String dataDebugId) {
        this.tabName = tabName;
        this.dataDebugId = dataDebugId;
    }


    public String getTabName() {

        return this.tabName;
    }

    public String getDataDebugId() {
        return "Standalone-NGR-" + this.dataDebugId;
    }

}
