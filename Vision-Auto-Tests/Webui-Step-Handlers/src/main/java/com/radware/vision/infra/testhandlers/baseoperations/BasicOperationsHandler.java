package com.radware.vision.infra.testhandlers.baseoperations;

import com.aqua.sysobj.conn.CliConnectionImpl;
import com.google.common.io.ByteStreams;
import com.radware.automation.react.widgets.impl.ReactDropdown;
import com.radware.automation.react.widgets.impl.ReactList;
import com.radware.automation.react.widgets.impl.ReactSwitchButton;
import com.radware.automation.react.widgets.impl.enums.OnOffStatus;
import com.radware.automation.react.widgets.impl.enums.WebElementType;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.FileUtils;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.automation.tools.utils.PropertiesFilesUtils;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.utils.image.ImageCompression;
import com.radware.automation.webui.utils.multitab.BrowserMultiTabManager;
import com.radware.automation.webui.utils.multitab.TabInfo;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.webpages.Header;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.api.Dropdown;
import com.radware.automation.webui.widgets.api.TextField;
import com.radware.automation.webui.widgets.api.Widget;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.automation.tools.exceptions.misc.NoSuchOperationException;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.base.pages.VisionServerInfoPane;
import com.radware.vision.infra.base.pages.VisionWebUILogin;
import com.radware.vision.infra.base.pages.navigation.HomePage;
import com.radware.vision.infra.base.pages.navigation.WebUIUpperBar;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.infra.enums.UpperBarItems;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.baseoperations.enums.Operation;
import com.radware.vision.infra.testhandlers.vrm.VRMBaseUtilies;
import com.radware.vision.infra.utils.*;
import com.radware.vision.vision_project_cli.MysqlClientCli;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import com.radware.vision.vision_project_cli.RootServerCli;
import com.radware.vision.vision_project_cli.menu.Menu;
import junit.framework.SystemTestCase;
import org.openqa.selenium.*;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.How;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.io.*;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.*;

import static com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler.checkIfElementExistAndDisplayed;
import static com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler.clickWebElement;

public class BasicOperationsHandler {
    public static boolean isLoggedIn;

