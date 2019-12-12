package com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums;

/**
 * Created by stanislava on 1/8/2015.
 */
public enum PreferencesSubMenuItems {
    USER_PREFERENCES("preferences.tab");

    private String subMenu;

    private PreferencesSubMenuItems(String subMenu) {
        this.subMenu = subMenu;
    }

    public String getSubMenu() {
        return this.subMenu;
    }
}
