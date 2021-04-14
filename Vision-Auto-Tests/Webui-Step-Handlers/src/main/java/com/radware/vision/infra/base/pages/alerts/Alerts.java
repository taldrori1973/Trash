package com.radware.vision.infra.base.pages.alerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.table.WebUIRow;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.infra.base.pages.dialogboxes.AreYouSureDialogBox;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.RaisedTimeUnits;
import com.radware.vision.infra.tablepagesnavigation.NavigateTable;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.infra.utils.TimeUtils;
import com.radware.vision.infra.utils.WebUIStringsVision;
import com.radware.vision.infra.validationutils.ValidateAlertsTable;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.util.*;

public class Alerts extends WebUIVisionBasePage {
    public static String TimeAndDateFormat = "dd.MM.yyyy HH:mm:ss";
    public final String[] ALERT_FIELDS = new String[]{"Date And Time", "Ack", "Message"};
    public final String[] ALERT_FIELD_KEYS = new String[]{"Date And Time", "Message"};
    String tableLabel = "Alerts Table";

    public Alerts() {
        super("Alerts Table", "AlertBrowser.Alerts.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getAlertsTab());
    }

    public static long parseDateTime(String raisedTimeUnit, String raisedTimeValue) {
        long min = 60;
        long sec = 60;
        long milliSec = 1000;
        long timeRaisedMinutes = Long.parseLong(raisedTimeValue) * (sec * milliSec);

        if (raisedTimeUnit.equals(RaisedTimeUnits.HOURS.getTimeUnits())) {
            timeRaisedMinutes = timeRaisedMinutes * min;
        }
        return timeRaisedMinutes;
    }

    public void alertsMaximize() {
        try {
            TopologyTreeHandler.clickTreeNodeDefault();

            //wait before next step done, otherwise it will not be performed well
            BasicOperationsHandler.delay(1);
            WebUIUtils.isAllowInexistenceMode = true;
            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsMaximizeButton());
            WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        } finally {
            WebUIUtils.isAllowInexistenceMode = false;
        }
    }

    public boolean isAlertsTableOpen() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsTab());
        WebElement element = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (element != null) {
            return true;
        }
        return false;
    }

    public WebUITable retrieveAlertsTable() {
        WebUITable table = (WebUITable) container.getTable(tableLabel);
        return table;
    }

    public void alertsMinimize() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsMinimizeButton());
        WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
    }

    public void viewAlert(Integer rowNumber) {
        WebUITable usersTable = (WebUITable) container.getTable(tableLabel);
        usersTable.editRow(rowNumber);
    }

    public void ackAlertButtonClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsAcknowlegeButton());
        WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
    }

    public void ackAllAlertsButtonClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAckAllAlerts());
        WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
    }

    public void submitFilter() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsFIlterSubmitButton());
        WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
    }

    public void unackAlertButtonClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsUnacknowlegeButton());
        WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
    }

    public void closeViewAlertsTab() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getViewAlertsTabCloseButton());
        WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
    }

    public void filterAlertsClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsFilterButton());
        WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
    }

    public void autoRefreshAlertsOn() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsAutoRefreshButton());
        WebUIComponent element = (new WebUIComponent(locator));
        if (element.getWebElement() != null && element.getWebElement().getAttribute("title").contains("Resume Auto Refresh")) {
            WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        }
    }

