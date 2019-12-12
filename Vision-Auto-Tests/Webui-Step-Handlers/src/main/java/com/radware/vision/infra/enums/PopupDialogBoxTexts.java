package com.radware.vision.infra.enums;

public enum PopupDialogBoxTexts {
    CAPTION("_Caption"),
    MESSAGE("_Message");

    private String textType;

    private PopupDialogBoxTexts(String textType) {
        this.textType = textType;
    }

    public String getByTextType() {
        return this.textType;
    }
}
