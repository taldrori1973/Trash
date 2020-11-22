package com.radware.vision.automation.AutoUtils.Operators;

/**
 * Created by stanislava on 4/18/2016.
 */
public enum OperatorsEnum {
    EQUALS("equals"),
    NOT_EQUALS("not_equals"),
    CONTAINS("contains"),
    MatchRegex("MatchRegex"),
    GT(">"),
    GTE(">="),
    LT("<"),
    LTE("<=");




    private String validationType;

    private OperatorsEnum(String validationType) {
        this.validationType = validationType;
    }

    public String getValidationType() {
        return this.validationType;
    }
}
