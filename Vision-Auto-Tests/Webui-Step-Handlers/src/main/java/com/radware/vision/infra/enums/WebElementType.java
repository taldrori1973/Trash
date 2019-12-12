package com.radware.vision.infra.enums;

/**
 * Created by AviH on 7/10/2015.
 */

public enum WebElementType {
    Id("id"),
    Class("class"),
    Data_Debug_Id("data-debug-id"),
    XPATH("");
    private String attributeValue;

    WebElementType(String attributeValue) {
        this.attributeValue = attributeValue;
    }

    public String getAttributeValue() {
        return attributeValue;
    }
}
