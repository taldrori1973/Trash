package com.radware.vision.bddtests.basicoperations;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.api.TextField;
import com.radware.automation.webui.widgets.api.Widget;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.restcore.VisionRestClient;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.base.WebUITestSetup;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Forensics;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers.TemplateHandlers;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Report;
import com.radware.vision.bddtests.ReportsForensicsAlerts.ReportsForensicsAlertsAbstract;
import com.radware.vision.bddtests.ReportsForensicsAlerts.WebUiTools;
import com.radware.vision.infra.base.pages.navigation.HomePage;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.*;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsByNameIdHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.infra.testhandlers.vrm.VRMHandler;
import com.radware.vision.infra.testhandlers.vrm.enums.vrmActions;
import com.radware.vision.infra.utils.TimeUtils;
import com.radware.vision.infra.utils.VisionWebUIUtils;
import com.radware.vision.infra.utils.json.CustomizedJsonManager;
import cucumber.api.PendingException;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import jsystem.framework.RunProperties;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.*;
import org.openqa.selenium.support.How;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.*;

import static com.radware.vision.infra.testhandlers.BaseHandler.devicesManager;
import static com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler.*;
import static com.radware.vision.infra.utils.ReportsUtils.addErrorMessage;
import static com.radware.vision.infra.utils.ReportsUtils.reportErrors;

/**
 * Created by AviH on 30-Nov-17.
 */

public class BasicOperationsSteps extends BddUITestBase {
    private BasicOperationsByNameIdHandler basicOperationsByNameIdHandler = new BasicOperationsByNameIdHandler();

    public BasicOperationsSteps() throws Exception {
    }

