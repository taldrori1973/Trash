package com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.setup;

import com.radware.automation.webui.webpages.dp.configuration.setup.reportingsettings.advancedReportingSettings.AdvancedReportingSettings;
import com.radware.automation.webui.webpages.dp.configuration.setup.reportingsettings.signaling.Signaling;
import com.radware.automation.webui.webpages.dp.configuration.setup.reportingsettings.syslog.Syslog;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProReportingSettingsTableActionHandler extends RBACHandlerBase {

    public static boolean verifySyslogTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        Syslog syslog = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mReportingSettings().mSyslog();
        syslog.openPage();

        WebUITable table = syslog.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("syslogTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySignalingTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        Signaling signaling = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mReportingSettings().mSignaling();
        signaling.openPage();

        WebUITable table = signaling.getTable();
        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("signalingTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyDataReportingDestinationsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);

        AdvancedReportingSettings advancedReportingSettings = DeviceVisionWebUIUtils.dpUtils.dpProduct.mConfiguration().mSetup().mReportingSettings().mAdvancedReportingSettings();
        advancedReportingSettings.openPage();

        advancedReportingSettings.mDataReportingDestinations().openTab();
        WebUITable table = advancedReportingSettings.mDataReportingDestinations().getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("dataReportingDestinationsTableAction"), expectedResultRBAC);
        return result;
    }

}
