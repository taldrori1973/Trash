package com.radware.vision.bddtests;

import com.radware.automation.react.widgets.impl.enums.OnOffStatus;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.ComparableUtils;
import com.radware.automation.webui.UIUtils;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.api.TextField;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.automation.tools.exceptions.misc.NoSuchOperationException;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.clioperation.FileSteps;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.DeviceDriverType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.TableHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.infra.testhandlers.vrm.VRMHandler;
import com.radware.vision.infra.testhandlers.vrm.VRMReportsHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import enums.SUTEntryType;
import org.openqa.selenium.*;
import org.openqa.selenium.support.How;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.FluentWait;
import org.openqa.selenium.support.ui.Wait;

import java.time.Duration;
import java.util.Arrays;
import java.util.List;
import java.util.Objects;

import static com.radware.vision.infra.utils.ReportsUtils.reportErrors;


public class GenericSteps extends BddUITestBase {

    private VRMReportsHandler vrmReportsHandler = new VRMReportsHandler();
    private TableHandler tableHandler = new TableHandler();

    public GenericSteps() throws Exception {
    }

    @Given("^UI Open \"([^\"]*)\" Tab( negative)?$")
    public void uiOpenTab(String tabName, String isNegativeArg) {
        if (isNegativeArg != null) {
//            WebUIUtils.isIgnoreDisplayedPopup = true;
            WebUIUtils.setIsTriggerPopupSearchEvent(false);
        }
        BasicOperationsHandler.openTab(tabName);
    }

    @Given("^UI move to New Tab by index (\\S+)$")
    public void uiSwitchTab(int tabIndex) {
        BasicOperationsHandler.moveToTab(tabIndex);
    }

    @Then("^validate number of open tabs are (\\S+)$")
    public void countOfOpenTabs(int count) {
        BasicOperationsHandler.validateNumberOfOpenTabs(count);
    }

    @Then("^UI move to iframe by \\\"(Id|ClassName)\\\" Equals to \"([^\"]*)\"$")
    public void uiSwitchIframe(String by, String iframe) {
        BasicOperationsHandler.moveToIframe(by, iframe);
    }

    @Then("^UI move to \"([^\"]*)\" iframe$")
    public void uiSwitchToIframe(String name) {
        BasicOperationsHandler.selectIframvalue(name);
    }

    @When("^UI Set Checkbox \"([^\"]*)\"(?: with extension \"([^\"]*)\")? To \"([^\"]*)\"$")
    public void uiSetCheckboxWithExtensionTo(String name, String extension, boolean value) {
        BasicOperationsHandler.setCheckbox(name, extension, value);
    }

    @When("^UI Set Checkbox by ID \"([^\"]*)\" To \"([^\"]*)\"$")
    public void uiSetCheckboxById(String elementId, boolean selectCheckbox) {
        BasicOperationsHandler.setCheckboxById(elementId, selectCheckbox);
    }

