package com.radware.vision.infra.testhandlers.alerts;

import com.aqua.sysobj.conn.CliConnection;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.widgets.api.table.Table;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.restcore.VisionRestClient;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.infra.base.pages.alerts.AlertFilter;
import com.radware.vision.infra.base.pages.alerts.Alerts;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.AlertsTableColumns;
import com.radware.vision.infra.enums.DualListTypeEnum;
import com.radware.vision.infra.enums.RaisedTimeUnits;
import com.radware.vision.infra.enums.WebElementType;
import com.radware.vision.infra.testhandlers.alerts.AlertsUtils.AcknowledgementSetter;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.utils.GeneralUtils;
import com.radware.vision.infra.utils.WebUIStringsVision;

import java.util.*;

public class AlertsHandler {

    public static VisionRestClient visionRestClient;

    public static boolean maximizeAlertsBrowser() {

        new Alerts().alertsMaximize();
        String minimizeButtonXpath = GeneralUtils.buildGenericXpath(WebElementType.Id, WebUIStringsVision.getAlertsMinimizeButton(), OperatorsEnum.EQUALS);
        return ClickOperationsHandler.checkIfElementExistAndDisplayed(minimizeButtonXpath);
    }

    public static boolean minimizeAlertsBrowser() {
        new Alerts().alertsMinimize();
        String minimizeButtonXpath = GeneralUtils.buildGenericXpath(WebElementType.Id, WebUIStringsVision.getAlertsMaximizeButton(), OperatorsEnum.EQUALS);
        return ClickOperationsHandler.checkIfElementExistAndDisplayed(minimizeButtonXpath);
    }

    public static boolean clearAlert(String rowIndexes) {
        try {
            HashMap<String, String> filterProperties = new HashMap<String, String>();
            filterProperties.put("selectAllDevices", "true");
            filterProperties.put("raisedTimeUnit", RaisedTimeUnits.HOURS.getTimeUnits());
            filterProperties.put("raisedTimeValue", "24");
            filterProperties.put("devicesTypeList", "Alteon,Vision");
            AlertsHandler.filterAlerts(filterProperties);
            WebUIUtils.setIsTriggerPopupSearchEvent(false);
            Alerts alerts = new Alerts();
            alerts.alertsMaximize();
            alerts.autoRefreshAlertsOff();
            int origAlertsNum = alerts.getAlertsNumber();
            alerts.selectMultipleAlerts(rowIndexes);
            alerts.clearAlertButtonClick();
            alerts.autoRefreshAlertsOn();
            BasicOperationsHandler.delay(200);
            return check4AlertsNumber(rowIndexes, origAlertsNum);
        } finally {
            WebUIUtils.setIsTriggerPopupSearchEvent(true);
        }
    }

    public static boolean clearAllAlerts(int timeout) {
        boolean isClearAllAlerts;
        Alerts alerts = new Alerts();
        alerts.alertsMaximize();
        alerts.autoRefreshAlertsOff();
        alerts.clearAllAlertsButtonClick();
        BasicOperationsHandler.delay(2);
        BasicOperationsHandler.delay(timeout);
//        BasicOperationsHandler.refresh();
        isClearAllAlerts = alerts.validateClearAllAlertsAction();
        alerts.alertsMinimize();
        return isClearAllAlerts;
    }

    public static boolean ackAllAlerts() {
        HashMap<String, String> filterProperties = new HashMap<String, String>();
        filterProperties.put("selectAllDevices", "true");
        filterProperties.put("raisedTimeUnit", RaisedTimeUnits.HOURS.getTimeUnits());
        filterProperties.put("raisedTimeValue", "2");
        filterProperties.put("devicesTypeList", "Alteon,Vision");
        filterProperties.put("ackUnackStatusList", "Unacknowledged");
        AlertsHandler.filterAlerts(filterProperties);

        Alerts alerts = new Alerts();
        alerts.alertsMaximize();
        alerts.autoRefreshAlertsOff();
        alerts.ackAllAlertsButtonClick();
        BasicOperationsHandler.delay(200);
        BasicOperationsHandler.refresh();
        setFilterToAck();
        return AlertsValidationHandler.validateAckAllAlerts();
    }