    public static void openTab(String tabName) {
        VisionDebugIdsManager.setTab(tabName);
        try {
            Thread.sleep(500); //to make sure licence response is ready
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        WebUIVisionBasePage.getCurrentPage().getContainer().getWidget(tabName).click();
    }


    public static void moveToTab(int tabIndex) {

        try {
            Thread.sleep(500); //to make sure licence response is ready
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        //get window handlers as list
        List<String> browserTabs = new ArrayList<String>(WebUIUtils.getDriver().getWindowHandles());
        //switch to new tab
        WebUIUtils.getDriver().switchTo().window(browserTabs.get(tabIndex));
    }

    public static int getNumberOfOpenTabs() {

        try {
            Thread.sleep(500); //to make sure licence response is ready
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        //get window handlers as list
        List<String> browserTabs = new ArrayList<String>(WebUIUtils.getDriver().getWindowHandles());
        //switch to new tab
        return browserTabs.size();
    }

    public static void validateNumberOfOpenTabs(int count) {

        try {
            Thread.sleep(500); //to make sure licence response is ready
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        if (getNumberOfOpenTabs() != count) {
            BaseTestUtils.report("Actual open tabs are: " + getNumberOfOpenTabs() + " Expected are: " + count, Reporter.FAIL);

        }

    }

    public static void moveToIframe(String by, String id) {

        try {
            Thread.sleep(500); //to make sure licence response is ready
        } catch (InterruptedException e) {
            e.printStackTrace();
        }

        By byInstance = by.equals("Id") ? By.id(id) : By.className(id);
        new WebDriverWait(WebUIDriver.getDriver(), 30).until(ExpectedConditions.frameToBeAvailableAndSwitchToIt(byInstance));
        WebUIUtils.fluentWaitClick(By.id(id), WebUIUtils.SHORT_WAIT_TIME, false);

    }

    public static void selectIframvalue(String iframeName) {

        String by = "", value = "";

//        try {
//            Thread.sleep(500); //to make sure licence response is ready
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }

        if (iframeName.equalsIgnoreCase("Configurations")) {
            by = "ClassName";
            value = "sc-fhYwyz";
        }
        moveToIframe(by, value);

    }


    public static void openSubTab(String subTab) {
        VisionDebugIdsManager.setSubTab(subTab);
        WebUIVisionBasePage.getCurrentPage().getContainer().getWidget(subTab).click();
    }

    public static void doOperation(String operation, String label, String params) throws NoSuchOperationException {
        params = replaceParams(label, params);
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        if (!Operation.getEnum(operation).equals(Operation.HOVER)) {
            Widget w = WebUIVisionBasePage.getCurrentPage().getContainer().getWidget(label);
            //TODO find a better way to make sure element is ready to be clicked
            try {
                Thread.sleep(300);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            if (w.find())
                w.click();
            else
                BaseTestUtils.report("Widget with label: \"" + label + "\" not found.", Reporter.FAIL);
        } else {
            ComponentLocator locator = ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
            MouseUtils.hover(locator);
        }
    }

    public static String replaceParams(String label, String params) {
        try {
            switch (label) {
                case "Available Device CheckBox":
                    int index = Integer.parseInt(params);
                    return BaseHandler.devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, index).getDeviceIp();
                default:
                    return params;
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        return params;
    }

    public static void setCheckbox(String name, boolean value) {
        setCheckbox(name, null, value);
    }

    public static void setCheckbox(String name, String params, boolean value) {
        VisionDebugIdsManager.setLabel(name);
        if (params != null)
            VisionDebugIdsManager.setParams(params);
        WebUICheckbox checkbox = (WebUICheckbox) WebUIVisionBasePage.getCurrentPage().getContainer().getCheckbox(name);
        if (value)
            checkbox.check();
        else checkbox.uncheck();
    }

    public static void setCheckboxById(String elementId, boolean selectCheckbox) {
        try {
            if (!checkIfElementExistAndDisplayed(GeneralUtils.buildGenericXpath(com.radware.vision.infra.enums.WebElementType.Id, elementId, OperatorsEnum.EQUALS))) {
                throw new Exception("Element not found");
            }
            WebUICheckbox checkbox = new WebUICheckbox(new ComponentLocator(How.ID, elementId));
            if (checkbox != null) {
                if (selectCheckbox) {
                    checkbox.check();
                } else {
                    checkbox.uncheck();
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to set the CheckBox selection: " + elementId, Reporter.FAIL);
        }
    }

    public static void clickButton(String label, long time, String... params) throws TargetWebElementNotFoundException {
        int timeCount = (int) time;
        boolean needToWait = true;
        while (timeCount > 0 && needToWait) {
            VisionDebugIdsManager.setLabel(label);
            VisionDebugIdsManager.setParams(params);
            if (WebUIVisionBasePage.getCurrentPage().getContainer().getButton(label).getWebElement() == null) {
                BasicOperationsHandler.delay(1);
                timeCount--;
            } else {
                needToWait = false;
            }

        }
        clickButton(label, params);
    }

    /**
     * @param label
     * @param params for id's that only will be known at test run time
     */
    public static WebElement clickButton(String label, String... params) throws TargetWebElementNotFoundException {
        if (VisionDebugIdsManager.getTab() == null || VisionDebugIdsManager.getTab().equals("")) {
            if (label.equals("Submit")) {
                WebUIVisionBasePage.getCurrentPage().submit();
            } else if (label.equals("Cancel")) {
                WebUIVisionBasePage.getCurrentPage().cancel();
            }
        } else {
            VisionDebugIdsManager.setLabel(label);
            VisionDebugIdsManager.setParams(params);
            if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()) == null) {
                throw new TargetWebElementNotFoundException("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId());
            }
            return WebUIVisionBasePage.getCurrentPage().getContainer().getButton(label).click();
        }

        return null;
    }

    public static void clickChildButton(String childLabel, String[] childParams, String parentLabel, String... parentParams) throws TargetWebElementNotFoundException {

        VisionDebugIdsManager.setLabel(parentLabel);
        VisionDebugIdsManager.setParams(parentParams);
        WebElement parent = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (parent == null)
            throw new TargetWebElementNotFoundException("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId());


        VisionDebugIdsManager.setLabel(childLabel);
        VisionDebugIdsManager.setParams(childParams);
        WebElement child = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()
                , WebUIUtils.DEFAULT_WAIT_TIME, false, parent);
        if (child == null)
            throw new TargetWebElementNotFoundException("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId());

        clickWebElement(child);


    }

    public static void selectItemFromDropDown(String label, String value) {
        VisionDebugIdsManager.setLabel(label);
        Dropdown dropDown = WebUIVisionBasePage.getCurrentPage().getContainer().getDropdown(label);
        dropDown.selectOptionByText(value);
    }

    public static void multiSelectItemFromDropDown(String label, List<String> items, boolean isApply) {
        VisionDebugIdsManager.setLabel(label);
        String debugId = VisionDebugIdsManager.getDataDebugId();
        ComponentLocator locator = ComponentLocatorFactory.getLocatorByDbgId(debugId);
        ReactDropdown dd = new ReactDropdown(locator);
        dd.selectMultiOptionsByText(items, isApply);
    }

    public static void clickSwitchButtonByLabel(String label, OnOffStatus switchButtonStatus) {
        VisionDebugIdsManager.setLabel(label);
        String debugId = VisionDebugIdsManager.getDataDebugId();
        clickSwitchButton(WebElementType.Data_Debug_Id, debugId, switchButtonStatus);
    }

    public static boolean validateSwitchButtonIsEnabledStatusByLabel(String label, boolean isEnabled) {
        VisionDebugIdsManager.setLabel(label);
        String debugId = VisionDebugIdsManager.getDataDebugId();
        return validateSwitchButtonIsEnabledStatusById(debugId, isEnabled);
    }

    public static boolean validateSwitchButtonIsEnabledStatusById(String debugId, boolean isEnabled) {
        try {
            ReactSwitchButton reactSwitchButton = new ReactSwitchButton();
            boolean isEnabledActual = reactSwitchButton.isEnabled(debugId);
            if (isEnabledActual == isEnabled) {
                return true;
            } else {
                String errMsg = String.format("Switch button %s enable status expected: %s, actual: %s", debugId, isEnabled, !isEnabled);
                BaseTestUtils.report(errMsg, Reporter.FAIL);
                return false;
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Validate Switch Button EnableDisable status with Id: " + debugId, e);
            return false;
        }

    }

    public static void clickSwitchButton(WebElementType selectorType, String debugId, OnOffStatus onOffStatus) {
        try {
            ReactSwitchButton reactSwitchButton = new ReactSwitchButton();
            reactSwitchButton.setOnOffStatus(selectorType, debugId, onOffStatus);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Click Switch with id: " + debugId, e);
        }
    }


    public static void newSelectItemFromDropDown(String label, String value) {

        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams("");
        String debugId = VisionDebugIdsManager.getDataDebugId();
        ComponentLocator locator = ComponentLocatorFactory.getLocatorByDbgId(debugId);
        WebElement ddElement = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        if (ddElement != null) {
            ReactDropdown dd = new ReactDropdown(locator);
            dd.selectOptionByText(value);
        }
    }

    public static void setTextField(String label, String value, boolean enterKey) throws NotFoundException, TargetWebElementNotFoundException {
        VisionDebugIdsManager.setLabel(label);
        TextField textField = WebUIVisionBasePage.getCurrentPage().getContainer().getTextField(label);
        textField.replaceContent(value, enterKey);
    }

    public static void setTextField(String label, String value) throws NotFoundException, TargetWebElementNotFoundException {
        setTextField(label, value, false);
    }

    public static void setTextField(String label, String params, String value, boolean enterKey) throws NotFoundException, TargetWebElementNotFoundException {

        //VisionDebugIdsManager.resetAllNodes();
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        TextField textField;
        if (params == null) {
            textField = WebUIVisionBasePage.getCurrentPage().getContainer().getTextField(label);
        } else {
            String debugID = VisionDebugIdsManager.getDataDebugId();
            textField = WebUIVisionBasePage.getCurrentPage().getContainer().getTextField(debugID);
        }
        textField.replaceContent(value, enterKey);
//        WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).sendKeys(value);
    }

    public static String getText(String label, String... params) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        return WebUIVisionBasePage.getCurrentPage().getContainer().getTextField(label).getValue();
    }


    public static void isTextEqualValue(String label, String expectedValue, String param) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(param);
        String actualValue = WebUIVisionBasePage.getCurrentPage().getContainer().getLabel(label).getInnerText();
        if (actualValue.contains(expectedValue)) {
            BaseTestUtils.report("Successfully validated element value: " + label + " equals to " + expectedValue , Reporter.PASS);
        } else {
            BaseTestUtils.report("Failed to validate element value: " + label +  " ,Expected result is: " + expectedValue +" but Actual value is: " + actualValue, Reporter.FAIL);
        }
    }

    /**
     * This check will rely on the way that selenium does it
     *
     * @param LabelName
     * @param params    for id's that only will be known at test run time
     * @return
     */




    public static boolean isItemSelected(String LabelName, String... params) {

        VisionDebugIdsManager.setLabel(LabelName);
        VisionDebugIdsManager.setParams(params);
        return WebUIVisionBasePage.getCurrentPage().getContainer().getWidget(LabelName).isSelected();

    }

    public static WebElement isItemAvailableById(String LabelName, String param) {
        VisionDebugIdsManager.setLabel(LabelName);
        if (param != null)
            VisionDebugIdsManager.setParams(param.split(","));
        return WebUIVisionBasePage.getCurrentPage().getContainer().getWidget(LabelName).getWebElement();

    }

    public static WebElement isItemAvailableByGwtId(String LabelName, String param) {
        VisionDebugIdsManager.setLabel(LabelName);
        if (param != null)
            VisionDebugIdsManager.setParams(param);
        ComponentLocator locator = new ComponentLocator(How.ID, VisionDebugIdsManager.getDataDebugId());
        WebElement element = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        return element;

    }

    public static void isGwtElementExists(String LabelName, boolean isExists, String param) {
        WebElement element = isItemAvailableByGwtId(LabelName, param);
        if (element != null && isExists || element == null && !isExists) {
            BaseTestUtils.report("Successfully validated element existence: " + LabelName + " " + isExists, Reporter.PASS);
        } else {
            BaseTestUtils.report("Failed to validate element existence: " + LabelName + " " + isExists, Reporter.FAIL);
        }
    }

    public static boolean isElementExists(String LabelName, boolean isExists, String param) {
        WebElement element = isItemAvailableById(LabelName, param);
        return element != null && isExists || element == null && !isExists;
    }

    public static void isElementSelected(String LabelName, boolean isSelected, String param) {
        WebElement element = isItemAvailableById(LabelName, param);
        if (element != null && (element.getAttribute("class").contains("selected") == isSelected)) {
            BaseTestUtils.report("Successfully validated element Selection: " + LabelName + " " + isSelected, Reporter.PASS);
        } else {
            BaseTestUtils.report("Failed to validate element Selection: " + LabelName + " " + isSelected, Reporter.FAIL);
        }
    }

    /**
     * @param LabelName
     * @param params
     * @return if the class attribute contains "selected" returns true else false
     */
    public static boolean isItemSelectedByClass(String LabelName, String... params) {
        VisionDebugIdsManager.setLabel(LabelName);
        VisionDebugIdsManager.setParams(params);
        ComponentLocator itemLocator = WebUIVisionBasePage.getCurrentPage().getContainer().getWidget(LabelName).getLocator();
        return WebUIUtils.isItemSelected(itemLocator);

    }

    /**
     * Validate Item's text is equal to value
     *
     * @param item
     * @return
     */
    public static String getItemValue(String item, String... params) throws TargetWebElementNotFoundException {
        VisionDebugIdsManager.setLabel(item);
        VisionDebugIdsManager.setParams(params);
        Widget widget = WebUIVisionBasePage.getCurrentPage().getContainer().getWidget(item);
        if (widget == null) {
            String messagePrefix = "Could not find element with label";
            String errorMessage = params == null ? String.format("%s %s", messagePrefix, item) :
                    String.format("%s %s and param %s", messagePrefix, item, params);
            throw new TargetWebElementNotFoundException(errorMessage);
        }
        String itemValue = widget.getInnerText();
        return itemValue;
    }

    /**
     * Validate Item's text is contains the value
     *
     * @param item
     * @param expectedValue
     * @param params
     * @return
     */
    public static boolean isItemValueContains(String item, String params, String expectedValue) {
        String itemValue = null;
        try {
            itemValue = getItemValue(item, params);
        } catch (TargetWebElementNotFoundException e) {
            e.printStackTrace();
        }
        return itemValue.contains(expectedValue);
    }

    /**
     * Validate Item's text contains value
     *
     * @param item
     * @param expectedValue
     * @return
     */
    public static boolean isItemValueContains(String item, String expectedValue) {
        VisionDebugIdsManager.setLabel(item);
        Widget widget = WebUIVisionBasePage.getCurrentPage().getContainer().getWidget(item);
        String itemValue = widget.getInnerText();
        return itemValue.contains(expectedValue);

    }

    public static void login(String username, String password) {
        try {
            WebUIUtils.isAllowInexistenceMode = true;
            VisionWebUILogin visionWebUILogin = new VisionWebUILogin();
            visionWebUILogin.setUsername(username);
            visionWebUILogin.setUPassword(password);
            visionWebUILogin.login();
            WebUIUtils.sleep(15);
            String loginStatusMsg = verifyLogin();
            if (loginStatusMsg.isEmpty()) {
                BaseTestUtils.report("Failed to Login with username:" + username + " " + "Password: " + password + ", Error:\n" + loginStatusMsg, Reporter.FAIL);
                isLoggedIn = false;
            } else {
                BaseTestUtils.report("Login verification :" + loginStatusMsg, Reporter.PASS_NOR_FAIL);
                isLoggedIn = true;
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Login with username:" + username + " " + "Password: " + password, e);
        }
    }

    public static void validateLoginDialog(boolean ifExists) {
        try {
            boolean ifLoggedOut = isLoggedOut(WebUIUtils.DEFAULT_WAIT_TIME);
            if (ifLoggedOut != ifExists) {
                BaseTestUtils.report("Failed to validate Login dialog existence Status! expected status is: " + ifExists + " " + "Actual status is: " + ifLoggedOut + ", Error:\n", Reporter.FAIL);
            } else {
                isLoggedIn = false;
                BaseTestUtils.report("Validate Login dialog existence Status is Successful! expected status is: " + ifExists + " " + "Actual status is: " + ifLoggedOut + ", Error:\n", Reporter.PASS);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to validate Login dialog existence Status! expected status is: " + ", Error:\n" + e.getMessage(), Reporter.FAIL);
        }
    }

    public static boolean negativeLogin(String username, String password, double loginTimeout) throws Exception {
        VisionWebUILogin visionWebUILogin = new VisionWebUILogin();
        visionWebUILogin.setUsername(username);
        visionWebUILogin.setUPassword(password);
        WebUIDriver.getListenerManager().unregisterEventListener();
        ComponentLocator loginBtnLocator = new ComponentLocator(How.ID, WebUIStrings.getLoginButton());
        WebUIComponent loginButton = new WebUIComponent(loginBtnLocator);
        loginButton.click();
        delay(loginTimeout);
        ComponentLocator loginDlgLocator = new ComponentLocator(How.ID, "gwt-debug-Dialog_Box");
        try {
            WebUIComponent loginDlg = new WebUIComponent(loginDlgLocator);
            if (loginDlg.getWebElement() != null) {
                return false;
            }
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
        WebUIUtils.registerEventListener();
        return true;
    }

    public static void logout() {
        try {
            WebUIUtils.isIgnoreDisplayedPopup = true;
            WebUIUtils.setIsTriggerPopupSearchEvent(true);
            if (!isLoggedOut(WebUIUtils.SHORT_WAIT_TIME)) {
                openUserInfoPanel();
                ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getLogoutButton());
                WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                delay(2);
                if (!isLoggedOut(WebUIUtils.DEFAULT_LOGIN_WAIT_TIME)) {
                    WebUIUtils.closeBrowser();
                    BaseTestUtils.report("Logout Operation failed, no <log In> button found", Reporter.FAIL);
                } else isLoggedIn = false;
            }
        } catch (Exception e) {
            BaseTestUtils.report("Logout failed with the error", e);
        } finally {
            WebUIUtils.setIsTriggerPopupSearchEvent(false);
        }
    }

    public static void closeBrowser() throws Exception {
        WebUIUtils.isDriverQuit = true;
        WebUIUtils.closeBrowser();
        WebUIDriver.setDriver(null);
    }

    public static String verifyLogin() {

        WebElement webElement = null;
        try {
            //Makes sure browser is maximized or the user name will not be seem.
            WebUIDriver.getDriver().manage().window().maximize();

            VisionDebugIdsManager.setTab("HomePage");
            VisionDebugIdsManager.setLabel("loggedInUsername");
            WebUIUtils.sleep(3);
            webElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
//            webElement = WebUIUtils.fluentWaitDisplayedEnabled(new ComponentLocator(How.ID, WebUIStringsVision.getUserName()).getBy(), WebUIUtils.DEFAULT_LOGIN_WAIT_TIME, false);
            if (webElement != null) {
                //TODO find a better way to validate login page was rendered successfully
                Thread.sleep(7000);
                return webElement.getText();
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        return "";
    }

    public static boolean isLoggedOut(long waitTimeout) {
        if (!isLoggedIn)
            return true;
//        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getVisionLoginIcon());
        ComponentLocator locator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='card-header_']");
        try {
            WebElement headerElement = WebUIUtils.fluentWaitDisplayed(locator.getBy(), waitTimeout, false);
            return headerElement != null;
        } catch (Exception e) {
            return false;
        }
    }


    public static String getLoggedInUser() {
        WebUIUtils.isAllowInexistenceMode = true;
        Header header = new Header();
        return header.getUsername();
    }


    public static void refresh() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getTopOperationsRefresh());
        WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
    }

    public static void refreshBrowserPage() {
        WebUIUtils.refreshPage();
    }

    public static void settings() {
        navigateFromHomePage("VISION SETTINGS");
        WebUIBasePage.closeAllYellowMessages();
    try
    {
        HomePage.navigateFromHomePage(PropertiesFilesUtils.mapAllPropertyFiles("Navigations").get("VISION SETTINGS"));
        WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorById("gwt-debug-System").getBy()).click();
    }catch (Exception ignore){}
        //Verify the click
        if (!new VisionServerInfoPane().getDeviceName().equals("APSolute Vision")) {
            ReportsUtils.reportAndTakeScreenShot("Failed To Go To Vision ", Reporter.FAIL);
        }
    }

    public static void openUserInfoPanel() throws TargetWebElementNotFoundException {
        ComponentLocator userInfo = new ComponentLocator(How.ID, WebUIStrings.getUserInfoButton());
        if (WebUIUtils.fluentWaitClick(userInfo.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false) == null)
            throw new TargetWebElementNotFoundException("Could not locate user info panel");
    }

    public static void scheduler(boolean clickToOpen) {
        ComponentLocator locator = new ComponentLocator(How.XPATH, ".//*[contains(@id,'ScheduledTasks')]");
        WebElement scheduledTable = WebUIUtils.fluentWaitDisplayed(locator.getBy(), 100, false);
        if ((clickToOpen && scheduledTable == null) || (!clickToOpen && scheduledTable != null)) {
            locator = new ComponentLocator(How.ID, WebUIStrings.getUpperBarScheduler());
            try {
                WebUIUtils.setIsTriggerPopupSearchEvent(false);
                WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            } finally {
                WebUIUtils.setIsTriggerPopupSearchEvent(true);
            }
        }
    }

    public static void templates() {
        WebUIUpperBar.select(UpperBarItems.ToolBox);
        WebUIUpperBar.select(UpperBarItems.ToolBox_Advanced);
    }

    public static void toolbox(boolean clickToOpen) {
        WebElement templatesLink = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, WebUIStringsVision.getToolboxTab()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (clickToOpen) {
            if (!templatesLink.getAttribute("class").contains("-selected")) {
                try {
                    WebUIUtils.setIsTriggerPopupSearchEvent(false);
                    templatesLink.click();
                } finally {
                    WebUIUtils.setIsTriggerPopupSearchEvent(true);
                }
            }
        } else {
            if (templatesLink.getAttribute("class").contains("-selected")) {
                try {
                    WebUIUtils.setIsTriggerPopupSearchEvent(false);
                    templatesLink.click();
                } finally {
                    WebUIUtils.setIsTriggerPopupSearchEvent(true);
                }
            }
        }
    }

    public static void setWaitAfterClick(long timeout) {
        WebUIUtils.waitAfterClickOperation = timeout;
    }

    public static String setMysqlGlobalVariable(RootServerCli rootServerCli, MysqlClientCli mysqlClientCli, String
            varName, String varValue) throws Exception {
        rootServerCli.addDBPermissionsToConnectoToMySql("vision.radware");
        mysqlClientCli.openMysqlShell(mysqlClientCli.getSqlUser(), mysqlClientCli.getSqlPassword());
        String commandResult = mysqlClientCli.runSqlFromMysqlShell("set " + varName + "=" + varValue + ";");
        InvokeUtils.invokeCommand("quit", mysqlClientCli);
        return commandResult;
    }

    public static void appendMyCnfFile(RootServerCli rootServerCli, String varName, String varValue) throws
            Exception {
        InvokeUtils.invokeCommand("sed -i '30i" + varName + "=" + varValue + "' " + "/etc/my.cnf", rootServerCli);
    }

    public static void restartVisionServerServices(RadwareServerCli visionRestClient) throws Exception {
        visionRestClient.connect();
        InvokeUtils.invokeCommand(null, Menu.system().visionServer().stop().build(), visionRestClient, 600000L);
        InvokeUtils.invokeCommand(null, Menu.system().visionServer().start().build(), visionRestClient, 600000L, false, true);
    }

    public static boolean verifyLogout() {
        ComponentLocator logoutDialogLocator = new ComponentLocator(How.XPATH, "//div[contains(@id,'gwt-debug-Dialog_Box') and contains(@class,'LoginDialog')]");
        try {
            WebUIDriver.getDriver().manage().window().maximize();
            WebUIUtils.fluentWaitDisplayed(logoutDialogLocator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    public static void refreshPage() {
        WebUIDriver.getDriver().navigate().refresh();
    }

    public static void delay(double secToWait) {
        try {
            Thread.sleep(Math.round(secToWait * 1000));
        } catch (InterruptedException ie) {
//			Ignore
        }
    }

    public static void runVisionServerDebugMode(CliConnectionImpl cli) throws Exception {
        cli.connect();
        InvokeUtils.invokeCommand(null, "start_server_debug", cli, 3 * 60 * 1000);
    }

    public static String getVisionClientTime() {
        ComponentLocator componentLocator = new ComponentLocator(How.ID, WebUIStringsVision.getDate());

        WebUITextField webUITextField = new WebUITextField(componentLocator);
        return webUITextField.getInnerText();

    }

    public static boolean validateBrowserTabExistence(String url) {
        List<TabInfo> tabsList = BrowserMultiTabManager.getInstance().getAllTabs();
        for (TabInfo tab : tabsList) {
            if (tab.getUrl().contains(url)) {
                return true;
            }
        }
        return false;
    }

    public static void takeScreenShot() throws IOException {

        LocalTime time = LocalTime.now();
        WebDriver driver = WebUIUtils.getDriver();
        byte[] buff = ((TakesScreenshot) driver).getScreenshotAs(OutputType.BYTES);
        InputStream inputStream = new ByteArrayInputStream(buff);
        //generate random name for screenshot file
        String randomFileName = UUID.randomUUID().toString();
        randomFileName += ".png";
        inputStream = ImageCompression.compressFile(inputStream);

        SystemTestCase.report.saveFile(randomFileName, ByteStreams.toByteArray(inputStream));

        String imageSource = randomFileName;
        SystemTestCase.report.reportHtml(time + " Screenshot. ", "<img src=" + imageSource + " alt=screenshot width=1280 height=848>", true);
    }

    public static void setIsLoggedIn(boolean isLoggedIn) {
        BasicOperationsHandler.isLoggedIn = isLoggedIn;
    }

    public static void deleteView(String params, String approveOrCancel) {
        String delete = "Delete";
        VisionDebugIdsManager.setLabel(delete);
        VisionDebugIdsManager.setParams(params);
        WebUIVisionBasePage.getCurrentPage().getContainer().getButton("").click();
        if (approveOrCancel != null) {
            String option = delete + "." + approveOrCancel;
            VisionDebugIdsManager.setLabel(option);
            WebUIVisionBasePage.getCurrentPage().getContainer().getButton(option).click();
        }
    }

    /**
     * Validate if the user loggedIn with specific username
     *
     * @param userName The userName of the user
     * @return true if the user loggedIn with userName and false if he not loggedIn or not loggedIn with userName
     */
    public static boolean isLoggedInWithUser(String userName) {
        if (isLoggedIn) {
            String actualUserName = verifyLogin();
//            ComponentLocator usernameLoggedInLocator = new ComponentLocator(How.ID, WebUIStringsVision.getUserName());
//            WebUIComponent usernameLoggedInWebUi = new WebUIComponent(usernameLoggedInLocator);
//            String actualUserName = usernameLoggedInWebUi.getInnerText().split("User: ")[1];

            return actualUserName.equals(userName);
        }
        return false;
    }

    public static void validatePopupMessageText(String expectedText, String textTypeSuffix) {
        WebElement element = null;
        String elementMessage = "";
        ComponentLocator componentLocator = new ComponentLocator(How.XPATH, "//button[contains(@class,'gwt-Button') and contains(@id,'" + WebUIStrings.getDialogBox() + "')]");
        try {
            WebUIUtils.setIsTriggerPopupSearchEvent(false);

            String elementId = WebUIStrings.getDialogBoxTextIdByType(textTypeSuffix);
            element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.MAX_RENDER_WAIT_TIME, false);
            if (element == null) {
                BaseTestUtils.report("Could not locate popup dialog box with id: " + elementId, Reporter.FAIL);
            } else {
                elementMessage = element.getText();
            }
            if (!elementMessage.equals(expectedText))
                BaseTestUtils.report("TextField Validation Failed. Expected Text is:" + expectedText + " Actual Text is:" + elementMessage, Reporter.FAIL);
        } finally {
            if (element != null)
                WebUIUtils.fluentWaitClick(componentLocator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);

        }
    }

    public static void isElementFounds(String label, boolean isExists, String param) {
        if (isElementExists(label, isExists, param))
            BaseTestUtils.report("Successfully validated element existence: " + label + " " + isExists, Reporter.PASS);
        else {
            BaseTestUtils.report("Failed to validate element existence: " + label + " " + isExists, Reporter.FAIL);
        }
    }

    public static WebElement getDisplayedWebElement(String label, String params) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        ComponentLocator elementLocator = ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
        return WebUIUtils.fluentWaitDisplayedEnabled(elementLocator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
    }

    public static void clickListItem(String selector, String label, boolean checkUncheck) {
        try {
            VisionDebugIdsManager.setLabel(selector);
            ReactList portsList = new ReactList(VisionDebugIdsManager.getDataDebugId());
            portsList.checkUncheckListItemByLabel(label, checkUncheck);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the List item: " + label, Reporter.FAIL);
        }
    }

    public static void isEnabledListItem(String selector, String label) {
        try {
            VisionDebugIdsManager.setLabel(selector);
            ReactList portsList = new ReactList(VisionDebugIdsManager.getDataDebugId());
            if (portsList.isEnabled(label)) {
                BaseTestUtils.report("Successfully validated List item EnableDisable status: " + label, Reporter.PASS);
            } else {
                BaseTestUtils.report("Failed to click on the List item: " + label, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the List item: " + label, Reporter.FAIL);
        }
    }

    public static void validateArrow(String label, String params, String status) {
        status = status.toLowerCase();
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        WebElement element = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (!element.getAttribute("class").contains(status)) {
            String actualStatus;
            if (status.equalsIgnoreCase("expanded")) {
                actualStatus = "collapsed";
            } else {
                actualStatus = "expanded";
            }
            BaseTestUtils.report("The EXPECTED value of : '" + label + "' with params: '" + params + "' is " + status + " but the ACTUAL is: '" + actualStatus + "' ", Reporter.FAIL);
        }
    }

    public static void uiValidateClassContentOfWithParamsIsEQUALSCONTAINSTo(String attribute, String label, String params, String compare, String value, String expectedErrorMessage) {
        if (params == null) params = "";
        VisionDebugIdsManager.setLabel(label);
        if (params != null)
            VisionDebugIdsManager.setParams(params.split(","));
        else
            VisionDebugIdsManager.setParams(params);
        WebElement element = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (element == null) {
            BaseTestUtils.report("no Element with locator: " + ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()), Reporter.FAIL);
        }
        String actualStatus = "";
        try {
            assert element != null;
            actualStatus = element.getAttribute(attribute);
        } catch (Exception e) {
            BaseTestUtils.report("No " + attribute + " attribute in element that contains " + VisionDebugIdsManager.getDataDebugId() + " in this data-debug-id", Reporter.FAIL);
        }
        String errorMessage = "The EXPECTED value of : '" + label + "' with params: '" + params + "' is not equal to '" + actualStatus + "' ";
        switch (compare) {
            case "EQUAL":
                if (!element.getAttribute(attribute).equalsIgnoreCase(value)) {
                    if (expectedErrorMessage != null) errorMessage = expectedErrorMessage;
                    BaseTestUtils.report(errorMessage, Reporter.FAIL);
                }
                break;
            case "CONTAINS":
                if (!element.getAttribute(attribute).contains(value)) {
                    errorMessage.replaceFirst(" is not equal to ", " is not contained in ");
                    if (expectedErrorMessage != null) errorMessage = expectedErrorMessage;
                    BaseTestUtils.report(errorMessage, Reporter.FAIL);
                }
                break;
            case "NOT CONTAINS":
                if (element.getAttribute(attribute).contains(value)) {
                    errorMessage.replaceFirst(" is not equal to ", " is contained in ");
                    if (expectedErrorMessage != null) errorMessage = expectedErrorMessage;
                    BaseTestUtils.report(errorMessage, Reporter.FAIL);
                }
                break;
        }
    }


    public static boolean isElementContainsClass(String label, String params, String value) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        WebElement element = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        String elementClass = element.getAttribute("class");
        List<String> elementClasses = Arrays.asList(elementClass.split("\\s+"));
        return elementClasses.contains(value);
    }


    public static boolean validateDateTextFieldInElement(WebElement textFieldElement, String date, String format) throws Exception {
        if (textFieldElement == null)
            throw new Exception("No Element");
        DateTimeFormatter inputFormatter;
        if (format != null)
            inputFormatter = DateTimeFormatter.ofPattern(format);
        else inputFormatter = DateTimeFormatter.ofPattern("dd.MM.yyyy");
        LocalDateTime fromLocalDate = TimeUtils.getAddedDate(date);
        return (textFieldElement.getText().equals(fromLocalDate.format(inputFormatter)));
    }

    public static void clickSvgElement(String label, String... paramsValues) throws TargetWebElementNotFoundException {

        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(paramsValues);
//        WebElement svgElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        WebElement svgElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (svgElement == null)
            throw new TargetWebElementNotFoundException("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId());
        Actions builder = new Actions(WebUIUtils.getDriver());
        builder.click(svgElement).build().perform();
    }

    public static void uploadFileToVision(String name, String label, String param) throws IOException {
        WebElement elem;
        Properties properties = new Properties();        //function to upload file from project
//        properties.load(new FileInputStream("jsystem.properties"));
//        String basePath = properties.getProperty("resources.src");
        String basePath = FileUtils.getAbsoluteProjectPath()+ "src" + File.separator + "main" + File.separator + "resources" + File.separator;
        String uploadFilePath = basePath  + File.separator + "uploadedFiles" + (System.getProperty("os.name").contains("Windows")? "\\":"/") + name;
        BaseTestUtils.report("Path of Uploaded file is: " + uploadFilePath, Reporter.PASS_NOR_FAIL);
        BaseTestUtils.report("The label is: " + label, Reporter.PASS_NOR_FAIL);
        if(label!= null){
            VisionDebugIdsManager.setLabel(label);
            VisionDebugIdsManager.setParams(param);
            String debugId = VisionDebugIdsManager.getDataDebugId();
            BaseTestUtils.report("The debug id is: " + debugId, Reporter.PASS_NOR_FAIL);
            elem = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH,"//*[contains(@data-debug-id,'" + debugId +"')]/..//input[@type='file']").getBy(),WebUIUtils.SHORT_WAIT_TIME, false);
        }
        else {
            elem = WebUIDriver.getDriver().findElement(By.xpath("//input[@type='file']"));
        }
        elem.sendKeys(uploadFilePath);
//        WebUIUtils.generateAndReportScreenshot();
        WebUIUtils.forceGenerateAndReportScreenshot();
    }

    public static void openDeviceList(String label) throws Exception {

        switch(label){
            case "Devices":
                label="Device Selection";
                BasicOperationsHandler.clickButton(label, "");
                break;
            case "Reports":
             //   openTab(label);
                clickButton("Add New", "");
                clickButton("Template","");
                BasicOperationsHandler.clickButton("DefensePro Behavioral Protections Template", "");
                clickButton("Widget Apply");
                VRMBaseUtilies.expandViews(true);
                break;
            case "Forensics":
            case "Alerts":
               // openTab(label);
                clickButton("Add New", "");
                VRMBaseUtilies.expandViews(true);
                break;
        }

    }

    public static void navigateFromHomePage(String pageName) {
        try {
            closeAllPopups();
            HomePage.navigateFromHomePage(PropertiesFilesUtils.mapAllPropertyFiles("Navigations").get(pageName));
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    private static void closeAllPopups() {
        ComponentLocator locator = ComponentLocatorFactory.getLocatorByClass("ant-modal-close");
        if ((WebUIUtils.fluentWait(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME)) != null && WebUIUtils.fluentWait(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME).isDisplayed())
            try
            {
                WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME,  false).click();
            }catch (ElementNotInteractableException ignore){}

    }

    public static boolean isNavigationDisabled(String pageName) throws Exception {
        closeAllPopups();
        return HomePage.isNavigationDisabled(PropertiesFilesUtils.mapAllPropertyFiles("Navigations").get(pageName));
    }
}

