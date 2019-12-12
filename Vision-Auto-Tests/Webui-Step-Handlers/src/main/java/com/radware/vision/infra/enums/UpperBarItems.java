package com.radware.vision.infra.enums;

public enum UpperBarItems {
    TOOLTIP("gwt-debug-applicationMenu", "Tooltip", "gwt-debug-Global_AVR", new Boolean[]{false}),
    AVR("gwt-debug-Global_AVR", "AVR", "", new Boolean[]{false}),
    APM("gwt-debug-Global_APM", "APM", "", new Boolean[]{false}),
    DPM("gwt-debug-Global_DPM", "DPM", "", new Boolean[]{false}),
    ADC("gwt-debug-Global_DPM", "ADC", "", new Boolean[]{false}),
    CLOUD_DDOS_PORTAL("gwt-debug-Global_DPIPE", "Cloud DDoS Portal", "", new Boolean[]{false}),
    V_DIRECT("gwt-debug-Global_VDIRECT", "vDirect", "", new Boolean[]{false}),
    ScheduledTaskTab("gwt-debug-Global_ScheduledTaskTab", "Scheduler", "", new Boolean[]{true}),
    VisionSettings("gwt-debug-Global_VisionSettings", "Vision Settings", "", new Boolean[]{true}),
    Refresh("gwt-debug-Global_Refresh", "Refresh", "", new Boolean[]{false}),
    security_control_center("gwt-debug-Global_security_control_center", "Security Control Center", "", new Boolean[]{false}),
    ToolBox("gwt-debug-Global_ToolBox", "Toolbox", "gwt-debug-ToolBox_Tab", new Boolean[]{true}),
    ToolBox_Dashboard("gwt-debug-ToolBox_DASHBOARD", "Dashboard", "gwt-debug-ToolBox_Tab", new Boolean[]{true, false}),
    ToolBox_Advanced("gwt-debug-ToolBox_ADVANCED", "Advanced", "gwt-debug-DefensePro_TemplatesNode-content", new Boolean[]{true, false}),
    AMS("gwt-debug-Global_VRM", "AMS", "", new Boolean[]{false}),
    ANALYTICS("gwt-debug-Global_Analytics", "Analytics", "", new Boolean[]{false}),
    EAAF_Dashboard("gwt-debug-Global_ert_menu_item", "EAAF Dashboard", "", new Boolean[]{false}),
    ALERTS("gwt-debug-AlertsMaximize", "ALERTS", "", new Boolean[]{false}),
    GEL_Dashboard("gwt-debug-Global_vdirect_gel_dashboard", "GEL Dashboard", "", new Boolean[]{false});
    private String menuIds;
    private String verifyIds;
    private Boolean[] toggleIds;


    private String name;

    private UpperBarItems(String menus, String name, String verifies, Boolean[] toggles) {
        menuIds = menus;
        this.name = name;
        verifyIds = verifies;
        toggleIds = toggles;
    }

    public static UpperBarItems getEnumValue(String value) {

        for (UpperBarItems item : UpperBarItems.values()) {

            if (item.getName().equals(value)) return item;
        }
        return null;
    }

    public String getMenuIds() {
        return menuIds;
    }

    public String getVerifyIds() {
        return verifyIds;
    }

    public Boolean[] getToggles() {
        return toggleIds;
    }

    public String getName() {
        return name;
    }

}
