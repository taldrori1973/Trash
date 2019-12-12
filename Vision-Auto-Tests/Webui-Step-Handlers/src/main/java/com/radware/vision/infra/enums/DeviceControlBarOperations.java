package com.radware.vision.infra.enums;

import com.radware.automation.webui.utils.WebUIStrings;

/**
 * Created by stanislava on 9/16/2015.
 */
public enum DeviceControlBarOperations {

    SELECT_DEVICE_CONTROL_BAR_OPERATION("", ""),
    APPLY("", WebUIStrings.getApplyButton()),
    SAVE("", WebUIStrings.getSaveButton()),
    REVERT(WebUIStrings.getRevertButton(), WebUIStrings.getRevertAlteonRevertButton()),
    REVERT_APPLY(WebUIStrings.getRevertButton(), WebUIStrings.getRevertAlteonApplyButton()),
    SYNC("", WebUIStrings.getSyncButton()),
    ALTEON_IMPORT(WebUIStrings.getOperationsButton(), WebUIStrings.getImportConfigurationFileToDevice()),
    ALTEON_EXPORT(WebUIStrings.getOperationsButton(), WebUIStrings.getExportConfigurationFileToDevice()),
    DP_UPDATE_POLICIES(WebUIStrings.getOperationsButton(), WebUIStrings.getUpdatePoliciesButton()),
    DP_IMPORT_CONFIGURATION_FILE(WebUIStrings.getOperationsButton(), WebUIStrings.getImportConfigurationFileButton()),
    DP_EXPORT_CONFIGURATION_FILE(WebUIStrings.getOperationsButton(), WebUIStrings.getExportConfigurationFileToDevice()),
    DP_EXPORT_LOG_SUPPORT_FILE(WebUIStrings.getOperationsButton(), WebUIStrings.getExportLogSupportFile()),
    DP_EXPORT_TECHNICAL_SUPPORT_FILE(WebUIStrings.getOperationsButton(), WebUIStrings.getExportTechnicalSupportFile()),
    DP_UPDATE_SOFTWARE_VERSION(WebUIStrings.getOperationsButton(), WebUIStrings.getUpdateSoftwareVersion()),
    DP_UPDATE_SECURITY_SIGNATURES(WebUIStrings.getOperationsButton(), WebUIStrings.getUpdateSecuritySignatures()),
    DIFF("", WebUIStrings.getDiffButton()),
    DUMP("", WebUIStrings.getDumpButton()),
    HELP("", WebUIStrings.getHelpButton()),
    ONLINE_HELP(WebUIStrings.getHelpTriangleButton(), WebUIStrings.getHelpButton()),
    ONLINE_SUPPORT(WebUIStrings.getHelpTriangleButton(), WebUIStrings.getOnlineSupportButton()),
    SEND_FEEDBACK(WebUIStrings.getHelpTriangleButton(), WebUIStrings.getOnlineFeedbackButton());


    String deviceControlBarOperation;
    String operationType;

    DeviceControlBarOperations(String operationType, String deviceControlBarOperation) {
        this.deviceControlBarOperation = deviceControlBarOperation;
        this.operationType = operationType;
    }

    public String getDeviceControlBarOperation() {
        return this.deviceControlBarOperation;
    }

    public String getOperationType() {
        return this.operationType;
    }


}
