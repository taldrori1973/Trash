package com.radware.vision.automation.systemManagement;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;

import java.util.ArrayList;
import java.util.List;

public abstract class ReportsUtilsAutoCommon {

    protected static List<String> errorMessages = new ArrayList<>();

    /**
     * method for adding error message's
     * each call will append the message to the previous one
     *
     * @param message
     */
    public static void addErrorMessage(String message) {
        errorMessages.add(message);
        errorMessages.add(System.lineSeparator());
    }

    /**
     * calling this method will report all messages and that have been added by using method addErrorMessage
     * and clean the list
     */
    public static void reportErrors() {
        if (!errorMessages.isEmpty()) {
            try {
                BaseTestUtils.report(errorMessages.toString(), Reporter.FAIL);
            } finally {
                errorMessages.clear();
            }
        }
    }
}