    @When("^UI Click Button \"([^\"]*)\"(?: with value \"([^\"]*)\")?$")
    public WebElement buttonClick(String label, String param) throws TargetWebElementNotFoundException {
        try {
            if (param == null)
                return BasicOperationsHandler.clickButton(label, param);
            else {
                String[] params = param.split(",");
                return BasicOperationsHandler.clickButton(label, params);
            }
        } catch (TargetWebElementNotFoundException e) {
            BaseTestUtils.report("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId(), Reporter.FAIL);
        }
        return null;
    }

    /**
     * @param saveServer - string to check if data
     * @param servers    - list of DataServers
     * @throws TargetWebElementNotFoundException
     */
    @When("UI Select Server( and [S|s]ave)?")
    public void selectServer(String saveServer, List<DataServer> servers) throws TargetWebElementNotFoundException {
        if (servers.size() == 0) {
            BaseTestUtils.report("No server has been selected, 1 server is required", Reporter.FAIL);
        }
        // In case there are several servers - select the first one
        DataServer server = servers.get(0);
        // click button servers
        buttonClick("Servers Button", (String) null);
        // set text field
        uiSetTextFieldTo("Server Selection.Search", null, server.name, false);
        // lazy scrolling and click the chosen server
        VisionDebugIdsManager.setLabel("Server Selection");
        VisionDebugIdsManager.setParams(server.name, server.device, server.policy);
        ComponentLocator targetElementLocator = ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
        //ComponentLocator elementsLocator = new ComponentLocator(How.XPATH, "//*[contains(@data-debug-id, 'radio-" + server.name + "') and contains(@data-debug-id, '" + server.device + "')]");
        ComponentLocator elementsLocator = new ComponentLocator(How.XPATH, "//*[contains(@data-debug-id, 'radio-" + server.name + "') and contains(@data-debug-id, 'parent')]");
        new VRMHandler().scrollUntilElementDisplayed(elementsLocator, targetElementLocator);
        buttonClick("Server Selection.Server Name", server.toString());
        if (saveServer != null) {
            buttonClick("Server Selection.Save", (String) null);
        }
    }

    @When("^UI Click Button By JavascriptExecutor with label \"([^\"]*)\"(?: with value \"([^\"]*)\")?$")
    public void clickButtonByJavaScript(String label, String param) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(param);
        WebElement webElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        ((JavascriptExecutor) WebUIUtils.getDriver()).executeScript("arguments[0].click();", webElement);
    }

