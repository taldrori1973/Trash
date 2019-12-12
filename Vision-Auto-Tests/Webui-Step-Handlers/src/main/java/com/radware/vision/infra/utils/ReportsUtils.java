package com.radware.vision.infra.utils;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;

import java.util.ArrayList;
import java.util.List;

public class ReportsUtils {

    private static List<String> errorMessages = new ArrayList<>();

    public static void reportAndTakeScreenShot(String message, int status) {
        WebUIUtils.generateAndReportScreenshot();
        BaseTestUtils.report(message, status);
    }

    /**
     * method for adding error message's
     * each time you call it it will append the message to the previous one
     *
     * @param message
     */

    public static void addErrorMessage(String message) {
        errorMessages.add(message);
        errorMessages.add(GeneralUtils.lineSeparator);
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

    public static boolean isErrorMessagesEmpty() {
        return errorMessages.isEmpty();
    }

    public static void clearErrorMessages() {
        errorMessages.clear();
    }
}
