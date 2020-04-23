package com.radware.vision.tests.alerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.AlertsTableColumns;
import com.radware.vision.infra.enums.RaisedTimeUnits;
import com.radware.vision.infra.testhandlers.alerts.AlertsHandler;
import com.radware.vision.infra.testhandlers.alerts.AlertsValidationHandler;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.apache.commons.lang.StringUtils;
import org.junit.Test;

import java.awt.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class AlertsTests extends WebUITestBase {
    int rowNumber;
    String devicesList;
    boolean selectAllDevices;
    RaisedTimeUnits raisedTimeUnit = RaisedTimeUnits.MINUTES;
    String raisedTimeValue;
    String severityList;
    String modulesList;
    String devicesTypeList;
    String ackUnackStatusList;
    boolean restoreDefaults = true;
    String columnName;
    String columnValue;
    String listOfRowIndexes;
    //===== copyFile params ===
    String fileName;
    String userName = "root";
    String password = "radware";
    String scriptArguments;
    String groupsList;
    int timeout = 0;


    @Test
    @TestProperties(name = "copy ScriptFile to vision machine", paramsInclude = {"qcTestId", "fileName", "scriptArguments", "userName", "password"})
    public void copyFile() throws AWTException {
        try {
            FileUtils.copyFile(getRootServerCliCredentials(), fileName);
            FileUtils.executeScript(getRootServerCliCredentials(), fileName, scriptArguments);
        } catch (Exception e) {
            BaseTestUtils.report("copyFile operation may have been executed incorrectly :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "clear Alerts", paramsInclude = {"qcTestId", "listOfRowIndexes"})
    public void clearAlert() {
        try {
            if (!(AlertsHandler.clearAlert(listOfRowIndexes))) {
                BaseTestUtils.report("Clear alerts:" + listOfRowIndexes + " " + "Not all alerts were cleared", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Clear alerts:" + listOfRowIndexes + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "acknowledge Alerts", paramsInclude = {"qcTestId", "listOfRowIndexes"})
    public void ackAlert() {
        try {
            if (!(AlertsHandler.ackAlert(listOfRowIndexes))) {
                BaseTestUtils.report("Ack alerts:" + listOfRowIndexes + " " + "Not all alerts were acknowledged", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Ack alerts:" + listOfRowIndexes + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "unacknowledge Alerts", paramsInclude = {"qcTestId", "listOfRowIndexes"})
    public void unackAlert() {
        try {
            if (!(AlertsHandler.unackAlert(listOfRowIndexes))) {
                BaseTestUtils.report("Unack alerts:" + listOfRowIndexes + " " + "Not all alerts were unacknowledged", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Unack alerts:" + listOfRowIndexes + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "view Alerts", paramsInclude = {"qcTestId", "rowNumber"})
    public void viewAlert() {
        try {
            AlertsHandler.editAlert(rowNumber);
        } catch (Exception e) {
            BaseTestUtils.report("View alerts:" + rowNumber + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "auto Refresh Alerts On", paramsInclude = {"qcTestId"})
    public void autoRefreshAlertsOn() {
        try {
            AlertsHandler.autoRefreshOn(true);
        } catch (Exception e) {
            BaseTestUtils.report("auto Refresh Alerts On:" + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "acknowledge All Alerts", paramsInclude = {"qcTestId"})
    public void acknowledgeAllAlerts() {
        try {
            if (!AlertsHandler.ackAllAlerts()) {
                BaseTestUtils.report("acknowledgeAllAlerts validation has failed " + " " + "some alerts might have remained uncleared:\n", Reporter.FAIL);
            } else {
                BaseTestUtils.report("acknowledgeAllAlerts validation is Successful: " + "\n.", Reporter.PASS);
            }
        } catch (Exception e) {
            BaseTestUtils.report("acknowledge All Alerts:" + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "clear All Alerts", paramsInclude = {"qcTestId", "timeout"})
    public void clearAllAlerts() {
        try {
            if (!AlertsHandler.clearAllAlerts(timeout)) {
                BaseTestUtils.report("clearAllAlerts validation has failed " + " " + "some alerts might have remained uncleared:\n", Reporter.FAIL);
            } else {
                BaseTestUtils.report("clearAllAlerts validation is Successful: " + "\n.", Reporter.PASS);
            }
        } catch (Exception e) {
            BaseTestUtils.report("clear All Alerts:" + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }


    @Test
    @TestProperties(name = "auto Refresh Alerts Off", paramsInclude = {"qcTestId"})
    public void autoRefreshAlertsOff() {
        try {
            AlertsHandler.autoRefreshOff();
        } catch (Exception e) {
            BaseTestUtils.report("auto Refresh Alerts Off:" + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "filter Alerts", paramsInclude = {"qcTestId", "devicesList", "selectAllDevices", "raisedTimeUnit",
            "raisedTimeValue", "severityList", "modulesList", "devicesTypeList", "groupsList", "ackUnackStatusList", "restoreDefaults"})
    public void filterAlerts() {
        try {
            HashMap<String, String> filterProperties = new HashMap<String, String>();
            filterProperties.put("devicesList", devicesList);
            filterProperties.put("selectAllDevices", String.valueOf(selectAllDevices));
            filterProperties.put("raisedTimeUnit", raisedTimeUnit.getTimeUnits());
            filterProperties.put("raisedTimeValue", raisedTimeValue);
            filterProperties.put("severityList", severityList);
            filterProperties.put("modulesList", modulesList);
            filterProperties.put("devicesTypeList", devicesTypeList);
            filterProperties.put("groupsList", groupsList);
            if (ackUnackStatusList != null) {
                ackUnackStatusList = ackUnackStatusList.replaceAll("true", "acknowledged");
                ackUnackStatusList = ackUnackStatusList.replaceAll("false", "unAcknowledged");
            }
            if (severityList != null) {
                severityList = severityList.replaceAll("Information", "info");
            }
            filterProperties.put("ackUnackStatusList", ackUnackStatusList);
            filterProperties.put("severityList", severityList);
            filterProperties.put("restoreDefaults", String.valueOf(restoreDefaults));

            AlertsHandler.visionRestClient = getVisionRestClient();
            AlertsHandler.filterAlerts(filterProperties);
            HashMap<String, List<String>> expectedData = new HashMap<String, List<String>>();
            if (raisedTimeUnit != null && raisedTimeValue != null)
                expectedData.put(AlertsTableColumns.TimeAndData.toString(), Arrays.asList(new String[]{raisedTimeUnit.getTimeUnits(), raisedTimeValue}));
            if (ackUnackStatusList != null)
                expectedData.put(AlertsTableColumns.Acknowledged.toString(), Arrays.asList(ackUnackStatusList.split(",")));
            if (severityList != null) {
                severityList = severityList.replaceAll("info", "Info");
                expectedData.put(AlertsTableColumns.Severity.toString(), Arrays.asList(severityList.split(",")));
            }
            if (devicesList != null && !selectAllDevices) {
                expectedData.put(AlertsTableColumns.DeviceName.toString(), Arrays.asList(devicesList.split(",")));
            }
            if (modulesList != null) {
                expectedData.put(AlertsTableColumns.Module.toString(), Arrays.asList(modulesList.split(",")));
            }
            if (ackUnackStatusList != null) {
                ackUnackStatusList = ackUnackStatusList.replaceAll("Acknowledged", "true");
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

    @Test
    @TestProperties(name = "verify Existing Alert", paramsInclude = {"qcTestId", "columnName", "columnValue"})
    public void verifyExistingAlert() {
        try {
            if (!(AlertsHandler.validateAlert(columnName, columnValue))) {
                BaseTestUtils.report("Verify non existing Task: " + columnValue + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify non existing Task: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    //============================
    @Test
    @TestProperties(name = "validate RaisedTimeFilter", paramsInclude = {"qcTestId", "raisedTimeUnit", "raisedTimeValue"})
    public void validateRaisedTimeFilter() {
        try {
            String result = (AlertsHandler.validateRaisedTimeFilter(raisedTimeUnit.getTimeUnits(), raisedTimeValue, getRestTestBase().getRootServerCli()));
            if (!result.isEmpty()) {
                BaseTestUtils.report("Alert: " + result + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify RaisedTimeFilter: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate SelectAllDevices Filter", paramsInclude = {"qcTestId"})
    public void validateSelectAllDevicesFilter() {
        try {
            if (!(AlertsHandler.validateSelectAllDevices())) {
                BaseTestUtils.report("SelectAllDevices validation Has failed " + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify SelectAllDevices: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    //==============================================
    @ParameterProperties(description = "Please specify number of row You want to perform action with.")
    public void setRowNumber(String rowNumber) {
        try {
            if (!StringUtils.isEmpty(rowNumber) && !rowNumber.equals("null")) {
                this.rowNumber = Integer.valueOf(rowNumber);
            }
        } catch (NumberFormatException e) {
            BaseTestUtils.report("Error in setRowNumber " + rowNumber, Reporter.PASS);
        }
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getListOfRowIndexes() {
        return listOfRowIndexes;
    }

    @ParameterProperties(description = "Please specify number of row/s You want to perform action with. Separate digits by <,>!")
    public void setListOfRowIndexes(String listOfRowIndexes) {
        this.listOfRowIndexes = listOfRowIndexes;
    }

    public String getRowNumber() {
        return String.valueOf(rowNumber);
    }

    public String getDevicesList() {
        return devicesList;
    }

    @ParameterProperties(description = "Specify devices List. Device names must be separated by <,>.")
    public void setDevicesList(String devicesList) {
        this.devicesList = devicesList;
    }

    public String getRaisedTimeValue() {
        return raisedTimeValue;
    }

    @ParameterProperties(description = "Please specify \"Raised Time\" Value. Available options are: for Hour/s - from 1 to 24 and for Minute/s - from 1 to 60.")
    public void setRaisedTimeValue(String raisedTimeValue) {
        this.raisedTimeValue = raisedTimeValue;
    }

    public RaisedTimeUnits getRaisedTimeUnit() {
        return raisedTimeUnit;
    }

    @ParameterProperties(description = "Please specify \"Raised Time\" Unit. Available options are <Hour/s> and <Minute/s>.")
    public void setRaisedTimeUnit(RaisedTimeUnits raisedTimeUnit) {
        this.raisedTimeUnit = raisedTimeUnit;
    }

    public String getSeverityList() {
        return severityList;
    }

    @ParameterProperties(description = "Specify Severities to set filter with. Severities must be separated by <,>.")
    public void setSeverityList(String severityList) {
        this.severityList = severityList;
    }

    public String getModulesList() {
        return modulesList;
    }

    @ParameterProperties(description = "Specify Modules to set filter with. Modules must be separated by <,>.")
    public void setModulesList(String modulesList) {
        this.modulesList = modulesList;
    }

    public String getDevicesTypeList() {
        return devicesTypeList;
    }

    @ParameterProperties(description = "Specify DeviceTypes to set filter with. DeviceTypes must be separated by <,>.")
    public void setDevicesTypeList(String devicesTypeList) {
        this.devicesTypeList = devicesTypeList;
    }

    public String getAckUnackStatusList() {
        return ackUnackStatusList;
    }

    @ParameterProperties(description = "Specify acknowledged/unAcknowledged status to set filter with. Statuses must be separated by <,>.")
    public void setAckUnackStatusList(String ackUnackStatusList) {
        this.ackUnackStatusList = ackUnackStatusList;
    }

    public boolean getSelectAllDevices() {
        return selectAllDevices;
    }

    public void setSelectAllDevices(boolean selectAllDevices) {
        this.selectAllDevices = selectAllDevices;
    }

    public boolean getRestoreDefaults() {
        return restoreDefaults;
    }

    public void setRestoreDefaults(boolean restoreDefaults) {
        this.restoreDefaults = restoreDefaults;
    }

    public String getColumnName() {
        return columnName;
    }

    @ParameterProperties(description = "Please specify columnName You want to validate by. ")
    public void setColumnName(String columnName) {
        this.columnName = columnName;
    }

    public String getColumnValue() {
        return columnValue;
    }

    @ParameterProperties(description = "Please specify columnValue You want to validate by. ")
    public void setColumnValue(String columnValue) {
        this.columnValue = columnValue;
    }

    public String getScriptArguments() {
        return scriptArguments;
    }

    public void setScriptArguments(String scriptArguments) {
        this.scriptArguments = scriptArguments;
    }

    public String getGroupsList() {
        return groupsList;
    }

    @ParameterProperties(description = "Specify Groups List. Group names must be separated by <,>.")
    public void setGroupsList(String groupsList) {
        this.groupsList = groupsList;
    }

    public int getTimeout() {
        return timeout;
    }

    @ParameterProperties(description = "Specify time to wait for cleaning alerts")
    public void setTimeout(int timeout) {
        this.timeout = timeout;
    }
}
