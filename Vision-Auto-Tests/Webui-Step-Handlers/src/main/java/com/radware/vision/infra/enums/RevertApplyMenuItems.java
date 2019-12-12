package com.radware.vision.infra.enums;

/**
 * Created by stanislava on 9/16/2015.
 */
public enum RevertApplyMenuItems {
    SELECT_DESIRED_MENU_ITEM(""),
    REVERT("Revert"),
    REVERT_APPLY("Apply");

    String revertApplyMenuItem;

    RevertApplyMenuItems(String revertApplyMenuItem) {
        this.revertApplyMenuItem = revertApplyMenuItem;
    }

    public String getRevertApplyMenuItem() {
        return this.revertApplyMenuItem;
    }
}