    @When("^UI Click Button \"([^\"]*)\" with params$")
    public static void buttonClick(String label, List<VRMHandler.DpDeviceFilter> entries) {

        entries.forEach(entry -> {
            String param = null;
            try {
                if (entry.index != null) {
                    param = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, entry.index).getDeviceIp();
                    String[] params = param.split(",");
                    try {
                        BasicOperationsHandler.clickButton(label, params);
                    } catch (TargetWebElementNotFoundException e) {
                        BaseTestUtils.report("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId(), Reporter.FAIL);
                    }

                } else {
                    BasicOperationsHandler.clickButton(label, param);
                }

            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), e);
            }

        });
    }

    @When("^UI Click Switch button \"(.*)\" and set the status to \"(ON|OFF)\"$")
    public void clickSwitchButtonByLabel(String label, OnOffStatus switchButtonStatus) {
        BasicOperationsHandler.clickSwitchButtonByLabel(label, switchButtonStatus);
    }

    @Then("^UI Validate Switch Button \"(.*)\"(?: with extension \"([^\"]*)\")? isEnabled status \"(true|false)\"$")
    public void validateSwitchButtonIsEnabled(String label, String param, boolean isEnabled) {
//        label=label+param;
        label = param != null ? label + param : label;
        BasicOperationsHandler.validateSwitchButtonIsEnabledStatusByLabel(label, isEnabled);
    }

    @Then("^UI validate Date by Label \"([^\"]*)\"(?: with time Format \"([^\"]*)\")?(?: by error threshold in minutes \"([^\"]*)\")?$")
    public void validateDate(String dateLabel, String timeFormat, String thresholdInMinutes) {
        vrmReportsHandler.validateSimpleDate(dateLabel, timeFormat, thresholdInMinutes);
    }

    @When("^UI Select \"([^\"]*)\" from dropdown \"([^\"]*)\"$")
    public void uiSelectFromDropdown(String value, String label) {
        BasicOperationsHandler.newSelectItemFromDropDown(label, value);
    }

    @When("^UI Select \"([^\"]*)\" from Vision dropdown \"([^\"]*)\"$")
    public void uiSelectFromVisionDropdown(String value, String label) {
        BasicOperationsHandler.selectItemFromDropDown(label, value);
    }

    @When("^UI Select \"([^\"]*)\" from Vision dropdown by Id \"([^\"]*)\"$")
    public void selectFromVisionDropdownById(String value, String elementId) {
        ClickOperationsHandler.selectItemFromDropdown(elementId, value, DeviceDriverType.VISION.getDDType());
    }

    @When(("^UI Select Multi items from dropdown \"([^\"]*)\"( apply)?$"))
    public void uiMultiSelectFromDrown(String label, String apply, List<String> cells) {
        boolean isApply = apply != null;
        BasicOperationsHandler.multiSelectItemFromDropDown(label, cells, isApply);
    }

    @When("^UI Set Text Field \"([^\"]*)\"(?: and params \"([^\"]*)\")? To \"([^\"]*)\"(?: enter Key (true|false))?$")
    public void uiSetTextFieldTo(String label, String params, String value, boolean enterKey) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.setTextField(label, params, value, enterKey);
    }

    @When("^UI Set Text Field BY Character \"([^\"]*)\"(?: and params \"([^\"]*)\")? To \"([^\"]*)\"(?: enter Key (true|false))?$")
    public static void uiSetTextFieldByCharacterTo(String label, String params, String value, boolean enterKey) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.setTextField(label, params, "", enterKey);
        TextField textField = WebUIVisionBasePage.getCurrentPage().getContainer().getTextField(VisionDebugIdsManager.getDataDebugId());
        ((WebUITextField) textField).sendKeysByCharacter(value);
    }

    @When("^UI Do Operation \"([^\"]*)\" item \"([^\"]*)\"(?: with value \"([^\"]*)\")?$")
    public void uiSSlInspectionDoOperation(String operation, String item, String params) {
        try {
            BasicOperationsHandler.doOperation(operation, item, params);
        } catch (NoSuchOperationException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Description: Validate ALL inner texts of an element (including all inner levels) is equal to value
     *
     * @param label         - the debug id of the element that has the text that you want to compare to
     * @param expectedValue - the text that you want to compare
     * @param params        - adding to debugs id
     */
    @Then("^UI Text of \"([^\"]*)\"(?: with extension \"(.*)\")? equal to \"([^\"]*)\"$")
    public void uiTextOfEqualTo(String label, String params, String expectedValue) throws TargetWebElementNotFoundException {
        String actualValue = null;

        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);

        ComponentLocator locator = ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());

        Wait<WebDriver> wait = new FluentWait<>(WebUIUtils.getDriver()).
                withTimeout(Duration.ofMillis(WebUIUtils.DEFAULT_WAIT_TIME)).
                pollingEvery(Duration.ofMillis(2)).
                ignoring(StaleElementReferenceException.class, WebDriverException.class);

        boolean displayed = wait.until(ExpectedConditions.presenceOfElementLocated(locator.getBy())).isDisplayed();
        if (displayed) {
            try {
                if (params == null)
                    actualValue = BasicOperationsHandler.getItemValue(label, params);
                else {
                    String[] params_values = params.split(",");
                    actualValue = BasicOperationsHandler.getItemValue(label, params_values);
                }
            } catch (TargetWebElementNotFoundException e) {
                e.printStackTrace();
            }
            if (actualValue == null) {
                String errorMessage = "Element Value with label " + label + " returns null";
                BaseTestUtils.report(errorMessage, Reporter.FAIL);
                throw new TargetWebElementNotFoundException(errorMessage);
            }
            if (!actualValue.trim().equals(expectedValue)) {
                try {
                    VRMHandler.scroll("Table_Attack Details");
                } catch (Exception e) {
                }
                ReportsUtils.reportAndTakeScreenShot(String.join(" : ", label + "-" + params, "Actual is \"" + actualValue + "\" but is not equal to \"" + expectedValue + "\""), Reporter.FAIL);
            }
        } else
            BaseTestUtils.report(String.format("Web Element located by %s is not diplayed", locator.getBy()), Reporter.FAIL);
    }

    /**
     * Description: Validate elements order inside parent element
     *
     * @param label         - the debug id of the element that has the text that you want to compare to
     * @param prefix        - the children elements prefixes
     * @param expectedValue - string with the expected elements order seperated by comma - WITHOUT THE PREFIX!!!.
     *                      for example: in order to validate ports order is: port_3, port_9, port_2, the "prefix" param is "port_" and the "expectedValue" is "3,9,2"
     */
    @Then("^UI validate order of \"([^\"]*)\" with elements prefix \"([^\"]*)\" is equal to \"([^\"]*)\"$")
    public void uiTextOrderEqualTo(String label, String prefix, String expectedValue) throws TargetWebElementNotFoundException {
        String actualValue = null;
        try {
            actualValue = BasicOperationsHandler.getItemValue(label, null);
        } catch (TargetWebElementNotFoundException e) {
            e.printStackTrace();
        }
        if (actualValue == null) {
            String errorMessage = "Element Value with label " + label + " returns null";
            BaseTestUtils.report(errorMessage, Reporter.FAIL);
            throw new TargetWebElementNotFoundException(errorMessage);
        }
        expectedValue.replaceAll(" ", "");
        List<String> expectedValueList = Arrays.asList(expectedValue.replaceAll(" ", "").split(","));
        List<String> actualValuesList = Arrays.asList(actualValue.substring(actualValue.indexOf(prefix) + prefix.length()).split(prefix));
        for (int i = 0; i < actualValuesList.size(); i++) {
            if (!actualValuesList.get(i).equals(expectedValueList.get(i))) {
                ReportsUtils.addErrorMessage("Element in place " + (i + 1) + " is " + prefix + actualValuesList.get(i) + " instead of " + prefix + expectedValueList.get(i));
            }
        }
        reportErrors();
    }


    /**
     * Description: Validate text of an element is contains the value
     *
     * @param label         - the debug id of the element that has the text that you want to compare to
     * @param expectedValue - the text that you want to compare
     * @param params        - adding to debugs id
     */
    @Then("^UI Text of \"([^\"]*)\"(?: with extension \"(.*)\")? contains \"([^\"]*)\"$")
    public void uiTextContains(String label, String params, String expectedValue) {
        String actualValue = null;
        try {
            actualValue = BasicOperationsHandler.getItemValue(label, params);
        } catch (TargetWebElementNotFoundException e) {
            e.printStackTrace();
        }
        assert actualValue != null;
        if (!actualValue.contains(expectedValue)) {
            ReportsUtils.reportAndTakeScreenShot(String.join(" : ", "The actual value of " + label + "-" + params, " is " + actualValue + " but not contains " + expectedValue), Reporter.FAIL);
        }
    }

    /**
     * @param subTab   - sub menu to select
     * @param negative - option negative testing
     */
    @When("^UI Open \"([^\"]*)\" Sub Tab( negative)?$")
    public void uiOpenSubTab(String subTab, String negative) {
        if (negative != null)
            WebUIUtils.setIsTriggerPopupSearchEvent(false);
        BasicOperationsHandler.openSubTab(subTab);
    }

    @Then("^UI Item with label \"([^\"]*)\" and value \"([^\"]*)\" is selected \"([^\"]*)\"$")
    public void uiItemWithLabelAndValueIsSelected(String label, String params, boolean expected) {

        boolean isSelected = BasicOperationsHandler.isItemSelectedByClass(label, params);
        if (!ComparableUtils.equals(isSelected, expected)) {
            String errorMessage = String.format("Item with name : %s Does not match the expected result : %s", String.join(".", label, params), String.valueOf(expected));
            BaseTestUtils.report(errorMessage, Reporter.FAIL);
        }
    }

    /**
     * validate each attribute of a web element
     *
     * @param label                 - web element label
     * @param elementAttributesList - attribute list to validate
     */
    @Then("^UI Validate element \"([^\"]*)\" attribute(?: with param \"(.*)\")?$")
    public void validateElementAttributes(String label, String params, List<ElementAttribute> elementAttributesList) {
        Objects.requireNonNull(elementAttributesList, "Element's attribute is empty");
//        to keep looking for all attributes of the web element.
        boolean status = true;

        StringBuilder failureMessage = new StringBuilder();
        VisionDebugIdsManager.setLabel(label);
        if (params != null)
            VisionDebugIdsManager.setParams(params);
//        WebElement element = WebUIVisionBasePage.getCurrentPage().getContainer().getWidget("").getWebElement();
        WebElement element = WebUIUtils.fluentWaitClick(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (element == null) {
            BaseTestUtils.report("Could not find element with label: " + label, Reporter.FAIL);
            return;
        }
        for (ElementAttribute attribute : elementAttributesList) {
            String value;
            try {
                value = element.getAttribute(attribute.name);
            } catch (Exception e) {
                element = WebUIUtils.fluentWaitClick(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                value = element.getAttribute(attribute.name);
            }

            if (value == null) {
                BaseTestUtils.report((failureMessage.append("Could not find attribute: ").append(attribute.name).append("\n")).toString(), Reporter.FAIL);
                return;
            }
            if (!value.contains(attribute.value)) {
                failureMessage.append(String.format("Attribute %s: Expected: %s. Actual: %s", attribute.name, attribute.value, value)).append("\n");
                status = false;
            }
        }
        if (!status)
            BaseTestUtils.report(failureMessage.toString(), Reporter.FAIL);
    }

    /**
     * Delete line at views
     *
     * @param params          - the adding value to the label
     * @param approveOrCancel - approve or cancel, delete button's id's
     */
    @When("^UI Delete \"([^\"]*)\"(?: and (Approve|Cancel))?$")
    public void deleteView(String params, String approveOrCancel) {
        BasicOperationsHandler.deleteView(params, approveOrCancel);
    }

    @When("^UI validate Browser Tab Existence by URL \"([^\"]*)\"$")
    public void validateBrowserTabExistence(String url) {
        if (BasicOperationsHandler.validateBrowserTabExistence(url)) {
            BaseTestUtils.report("found tab with URL: " + url, Reporter.PASS);
        } else {
            BaseTestUtils.report("Failed to validate Browser Tab Existence with URL: " + url, Reporter.FAIL);
        }
    }

    @Then("^Browser Refresh Page$")
    public void refreshPage() {
        WebUIUtils.getDriver().navigate().refresh();
    }

    @Then("^UI Table Validate Value Existence in Table \"(.*)\" with Column Name \"(.*)\" and Value \"(.*)\" if Exists \"(true|false)\"$")
    public void uiValidateElementWithLabelIsNotExist(String label, String columnName, String value, String existence) throws Throwable {
        tableHandler.validateValueExistenceAtTableByColumn(label, columnName, value, Boolean.valueOf(existence));
    }

    @Then("^UI Click Button \"([^\"]*)\"(?: with value \"([^\"]*)\")? Under Parent \"([^\"]*)\"(?: with value \"([^\"]*)\")?$")
    public void uiClickButtonWithValueUnderParentWithValue(String label, String params, String parentLabel, String parentParams) throws Throwable {
        String[] a = new String[1];
        String[] b = new String[1];
        a[0] = params;
        b[0] = parentParams;
        BasicOperationsHandler.clickChildButton(label, a, parentLabel, b);
    }

    @Then("^UI Click SVG Element \"([^\"]*)\"(?: with Params \"([^\"]*)\")?$")
    public void uiClickSVGElementWithParams(String label, String params) {
        String[] paramsValues;
        if (params != null) paramsValues = params.split(",");
        else paramsValues = null;

        try {
            BasicOperationsHandler.clickSvgElement(label, paramsValues);
        } catch (TargetWebElementNotFoundException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }

    @And("^UI Click Button by Attribute: \"([^\"]*)\" and value: \"([^\"]*)\"( negative)?$")
    public void uiClickButtonByAttribute(String attribute, String value, String negative) {
        WebUIUtils.fluentWait(ComponentLocatorFactory.getCssLocatorByAttribute(attribute, value).getBy()).click();
    }

    @When("^UI set \"([^\"]*)\" switch button to \"([^\"]*)\"$")
    public void clickOnSwitchButton(String label, String state) throws TargetWebElementNotFoundException {
        ClickOperationsHandler.clickOnSwitchButton(label, null, state);
    }

    static class DataServer {
        String name;
        String device;
        String policy;

        @Override
        public String toString() {
            return this.name + "," + this.device + "," + this.policy;
        }
    }


    private class ElementAttribute {
        String name;
        String value;
    }
}






