package com.radware.vision.bddtests.basicoperations;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.api.Widget;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.restcore.VisionRestClient;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.base.WebUITestSetup;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.*;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsByNameIdHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.infra.utils.TimeUtils;
import com.radware.vision.infra.utils.VisionWebUIUtils;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import jsystem.framework.RunProperties;
import org.openqa.selenium.By;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import static com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler.*;

/**
 * Created by AviH on 30-Nov-17.
 */

public class BasicOperationsSteps extends BddUITestBase {
    private BasicOperationsByNameIdHandler basicOperationsByNameIdHandler = new BasicOperationsByNameIdHandler();

    public BasicOperationsSteps() throws Exception {
    }

    @Given("^UI Go To Vision$")
    public void goToVision() throws Exception {
        setDeviceName(null);
        BasicOperationsHandler.settings();
    }

    @Given("^UI Select \"(.*)\" device from tree with index (\\d+)$")
    public void selectDeviceFromTree(SUTDeviceType deviceType, int deviceIndex) throws Exception {
        DeviceInfo deviceInfo = devicesManager.getDeviceInfo(deviceType, deviceIndex);
        setDeviceName(deviceInfo.getDeviceName());
        TopologyTreeHandler.clickTreeNode(deviceInfo.getDeviceName());
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
//        WebUIUtils.getDriver().get("http://172.17.173.100:3000");
        WebUIVisionBasePage.navigateToPageMenu(path);
    }