    public static boolean ackAlert(String rowIndexes) {
        HashMap<String, String> filterProperties = new HashMap<String, String>();
        filterProperties.put("selectAllDevices", "true");
        filterProperties.put("raisedTimeUnit", RaisedTimeUnits.HOURS.getTimeUnits());
        filterProperties.put("raisedTimeValue", "1");
        filterProperties.put("devicesTypeList", "Alteon,Vision");
        filterProperties.put("ackUnackStatusList", "Unacknowledged");
        AlertsHandler.filterAlerts(filterProperties);

        return innerAckUnackAlerts(filterProperties, rowIndexes, true);
//        alerts.submitAlertAction();
    }

    public static boolean ackUnackAlert(String ackState, String rowIndexes) {
        switch (ackState) {
            case "acknowledge":
                return ackAlert(rowIndexes);
            case "unacknowledge":
                return unackAlert(rowIndexes);
        }
        return false;
    }

    public static boolean unackAlert(String rowIndexes) {
        HashMap<String, String> filterProperties = new HashMap<String, String>();
        filterProperties.put("selectAllDevices", "true");
        filterProperties.put("raisedTimeUnit", RaisedTimeUnits.HOURS.getTimeUnits());
        filterProperties.put("raisedTimeValue", "1");
        filterProperties.put("devicesTypeList", "Alteon,Vision");
        filterProperties.put("ackUnackStatusList", "Acknowledged");
        AlertsHandler.filterAlerts(filterProperties);

        return innerAckUnackAlerts(filterProperties, rowIndexes, false);
    }

    private static boolean innerAckUnackAlerts(HashMap<String, String> filterProperties, String rowIndexes, boolean ack) {
        int row = Integer.parseInt(rowIndexes);
        Alerts alerts = new Alerts();
        if (!alerts.isAlertsTableOpen()) {
            alerts.alertsMaximize();
        }
        int origAlertsNum = alerts.getAlertsNumber();
        if (origAlertsNum == 0) {
            BaseTestUtils.report("AckUnackAlerts: Current Alert Table contains no alerts items", Reporter.WARNING);
            return true;
        }
        Map<String, String> saveAlert = alerts.getAlertData(row);
        alerts.selectMultipleAlerts(rowIndexes);
        BasicOperationsHandler.delay(1);

        if (ack) {
            alerts.ackAlertButtonClick();
        } else {
            alerts.unackAlertButtonClick();
        }

        BasicOperationsHandler.delay(60);
        BasicOperationsHandler.refresh();
        filterProperties.put("ackUnackStatusList", "Acknowledged,Unacknowledged");
        filterProperties.put("raisedTimeValue", "2");
        AlertsHandler.filterAlerts(filterProperties);

        if (!alerts.isAlertsTableOpen()) {
            alerts.alertsMaximize();
        }
        final Map<String, Map<String, String>> allAlert = alerts.getAllAlertData(20);
        Map<String, String> updateAlert = allAlert.get(alerts.buildAlertKey(saveAlert));
        if (updateAlert == null) {
            BaseTestUtils.report("AckUnackAlerts: Can't get alert: " + alerts.buildAlertKey(saveAlert), Reporter.FAIL);
            return false;
        }

        if (ack) {
            return updateAlert.get("Ack").equals("true");
        } else {
            return updateAlert.get("Ack").equals("false");
        }
    }

    public static void editAlert(Integer rowNum) {
        Alerts alerts = new Alerts();
        alerts.alertsMaximize();
        alerts.viewAlert(rowNum);
        alerts.closeViewAlertsTab();
    }

    public static void autoRefreshOnOff(boolean isOn) {
        if (isOn) {
            autoRefreshOn(true);
        } else {
            autoRefreshOff(true);
        }
    }

    public static void autoRefreshOn(boolean isMinimize) {
        Alerts alerts = new Alerts();
        if (!alerts.isAlertsTableOpen()) {
            alerts.alertsMaximize();
        }
        alerts.autoRefreshAlertsOn();
        if (isMinimize) {
            alerts.alertsMinimize();
        }
    }

