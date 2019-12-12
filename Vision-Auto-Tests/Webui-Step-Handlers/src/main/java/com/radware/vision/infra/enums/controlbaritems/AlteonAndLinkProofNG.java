package com.radware.vision.infra.enums.controlbaritems;


import com.radware.vision.infra.enums.enumsutils.Element;

public enum AlteonAndLinkProofNG implements Element {

    APPLY("Apply", "gwt-debug-DeviceControlBar_Apply_alteonApply"),
    SAVE("Save", "gwt-debug-DeviceControlBar_Save_alteonSave"),
    REVERT("Revert", "gwt-debug-DeviceControlBar_Revert"),
    REVERT_CHILD("Revert->Revert", "gwt-debug-DeviceControlBar_Revert_alteonRevert"),
    REVERT_APPLY("Revert->Revert Apply", "gwt-debug-DeviceControlBar_Revert_alteonRevertApply"),
    SYNC("Sync", "gwt-debug-DeviceControlBar_Sync_Disabled_highAvailabilityBaselineSynch"),
    OPERATIONS("Operations", "gwt-debug-DeviceControlBar_Operations"),
    IMPORT("Operations->Import", "gwt-debug-DeviceControlBar_Operations_sendFileToDevice_Configuration"),
    EXPORT("Operations->Export", "gwt-debug-DeviceControlBar_Operations_getFileFromDevice_Configuration"),
    DIFF("Diff", "gwt-debug-DeviceControlBar_Diff"),
    DUMP("Dump", "gwt-debug-DeviceControlBar_Dump");


    private String elementId;
    private String elementName;


    AlteonAndLinkProofNG(String elementName, String elementId) {
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