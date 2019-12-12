package com.radware.vision.infra.testhandlers.rbac.enums;

import com.radware.vision.infra.enums.enumsutils.Element;

/**
 * Created by stanislava on 12/9/2014.
 */
public enum VisionSettingsSubMenu implements Element {
    SYSTEM("System", "gwt-debug-System"),
    DASHBOARDS("Dashboards", "gwt-debug-Dashboards"),
    PREFERENCES("Preferences", "gwt-debug-Preferences");

    private String elementName;
    private String elementId;

    private VisionSettingsSubMenu(String elementName, String elementId) {
        this.elementName = elementName;
        this.elementId = elementId;
    }

    @Override
    public String getElementName() {
        return elementName;
    }

    @Override
    public String getElementId() {
        return elementId;
    }
}
