package com.radware.vision.infra.enums.controlbaritems;

import com.radware.vision.infra.enums.enumsutils.Element;

public enum DefensePro implements Element {

    UPDATE_POLICES("Update Policies", "gwt-debug-DeviceControlBar_Apply_updatePolicies"),
    OPERATIONS("Operations", "gwt-debug-DeviceControlBar_Operations"),
    IMPORT_CONFIGURATION_FILE("Operations->Import Configuration File", "gwt-debug-DeviceControlBar_Operations_sendFileToDevice_Configuration"),
    EXPORT_CONFIGURATION_FILE("Operations->Export Configuration File", "gwt-debug-DeviceControlBar_Operations_getFileFromDevice_Configuration"),
    EXPORT_LOG_SUPPORT_FILE("Operations->Export Log Support File", "gwt-debug-DeviceControlBar_Operations_getFileFromDevice_Configuration"),
    EXPORT_TECHNICAL_SUPPORT_FILE("Operations->Export Technical Support File", "gwt-debug-DeviceControlBar_Operations_getFileFromDevice_Support"),
    UPDATE_SOFTWARE_VERSION("Operations->Update Software Version", "gwt-debug-DeviceControlBar_Operations_upgradeSoftware"),
    UPDATE_SECURITY_SINGAUTES("Operations->Update Security Signatures", "gwt-debug-DeviceControlBar_Operations_sendSignatureFileFromWebsiteToDevice"),
    DIFF("Diff", "gwt-debug-DeviceControlBar_Compare");

    private String elementId;
    private String elementName;

    DefensePro(String elementName, String elementId) {
        this.elementName = elementName;
        this.elementId = elementId;
    }

    public static DefensePro getEnumByName(String name) throws Exception {

        for (DefensePro instance : DefensePro.values()) {

            if (instance.getElementName().equals(name)) return instance;

        }
        throw new Exception("There is no operations matches :" + name);
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