//    public void setPageTextBox(String pageNum) {
//
//        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getPageTextBox());
//        WebUITextField textField = new WebUITextField();
//        textField.setWebElement((new WebUIComponent(locator)).getWebElement());
//        textField.type(pageNum);
//        try {
//            WebUIUtils.pressEnter();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

    public void autoRefreshAlertsOff() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsAutoRefreshButton());
        WebUIComponent element = (new WebUIComponent(locator));
        if (element.getWebElement() != null && element.getWebElement().getAttribute("title").contains("Pause Auto Refresh")) {
            WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        }
    }

    public void clearAlertButtonClick() {
        try {
            WebUIUtils.setIsTriggerPopupSearchEvent(false);
            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsClearButton());
            WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        } finally {
            WebUIUtils.setIsTriggerPopupSearchEvent(true);
        }
    }

    public void clearAllAlertsButtonClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsClearAllButton());
        WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
    }

    public boolean validateClearAllAlertsAction() {
        WebUITable table = (WebUITable) container.getTable(tableLabel);
        final String ALERT_UPDATE_TASK = "M_00815: Scheduled Task AlertUpdateTask executed successfully.";
        if (table.getRowCount() == 0 ||
                (table.getRowCount() == 1 && table.getCellValue(0, 8).equals(ALERT_UPDATE_TASK))) {
            return true;
        }
        return false;
    }

    public String validateTableData(HashMap<String, List<String>> tableExpectedData) throws Exception {
        WebUITable table = (WebUITable) container.getTable(tableLabel);
        List<String> tableColumns = table.getTableHeaders();
        boolean ifStop = false;

        StringBuffer validationResult = new StringBuffer();
        ArrayList<ValidateAlertsTable> validationThreads = new ArrayList<ValidateAlertsTable>();
        long clientEpochTime = TimeUtils.getCurrentDate();
        int pageCount = NavigateTable.getPageCount();
        for (int i = 0; i < pageCount; i++) {
            table.analyzeTable("div");
            List<WebUIRow> rows = table.getRows();
            for (WebUIRow currentRow : rows) {
                ValidateAlertsTable validateAlertsTable = new ValidateAlertsTable(tableExpectedData, currentRow, clientEpochTime, tableColumns);
                validateAlertsTable.start();
                validationThreads.add(validateAlertsTable);
//                Thread.sleep(100); // In order to avoid large load on the Browser-Side
            }
            for (ValidateAlertsTable validateAlertsTable : validationThreads) {
                validationResult.append(validateAlertsTable.getCompareResult());
            }
            if (i < (pageCount - 1)) {
                table.setSpecificPage(String.valueOf(i + 2));
            }
        }
        return validationResult.toString();
    }

    public boolean validateAckAllAlertsAction() {
        WebUITable table = (WebUITable) container.getTable(tableLabel);
        boolean ifStop = false;
        boolean validTest = true;
        int pageCount = NavigateTable.getPageCount();
        try {
            for (int i = 0; i < pageCount; i++) {
                for (int j = 0; j < table.getRowCount(); j++) {
                    if ((table.getCellValue(j, table.getColIndex("Ack"))).equalsIgnoreCase("false")) {
                        validTest = false;
                    }
                }
                if (i < (pageCount - 1)) {
                    table.setSpecificPage(String.valueOf(i + 2));
                }
            }
        } catch (Exception e) {
            throw new IllegalArgumentException(e.getMessage() + "\n" + e.getStackTrace());
        }
        return validTest;
    }

    public void submitAlertAction() {
        AreYouSureDialogBox dialogBox = new AreYouSureDialogBox();
        dialogBox.yesButtonClick();
    }

    public void clearAlerts(Integer rowNum) {
        WebUITable table = (WebUITable) container.getTable(tableLabel);
        try {
            if (rowNum == 0) {
                for (int i = 0; i < table.getRowCount(); i++) {
                    table.clickOnRow(i);
                    clearAlertButtonClick();
                    submitAlertAction();
                }
            } else if (rowNum > 0) {
                if (table.getRowCount() >= rowNum) {
                    table.clickOnRow(rowNum - 1);
                    clearAlertButtonClick();
                    submitAlertAction();
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    public void selectMultipleAlerts(String multipleAlerts) {
        WebUITable table = (WebUITable) container.getTable(tableLabel);
        List<String> rowIndices = new ArrayList<String>();
        if (multipleAlerts != null) {
            rowIndices = Arrays.asList(multipleAlerts.split(","));
        }
        List<WebElement> allTableRows = table.getRowsAsList();
        List<WebElement> elements = new ArrayList<WebElement>();
        for (String rowIndex : rowIndices) {
            int currentRowIndex = Integer.parseInt(rowIndex) - 1;
            if (currentRowIndex > allTableRows.size()) {
                BaseTestUtils.reporter.report("++++ Row: " + currentRowIndex + " larger than current table count: " + allTableRows.size() + ". row selection was skipped." + Reporter.PASS);
                elements.add(allTableRows.get(allTableRows.size() / 2));
            } else {
                elements.add(allTableRows.get(currentRowIndex));
            }
        }
        WebUIUtils.clickMultiSelectByElement(elements);
    }

    public int getAlertsNumber() {
        int totalRows = retrieveAlertsTable().getRowCount();
        if (totalRows < 1) {
            return 0;
        } else {
            try {
                return totalRows;
            } catch (NumberFormatException nfe) {
                return -1;
            }
        }
    }

    public void ackAlerts(Integer rowNum) {
        WebUITable table = (WebUITable) container.getTable(tableLabel);
        try {
            if (rowNum == 0) {
                for (int i = 0; i < table.getRowCount(); i++) {
                    table.clickOnRow(i);
                    ackAlertButtonClick();
//					submitAlertAction();
                }
            } else if (rowNum > 0) {
                if (table.getRowCount() >= rowNum) {
                    table.clickOnRow(rowNum - 1);
                    ackAlertButtonClick();
//					submitAlertAction();
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    public void unackAlerts(Integer rowNum) {
        WebUITable table = (WebUITable) container.getTable(tableLabel);
        try {
            if (rowNum == 0) {
                for (int i = 0; i < table.getRowCount(); i++) {
                    table.clickOnRow(i);
                    unackAlertButtonClick();
                    submitAlertAction();
                }
            } else if (rowNum > 0) {
                if (table.getRowCount() >= rowNum) {
                    table.clickOnRow(rowNum - 1);
                    unackAlertButtonClick();
                    submitAlertAction();
                }
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }

    public void selectAlert(Integer rowNum) {
        WebUITable usersTable = (WebUITable) container.getTable(tableLabel);
        usersTable.clickOnRow(rowNum);
    }

    public String validateFilteredByRaisedTimeTable(String raisedTimeUnit, String raisedTimeValue, ServerCliBase cli) throws Exception {
        CliOperations.runCommand(cli, "date +%s");
        String serverTimeString = ((RootServerCli) cli).getTestAgainstObject().toString();

        long serverTime = Long.parseLong(serverTimeString.split("\\r\\n")[1]);
        long alertDate;
        boolean ifStop = false;
        long timeRaisedMinutes = parseDateTime(raisedTimeUnit, raisedTimeValue);
        StringBuffer result = new StringBuffer();

        WebUITable table = (WebUITable) container.getTable(tableLabel);
        table.getTableHeaders();
        try {
            table.setSpecificPage("1");
            int timeDateColIndex = table.getColIndex("Date And Time");
            int pageCount = NavigateTable.getPageCount();
            for (int i = 0; i < pageCount; i++) {
                table.analyzeTable("div");
                List<WebUIRow> rows = table.getRows();
                if (rows == null) {
                    continue;
                } else if (rows.size() == 0) {
                    continue;
                }
                for (int j = 0; j < rows.size(); j++) {
                    alertDate = getAlertDate(rows.get(j).getCells().get(timeDateColIndex).getInnerText());

                    if (serverTime - timeRaisedMinutes > alertDate) {
                        result.append("Server Time: ").append(serverTimeString).append(", ").append("Found: ").append(TimeUtils.getHumanReadableDate(serverTime));
                    }
                }
                if (i < (pageCount - 1)) {
                    table.setSpecificPage(String.valueOf(i + 2));
                }
            }
        } catch (Exception e) {
            throw new IllegalArgumentException(e.getMessage() + "\n" + e.getStackTrace());
        }
        return result.toString();
    }

    public WebUITable setNextPage() {
        NavigateTable.nextPage();
        new Alerts();
        return (WebUITable) container.getTable(tableLabel);
    }

    public void setSpecificPage(WebUITable table, String pageNum) {
        table.setSpecificPage(pageNum);
//        new Alerts();
    }

    private long getAlertDate(String alertDate) {
        return TimeUtils.getEpochTime(alertDate, TimeAndDateFormat);
    }

    public Map<String, Map<String, String>> getAllAlertData(int maxRows) {
        Map<String, Map<String, String>> alerts = new HashMap<>();
        WebUITable table = (WebUITable) container.getTable(tableLabel);
        if (maxRows > table.getRowCount()) {
            maxRows = table.getRowCount();
        }
        try {
            for (int i = 1; i < maxRows; i++) {
                Map<String, String> alert = getAlertData(i);
                alerts.put(buildAlertKey(alert), alert);
            }
        } catch (Exception e) {
            throw new IllegalArgumentException("Error at getAllAlertData()", e);
        }
        return alerts;
    }

    public Map<String, String> getAlertData(int row) {
        WebUITable table = (WebUITable) container.getTable(tableLabel);
        Map<String, String> alert = new HashMap<>();
        for (String field : ALERT_FIELDS) {
            String value;
            int count = 0;
            do {
                value = table.getCellValue(row - 1, table.getColIndex(field));
            } while (value == null && count++ < 5);
            alert.put(field, value);
        }
        BaseTestUtils.report("Alert:", alert.toString(), Reporter.PASS);
        return alert;
    }

    public String buildAlertKey(Map<String, String> alert) {
        String alertKey = "";
        for (String key : ALERT_FIELD_KEYS) {
            alertKey += alert.get(key);
        }
        return alertKey;
    }
}
