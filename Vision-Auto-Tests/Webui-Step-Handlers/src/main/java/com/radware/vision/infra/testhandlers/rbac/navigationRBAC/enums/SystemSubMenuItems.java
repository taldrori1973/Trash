package com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums;

import com.radware.vision.infra.enums.enumsutils.Element;
import com.radware.vision.infra.utils.WebUIStringsVision;

/**
 * Created by stanislava on 1/8/2015.
 */
public enum SystemSubMenuItems implements Element {
    GENERAL_SETTINGS("General Settings", "generalSettings"),
    USER_MANAGEMENT("User Management", "tree.userManagement"),
    DEVICE_RESOURCES("Device Resources", "tree.additional");

    private String elementId;
    private String elementName;


    SystemSubMenuItems(String elementName, String elementId) {
        this.elementName = elementName;
        this.elementId = elementId;
    }

    @Override
    public String getElementName() {
        return elementName;
    }

    @Override
    public String getElementId() {
        return WebUIStringsVision.getVisionSystemSubMenuItem(elementId);
    }
}
