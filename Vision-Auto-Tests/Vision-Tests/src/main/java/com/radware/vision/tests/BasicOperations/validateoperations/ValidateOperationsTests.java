package com.radware.vision.tests.BasicOperations.validateoperations;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIRadioGroup;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.infra.enums.FindByType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsByNameIdHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 6/30/2015.
 */
public class ValidateOperationsTests extends WebUITestBase {
    String elementId;
    String expectedText;
    String expectedDropdownTextOption;
    boolean expectedCheckboxSelection = false;
    boolean expectedRadioStatus = false;
    int radioSelectionIndex;
    String xmlFileName;
    String deviceIp;
    boolean isWebElementStatusEnabled = true;
    OperatorsEnum validationType = OperatorsEnum.EQUALS;
    int cutCharsNumber = 0;
    String offset = null;
    int expectedRecordsNumber;
    String columnKey;
    String columnValue;
    FindByType findByType = FindByType.BY_ID;
    BasicOperationsByNameIdHandler basicOperationsByNameIdHandler = new BasicOperationsByNameIdHandler();


    @Test
    @TestProperties(name = "validate Text Field Element", paramsInclude = {"elementId", "expectedText", "validationType", "cutCharsNumber"})
    public void validateTextFieldElement() {
        ClickOperationsHandler.validateTextFieldElementById(elementId, expectedText, validationType, cutCharsNumber,offset);
    }