    @Given("^UI Navigate to \"(.*)\" page via homePage$")
    public void navigateFromHomePage(String pageName) {
        try {
            WebUIUtils.getDriver().get("http://172.17.173.100:3000");
            WebUIVisionBasePage.navigateFromHomePage(pageName);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

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
    public void login(String username, String password, String negative) {
        if (isLoggedIn) {
            if (BasicOperationsHandler.isLoggedInWithUser(username)) {
                BasicOperationsHandler.openTab("Configurations");
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
            } else isLoggedIn = false;
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
    public void validateTextToElementWithClass(String elementClass, String compareMethod, String expectedText, String cutCharsNumber) {
        cutCharsNumber = cutCharsNumber == null ? "0" : cutCharsNumber;
        EqualsOrContains equalsOrContains;
        switch (compareMethod) {
            case "Contains":
                equalsOrContains = EqualsOrContains.CONTAINS;
                break;
            case "Equals":
            default:
                equalsOrContains = EqualsOrContains.EQUALS;
        }
        ClickOperationsHandler.validateTextFieldElementByClass(elementClass, expectedText, equalsOrContains, Integer.parseInt(cutCharsNumber));
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
    public void moveDualListItems(int deviceIndex, SUTDeviceType deviceType, DualListSides dualListSide, String dualListID) throws Exception {
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
    public void uiValidateAlteonNameWithParamsWithStatus(String portNumber, String label, String params, String expectedStatus) throws Exception {
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
        DateTimeFormatter timeRangeFormat = DateTimeFormatter.ofPattern("dd.MM.YYYY, HH:mm");
        if (fromDate != null) {
            By locator = new ComponentLocator(How.XPATH, "//*[@class='date-from']//input").getBy();
            String fromDateText = (fromDate.contains("+") || fromDate.contains("-")) ? timeRangeFormat.format(TimeUtils.getAddedDate(fromDate)) : fromDate;
            WebUIUtils.fluentWait(locator, WebUIUtils.DEFAULT_WAIT_TIME, false).clear();
            WebUIUtils.fluentWaitSendText("", locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(fromDateText, locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
            WebUIUtils.fluentWait(locator, WebUIUtils.DEFAULT_WAIT_TIME, false).clear();
            WebUIUtils.fluentWaitSendText("", locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
            WebUIUtils.fluentWaitSendText(fromDateText, locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
        }
        if (toDate != null) {
            By locator = new ComponentLocator(How.XPATH, "//*[@class='date-to']//input").getBy();
            String toDateText = (toDate.contains("+") || toDate.contains("-")) ? timeRangeFormat.format(TimeUtils.getAddedDate(toDate)) : toDate;
            WebUIUtils.fluentWaitSendText("", locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
            WebUIUtils.fluentWait(locator, WebUIUtils.DEFAULT_WAIT_TIME, false).clear();
            WebUIUtils.fluentWaitSendText(toDateText, locator, WebUIUtils.DEFAULT_WAIT_TIME, false);
        }
        WebUIUtils.fluentWaitClick(ComponentLocatorFactory.getLocatorByXpathDbgId("Date-Range-Picker-Apply").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
    }

    @Then("^UI validate arrow with label \"(.*)\" and params \"(.*)\" if \"(COLLAPSED|EXPENDED)\"$")
    public void expandArrowView(String label, String params, String status) {
        BasicOperationsHandler.validateArrow(label, params, status);
    }


    //    @Then("^UI Validate the attribute \"([^\"]*)\" Of Label \"([^\"]*)\"(?: With Params \"([^\"]*)\")? is \"(EQUALS|CONTAINS)\" to \"(.*)\"(?: with errorMessage \"([^\"]*)\")?$")
//    public void uiValidateClassContentOfWithParamsIsEQUALSCONTAINSTo(String attribute, String label, String params, String compare, String value, String expectedErrorMessage) {
//        BasicOperationsHandler.uiValidateClassContentOfWithParamsIsEQUALSCONTAINSTo(attribute, label, params, compare, value, expectedErrorMessage);
//    }
    @Then("^UI Validate the attribute \"([^\"]*)\" Of Label \"([^\"]*)\"(?: With Params \"([^\"]*)\")?(?: with errorMessage \"([^\"]*)\")? is \"(EQUALS|CONTAINS|NOT CONTAINS)\" to \"(.*)\"$")
    public void uiValidateClassContentOfWithParamsIsEQUALSCONTAINSTo(String attribute, String label, String params, String expectedErrorMessage, String compare, String value) {
        BasicOperationsHandler.uiValidateClassContentOfWithParamsIsEQUALSCONTAINSTo(attribute, label, params, compare, value, expectedErrorMessage);
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
    public void uiClickOnUpBarButton(String label, String withoutNavigateToAnotherPage) throws Throwable {
        if (withoutNavigateToAnotherPage == null)
            VisionDebugIdsManager.setTab("upBar");
        BasicOperationsHandler.clickButton(label);
    }

    @When("^UI Set Text Field \"([^\"]*)\"(?: and params \"([^\"]*)\")? To \"([^\"]*)\" by sendkeys")
    public void uiSetTextFieldAndParamsToByJavaScript(String label, String params, String value) throws Throwable {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        if (WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//*[@data-debug-id= '" + VisionDebugIdsManager.getDataDebugId() + "']").getBy()) == null)
            throw new Exception("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId());
        WebUIUtils.getDriver().findElement(new ComponentLocator(How.XPATH, "//*[@data-debug-id= '" + VisionDebugIdsManager.getDataDebugId() + "']").getBy()).clear();
        WebUIUtils.getDriver().findElement(new ComponentLocator(How.XPATH, "//*[@data-debug-id= '" + VisionDebugIdsManager.getDataDebugId() + "']").getBy()).sendKeys(value);
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

    static public class TableEntry {
        String columnName;
        String value;
        Boolean isDate;
        String dateFormat;
    }

    @Then("Upload file \"([^\"]*)\"(?: to \"([^\"]*)\")?(?: for element \"([^\"]*)\")?$")
    public void uploadFileToVision(String name, String label, String param) throws Exception {
        BasicOperationsHandler.uploadFileToVision(name, label, param);
    }

    @Then("UI Validate Number Of Elements Label \"([^\"]*)\" With Params \"([^\"]*)\" If Equal to (\\d+)$")
    public void numOfElements(String label, String params, int exbectedNumber) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        String dataDebugId = VisionDebugIdsManager.getDataDebugId();
        int sizeOfList = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByDbgId(dataDebugId).getBy()).size();
        if (sizeOfList != exbectedNumber)
            BaseTestUtils.report("the size : " + sizeOfList + " is not equal to : " + exbectedNumber + " ", Reporter.FAIL);
    }

    @Then("^UI open devices list of \"([^\"]*)\"$")
    public void uiOpenDeviceSelection(String label) throws Exception {
        BasicOperationsHandler.openDeviceList(label);
    }
}
