package com.radware.vision.infra.testhandlers.rbac.enums;

/**
 * Created by stanislava on 10/23/2014.
 */
public enum DeviceSettingsSubMenus {
    CONFIGURATION("Configuration"),
    MONITORING("Monitoring"),
    SECURITY_MONITORING("Security Monitoring");


    private String subMenu;

    private DeviceSettingsSubMenus(String subMenu) {
        this.subMenu = subMenu;
    }

    public String getSubMenu() {
        return this.subMenu;
    }
}
