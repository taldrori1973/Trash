package com.radware.vision.infra.enums;

/**
 * Created by stanislava on 4/18/2016.
 */
public enum EqualsOrContains {
    EQUALS("equals"),
    NOT_EQUALS("not_equals"),
    CONTAINS("contains"),
    MatchRegex("MatchRegex"),
    GT(">"),
    GTE(">="),
    LT("<"),
    LTE("<=");




    private String validationType;

    private EqualsOrContains(String validationType) {
        this.validationType = validationType;
    }

    public String getValidationType() {
        return this.validationType;
    }
}
