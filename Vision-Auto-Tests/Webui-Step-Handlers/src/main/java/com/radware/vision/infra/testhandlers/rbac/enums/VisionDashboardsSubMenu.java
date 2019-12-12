package com.radware.vision.infra.testhandlers.rbac.enums;

import com.radware.vision.infra.enums.enumsutils.Element;

public enum VisionDashboardsSubMenu implements Element {


    DASHBOARDS_SUB_MENU("Dashboards", "gwt-debug-TopicsStack_am.dashboards.tab"),
    APPLICATION_SLA_DASHBOARD("Application SLA Dashboard", "gwt-debug-TopicsNode_sc-dashboard-content"),
    SECURITY_CONTROL_CENTER("Security Control Center", "gwt-debug-TopicsNode_SecurityControlCenter-content");

    private String elementName;
    private String elementId;

    private VisionDashboardsSubMenu(String elementName, String elementId) {
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
