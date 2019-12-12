package com.radware.vision.tests.GeneralOperations.DeviceOperations;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.DeviceControlBarOperations;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.ResetShutDownOperations;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.support.How;

/**
 * Created by urig on 9/9/2015.
 */
public class DeviceOperationsTests extends WebUITestBase {

    DeviceState deviceState = DeviceState.Lock;
    DeviceControlBarOperations deviceControlBarOperation = DeviceControlBarOperations.SELECT_DEVICE_CONTROL_BAR_OPERATION;
    ResetShutDownOperations operationToPerform = ResetShutDownOperations.Reset;

    @Test
    @TestProperties(name = "Perform Device LockUnlock Operation", paramsInclude = {"deviceState"})
    public void performDeviceLockUnlockOperation() {
        try {
            BasicOperationsHandler.delay(1);
            if (!deviceState.toString().equals("") && deviceState != null) {
                DeviceOperationsHandler.atomicLockUnlockDevice(deviceState.getDeviceState());
            } else {
                report.report("Failed to click on the specified button : " + deviceState.toString(), Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Failed to click on the specified button : " + deviceState.toString(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Perform Device ResetShutDown Operation", paramsInclude = {"operationToPerform"})
    public void performDeviceResetShutDownOperation() {
        try {
            if (!operationToPerform.getOperationType().equals("") && deviceState != null) {
                DeviceOperationsHandler.atomicLockUnlockDevice(DeviceState.Lock.getDeviceState());
                WebUIUtils.fluentWaitClick(new ComponentLocator(How.ID, WebUIStrings.getSelectResetOrShutdownButton()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                WebUIUtils.fluentWaitClick(new ComponentLocator(How.ID, operationToPerform.getOperationType()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                WebUIBasePage.silentPopupclose();

            } else {
                report.report("Failed to click on the specified button : " + operationToPerform.toString(), Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Failed to click on the specified button : " + operationToPerform.toString(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Perform Device control Bar Operation", paramsInclude = {"deviceControlBarOperation"})
    public void performDeviceControlBarOperation() {
        try {
            if (!deviceControlBarOperation.getOperationType().equals("")) {
                WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, deviceControlBarOperation.getOperationType()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).click();
            }
            if (!deviceControlBarOperation.getDeviceControlBarOperation().equals("")) {
                WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, deviceControlBarOperation.getDeviceControlBarOperation()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).click();
            } else {
                report.report("No button selection is made : " + deviceControlBarOperation.getDeviceControlBarOperation(), Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Failed to click on the specified button : " + deviceControlBarOperation.getDeviceControlBarOperation(), Reporter.FAIL);
        }
    }

    public ResetShutDownOperations getOperationToPerform() {
        return operationToPerform;
    }

    public void setOperationToPerform(ResetShutDownOperations operationToPerform) {
        this.operationToPerform = operationToPerform;
    }

    public DeviceControlBarOperations getDeviceControlBarOperation() {
        return deviceControlBarOperation;
    }

    public void setDeviceControlBarOperation(DeviceControlBarOperations deviceControlBarOperation) {
        this.deviceControlBarOperation = deviceControlBarOperation;
    }

    public DeviceState getDeviceState() {
        return deviceState;
    }

    public void setDeviceState(DeviceState deviceState) {
        this.deviceState = deviceState;
    }
}
