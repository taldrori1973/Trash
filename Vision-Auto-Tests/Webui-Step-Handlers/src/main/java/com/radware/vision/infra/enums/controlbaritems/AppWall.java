package com.radware.vision.infra.enums.controlbaritems;

import com.radware.vision.infra.enums.enumsutils.Element;

public enum AppWall implements Element {
    APPLY("Apply", "gwt-debug-DeviceControlBar_Apply_apply");


    private String elementId;
    private String elementName;


    AppWall(String elementName, String elementId) {
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
