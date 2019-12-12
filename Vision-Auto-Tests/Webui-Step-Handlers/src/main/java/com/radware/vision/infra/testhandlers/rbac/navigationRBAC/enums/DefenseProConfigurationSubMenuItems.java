package com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums;

/**
 * Created by stanislava on 1/8/2015.
 */
public enum DefenseProConfigurationSubMenuItems {
    SETUP("setup"),
    CLASSES("classes"),
    NETWORK_PROTECTION("nwprotection"),
    SERVER_PROTECTION("serverprotection"),
    ACCESS_CONTROL("blackwhitelist");

    private String subMenu;

    private DefenseProConfigurationSubMenuItems(String subMenu) {
        this.subMenu = subMenu;
    }

    public String getSubMenu() {
        return this.subMenu;
    }
}
