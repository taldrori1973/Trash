package com.radware.vision.infra.testhandlers.baseoperations.enums;

import com.radware.vision.automation.tools.exceptions.misc.NoSuchOperationException;

import java.util.Arrays;

public enum Operation {

    SELECT("select"),
    OPEN("open"),
    EDIT("edit"),
    DELETE("delete"),
    HOVER("hover");

    private String operationName;

    Operation(String operationName) {
        this.operationName = operationName;
    }

    public static Operation getEnum(String operationName) throws NoSuchOperationException {
        return Arrays.stream(Operation.values())
                .filter(e -> e.getOperationName().equalsIgnoreCase(operationName))
                .findAny()
                .orElseThrow(() -> new NoSuchOperationException("There is no operation of type "));
    }

    public String getOperationName() {
        return operationName;
    }
}
