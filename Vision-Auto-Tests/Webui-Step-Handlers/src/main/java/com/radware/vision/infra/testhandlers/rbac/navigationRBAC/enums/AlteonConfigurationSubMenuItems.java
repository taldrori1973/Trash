package com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums;

/**
 * Created by stanislava on 1/8/2015.
 */
public enum AlteonConfigurationSubMenuItems {
    SYSTEM("Configuration.System"),
    NETWORK("Configuration.Network"),
    APPLICATION_DELIVERY("Configuration.Application Delivery"),
    SECURITY("Security");

    private String subMenu;

    private AlteonConfigurationSubMenuItems(String subMenu) {
        this.subMenu = subMenu;
    }

    public String getSubMenu() {
        return this.subMenu;
    }
}
