package com.radware.vision.infra.testhandlers.ams.enums;

import com.radware.vision.automation.tools.exceptions.misc.NoSuchOperationException;

import java.util.Arrays;

public enum vrmActions {


    CREATE("Create"),
    GENERATE("Generate"),
    VALIDATE("Validate"),
    ISEXIST("Isexist"),
    EDIT("Edit");


    String value;

     vrmActions(String value) {
        this.value = value;
    }

    public static vrmActions getEnum(String action) throws NoSuchOperationException {
        return Arrays.stream(vrmActions.values())
                .filter(e -> e.value.equalsIgnoreCase(action))
                .findAny()
                .orElseThrow(() -> new NoSuchOperationException("There is no action of type " + action));
    }
}
