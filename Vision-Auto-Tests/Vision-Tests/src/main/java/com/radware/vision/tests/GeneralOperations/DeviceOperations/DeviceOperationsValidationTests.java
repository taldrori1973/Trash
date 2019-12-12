package com.radware.vision.tests.GeneralOperations.DeviceOperations;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.testhandlers.multipleUseHandlers.MultipleUseHandlers;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by stanislava on 9/16/2015.
 */
public class DeviceOperationsValidationTests extends WebUITestBase {
    boolean expectedResult = true;

    @Test
    @TestProperties(name = "Validate LockUnlock Operation", paramsInclude = {"expectedResult"})
    public void validateLockUnlockOperation() {
        try {
            if (!MultipleUseHandlers.verifyLockUnlockOperation(expectedResult, "", "")) {
                report.report("Device Operation validation has failed: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Device Operation validation has failed : " + expectedResult, Reporter.FAIL);
        }
    }

    public boolean isExpectedResult() {
        return expectedResult;
    }

    public void setExpectedResult(boolean expectedResult) {
        this.expectedResult = expectedResult;
    }
}
