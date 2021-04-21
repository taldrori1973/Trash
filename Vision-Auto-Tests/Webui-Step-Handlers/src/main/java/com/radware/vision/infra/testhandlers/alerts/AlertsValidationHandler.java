package com.radware.vision.infra.testhandlers.alerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.restcore.VisionRestClient;
import com.radware.restcore.utils.enums.DeviceType;
import com.radware.vision.infra.base.pages.alerts.Alerts;
import com.radware.vision.infra.tablepagesnavigation.NavigateTable;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import org.json.JSONObject;
import testhandlers.Device;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * Created by stanislava on 10/7/2014.
 */
public class AlertsValidationHandler {
    public static boolean validateClearAllAlerts() {
        Alerts alerts = new Alerts();
        if (!alerts.isAlertsTableOpen()) {
            alerts.alertsMaximize();
        }
        return alerts.validateClearAllAlertsAction();
    }

    public static boolean validateAckAllAlerts() {
        Alerts alerts = new Alerts();
        if (!alerts.isAlertsTableOpen()) {
            alerts.alertsMaximize();
        }
        return alerts.validateAckAllAlertsAction();
    }

    public static String validateAlertTableData(HashMap<String, List<String>> expectedTableData) throws Exception {
        Alerts alerts = new Alerts();
        alerts.alertsMaximize();
        alerts.autoRefreshAlertsOff();
        String resultMessage = "";
        resultMessage = resultMessage.concat(alerts.validateTableData(expectedTableData));
        alerts.alertsMinimize();
        return resultMessage;
    }

    public static boolean validateCriticalAlerts(VisionRestClient visionRestClient) {
        Alerts alerts = new Alerts();
        alerts.alertsMaximize();
        alerts.autoRefreshAlertsOff();
        WebUITable table = alerts.retrieveAlertsTable();
        String result = visionRestClient.mgmtCommands.visionCommands.getAlertBrowserSettings();
        alerts.alertsMinimize();
        JSONObject json = new JSONObject(result);
        int lastCriticalAlertNumber = Integer.parseInt(json.get("lastCriticalAlertNumber").toString());
        return table.getRowCount() <= lastCriticalAlertNumber;
    }

    public static long validateRefreshInterval(VisionRestClient visionRestClient, com.radware.vision.pojomodel.helpers.constants.ImConstants$VisionMgtPortEnumPojo visionMgtPort) {
        long sec = 1000;
        String parentName = "Default";
        Alerts alerts = new Alerts();
        alerts.alertsMaximize();
        String result = visionRestClient.mgmtCommands.visionCommands.getAlertBrowserSettings();
        JSONObject json = new JSONObject(result);
        int refreshInterval = Integer.parseInt(json.get("refreshInterval").toString());
        Date endTime;
        startNewRefreshCount(visionRestClient, parentName, getDeviceProperties(), visionMgtPort);

        Date startTime = new Date();
        int rowsNumStart = NavigateTable.getRowsTotal();

        Device.addNewAlteonDevice(visionRestClient, "refreshIntervalTestDevice", parentName, getDeviceProperties(), visionMgtPort);
        do {
            BasicOperationsHandler.delay(1);
        }
        while (rowsNumStart == NavigateTable.getRowsTotal());
        endTime = new Date();

        return (endTime.getTime() - startTime.getTime()) / sec;
    }

    public static void startNewRefreshCount(VisionRestClient visionRestClient, String parentName, HashMap<String, String> properties, com.radware.vision.pojomodel.helpers.constants.ImConstants$VisionMgtPortEnumPojo visionMgtPort) {
        int rowsNumStart = NavigateTable.getRowsTotal();
        WebUITable tableEnd;
        Device.addNewAlteonDevice(visionRestClient, properties.get("name"), parentName, getDeviceProperties(), visionMgtPort);
        Device.deleteDeviceById(visionRestClient, properties.get("name"));

        do {
            BasicOperationsHandler.delay(1);

        }
        while (rowsNumStart == NavigateTable.getRowsTotal());
    }

    public static HashMap<String, String> getDeviceProperties() {
        HashMap<String, String> properties = new HashMap<String, String>();
        try {
            properties.put("ip", "1.1.1.1");
            properties.put("name", "refreshIntervalTestDevice");
            properties.put("sshPort", "22");
            properties.put("deviceType", String.valueOf(DeviceType.Alteon));
        } catch (Exception e) {
            BaseTestUtils.report("Test " + " failed with the following error:\n" + e.getMessage(), Reporter.FAIL);
        }
        return properties;
    }

}
