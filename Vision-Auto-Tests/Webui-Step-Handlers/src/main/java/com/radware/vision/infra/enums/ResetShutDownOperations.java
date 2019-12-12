package com.radware.vision.infra.enums;

import com.radware.automation.webui.utils.WebUIStrings;

/**
 * Created by stanislava on 9/20/2015.
 */
public enum ResetShutDownOperations {
    Reset(WebUIStrings.getDeviceResetButton()),
    ShutDown(WebUIStrings.getDeviceShutDownButton());

    private String operationType;

    private ResetShutDownOperations(String operationType) {
        this.operationType = operationType;
    }

    public String getOperationType() {
        return this.operationType;
    }
}
