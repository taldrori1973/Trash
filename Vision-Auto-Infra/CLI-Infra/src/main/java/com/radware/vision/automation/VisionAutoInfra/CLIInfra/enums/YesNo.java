package com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums;

/**
 * Created by moaada on 6/25/2017.
 */
public enum YesNo {
    YES("y"),
    NO("n");

    private String text;

    YesNo(String text) {
        this.text = text;
    }

    public String getText() {
        return this.text;
    }

    public static YesNo getConstant(String yn){
        yn=yn.toLowerCase();
        switch (yn){
            case "y":return YES;
            case "n":return NO;
            default:return null;
        }
    }
}
