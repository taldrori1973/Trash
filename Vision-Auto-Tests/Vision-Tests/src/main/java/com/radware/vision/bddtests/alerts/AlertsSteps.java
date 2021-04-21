package com.radware.vision.bddtests.alerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.events.ReportWebDriverEventListener;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.widgets.api.popups.PopupContent;
import com.radware.automation.webui.widgets.api.table.Table;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.enums.RaisedTimeUnits;
import com.radware.vision.infra.testhandlers.alerts.AlertsHandler;
import com.radware.vision.infra.testhandlers.alerts.AlertsNegativeHandler;
import com.radware.vision.infra.testhandlers.rbac.RBACHandler;
import com.radware.vision.infra.testhandlers.system.generalsettings.alertSettings.AlertSettingsHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AlertsSteps extends VisionUITestBase {


    public AlertsSteps() throws Exception {
    }

    @When("^UI Maximize Alerts Browser$")
    public void maximizeAlertsBrowser() {

        if (!AlertsHandler.maximizeAlertsBrowser())
            ReportsUtils.reportAndTakeScreenShot("Maximizing Alerts Browser Action Did Not Succeeded", Reporter.FAIL);

    }

    @When("^UI Minimize Alerts Browser$")
    public void minimizeAlertsBrowser() {

        if (!AlertsHandler.minimizeAlertsBrowser())
            ReportsUtils.reportAndTakeScreenShot("Minimizing Alerts Browser Action Did Not Succeeded", Reporter.FAIL);

    }

    @Then("^UI Validate existing alert with columnName \"(.*)\" have value \"(.*)\"$")
    public void verifyExistingAlert(String columnName, String columnValue) {
        try {
            if (!(AlertsHandler.validateAlert(columnName, columnValue))) {
                BaseTestUtils.report("Verify Alert's column By value: " + columnValue + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify Alert's column By value: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Validate Alert Property by other Property( closeAlertsTable)?$")
    public void verifyAlertPropertyByOtherProperty(String closeAlertsTable, List<AlertsHandler.TableKeyValueByKeyValueExpectedDataSet> tableProperties) {
        try {
            boolean closeAlertsModule = closeAlertsTable != null ? true : false;
            if (!(AlertsHandler.validateAlertPropertyByOtherProperty(closeAlertsModule, tableProperties))) {
                WebUIUtils.generateAndReportScreenshot();
                BaseTestUtils.report("Verify Alert's Property By other Property: " + tableProperties.get(0).columnNameExpected + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify Alert's Property By other Property: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Validate Alert record Content by KeyValue with columnName \"(.*)\" with content \"(.*)\"( closeAlertsModule)?$")
    public void verifyAlertContentByKeyValue(String key, String value, String closeAlertsModule, List<Table.TableDataSets> tableData) {
        try {
            boolean closeAlertsTable = closeAlertsModule != null;
            if (!(AlertsHandler.validateAlertContentByKeyValue(key, value, closeAlertsTable, tableData))) {
                BaseTestUtils.report("Verify Alert record Content by KeyValue: " + value + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify Alert record Content by KeyValue: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI clear All Alerts(?: with TimeOut (\\S+))?$")
    public void clearAllAlerts(String timeout) {
        try {
            timeout = timeout == null ? "0" : timeout;
            if (!AlertsHandler.clearAllAlerts(Integer.valueOf(timeout))) {
                BaseTestUtils.report("clearAllAlerts validation has failed " + " " + "some alerts might have remained uncleared:\n", Reporter.FAIL);
            } else {
                BaseTestUtils.report("clearAllAlerts validation is Successful: " + "\n.", Reporter.PASS);
            }
        } catch (Exception e) {
            BaseTestUtils.report("clear All Alerts:" + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Then("^UI validate Alerts Filter by KeyValue$")
    public void filterAlerts(Map<String,String> properties) {
        try {
            HashMap<String, String> filterProperties = new HashMap<String, String>(properties);
            AlertsHandler.validateAlertsFilter(restTestBase.getVisionRestClient(), filterProperties);
        } catch (Exception e) {
            BaseTestUtils.report("filter Alerts:" + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Then("^UI validate SelectAllDevices Filter$")
    public void validateSelectAllDevicesFilter() {
        try {
            if (!(AlertsHandler.validateSelectAllDevices())) {
                BaseTestUtils.report("SelectAllDevices validation Has failed " + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify SelectAllDevices: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI module Check Negative$")
    public void moduleCheckNegative() {
        try {
            AlertsNegativeHandler.moduleCheckWarning();
            List<PopupContent> popupErrors = ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).getLastPopupEvent();
            int popupSize = popupErrors.size();
            if (popupSize > 0) {
                BaseTestUtils.report("Warning is presented upon an incorrect <module> setup: " + "\n.", Reporter.PASS);
                ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).clearLastPopupEventList();
            } else {
                BaseTestUtils.report("No Warning is presented upon an incorrect <module> setup: At least one option must be selected!" + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("At least one <module> check box must remain checked: " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Then("^UI Severity Check Negative$")
    public void severityCheckNegative() {
        try {
            AlertsNegativeHandler.severityCheckWarning();
            if (AlertsNegativeHandler.isConfigurationError()) {
                BaseTestUtils.report("Warning is presented upon an incorrect <severity> setup: " + "\n.", Reporter.PASS);
                ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).clearLastPopupEventList();
            } else {
                BaseTestUtils.report("No Warning is presented upon an incorrect <severity> setup: At least one option must be selected!" + "\n.", Reporter.FAIL);
            }
            AlertsNegativeHandler.closeConfigurationErrorDialogAndAlertsTable();
        } catch (Exception e) {
            BaseTestUtils.report("At least one severity check box must remain <checked>: " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Then("^UI validate RaisedTimeFilter with raisedTimeUnit \"(HOURS|MINUTES)\" with raisedTimeValue \"(.*)\"$")
    public void validateRaisedTimeFilter(RaisedTimeUnits raisedTimeUnit, String raisedTimeValue) {
        try {
            String result = (AlertsHandler.validateRaisedTimeFilter(raisedTimeUnit.getTimeUnits(), raisedTimeValue, serversManagement.getRootServerCLI().get()));
            if (!result.isEmpty()) {
                BaseTestUtils.report("Alert: " + result + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify RaisedTimeFilter: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI set  RefreshInterval \"(.*)\"$")
    public void setRefreshInterval(String refreshInterval) {
        try {
            AlertSettingsHandler.setRefreshInterval(refreshInterval);
        } catch (Exception e) {
            BaseTestUtils.report("Set <refreshInterval>:" + refreshInterval + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Then("^UI Acknowledge Unacknowledge Alerts \"(acknowledge|unacknowledge)\" by listOfRowIndexes \"(.*)\"$")
    public void unackAlert(String ackState, String listOfRowIndexes) {
        try {
            if (!(AlertsHandler.ackUnackAlert(ackState, listOfRowIndexes))) {
                BaseTestUtils.report("Unack alerts:" + listOfRowIndexes + " " + "Not all alerts were unacknowledged", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Unack alerts:" + listOfRowIndexes + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Then("^UI acknowledge All Alerts$")
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

    @Then("^UI Auto Refresh Alerts OnOFF \"(ON|OFF)\"$")
    public void autoRefreshAlertsOn(String onOffState) {
        try {
            boolean isOn = onOffState.equals("ON") ? true : false;
            AlertsHandler.autoRefreshOnOff(isOn);
        } catch (Exception e) {
            BaseTestUtils.report("auto Refresh Alerts On:" + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Then("^UI clear Alerts by listOfRowIndexes \"(.*)\"$")
    public void clearAlert(String listOfRowIndexes) {
        try {
            if (!(AlertsHandler.clearAlert(listOfRowIndexes))) {
                BaseTestUtils.report("Clear alerts:" + listOfRowIndexes + " " + "Not all alerts were cleared", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Clear alerts:" + listOfRowIndexes + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Then("^UI verify Existing Alert with columnName \"(.*)\" by columnValue \"(.*)\"$")
    public void verifyNonExistingAlert(String columnName, String columnValue) {
        try {
            if (!(RBACHandler.verifyAlertRow(columnName, columnValue))) {
                BaseTestUtils.report("Failed to validate columnValue: " + columnValue + " at columnName: " + columnName + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Existing Alert operation Failure: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }
}