    @Given("^UI Go To Vision$")
    public void goToVision() {
        try {
            setDeviceName(null);
            BasicOperationsHandler.settings();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^UI Select \"(.*)\" device from tree with index (\\d+)$")
    public void selectDeviceFromTree(SUTDeviceType deviceType, int deviceIndex) {
        try {
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(deviceType, deviceIndex);
            setDeviceName(deviceInfo.getDeviceName());
            TopologyTreeHandler.clickTreeNode(deviceInfo.getDeviceName());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^UI Open Device Info Pane$")
    public void openDeviceInfoPane() {
        TopologyTreeHandler.openDeviceInfoPane();
    }

    @Given("^UI Open Sites and Devices$")
    public void openSitesAndDevices() {
        TopologyTreeHandler.openSitesAndClusters();
    }

    @Given("^UI Navigate to page \"(.*)\"$")
    public void navigateToPage(String path) {
        WebUIVisionBasePage.navigateToPage(path);
    }

    @Given("^UI Navigate to page via menu \"(.*)\"$")
    public void navigateToMenu(String path) {
        WebUIVisionBasePage.navigateToPageMenu(path);
    }

    @Given("^Browser$")
    public void browser() {
        WebUIUtils.getDriver().get("http://localhost:3003");
    }

    @Given("^UI Navigate to \"(.*)\" page via home[p|P]age$")
    public void navigateFromHomePage(String pageName) {
        BasicOperationsHandler.navigateFromHomePage(pageName);
    }

    /**
     * @param secToWait - Wait time in seconds
     */
    @Given("^Sleep \"(\\d+)\"$")
    public void sleep(int secToWait) {
        try {
            BasicOperationsHandler.delay(secToWait);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Sleep", e);
        }
    }

    /**
     * @param username - user name
     * @param password - user password
     *                 Do Login with userName and password and if the user had loggedIn with another userName it Do logout, after that login with the userName
     */
    @Given("^UI Login with user \"(.*)\" and password \"(.*)\"( negative)?$")
    public void login(String username, String password, String negative) throws Exception {
        if (isLoggedIn) {
            if (BasicOperationsHandler.isLoggedInWithUser(username)) {
                HomePage.navigateFromHomePage("HOME");
            } else {
                logout();
            }
        }
        if (!isLoggedIn) {
            try {
                loginToServer(username, password, restTestBase.getVisionRestClient());
            } catch (Exception e) {
                BaseTestUtils.report("Failed to Login", e);
            }
        }

        // see element that include User after login to verify logged in

        //TODO - to be used when Vision will be a React application
//        if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId("toolbar-item_user-details").getBy(), WebUIUtils.DEFAULT_LOGIN_WAIT_TIME) == null) {
        if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorById("gwt-debug-Global_UserName").getBy(), WebUIUtils.DEFAULT_LOGIN_WAIT_TIME) == null) {
            BaseTestUtils.report("The login has failed", Reporter.FAIL); // is not found
        }

    }


    /**
     * UI and REST login
     *
     * @param username         - user name
     * @param password         - password
     * @param visionRestClient - VisionRestClient object
     * @throws Exception - throws exception
     */
    public static void loginToServer(String username, String password, VisionRestClient visionRestClient) throws Exception {
        WebUITestSetup webUITestSetup = new WebUITestSetup();
        webUITestSetup.setup();
//        WebUIUtils.getDriver().get("http://localhost:3003/"); // temporary
        BasicOperationsHandler.login(username, password);
        VisionWebUIUtils.loggedinUser = username;
        visionRestClient.login(username, password, "", 1);
    }

    /**
     * REST logout from server and UI validation
     *
     * @param visionRestClient - rest client
     *                         //     * @param sessionID - rest session ID
     */
    public static void logoutFromServer(VisionRestClient visionRestClient, String username) {
        int sessionID = visionRestClient.getSuitableSessionId(username);
        WebUIUtils.isIgnoreDisplayedPopup = true;
        WebUIUtils.setIsTriggerPopupSearchEvent(true);
        try {
            if (!isLoggedOut(WebUIUtils.SHORT_WAIT_TIME)) {
                visionRestClient.logout(sessionID);
            }
        } catch (IllegalStateException e) {
            //if user was already logged in we got into a inactivity timeout (most likely Configuration TO)
            visionRestClient.login(visionRestClient.getUsername(), visionRestClient.getPassword(), "", sessionID);
            visionRestClient.logout(sessionID);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to logout: " + e.getMessage(), Reporter.FAIL);
        } finally {
            if (!isLoggedOut(WebUIUtils.DEFAULT_LOGIN_WAIT_TIME)) {
                BaseTestUtils.report("Logout Operation failed, no \"log In\" button found", Reporter.FAIL);
            } else {
                isLoggedIn = false;
                VisionDebugIdsManager.setTab("LoginPage");
            }
        }
    }

    /**
     * logout from Vision
     */
    @Given("^UI Logout$")
    public void logout() {
        try {
            logoutFromServer(restTestBase.getVisionRestClient(), VisionWebUIUtils.loggedinUser);
            VisionWebUIUtils.loggedinUser = null;
        } finally {
            BasicOperationsHandler.delay(1);
        }
    }

    /**
     * Logout and close the browser - use on feature cleanup
     */
    @When("^UI logout and close browser$")
    public void uiLogoutAndCloseBrowser() {
        try {
            logout();
        } finally {
            WebUIUtils.closeBrowser();
            BasicOperationsHandler.setIsLoggedIn(false);
        }
    }

    @When("^UI close browser$")
    public void uiCloseBrowser() {
        WebUIUtils.closeBrowser();
        BasicOperationsHandler.setIsLoggedIn(false);

    }


    /**
     * @param elementId - Debug ID
     */
    @Given("^UI Click Web element with id \"(.*)\"( by Data_Debug_Id)?$")
    public void clickWebElementWithId(String elementId, String dataDebugId) {
        WebElementType webElementType = WebElementType.Id;
        if (dataDebugId != null) {
            webElementType = WebElementType.Data_Debug_Id;
        }
        ClickOperationsHandler.clickWebElement(webElementType, elementId, 0);
    }

    @Given("^UI Click List item by selector id \"(.*)\" with label \"(.*)\" checkUncheck state \"(true|false)\"$")
    public void clickListItemByLabel(String selector, String label, boolean checkUncheck) {
        BasicOperationsHandler.clickListItem(selector, label, checkUncheck);
    }

    @Given("^UI is List item Enabled by selector id \"(.*)\" with label \"(.*)\"$")
    public void isListItemEnabled(String selector, String label) {
        BasicOperationsHandler.isEnabledListItem(selector, label);
    }


    /**
     * @param elementId - Debug ID
     * @param inputText - Text to set
     */
    @Given("^UI Set Text field with id \"(.*)\" with \"(.*)\"$")
    public void setTextToElementWithId(String elementId, String inputText) {
        ClickOperationsHandler.setTextToElement(WebElementType.Id, elementId, inputText, true);
    }

    /**
     * @param elementId - Class name
     * @param inputText - Text to set
     */
    @Given("^UI Set Text field with Class \"(.*)\" with \"(.*)\"$")
    public void setTextToElementWithClass(String elementId, String inputText) {
        ClickOperationsHandler.setTextToElement(WebElementType.Class, elementId, inputText, false);
    }

    @Given("^UI Validate Text field with Class \"(.*)\" \"(Equals|Contains)\" To \"(.*)\"(?: cut Characters Number (\\S+))?$")
    public void validateTextToElementWithClass(String elementClass, String compareMethod, String expectedText, String cutCharsNumber, String offset) {
        cutCharsNumber = cutCharsNumber == null ? "0" : cutCharsNumber;
        OperatorsEnum operatorsEnum;
        switch (compareMethod) {
            case "Contains":
                operatorsEnum = OperatorsEnum.CONTAINS;
                break;
            case "Equals":
            default:
                operatorsEnum = OperatorsEnum.EQUALS;
        }
        ClickOperationsHandler.validateTextFieldElementByClass(elementClass, expectedText, operatorsEnum, Integer.parseInt(cutCharsNumber), offset);
    }

    /**
     * Close popups and warning windows
     */
    @Then("^UI close tabs, popups and yellow messages$")
    public void closeTabsAndPopupsAndYellowMessages() {
        WebUIVisionBasePage.cancel(false);
    }

    /**
     * @param deviceIndex  - SUT device index
     * @param deviceType   - SUTDeviceType enum
     * @param dualListSide - LEFT/RIGHT
     * @param dualListID   - dual list ID
     */
    @Then("^UI DualList Move deviceIndex (\\d+) deviceType \"(.*)\" DualList Items to \"(LEFT|RIGHT)\" , dual list id \"(.*)\"$")
    public void moveDualListItems(int deviceIndex, SUTDeviceType deviceType, DualListSides dualListSide, String dualListID) {
        try {
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(deviceType, deviceIndex);
            String itemName = deviceType.getDeviceType() + "_" + deviceInfo.getDeviceIp();
            ClickOperationsHandler.moveScriptDualListItems(dualListSide, itemName, dualListID);
        } catch (Exception e) {

            BaseTestUtils.report("Failed to move dual list item: \n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }


    /**
     * execute operation
     *
     * @param commonTableAction - f.e. "_NEW" or "_DELETE" ...
     * @param label             - element label
     * @param isNegativeArg     - option - Negative
     */
    @Then("^UI Execute Vision table with Action ID \"(.*)\" by label \"(.*)\" isTriggerPopupSearch event \"(true|false)\"( negative)?$")
    public void executeVisionTableOperation(String commonTableAction, String label, boolean isTriggerPopupSearch, String isNegativeArg) {
        ClickOperationsHandler.executeVisionTableOperation(commonTableAction, label, isTriggerPopupSearch);
    }

    /**
     * Select a record from a table
     *
     * @param columnValue      - column value
     * @param columnName       - column name
     * @param elementLabelId   - table Label
     * @param deviceDriverType - VISION|DEVICE
     * @param findByType       - BY_NAME|BY_ID
     */
    @Then("^UI click Table Record with ColumnValue \"(.*)\" by columnKey \"(.*)\" by elementLabelId \"(.*)\" by deviceDriverType \"(VISION|DEVICE)\" findBy Type \"(BY_NAME|BY_ID)\"$")
    public void selectDeviceTableRow(String columnValue, String columnName, String elementLabelId, DeviceDriverType deviceDriverType, FindByType findByType) {
        try {
            basicOperationsByNameIdHandler.selectTableRecord(deviceDriverType.getDDType(), elementLabelId, columnName, columnValue, findByType);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the specified table record: " + e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Wait
     *
     * @param timeOut in Seconds
     */
    @Given("^UI Timeout in seconds \"(.*)\"$")
    public void timeOut(String timeOut) {
        try {
            BasicOperationsHandler.delay(Double.parseDouble(timeOut));
        } catch (Exception e) {
            BaseTestUtils.report("Timeout operation has failed :\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI set Current Time Plus Seconds \"(.*)\"$")
    public void setCurrentTimePlusSeconds(long secondsToAdd) {
        try {
            LocalTime currentTime = LocalTime.now();
            currentTime = currentTime.plusSeconds(secondsToAdd);
            String hours = Integer.toString(currentTime.getHour());
            String minutes = Integer.toString(currentTime.getMinute());
            String seconds = Integer.toString(currentTime.getSecond());
            String dateString = hours + ":" + minutes + ":" + seconds;
            RunProperties.getInstance().setRunProperty("currentTimePlus", dateString);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^Do Nothing \"([^\"]*)\"$")
    public void doNothing(String arg0) {
        System.out.println("Run Step: " + arg0);
    }

    @Then("^UI validate port number \"([^\"]*)\" for alteon name \"([^\"]*)\"(?: with params \"([^\"]*)\")? with status \"([^\"]*)\"$")
    public void uiValidateAlteonNameWithParamsWithStatus(String portNumber, String label, String params, String expectedStatus) {
        try {
            VisionDebugIdsManager.setLabel(label);
            VisionDebugIdsManager.setParams(params != null ? params : "");
            String actualStatus = WebUIUtils.getHiddenText(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
            if (!(actualStatus.contains("port_" + portNumber + "-") || actualStatus.contains("-"))) {
                BaseTestUtils.report("The actual status should contains the word 'port'" + portNumber + "- BUT the actualStatus is " + actualStatus, Reporter.FAIL);
            }
            actualStatus = actualStatus.split("port_" + portNumber + "-")[1].split(" port")[0].trim();
            if (!expectedStatus.equalsIgnoreCase(actualStatus)) {
                BaseTestUtils.report("The ACTUAL status of port_" + portNumber + "of " + VisionDebugIdsManager.getDataDebugId() + "is " + actualStatus + ", But the EXPECTED is " + expectedStatus, Reporter.FAIL);
            }
        } catch (TargetWebElementNotFoundException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * This method selected global time range that means the user send the 'from' time and the 'to' time and the method enter it and do apply
     *
     * @param fromDate you can type the date with this format 'dd.MM.YYYY, HH:mm'
     *                 or you can write like this examples:
     *                 -1m = the time before 1 minutes from now
     *                 -1H = the time before 1 hour from now
     *                 -1y = the time before 1 year from now
     *                 -1d = the time before 1 day from now
     *                 -1M = the time before 1 month from now
     * @param toDate   the same thing like the fromDate
     */
    @Then("^UI select time range(?: from \"([^\"]*)\")?(?: to \"([^\"]*)\")?$")
    public void uiSelectTimeRangeFromTo(String fromDate, String toDate) {
        DateTimeFormatter timeRangeFormat = DateTimeFormatter.ofPattern("dd.MM.YYYY HH:mm:ss");
        if (fromDate != null) {
//            By locator = new ComponentLocator(How.XPATH, "//*[@class='date-from']//input").getBy();
            By locator = new ComponentLocator(How.XPATH, "//div[.='From']/..//input").getBy();
            String fromDateText = (fromDate.contains("+") || fromDate.contains("-")) ? timeRangeFormat.format(TimeUtils.getAddedDate(fromDate)) : fromDate;
            WebUIUtils.fluentWait(locator, WebUIUtils.DEFAULT_WAIT_TIME, false).clear();
            WebUIUtils.fluentWaitSendText("", locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(fromDateText, locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
            WebUIUtils.fluentWait(locator, WebUIUtils.DEFAULT_WAIT_TIME, false).clear();
            WebUIUtils.fluentWaitSendText("", locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(fromDateText, locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
        }
        if (toDate != null) {
//            By locator = new ComponentLocator(How.XPATH, "//*[@class='date-to']//input").getBy();
            By locator = new ComponentLocator(How.XPATH, "//div[.='To']/..//input").getBy();
            String toDateText = (toDate.contains("+") || toDate.contains("-")) ? timeRangeFormat.format(TimeUtils.getAddedDate(toDate)) : toDate;
            WebUIUtils.fluentWaitSendText("", locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
            WebUIUtils.fluentWait(locator, WebUIUtils.DEFAULT_WAIT_TIME, false).clear();
            WebUIUtils.fluentWaitSendText(toDateText, locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
        }
        By locator = new ComponentLocator(How.XPATH, "//div[.='Apply']//button").getBy();
        WebUIUtils.fluentWaitClick(locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
    }

    @Then("^UI validate arrow with label \"(.*)\" and params \"(.*)\" if \"(COLLAPSED|EXPENDED)\"$")
    public void expandArrowView(String label, String params, String status) {
        BasicOperationsHandler.validateArrow(label, params, status);
    }


    //    @Then("^UI Validate the attribute \"([^\"]*)\" Of Label \"([^\"]*)\"(?: With Params \"([^\"]*)\")? is \"(EQUALS|CONTAINS)\" to \"(.*)\"(?: with errorMessage \"([^\"]*)\")?$")
//    public void uiValidateClassContentOfWithParamsIsEQUALSCONTAINSTo(String attribute, String label, String params, String compare, String value, String expectedErrorMessage) {
//        BasicOperationsHandler.uiValidateClassContentOfWithParamsIsEQUALSCONTAINSTo(attribute, label, params, compare, value, expectedErrorMessage);
//    }
    @Then("^UI Validate the attribute \"([^\"]*)\" Of Label \"([^\"]*)\"(?: With Params \"([^\"]*)\")?(?: with errorMessage \"([^\"]*)\")? is \"(EQUALS|CONTAINS|NOT CONTAINS|MatchRegx)\" to \"(.*)\" ?(?: with offset (\\S+))?$")
    public void uiValidateClassContentOfWithParamsIsEQUALSCONTAINSTo(String attribute, String label, String params, String expectedErrorMessage, String compare, String value, String offset) {
        BasicOperationsHandler.uiValidateClassContentOfWithParamsIsEQUALSCONTAINSTo(attribute, label, params, compare, value, expectedErrorMessage, offset);
    }

    @Then("^UI Validate order of labels \"([^\"]*)\" with attribute \"([^\"]*)\" that \"(EQUALS|CONTAINS|NOT CONTAINS)\" value of \"([^\"]*)\"$")
    public void uiValidateOrderOfLabelsWithAttributeThatValueOf(String label, String attribute, String compare, String value, List<VRMHandler.DfProtectedObject> entries) {
        BasicOperationsHandler.uiValidationItemsOrderInList(label, attribute, compare, value, entries);


    }

    @Then("^UI clear (\\d+) characters in \"([^\"]*)\"(?: with params \"([^\"]*)\")?(?: with enter Key \"(true|false)\")?$")
    public void uiClearCharactersInWithParamsEnterKeyTrue(int numCharacters, String label, String params, String enterKey) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        WebElement textFieldElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        int i = numCharacters;
        while (i > 0) {
            textFieldElement.sendKeys(Keys.BACK_SPACE);
            i--;
        }
        if (enterKey != null && enterKey.equalsIgnoreCase("true"))
            textFieldElement.sendKeys(Keys.ENTER);
    }

    @Then("^UI Validate number range between minValue (\\d+|\\d+.\\d+) and maxValue (\\d+|\\d+.\\d+) in label \"([^\"]*)\"(?: with params \"([^\"]*)\")?$")
    public void uiValidateNumberRangeBetweenMinValueAndMaxValueInLabelWithParams(double minValue, double maxValue, String label, String params) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        WebElement element = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (element == null) {
            BaseTestUtils.report("No element with data-debug-id " + VisionDebugIdsManager.getDataDebugId(), Reporter.FAIL);
        }
        assert element != null;
        String text = element.getText();
        if (!text.trim().matches("(\\d+|\\d+.\\d+)")) {
            BaseTestUtils.report("the text in " + label + " with params " + params + " is " + element.getText() + " and it should be number", Reporter.FAIL);
        }
        if (!(Double.parseDouble(text) >= minValue && Double.parseDouble(text) <= maxValue)) {
            BaseTestUtils.report("The ACTUAL value of " + VisionDebugIdsManager.getDataDebugId() + " is " + text + " but the EXPECTED is between " + minValue + " and " + maxValue, Reporter.FAIL);
        }

    }

    @Then("^Validate date Text field(?: in label \"([^\"]*)\" and params \"([^\"]*)\"| by id \"([^\"]*)\") EQUALS \"([^\"]*)\"(?: with format \"([^\"]*)\")?$")
    public void validateDateTextFieldInLabelAndParamsEQUALS(String label, String params, String id, String date, String format) {
        WebElement textFieldElement = null;
        if (label != null) {
            VisionDebugIdsManager.setLabel(label);
            if (params != null)
                VisionDebugIdsManager.setParams(params);
            textFieldElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        } else {
            if (id != null) {
                textFieldElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorById(id).getBy());
            }
        }
        try {
            if (!BasicOperationsHandler.validateDateTextFieldInElement(textFieldElement, date, format))
                BaseTestUtils.report("The ACTUAL date is " + textFieldElement.getText() + " but the EXPECTED is " + date, Reporter.FAIL);
        } catch (Exception e) {
            if (id != null)
                BaseTestUtils.report("No Element with id " + id, Reporter.FAIL);
            else if (label != null)
                BaseTestUtils.report("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId(), Reporter.FAIL);
        }
    }

    @Then("^UI validate Vision Table row by keyValue with elementLabel \"([^\"]*)\" findBy columnName \"([^\"]*)\" findBy KeyValue \"([^\"]*)\"$")
    public void uiValidateVisionTableRowByKeyValueWithElementLabelFindByColumnNameFindByKeyValue(String tableElement, String columnName, String columnValue, List<TableEntry> entries) {
        try {
            List<Widget> widgets = basicOperationsByNameIdHandler.findWidgetByNameId(WebUIUtils.VISION_DEVICE_DRIVER_ID, WebWidgetType.Table, tableElement, FindByType.BY_NAME);
            if (widgets.isEmpty()) {
                report.report("Failed to get Table for label: " + columnName + ", it may not be visible", Reporter.FAIL);
            }
            for (Widget widget : widgets) {
                if (widget == null || !widget.find(true, true) || !widget.getRawId().equals(tableElement)) {
                    continue;
                }
                WebUITable table = (WebUITable) widget;
                for (TableEntry tableEntry : entries) {
                    String expectedCellValue = tableEntry.value;
                    if (tableEntry.isDate) {
                        DateTimeFormatter inputFormatter;
                        if (tableEntry.dateFormat != null)
                            inputFormatter = DateTimeFormatter.ofPattern(tableEntry.dateFormat);
                        else inputFormatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
                        LocalDateTime fromLocalDate = TimeUtils.getAddedDate(tableEntry.value);
                        expectedCellValue = fromLocalDate.format(inputFormatter);
                    }
                    if (expectedCellValue != null) {
                        String actualCellValue = table.cell(table.findRowByKeyValue(columnName, columnValue), table.getColIndex(tableEntry.columnName)).textValue();
                        if (!expectedCellValue.equals(actualCellValue)) {
                            BaseTestUtils.report("The EXPECTED value is " + expectedCellValue + " BUT the ACTUAL is " + actualCellValue, Reporter.FAIL);
                        }
                    }
                }

            }
        } catch (Exception e) {
            report.report("Failed to get Table for label: " + columnName + " \n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Click on upBar Button \"([^\"]*)\"( without navigate to another page)?$")
    public void uiClickOnUpBarButton(String label, String withoutNavigateToAnotherPage) {
        try {
            if (withoutNavigateToAnotherPage == null)
                VisionDebugIdsManager.setTab("upBar");
            BasicOperationsHandler.clickButton(label);
        } catch (TargetWebElementNotFoundException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^UI Set Text Field \"([^\"]*)\"(?: and params \"([^\"]*)\")? To \"([^\"]*)\" by sendkeys")
    public void uiSetTextFieldAndParamsToByJavaScript(String label, String params, String value) {
        try {
            VisionDebugIdsManager.setLabel(label);
            VisionDebugIdsManager.setParams(params);
            if (WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//*[@data-debug-id= '" + VisionDebugIdsManager.getDataDebugId() + "']").getBy()) == null)
                throw new Exception("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId());
            WebUIUtils.getDriver().findElement(new ComponentLocator(How.XPATH, "//*[@data-debug-id= '" + VisionDebugIdsManager.getDataDebugId() + "']").getBy()).clear();
            WebUIUtils.getDriver().findElement(new ComponentLocator(How.XPATH, "//*[@data-debug-id= '" + VisionDebugIdsManager.getDataDebugId() + "']").getBy()).sendKeys(value);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^close popup if it exists by button \"([^\"]*)\"(?: with params \"([^\"]*)\")?$")
    public void closePopupIfItExistsByButtonWithParams(String label, String params) {
        try {
            BasicOperationsHandler.clickButton(label, params);
        } catch (Exception ignore) {
        }
    }

    @When("^set Tab \"([^\"]*)\"$")
    public void setTab(String tabName) {
        VisionDebugIdsManager.setTab(tabName);
    }

    @Then("^Validate Navigation to \"([^\"]*)\" is disabled$")
    public void validateNavigationToIsDisabled(String tab) {
        try {
            Thread.sleep(10 * 1000);
            boolean isDisabled = BasicOperationsHandler.isNavigationDisabled(tab);
            assert isDisabled;
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI Validate the attribute of \"([^\"]*)\" are \"(EQUAL|CONTAINS|NOT CONTAINS)\" to$")
    public void uiValidateTheAttributesOfAreTo(String attribute, String compare, List<ParameterSelected> listParamters) {
        uiValidateClassContentOfWithParamsIsEQUALSCONTAINSToListParameters(listParamters, attribute, compare);
    }


    @Then("^UI Select list of WAN Links in LinkProof \"([^\"]*)\"$")
    public void uiSelectListOfWANLinks(String WANLinks) throws Exception {
        Map<String, String> map = new HashMap<>();
        map.put("WAN Links", WANLinks);
        map = CustomizedJsonManager.fixJson(map);
        uiSelectWANLinks(map);
    }

    public static void uiSelectWANLinks(Map<String, String> map) throws Exception {
        if (map.containsKey("WAN Links")) {
            BasicOperationsHandler.delay(5);
            int WANLinkNumbers = ReportsForensicsAlertsAbstract.maxWANLinks;
            WebUiTools.check("Expand Scope WAN Links", "", true);
            ArrayList<String> expectedWANLinks = new ArrayList<>(Arrays.asList(map.get("WAN Links").split(",")));
            if (expectedWANLinks.size() == 1 && expectedWANLinks.get(0).equalsIgnoreCase("")) {
                unselectAllWanLinks();
                return;
            }
            for (WebElement instanceElement : WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//div[starts-with(@data-debug-id, 'WanLinkStatistics_instances_')] ").getBy())) {
                if (WANLinkNumbers > 0) {
                    String instanceText = instanceElement.getText();
                    if (expectedWANLinks.contains(instanceText)) {
                        WebUiTools.check("WAN Link Value", instanceText, true);
                        expectedWANLinks.remove(instanceText);
                        WANLinkNumbers--;
                    } else WebUiTools.check("WAN Link Value", instanceText, false);
                }
            }
//            if (expectedWANLinks.size() > 0)
//                throw new Exception("The Instance " + expectedWANLinks + " don't exist in the  ");
        }
    }

    private static void unselectAllWanLinks() throws Exception {
        for (WebElement instanceElement : WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//div[starts-with(@data-debug-id, 'WanLinkStatistics_instances_')] ").getBy())) {
            String instanceText = instanceElement.getText();
            WebUiTools.check("WAN Link Value", instanceText, false);
        }
    }


    public static void uiValidateClassContentOfWithParamsIsEQUALSCONTAINSToListParameters(List<ParameterSelected> listParamters, String attribute, String compare) {
        for (ParameterSelected parameter : listParamters) { //all the parameters that selected to compare with values
            VisionDebugIdsManager.setLabel(parameter.label);
            VisionDebugIdsManager.setParams(parameter.param);

            WebElement element = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
            if (element == null) {
                addErrorMessage("No " + attribute + " attribute in element that contains " + VisionDebugIdsManager.getDataDebugId() + " in this data-debug-id");
            } else {
                String actualStatus = element.getAttribute(attribute);
                String errorMessage = "The EXPECTED value of : '" + parameter.label + "' with params: '" + parameter.param + "' is not equal to '" + actualStatus + "' ";
                switch (compare) {
                    case "EQUAL":
                    case "EQUALS":
                        if (!element.getAttribute(attribute).equalsIgnoreCase(parameter.value)) {
                            addErrorMessage(errorMessage);
                        }
                        break;
                    case "CONTAINS":
                        if (!element.getAttribute(attribute).contains(parameter.value)) {
                            errorMessage.replaceFirst(" is not equal to ", " is not contained in ");
                            addErrorMessage(errorMessage);
                        }
                        break;
                    case "NOT CONTAINS":
                        if (element.getAttribute(attribute).contains(parameter.value)) {
                            errorMessage.replaceFirst(" is not equal to ", " is contained in ");
                            addErrorMessage(errorMessage);
                        }
                        break;
                }
            }
        }
        reportErrors();
    }

    @Then("^validate webUI CSS value \"([^\"]*)\" of label \"([^\"]*)\"(?: with params \"([^\"]*)\")? equals \"([^\"]*)\"$")
    public void validateWebUICSSOfLabelWithParams(String cssKey, String label, String param, String cssValue) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(param);
        WebUIUtils.sleep(3);
        WebElement element = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (element == null)
            BaseTestUtils.report("This element with label : " + label + " and params: " + param + " is not exist", Reporter.FAIL);
        else if (!element.getCssValue(cssKey).equals(cssValue))
            BaseTestUtils.report("This element with cssKey : " + cssKey + " and cssValue: " + cssValue + " not equal to " + element.getCssValue(cssKey), Reporter.FAIL);
    }

    @Then("^UI Select Time of label \"([^\"]*)\"(?: with params \"([^\"]*)\")? with value \"([^\"]*)\" and pattern \"([^\"]*)\"$")
    public void uiSelectTimeOfLabelWithParamsWithValue(String label, String param, String timeValue, String pattern) {
        LocalDateTime scheduleTime = readTime(timeValue, pattern);
        fillTime(label, param, scheduleTime);
    }

    private LocalDateTime readTime(String timeValue, String pattern) {
        if (TimeUtils.isWithComputing(timeValue))
            return TimeUtils.getAddedDate(timeValue);
        else
            return LocalDateTime.parse(timeValue, DateTimeFormatter.ofPattern(pattern));
    }

    public static void fillTime(String label, String params, LocalDateTime scheduleTime) {
        WebUiTools.getWebElement(label, params).click();
        selectDate(label, params, scheduleTime);
        WebUiTools.getWebElement(label, params).click();
        WebUiTools.getWebElement(label, params).findElement(By.xpath("./..//td[@class='rdtTimeToggle']")).click();
        selectHoursOrMinutes(label, params, "hours", scheduleTime);
        selectHoursOrMinutes(label, params, "minutes", scheduleTime);
    }

    private static void selectHoursOrMinutes(String label, String params, String HoursOrMinutes, LocalDateTime scheduleTime) {
        int differenceValue = Integer.valueOf(WebUiTools.getWebElement(label, params).findElement(By.xpath("(./..//div[@class='rdtCount'])[" + (HoursOrMinutes.toLowerCase().equalsIgnoreCase("hours") ? "1" : "2") + "]")).getText()) - (HoursOrMinutes.toLowerCase().equalsIgnoreCase("hours") ? scheduleTime.getHour() : scheduleTime.getMinute());
        for (int i = 0; i < Math.abs(differenceValue); i++)
            WebUiTools.getWebElement(label, params).findElement(By.xpath("(./..//div[@class='rdtCounter'])[" + (HoursOrMinutes.toLowerCase().equalsIgnoreCase("hours") ? "1" : "2") + "]//span[.='" + (differenceValue > 0 ? "▼" : "▲") + "']")).click();
    }

    private static void selectDate(String label, String params, LocalDateTime scheduleTime) {
        LocalDate actualLocalDate = LocalDate.parse("01 " + WebUiTools.getWebElement(label, params).findElement(By.xpath("./..//*[@class='rdtPicker']//*[@class='rdtSwitch']")).getText(), DateTimeFormatter.ofPattern("dd MMMM yyyy"));
        int monthsDifference = (int) ChronoUnit.MONTHS.between(actualLocalDate.withDayOfMonth(1), scheduleTime.withDayOfMonth(1));
        while (monthsDifference != 0) {
            WebUiTools.getWebElement(label, params).findElement(By.xpath("./..//*[@class='rdtPicker']//*[@class='rdt" + (monthsDifference > 0 ? "Next" : "Prev") + "']")).click();
            monthsDifference = monthsDifference > 0 ? monthsDifference - 1 : monthsDifference + 1;
        }
        WebUiTools.getWebElement(label, params).findElement(By.xpath("./..//td[@data-value='" + scheduleTime.getDayOfMonth() + "'][not(contains(@class,'rdtOld'))]")).click();
    }

    @Then("^UI Validate Deletion of (Report|Forensics|Alert) instance \"([^\"]*)\" with value \"([^\"]*)\"$")
    public void uiValidateDeletionOfReportInstanceWithValue(String type, String label, String params) {
        try {
            switch (type.toLowerCase()) {
                case "report":
                    new Report().deletionReportInstance(label, params);
                    break;
                case "forensics":
                    new Forensics().deletionReportInstance(label, params);
                    break;
                //            case "Alert": new Alert().deletionReportInstance(label,params);break;
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI \"(Select|UnSelect|Validate)\" Scope Polices$")
    public void uiScopePolicesInDevice(String operationType, Map<String, String> devicePolices) throws Exception {
        Map<String, String> map = null;
        map = CustomizedJsonManager.fixJson(devicePolices);
        ReportsForensicsAlertsAbstract.fixTemplateMap(map);
        switch (operationType) {
            case "Select":
                uiSelectScopePoliciesInDevice(map);
                break;
            case "UnSelect":
                uiUnSelectScopePoliciesInDevice(map);
                break;
            case "Validate":
                uiValidateScopePoliciesInDevice(map);
                break;
        }
    }

    private void uiSelectScopePoliciesInDevice(Map<String, String> map) throws Exception {
        Forensics.fixSelectionToArray("devices", map);
        new TemplateHandlers.DPScopeSelection(new JSONArray(map.get("devices")), "", new JSONObject(map.get("devices")).get("type").toString()).create();
    }

    private void uiUnSelectScopePoliciesInDevice(Map<String, String> map) throws Exception {
        String deviceIP = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, new JSONObject(map.get("devices")).get("index").toString().matches("\\d+") ? Integer.valueOf(new JSONObject(map.get("devices")).get("index").toString()) : -1).getDeviceIp();
        expandScopePolicies(deviceIP,map);
        for (Object policy : new JSONArray(new JSONObject(map.get("devices")).get("policies").toString())) {
            WebUiTools.check("DPPolicyCheck", new String[]{deviceIP, policy.toString()}, false);
        }
        saveScopeSelection(deviceIP);
    }

    private void uiValidateScopePoliciesInDevice(Map<String, String> map) throws Exception {
        StringBuilder errorMessage = new StringBuilder();
        String deviceIP = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, new JSONObject(map.get("devices")).get("index").toString().matches("\\d+") ? Integer.valueOf(new JSONObject(map.get("devices")).get("index").toString()) : -1).getDeviceIp();
        expandScopePolicies(deviceIP,map);
        if ((!(Integer.parseInt(WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[@data-debug-id='scopeSelection_DefensePro_" + deviceIP + "_policiesCount']/div").getBy()).get(0).getText().split("/")[0]) == new JSONArray(new JSONObject(map.get("devices")).get("policies").toString()).length())))
            errorMessage.append("This number of the expected policies  " + new JSONArray(new JSONObject(map.get("devices")).get("policies").toString()).length() + "  not equal of the actual policies number that equal to " + WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[@data-debug-id='scopeSelection_DefensePro" + deviceIP + "_policiesCount']/div").getBy()).get(0).getText().split("/")[1]);
        if (!WebUiTools.isElementChecked(WebUiTools.getWebElement("DPScopeSelectionChange", deviceIP)))
            errorMessage.append("This device DefensePro_" + deviceIP + " with index " + new JSONObject(map.get("devices")).get("index").toString() + " is not selected !!");
        for (Object policy : new JSONArray(new JSONObject(map.get("devices")).get("policies").toString()))
            if (!WebUiTools.isElementChecked(WebUiTools.getWebElement("DPPolicyCheck", new String[]{deviceIP, policy.toString()})))
                errorMessage.append("This Policy " + policy.toString() + " is not selected !!");
        if(!isSortedPolices(deviceIP,new JSONArray(new JSONObject(map.get("devices")).get("policies").toString()).length() ,new JSONArray(new JSONObject(map.get("devices")).get("policies").toString())))
            errorMessage.append("This Policies is not sorted !! ");
        saveScopeSelection(deviceIP);
        if (errorMessage.length() != 0)
            BaseTestUtils.report(errorMessage.toString(), Reporter.FAIL);
    }

    private boolean isSortedPolices(String deviceIP, int policesNumber , JSONArray polices) {
        ArrayList<String> policesArray =(ArrayList)polices.toList();
        policesArray.replaceAll(String::toLowerCase);
        Collections.sort(policesArray);
        List<WebElement> policyElements = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//label[starts-with(@data-debug-id, 'scopeSelection_DefensePro_" + deviceIP + "_policiesLabel_')]").getBy());
        for(int i=0; i<policesNumber;i++){
            if(!policyElements.get(i).getText().toLowerCase().equals(policesArray.get(i)))
                return false;
        }
        return true ;
    }

    private void saveScopeSelection(String deviceIP) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("DPScopeSelectionChange", deviceIP);
        BasicOperationsHandler.clickButton("SaveDPScopeSelection", "");
        if (WebUiTools.getWebElement("close scope selection") != null)
            BasicOperationsHandler.clickButton("close scope selection");
    }

    private void expandScopePolicies(String device,Map<String, String> map) throws Exception {
        try{
            clickButton("Device Selection", "");
        }catch(Exception e){
            clickButton("Open Scope Selection", new JSONObject(map.get("devices")).get("type").toString());
        }finally {
            setTextField("ScopeSelectionFilter", device);
            clickButton("DPScopeSelectionChange", device);
        }

    }

    public static class ParameterSelected {
        String label;
        String param;
        String value;
    }

    static public class TableEntry {
        String columnName;
        String value;
        Boolean isDate;
        String dateFormat;
    }

    @Then("Upload file \"([^\"]*)\"(?: to \"([^\"]*)\")?(?: for element \"([^\"]*)\")?$")
    public void uploadFileToVision(String name, String label, String param) {
        try {
            BasicOperationsHandler.uploadFileToVision(name, label, param);
        } catch (IOException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("UI Validate Number Of Elements Label \"([^\"]*)\" With Params \"([^\"]*)\" If Equal to (\\d+)$")
    public void numOfElements(String label, String params, int expectedNumber) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        String dataDebugId = VisionDebugIdsManager.getDataDebugId();
        int sizeOfList = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByDbgId(dataDebugId).getBy()).size();
        if (sizeOfList != expectedNumber)
            BaseTestUtils.report("the size : " + sizeOfList + " is not equal to : " + expectedNumber + " ", Reporter.FAIL);
    }

    @Then("^UI open devices list of \"([^\"]*)\"$")
    public void uiOpenDeviceSelection(String label) {
        try {
            BasicOperationsHandler.openDeviceList(label);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^UI Validate that number of elements of label \"([^\"]*)\" with value \"([^\"]*)\" is \"([^\"]*)\"$")
    public void uiValidateThatNumberOfElementsOfLabelWithValueIs(String label, String value, int count) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(value != null ? value : "");
        int actualcount = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).size();
        if (count != actualcount)
            BaseTestUtils.report("The expected count of Label " + label + "with value " + value + "is " + count + "But the Actual is " + actualcount, Reporter.FAIL);
    }


    // .... Maha test ....
    @Then("^MahaTest click on \"([^\"]*)\"$")
    public void mahatestClickOn(String buttonName) {
        // Write code here that turns the phrase above into concrete actions
        VisionDebugIdsManager.setLabel(buttonName);
        VisionDebugIdsManager.setParams("");
        WebUIUtils.fluentWait((ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId())).getBy()).click();
//        throw new PendingException();
    }


    @Then("^UI Unclick all the attributes \"([^\"]*)\" is \"(EQUALS|CONTAINS)\" to \"([^\"]*)\"$")
    public void uiUnclickAllTheAttributesOf(String attribute, String compare, String value, List<ParameterSelected> listParameters) {
        try {
            for (ParameterSelected parameter : listParameters) {
                VisionDebugIdsManager.setLabel(parameter.label);
                VisionDebugIdsManager.setParams(parameter.param);
                WebElement element = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
                if (element == null) {
                    addErrorMessage("No " + attribute + " attribute in element that contains " + VisionDebugIdsManager.getDataDebugId() + " in this data-debug-id");
                } else {
                    String actualStatus = element.getAttribute(attribute);
                    switch (compare) {
                        case "EQUALS":
                            if (element.getAttribute(attribute).equalsIgnoreCase(value)) {
                                BasicOperationsHandler.clickButton(parameter.label, parameter.param);
                            }
                            break;
                        case "CONTAINS":
                            if (element.getAttribute(attribute).contains(value)) {
                                BasicOperationsHandler.clickButton(parameter.label, parameter.param);
                            }
                            break;
                    }
                }
            }
            reportErrors();
        } catch (TargetWebElementNotFoundException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static class ClickParameter {
        String label;
        String param;
    }


//checkbox_select-all_Label
}
