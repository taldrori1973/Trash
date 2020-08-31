package com.radware.vision.infra.testhandlers.baseoperations.clickoperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.api.DualList;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.automation.webui.widgets.impl.WebUIDualList;
import com.radware.automation.webui.widgets.impl.WebUIDualListScripts;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.DualListSides;
import com.radware.vision.infra.enums.VisionTableIDs;
import com.radware.vision.infra.enums.WebElementType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.utils.GeneralUtils;
import com.radware.vision.infra.utils.ReportsUtils;
import jsystem.framework.RunProperties;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static java.util.Objects.nonNull;
import static org.apache.commons.lang3.math.NumberUtils.isParsable;

/**
 * Created by AviH on 03-Dec-17.
 */

public class ClickOperationsHandler {


    public static void clickWebElement(ComponentLocator locator, boolean closeYellowMessage) {
        if (closeYellowMessage) {
            WebUIBasePage.closeYellowMessage();
        }
        WebElement result = WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (result == null) {
            ReportsUtils.reportAndTakeScreenShot("Could not click on element with locator " + locator.getLocatorValue(), Reporter.FAIL);
        }
    }

    public static void clickWebElement(ComponentLocator locator) {
        clickWebElement(locator, true);
    }

    public static String getTextFromElement(String xpath) {
        return WebUIUtils.fluentWaitGetText(new ComponentLocator(How.XPATH, xpath).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
    }

    public static void clickWebElement(WebElement element) {

        WebUIBasePage.closeYellowMessage();
        WebUIUtils.setIsTriggerPopupSearchEvent(true);
        element.click();

    }

    public static void clickWebElement(String xpath) {

        WebUIBasePage.closeYellowMessage();
        WebUIUtils.setIsTriggerPopupSearchEvent(true);
        ComponentLocator locator = new ComponentLocator(How.XPATH, xpath);

        WebElement element = WebUIUtils.fluentWaitDisplayedEnabled(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (element == null) {
            WebUIUtils.generateAndReportScreeshort();
            BaseTestUtils.report("Element not found | Element is not Displayed | Element is not Enabled" + locator.getLocatorValue(), Reporter.FAIL);
            WebUIUtils.generateAndReportScreenshot();
            return;
        } else {
            WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        }
    }

    public static void clickWebElement(WebElementType elementType, String elementId, int waitBeforeAutoPopupClose) {
        WebUIBasePage.closeYellowMessage();
        WebUIUtils.setIsTriggerPopupSearchEvent(false);
        setWebListenerProperty(waitBeforeAutoPopupClose);
        ComponentLocator locator;
        if (elementType == WebElementType.XPATH) {
            locator = new ComponentLocator(How.XPATH, elementId);

        } else {
            locator = new ComponentLocator(How.XPATH, ".//*[@" + elementType.getAttributeValue() + "='" + elementId + "']");
        }

        WebElement element = WebUIUtils.fluentWaitDisplayedEnabled(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (element == null) {
            WebUIUtils.generateAndReportScreeshort();
            BaseTestUtils.report("Element not found | Element is not Displayed | Element is not Enabled" + locator.getLocatorValue(), Reporter.FAIL);
            WebUIUtils.generateAndReportScreenshot();
            return;
        } else {
            WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        }
    }

    public static void setTextToElement(String xpath, String inputText, boolean enterKey, boolean hardDelete) {

        WebUIUtils.setIsTriggerPopupSearchEvent(true);

        ComponentLocator locator = new ComponentLocator(How.XPATH, xpath);
        WebElement foundElement = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (hardDelete) {
            foundElement.sendKeys(Keys.CONTROL, "a", Keys.DELETE);
        } else {
            foundElement.clear();
        }
        foundElement.sendKeys(inputText);
        if (enterKey) {
            foundElement.sendKeys(Keys.ENTER);
        }

    }

    public static void setTextToElement(WebElementType elementType, String elementId, String inputText, boolean enterKey) {
        try {
            if (RunProperties.getInstance().getRunProperties().containsKey(inputText)) {
                inputText = RunProperties.getInstance().getRunProperties().getProperty(inputText);
            }
            WebUIUtils.setIsTriggerPopupSearchEvent(true);
            switch (elementType) {
                case Id:
                    WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).clear();
                    WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).sendKeys(inputText);
                    if (enterKey) {
                        WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).sendKeys(Keys.ENTER);
                    }
                    break;
                case Class:
                    String xpathLocator = "//*[contains(@class,'" + elementId + "')]";
                    ComponentLocator elementLocation = new ComponentLocator(How.XPATH, xpathLocator);
                    WebUIUtils.fluentWaitDisplayed(elementLocation.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).clear();
                    WebUIUtils.fluentWaitDisplayed(elementLocation.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).sendKeys(inputText);
                    if (enterKey) {
                        WebUIUtils.fluentWaitDisplayed(elementLocation.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).sendKeys(Keys.ENTER);
                    }
                    break;
                case Data_Debug_Id:
                    String xpathValue = ".//*[@data-debug-id='" + elementId + "']";
                    elementLocation = new ComponentLocator(How.XPATH, xpathValue);
                    WebUIUtils.fluentWaitSendText(inputText, elementLocation.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                    break;
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to set text type: " + elementType + ", Attribute Name: " + elementId, Reporter.FAIL);
        }
    }

    public static void validateTextFieldElementByLabel(String elementSelector, String params, String expectedText, String regex, OperatorsEnum validationType, int cutCharsNumber) {
        try {
            WebElement element = BasicOperationsHandler.isItemAvailableById(elementSelector, params);
            validateTextField(element, elementSelector, expectedText, regex, validationType, cutCharsNumber);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get the Text from element with ID: " + elementSelector + " it may not be visible", Reporter.FAIL);
        }
    }

    public static ValidateText validateTextFieldElementByLabelWithoutReporting(String elementSelector, String params, String expectedText, OperatorsEnum validationType, String cutCharsNumber) {
        cutCharsNumber = cutCharsNumber == null ? "0" : cutCharsNumber;
        int cutCharsNumberInt = Integer.valueOf(cutCharsNumber);
        WebElement element = BasicOperationsHandler.isItemAvailableById(elementSelector, params);
        return validateTextFieldWithoutReporting(element, elementSelector, expectedText, validationType, cutCharsNumberInt);

    }

    public static void validateTextFieldElementById(String elementSelector, String expectedText, OperatorsEnum validationType, int cutCharsNumber) {
        try {
            WebElement element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementSelector).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            validateTextField(element, elementSelector, expectedText, null, validationType, cutCharsNumber);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get the Text from element with ID: " + elementSelector + " it may not be visible", Reporter.FAIL);
        }
    }

    public static void validateTextFieldElementByClass(String elementSelector, String expectedText, OperatorsEnum validationType, int cutCharsNumber) {
        try {
//            WebElement element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.CLASS_NAME, elementSelector).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            WebElement element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.XPATH, "//*[@class='" + elementSelector + "']").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            validateTextField(element, elementSelector, expectedText, null, validationType, cutCharsNumber);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get the Text from element with Class: " + elementSelector + " it may not be visible", Reporter.FAIL);
        }
    }

    public static void validateTextField(WebElement element, String elementSelector, String expectedValue, String regex, OperatorsEnum validationOperation, int cutCharsNumber) {
        try {
//            The expectedValue for Contains Operation could be on the following format: value|value|...|value,
//            if the actual value contains one of these values , the test will pass:
            List<String> expectedTextList = expectedValue != null ? Arrays.asList(expectedValue.split("\\|")) : null;

//            TODO this line is duplicated by another methods -> should be packed as a method
            String actualValue = element.getAttribute("value");//get the actual value from the UI Element


            boolean contains = false;
//            if the element value attribute returns null or EMPTY , try to get the actual from getText()
            if (actualValue == null || actualValue.equals("")) {
                actualValue = element.getText();
            }


            String finalExpectedValue = "";
//            remove new line chars
            finalExpectedValue = nonNull(expectedValue) && (expectedValue.contains("\n") && expectedValue.lastIndexOf("\n") == expectedValue.length() - 1) ? expectedValue.substring(0, expectedValue.lastIndexOf("\n")) : expectedValue;

//            if regex is defined: the operation will work on the regex Group1
//            for example if the regex value is: "Total Packets: (\d+)" actual value is "Total Packets: 2,903"
//            we need to check if the actual value is GTE expected value.
//            in this case regex matching Group(1) will return "2,903" and this is our new actual value that will be compared with the expected value let's say 2900
            if (nonNull(regex)) {
                Pattern pattern = Pattern.compile(regex);
                Matcher matcher = pattern.matcher(actualValue);
                if (matcher.matches()) {//if the regex not matches the actual value , then no need to continue
                    actualValue = matcher.group(1);
                } else BaseTestUtils.report(
                        String.format("The Regex provided is not matches the actual value.\nRegex: \"%s\"\nActual Value: \"%s\"", regex, actualValue),
                        Reporter.FAIL);

            }

            /*
            Now we have 3 parameters for test:
            1. expectedTextList : for Contains Operation
            2. finalExpectedValue
            3. actualValue
             */
            if ((validationOperation.equals(OperatorsEnum.CONTAINS) && nonNull(expectedTextList)) ||
                    (!validationOperation.equals(OperatorsEnum.CONTAINS) && nonNull(finalExpectedValue) && nonNull(actualValue))) {
                switch (validationOperation) {
                    case CONTAINS:
                        for (String expectedText : expectedTextList) {
                            if (actualValue.contains(expectedText.substring(0, expectedText.length() - cutCharsNumber))) {
                                contains = true;
                                break;
                            }
                        }
                        if (expectedTextList.isEmpty())
                            contains = true;//if the array of expected values is empty . the test pass
                        if (!contains) {
                            BaseTestUtils.report("TextField Validation Failed. Expected Text is:" + expectedTextList + " Actual Text is:" + actualValue, Reporter.FAIL);
                        }
                        break;
                    case EQUALS:
                        if (isParsable(finalExpectedValue) && isParsable(actualValue)) {//if the both values is number then compare numbers
                            if (Double.parseDouble(finalExpectedValue) != Double.parseDouble(actualValue)) {
                                BaseTestUtils.report("TextField Validation Failed. Expected Value is:" + Double.parseDouble(finalExpectedValue) + " Actual Value is:" + Double.parseDouble(actualValue), Reporter.FAIL);
                            }
                        } else {//compare strings
                            if (!finalExpectedValue.equals(actualValue)) {
                                BaseTestUtils.report("TextField Validation Failed. Expected Text is:" + expectedValue + " Actual Text is:" + actualValue, Reporter.FAIL);
                            }
                        }
                        break;
                    case MatchRegex:
                        if (!actualValue.matches(expectedValue)) {
                            BaseTestUtils.report("TextField Validation Failed. Expected Text is:" + expectedValue + " Actual Text is:" + actualValue, Reporter.FAIL);
                        }
                        break;
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get the Text from element with selector: " + elementSelector + " it may not be visible", Reporter.FAIL);
        }
    }

    public static ValidateText validateTextFieldWithoutReporting(WebElement element, String elementSelector, String expectedText, OperatorsEnum validationType, int cutCharsNumber) {
        List<String> expectedTextList = expectedText != null ? Arrays.asList(expectedText.split("\\|")) : Arrays.asList("".split("\\|"));
        String actualText = element.getAttribute("value");
        boolean contains = false;
        if (actualText == null || actualText.equals("")) {
            actualText = element.getText();
        }
        String finalExpectedText = "";
        finalExpectedText = (expectedText.contains("\n") && expectedText.lastIndexOf("\n") == expectedText.length() - 1) ? expectedText.substring(0, expectedText.lastIndexOf("\n")) : expectedText;

        if (!(expectedText == null && actualText.equals(""))) {
            switch (validationType) {
                case CONTAINS:
                    for (int i = 0; i < expectedTextList.size(); i++) {
                        if (actualText.contains(expectedTextList.get(i).substring(0, expectedTextList.get(i).length() - cutCharsNumber))) {
                            contains = true;
                        }
                    }
                    if (!contains) return new ValidateText(false, actualText);
                case EQUALS:
                    if (!finalExpectedText.equals(actualText))
                        return new ValidateText(false, actualText);
                    ;
            }
        }
        return new ValidateText(true, actualText);
    }


    public static class ValidateText {
        public boolean isExpected;
        public String actualText;

        ValidateText() {
        }

        ValidateText(boolean isExpected, String actualText) {
            this.isExpected = isExpected;
            this.actualText = actualText;
        }
    }

    public static void selectItemFromDropdown(String elementId, String dropdownOptionText, String deviceDriverId) {
        try {
            if (!checkIfElementExistAndDisplayed(GeneralUtils.buildGenericXpath(WebElementType.Id, elementId, OperatorsEnum.EQUALS))) {
                throw new Exception("Element not found");
            }
            WebElement element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            WebUIBasePage webUIBasePage = new WebUIBasePage();
            webUIBasePage.setCurrentContainer(deviceDriverId, true);
            if (element != null) {
                WebUIDropdown dropdown = new WebUIDropdown();
                dropdown.setWebElement(element);
                dropdown.setLocator(new ComponentLocator(How.ID, elementId));
                dropdown.selectOptionByText(dropdownOptionText);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to select item: " + dropdownOptionText + " from element: " + elementId, Reporter.FAIL);
        }
    }

    public static boolean checkIfElementExistAndDisplayed(WebElementType webElementType, String value, OperatorsEnum operatorsEnum) {

        ComponentLocator locator = new ComponentLocator(How.XPATH, GeneralUtils.buildGenericXpath(webElementType, value, operatorsEnum));

        WebElement webElement = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (webElement != null) {
            return true;
        } else {
            return false;
        }

    }

    public static void executeVisionTableOperation(String commonTableAction, String tableLabel) {
        executeVisionTableOperation(commonTableAction, tableLabel, true);
    }

    public static void executeVisionTableOperation(String commonTableAction, String tableLabel, boolean isPopupSearch) {
        Boolean isExists = false;
        String visionTableID = VisionTableIDs.getByLabel(tableLabel).getVisionTableID();
        try {
            if (!visionTableID.equals("") && visionTableID != null) {
                WebUIUtils.isTriggerPopupSearchEvent4FreeTest = isPopupSearch;
                ComponentLocator locator = new ComponentLocator(How.ID, "gwt-debug-".concat(visionTableID).concat(commonTableAction));
                WebElement target = WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                isExists = target == null ? false : true;
                if (!isExists) {
                    BaseTestUtils.report("Requested operation was executed, while should not exist: " + commonTableAction, Reporter.FAIL);
                } else {
                    BaseTestUtils.report("Requested operation was executed successfully: " + commonTableAction, Reporter.PASS);
                }

            } else {
                BaseTestUtils.report("Incorrect ID is provided : " + "gwt-debug-".concat(visionTableID).concat(commonTableAction), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the specified table : " + "gwt-debug-".concat(visionTableID).concat(commonTableAction), Reporter.FAIL);
        } finally {
            WebUIUtils.isTriggerPopupSearchEvent4FreeTest = true;
        }
    }

    public static boolean checkIfElementExistAndDisplayed(String xpathElementValue) {

        WebElement webElement = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.XPATH, xpathElementValue).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (webElement != null) {
            return true;
        } else {
            return false;
        }
    }

    public static boolean checkIfElementExists(ComponentLocator locator) {

        WebElement webElement = WebUIUtils.fluentWait(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (webElement == null) return false;
        else return true;
    }

    public static boolean checkIfElementExists(String xpath) {

        WebElement webElement = WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, xpath).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (webElement == null) return false;
        else return true;
    }

    public static boolean checkIfElementExists(WebElementType elementType, String elementId, OperatorsEnum operatorsEnum) {

        ComponentLocator locator = new ComponentLocator(How.XPATH, GeneralUtils.buildGenericXpath(elementType, elementId, operatorsEnum));
        WebElement element = WebUIUtils.fluentWait(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (element == null) return false;
        else return true;
    }

    public static void validateElementEnableDisableStatusByLabel(String label, String value, Boolean expectedIsEnabled) {
        VisionDebugIdsManager.setLabel(label);
        if (value != null) VisionDebugIdsManager.setParams(value);
        ComponentLocator locator = ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
        Boolean actualIsEnabled = WebUIUtils.isItemEnabled(locator);
        if (actualIsEnabled != expectedIsEnabled) {
            BaseTestUtils.report("Validation Failure : actualIsEnabledStatus is:" + actualIsEnabled + " expectedIsEnabledStatus: " + expectedIsEnabled, Reporter.FAIL);
        } else {
            BaseTestUtils.report("Validation is successful. actualIsEnabledStatus is:" + actualIsEnabled + " expectedIsEnabledStatus: " + expectedIsEnabled, Reporter.PASS);
        }
    }


    public static void validateElementExistenceByLabel(String label, Boolean isExists) {
        VisionDebugIdsManager.setLabel(label);
        ComponentLocator locator = ComponentLocatorFactory.getLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
        WebElement webElement = WebUIUtils.fluentWait(locator.getBy());
        Boolean actualExists = webElement != null ? true : false;

        if (actualExists != isExists) {
            BaseTestUtils.report("Validation Failure : actualExistsStatus is:" + actualExists + " expectedExistsStatus: " + isExists, Reporter.FAIL);
        } else {
            BaseTestUtils.report("Validation is successful. actualExistsStatus is:" + actualExists + " expectedExistsStatus: " + isExists, Reporter.PASS);
        }
    }

    public static boolean checkIfElementAttributeContains(ComponentLocator locator, String attribute, String value) {

        String attributeValue = WebUIUtils.fluentWaitAttribute(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false, attribute, null);
        if (attributeValue == null) return false;
        return attributeValue.contains(value) ? true : false;
    }

    public static boolean checkIfElementAttributeContains(WebElement element, String attribute, String value) {

        return element.getAttribute(attribute).contains(value) ? true : false;
    }

    public static void setWebListenerProperty(int waitBeforeAutoPopupClose) {
        if (WebUIDriver.getListenerManager().getWebUIDriverEventListener() != null) {
            try {
                WebUIDriver.getListenerManager().getWebUIDriverEventListener().setWaitBeforeEventOperation(Long.valueOf(waitBeforeAutoPopupClose * 1000));
            } catch (Exception e) {
//                Ignore
            }
        }
    }

    public static void moveScriptDualListItems(DualListSides dualListSide, String dualListItems, String dualListID) {
        try {
            ComponentLocator dualListLocator = new ComponentLocator(How.ID, dualListID);
            WebUIDualListScripts dualList = new WebUIDualListScripts(new WebUIComponent(dualListLocator));
            ClickOperationsHandler.moveItems(dualListSide, dualListItems, dualListID, dualList);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void moveDualListItems(DualListSides dualListSide, String dualListItems, String dualListID) {
        try {
            ComponentLocator dualListLocator = new ComponentLocator(How.ID, dualListID);
            WebUIDualList dualList = new WebUIDualList(new WebUIComponent(dualListLocator));
            moveItems(dualListSide, dualListItems, dualListID, dualList);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void moveItems(DualListSides dualListSide, String dualListItems, String dualListID, DualList dualList) {
        try {
            if (dualList.getWebElement() == null) {
                throw new Exception("Dual list not found");
            }
            List<String> itemsToMoveList = new ArrayList<String>();
            if (dualListItems != null) {
                itemsToMoveList = Arrays.asList(dualListItems.split(","));
            }
            if (dualListSide.equals(DualListSides.LEFT)) {
                for (String item : itemsToMoveList) {
                    dualList.setRawId(dualListID.replace("gwt-debug-", ""));
                    dualList.moveLeft(item);
                }
            } else if (dualListSide.equals(DualListSides.RIGHT)) {
                for (String item : itemsToMoveList) {
                    dualList.setRawId(dualListID.replace("gwt-debug-", ""));
                    dualList.moveRight(item);
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void validateElementTooltipValue(String elementLabel, String extension, String expectedTooltipValue) {
        VisionDebugIdsManager.setLabel(elementLabel);
        VisionDebugIdsManager.setParams(extension);
        ComponentLocator elementLocator = ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
        String actualTooltipValue = WebUIUtils.getTooltipContent(elementLocator, null);
        if (actualTooltipValue == null) {
            BaseTestUtils.report(elementLabel + " element not found, or there is no tooltip.", Reporter.FAIL);
        }
        if (!expectedTooltipValue.equals(actualTooltipValue)) {
            BaseTestUtils.report("Failed to validate Tooltip, Expected value: " + expectedTooltipValue + ", Actual value: " + actualTooltipValue, Reporter.FAIL);
        }
    }


    public static void clickOnSwitchButton(String label, String params, String state) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        if (state.equalsIgnoreCase("off")) {
            if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).getAttribute("aria-checked").equals("true")) {
                WebUIVisionBasePage.getCurrentPage().getContainer().getButton(label).click();
            }
        }

        if (state.equalsIgnoreCase("on")) {
            if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).getAttribute("aria-checked").equals("false")) {
                WebUIVisionBasePage.getCurrentPage().getContainer().getButton(label).click();
            }
        }
    }

}