    public static void autoRefreshOn() {
        autoRefreshOn(false);
    }

    public static void autoRefreshOff(boolean isMinimize) {
        Alerts alerts = new Alerts();
        alerts.alertsMaximize();
        alerts.autoRefreshAlertsOff();
        if (isMinimize) {
            alerts.alertsMinimize();
        }
    }

    public static void autoRefreshOff() {
        autoRefreshOff(false);
    }

    public static void validateAlertsFilter(VisionRestClient visionReSTClient, HashMap<String, String> filterProperties) {
        try {
            if (filterProperties.get("ackUnackStatusList") != null && !filterProperties.get("ackUnackStatusList").equals("")) {
                filterProperties.put("ackUnackStatusList", filterProperties.get("ackUnackStatusList").replaceAll("true", "acknowledged"));
                filterProperties.put("ackUnackStatusList", filterProperties.get("ackUnackStatusList").replaceAll("false", "unAcknowledged"));
            }
            if (filterProperties.get("severityList") != null && !filterProperties.get("severityList").equals("")) {
                filterProperties.put("severityList", filterProperties.get("severityList").replaceAll("Information", "info"));
            }

            visionRestClient = visionReSTClient;
            filterAlerts(filterProperties);
            HashMap<String, List<String>> expectedData = new HashMap<String, List<String>>();
            if (filterProperties.get("raisedTimeUnit") != null && !filterProperties.get("raisedTimeUnit").equals("") && filterProperties.get("raisedTimeValue") != null && !filterProperties.get("raisedTimeValue").equals(""))
                expectedData.put(AlertsTableColumns.TimeAndData.toString(), Arrays.asList(new String[]{filterProperties.get("raisedTimeUnit"), filterProperties.get("raisedTimeValue")}));
            if (filterProperties.get("ackUnackStatusList") != null && !filterProperties.get("ackUnackStatusList").equals(""))
                expectedData.put(AlertsTableColumns.Acknowledged.toString(), Arrays.asList(filterProperties.get("ackUnackStatusList").split(",")));
            if (filterProperties.get("severityList") != null && !filterProperties.get("severityList").equals("")) {
                String severityList = filterProperties.get("severityList").replaceAll("info", "Info");
                expectedData.put(AlertsTableColumns.Severity.toString(), Arrays.asList(severityList.split(",")));
            }
            if (filterProperties.get("devicesList") != null && !filterProperties.get("devicesList").equals("") && !Boolean.valueOf(filterProperties.get("selectAllDevices"))) {
                expectedData.put(AlertsTableColumns.DeviceName.toString(), Arrays.asList(filterProperties.get("devicesList").split(",")));
            }
            if (filterProperties.get("modulesList") != null && !filterProperties.get("modulesList").equals("")) {
                expectedData.put(AlertsTableColumns.Module.toString(), Arrays.asList(filterProperties.get("modulesList").split(",")));
            }
            if (filterProperties.get("ackUnackStatusList") != null && !filterProperties.get("ackUnackStatusList").equals("")) {
                String ackUnackStatusList = filterProperties.get("ackUnackStatusList").replaceAll("Acknowledged", "true");
                ackUnackStatusList = ackUnackStatusList.replaceAll("Unacknowledged", "false");
                expectedData.put(AlertsTableColumns.Acknowledged.toString(), Arrays.asList(ackUnackStatusList.split(",")));
            }

            String failMsg = AlertsValidationHandler.validateAlertTableData(expectedData);
            if (!failMsg.isEmpty()) {
                BaseTestUtils.report("Fail: " + failMsg, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("filter Alerts:" + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    public static void setFilterToAck() {
        HashMap<String, String> filterProperties = new HashMap<>();
        filterProperties.put("ackUnackStatusList", "Acknowledged");
        AlertsHandler.filterAlerts(filterProperties);
    }

    public static void filterAlerts(HashMap<String, String> filterProperties) {
        Alerts alerts = new Alerts();
        if (!alerts.isAlertsTableOpen()) {
            alerts.alertsMaximize();
        }
        alerts.filterAlertsClick();
        BasicOperationsHandler.delay(6); // Allow the Filter Config Page to fully load
        WebUIBasePage.closeAllYellowMessages();
        setFilter(filterProperties);
        WebUIBasePage.closeAllYellowMessages();
        WebUIVisionBasePage.submit(WebUIStringsVision.getAlertsFIlterSubmitButton());
        alerts.alertsMinimize();
    }

    public static boolean validateAlert(String columnName, String columnValue) {
        Alerts alerts = new Alerts();
        alerts.alertsMaximize();
        BasicOperationsHandler.refresh();
        WebUITable table = alerts.retrieveAlertsTable();
        int rowIndex = table.getRowIndex(columnName, columnValue, true);
        alerts.alertsMinimize();
        if (rowIndex == (-1)) {
            return false;
        }
        return true;
    }

    public static boolean validateAlertContentByKeyValue(String key, String value, boolean closeAlertsTable, List<Table.TableDataSets> keyValueList) {
        WebUITable table = setupAlertTable();
        int rowToValidateIndex = table.getRowIndex(key, value, true);
        if (rowToValidateIndex == -1) {
            BaseTestUtils.report("Relevant Alert was not found by key: " + key + " value: " + value, BaseTestUtils.PASS_NOR_FAIL);
            return false;
        }
        boolean result = table.validateTableRowContent(keyValueList, rowToValidateIndex);
        Alerts alerts = new Alerts();
        if (closeAlertsTable) {
            alerts.alertsMinimize();
        }
        return result;
    }

    public static WebUITable setupAlertTable() {
        Alerts alerts = new Alerts();
        if (!alerts.isAlertsTableOpen()) {
            alerts.alertsMaximize();
        }
        alerts.autoRefreshAlertsOff();
        WebUITable table = alerts.retrieveAlertsTable();
        return table;
    }


    public static boolean validateAlertPropertyByOtherProperty(boolean isCloseModule, List<TableKeyValueByKeyValueExpectedDataSet> tableProperties) {
        TableKeyValueByKeyValueExpectedDataSet properties = tableProperties.get(0);
        WebUITable table = setupAlertTable();
        boolean result = table.validateRowPropertyByOtherProperty(properties.columnNameBy, properties.valueBy, properties.columnNameExpected, properties.valueExpected);
        Alerts alerts = new Alerts();
        if (isCloseModule) {
            alerts.alertsMinimize();
        }
        return result;
    }

    public class TableKeyValueByKeyValueExpectedDataSet {
        public String columnNameBy, valueBy, columnNameExpected, valueExpected;

        @Override
        public String toString() {
            return "TableKeyValueByKeyValueExpectedDataSet{" +
                    "columnNameBy='" + columnNameBy + '\'' +
                    ", valueBy='" + valueBy + '\'' +
                    ", columnNameExpected='" + columnNameExpected + '\'' +
                    ", valueExpected='" + valueExpected + '\'' +
                    '}';
        }
    }

    private static void setFilter(HashMap<String, String> filterProperties) {
        AlertFilter filter = new AlertFilter();
        try {
            List<String> deviceNames = new ArrayList<String>();
            List<String> severityList = new ArrayList<String>();
            List<String> modulesList = new ArrayList<String>();
            List<String> devicesTypeList = new ArrayList<String>();
            List<String> ackStatusList = new ArrayList<String>();
            boolean forceChange = true;


            if (filterProperties.get("raisedTimeUnit") != null && !filterProperties.get("raisedTimeUnit").equals("")) {
                filter.setRaisedTime(filterProperties.get("raisedTimeUnit"), filterProperties.get("raisedTimeValue"));
            }
            filter.setRestoreDefaultFilter(Boolean.valueOf(filterProperties.get("restoreDefaults")));

            filter.selectAllDevices(Boolean.valueOf(filterProperties.get("selectAllDevices")));
            if (filterProperties.get("devicesList") != null && !filterProperties.get("devicesList").equals("") && !Boolean.valueOf(filterProperties.get("selectAllDevices"))) {
                forceChange = false;
                deviceNames = Arrays.asList(filterProperties.get("devicesList").split(","));
                filter.moveAllDevicesLeft(DualListTypeEnum.ALERT_FILTER_DEVICES);
                filter.addSelectedDevices(DualListTypeEnum.ALERT_FILTER_DEVICES, deviceNames);
            }

            if (filterProperties.get("groupsList") != null && !filterProperties.get("groupsList").equals("")) {
                forceChange = false;
                deviceNames = Arrays.asList(filterProperties.get("groupsList").split(","));
                filter.moveAllDevicesLeft(DualListTypeEnum.ALERT_FILTER_GROUPS);
                filter.addSelectedDevices(DualListTypeEnum.ALERT_FILTER_GROUPS, deviceNames);
            }

            if (filterProperties.get("severityList") != null && !filterProperties.get("severityList").equals("")) {
                forceChange = false;
                severityList = Arrays.asList(filterProperties.get("severityList").split(","));
                filter.setSeverity(severityList);
            }

            if (filterProperties.get("modulesList") != null && !filterProperties.get("modulesList").equals("")) {
                forceChange = false;
                modulesList = Arrays.asList(filterProperties.get("modulesList").split(","));
                filter.setModules(modulesList);
            }

            if (filterProperties.get("devicesTypeList") == null || !filterProperties.get("devicesTypeList").equals("")) {
                filterProperties.put("devicesTypeList", "Alteon,insite,appwall,linkproof,defense_flow");
            }
            if (filterProperties.get("devicesTypeList") != null && !filterProperties.get("devicesTypeList").equals("")) {
                forceChange = false;
                devicesTypeList = Arrays.asList(filterProperties.get("devicesTypeList").split(","));
                filter.setDeviceType(devicesTypeList);
            }

            if (filterProperties.get("ackUnackStatusList") != null && !filterProperties.get("ackUnackStatusList").equals("")) {
                forceChange = false;
                ackStatusList = Arrays.asList(filterProperties.get("ackUnackStatusList").split(","));
                filter.setAckUnackStatus(ackStatusList);
            } else {
                forceChange = false;
                filter.setAckUnackStatus(AcknowledgementSetter.ackStatusAll);
            }

            // This code is workaround to in-force the Submit
            if (forceChange) {
                ackStatusList.add("Acknowledged");
                filter.setAckUnackStatus(ackStatusList);
                filter.setAckUnackStatus(ackStatusList);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Fail. " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static String validateRaisedTimeFilter(String raisedTimeUnit, String raisedTimeValue, ServerCliBase cli) throws Exception {
        HashMap<String, String> filterProperties = new HashMap<String, String>();
        filterProperties.put("raisedTimeUnit", raisedTimeUnit);
        filterProperties.put("raisedTimeValue", raisedTimeValue);
        AlertsHandler.filterAlerts(filterProperties);

        Alerts alerts = new Alerts();
        alerts.alertsMaximize();
        String result = alerts.validateFilteredByRaisedTimeTable(raisedTimeUnit, raisedTimeValue, cli);
        alerts.alertsMinimize();
        return result;
    }

    public static boolean validateSelectAllDevices() {
        Alerts alerts = new Alerts();
        alerts.alertsMaximize();
        alerts.filterAlertsClick();
        AlertFilter filter = new AlertFilter();

        return filter.validateSelectAllDevices(DualListTypeEnum.ALERT_FILTER_DEVICES);
    }

    private static boolean check4AlertsNumber(String rowIndexes, int origAlertsNum) {
        BasicOperationsHandler.delay(100);
        BasicOperationsHandler.refresh();
        BasicOperationsHandler.delay(2);
        Alerts alerts = new Alerts();
        if (origAlertsNum - alerts.getAlertsNumber() == rowIndexes.split(",").length) {
            return true;
        } else {
            String msg = String.format("origAlertsNum: %d, currentAlertsNumber: %d", origAlertsNum, alerts.getAlertsNumber());
            BaseTestUtils.reporter.report(msg);
            return false;
        }
    }


}