    @Test
    @TestProperties(name = "validate Element's Tooltip", paramsInclude = {"elementId", "expectedText"})
    public void validateTooltipElement() {
        try {
            String actualText = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).getAttribute("title");
            if (!actualText.equals(expectedText)) {
                report.report("Tooltip Validation Failed. Expected Tooltip Text is: " + expectedText + " Actual Tooltip Text is:" + actualText, Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Failed to get the Text from element with ID: " + elementId + " it may not be visible", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate WebElement Enabled/Disabled Status", paramsInclude = {"elementId", "isWebElementStatusEnabled"})
    public void validateWebElementStatus() {
        try {
            WebElement element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            if (!((element.getAttribute("readonly") == null && isWebElementStatusEnabled) || (element.getAttribute("readonly") != null && !isWebElementStatusEnabled))) {
                report.report("WebElement status Validation is Failed. Expected status is: Enabled =  " + isWebElementStatusEnabled + " Actual status is: enabled = " + element.isEnabled(), Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Failed to get the Text from element with ID: " + elementId + " it may not be visible", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate Dropdown Selected Text Option", paramsInclude = {"elementId", "expectedDropdownTextOption"})
    public void validateDropdownSelectedOption() {
        try {
            String actualSelectedTextOption = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).getAttribute("value");
            if (!actualSelectedTextOption.equals(expectedDropdownTextOption)) {
                report.report("DropDown Selection Validation Failed.\n Expected Text is: " + expectedDropdownTextOption + "\n Actual Text is:" + actualSelectedTextOption, Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Failed to validate Dropdown selection : " + expectedDropdownTextOption + " from element: " + elementId + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate Checkbox Selection", paramsInclude = {"elementId", "expectedCheckboxSelection"})
    public void validateCheckboxSelection() {
        try {
            WebElement element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            if (element != null) {
                ComponentLocator locator = new ComponentLocator(How.ID, elementId);
                WebUICheckbox checkbox = new WebUICheckbox(locator);
                checkbox.setWebElement(element);
                if (!((checkbox.isChecked() && expectedCheckboxSelection) || (!checkbox.isChecked() && !expectedCheckboxSelection))) {
                    report.report("CheckBox Validation Failed. \n Expected status is checked = : " + expectedDropdownTextOption + "\n Actual status is: checked = " + checkbox.isChecked(), Reporter.FAIL);
                }
            }
        } catch (Exception e) {
            report.report("Failed to validate CheckBox status: " + expectedCheckboxSelection + " from element: " + elementId + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate Radio Button", paramsInclude = {"elementId", "expectedRadioStatus"})
    public void validateRadioButton() {
        try {
            WebElement element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            if (element != null) {
                WebUIRadioGroup radio = new WebUIRadioGroup(new ComponentLocator(How.ID, elementId));
                radio.setWebElement(element);
                if (!((radio.isSelected() && expectedRadioStatus) || (!radio.isSelected() && !expectedRadioStatus))) {
                    report.report("Radio button Validation Failed. \n Expected status is : " + expectedRadioStatus + "\n Actual status is: " + radio.isSelected(), Reporter.FAIL);
                }
            }
        } catch (Exception e) {
            report.report("Failed to validate Radio button status: " + expectedRadioStatus + " from element: " + elementId + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Validate Table RecordsNumber with Identical Column Value", paramsInclude = {"expectedRecordsNumber", "columnKey", "columnValue",
            "deviceDriverType", "elementId", "findByType"})
    public void validateTableRecordsNumberWithIdenticalColumnValue() {
        try {
            int actualRowAmount = basicOperationsByNameIdHandler.getRowsAmountByKeyValue(getDeviceDriverType().getDDType(), elementId, columnKey, columnValue , findByType);
            if(actualRowAmount != expectedRecordsNumber){
                report.report("Records number by KeyValue validation has Failed : actualRowAmount = " + actualRowAmount + " expectedRecordsNumber: " + expectedRecordsNumber, Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Records number by KeyValue validation has Failed : ", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Validate Table RecordsNumber per Page", paramsInclude = {"expectedRecordsNumber", "deviceDriverType", "elementId", "findByType"})
    public void validateTableRecordsNumberPerPage() {
        try {
            int actualRowAmount = basicOperationsByNameIdHandler.getRowsAmountPerPage(getDeviceDriverType().getDDType(), elementId, findByType);
            if(actualRowAmount != expectedRecordsNumber){
                report.report("Records number by KeyValue validation has Failed : actualRowAmount = " + actualRowAmount + " expectedRecordsNumber: " + expectedRecordsNumber, Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Records number by KeyValue validation has Failed : ", Reporter.FAIL);
        }
    }

    public boolean getWebElementStatusEnabled() {
        return isWebElementStatusEnabled;
    }

    @ParameterProperties(description = "Please, choose Expected status!")
    public void setIsWebElementStatusEnabled(boolean isWebElementStatusEnabled) {
        this.isWebElementStatusEnabled = isWebElementStatusEnabled;
    }

    public String getDeviceIp() {
        return deviceIp;
    }

    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }

    public String getRadioSelectionIndex() {
        return String.valueOf(radioSelectionIndex);
    }

    @ParameterProperties(description = "Please, choose Expected status!")
    public void setRadioSelectionIndex(String radioSelectionIndex) {
        if(radioSelectionIndex != null) {
            this.radioSelectionIndex = Integer.valueOf(StringUtils.fixNumeric(radioSelectionIndex));
        }
    }

    public boolean isExpectedRadioStatus() {
        return expectedRadioStatus;
    }

    public void setExpectedRadioStatus(boolean expectedRadioStatus) {
        this.expectedRadioStatus = expectedRadioStatus;
    }

    public String getExpectedDropdownTextOption() {
        return expectedDropdownTextOption;
    }

    public void setExpectedDropdownTextOption(String expectedDropdownTextOption) {
        this.expectedDropdownTextOption = expectedDropdownTextOption;
    }

    public String getElementId() {
        return elementId;
    }

    @ParameterProperties(description = "Please, provide the elementID of the WebElement you want to use!")
    public void setElementId(String elementId) {
        this.elementId = elementId;
    }

    public String getExpectedText() {
        return expectedText;
    }
    @ParameterProperties(description = "Please, provide texts to look for separated by <|>!")
    public void setExpectedText(String expectedText) {
        this.expectedText = expectedText;
    }

    public OperatorsEnum getValidationType() {
        return validationType;
    }

    public void setValidationType(OperatorsEnum validationType) {
        this.validationType = validationType;
    }

    public String getCutCharsNumber() {
        return String.valueOf(cutCharsNumber);
    }
    @ParameterProperties(description = "Please, provide a Number(of characters) to cut your Text by!")
    public void setCutCharsNumber(String cutCharsNumber) {
        if(cutCharsNumber != null) {
            this.cutCharsNumber = Integer.valueOf(StringUtils.fixNumeric(cutCharsNumber));
        }
    }

    public boolean getExpectedCheckboxSelection() {
        return expectedCheckboxSelection;
    }

    public void setExpectedCheckboxSelection(boolean expectedCheckboxSelection) {
        this.expectedCheckboxSelection = expectedCheckboxSelection;
    }

    public String getColumnValue() {
        return columnValue;
    }

    public void setColumnValue(String columnValue) {
        this.columnValue = columnValue;
    }

    public String getColumnKey() {
        return columnKey;
    }

    public void setColumnKey(String columnKey) {
        this.columnKey = columnKey;
    }

    public String getExpectedRecordsNumber() {
        return String.valueOf(expectedRecordsNumber);
    }
    @ParameterProperties(description = "Please, provide a number of records to hold a specific value!")
    public void setExpectedRecordsNumber(String expectedRecordsNumber) {
        if(expectedRecordsNumber != null) {
            this.expectedRecordsNumber = Integer.valueOf(StringUtils.fixNumeric(expectedRecordsNumber));
        }
    }

    public FindByType getFindByType() {
        return findByType;
    }

    public void setFindByType(FindByType findByType) {
        this.findByType = findByType;
    }
}
