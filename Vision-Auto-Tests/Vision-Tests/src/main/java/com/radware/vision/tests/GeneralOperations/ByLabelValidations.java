package com.radware.vision.tests.GeneralOperations;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.events.PopupEventHandler;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.WebUIPage;
import com.radware.automation.webui.widgets.api.Widget;
import com.radware.automation.webui.widgets.impl.*;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.CheckboxStateEnum;
import com.radware.vision.infra.enums.FindByType;
import com.radware.vision.infra.enums.WebWidgetType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsByNameIdHandler;
import enums.NumberCheckOperationEnum;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.WebElement;
import com.radware.automation.tools.utils.StringUtils;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

/**
 * Created by aviH on 8/9/2015.
 */

public class ByLabelValidations extends WebUITestBase {

	WebWidgetType fieldType;
	String fieldLabel;
	String expectedValue;
	CheckboxStateEnum checkboxState;
    String rightList;
    String leftList;
	private String firstGlobalParamName;
	private String secondGlobalParamName;
	private String resultGlobalParamName;
	private String firstDateFormat;
	private String secondDateFormat;
	private NumberCheckOperationEnum paramCheckOperation;
	private long paramDiff;
	private long timeDiff;
	String rowKey = "Name";
	String rowValue;

	BasicOperationsByNameIdHandler basicOperationsByNameIdHandler = new BasicOperationsByNameIdHandler();

	@Test
	@TestProperties(name = "Validate Vision Field", paramsInclude = {"fieldType", "fieldLabel", "expectedValue", "checkboxState"})
	public void validateVisionField() {
		validateField(WebUIUtils.VISION_DEVICE_DRIVER_ID, fieldType, fieldLabel, expectedValue, checkboxState);
	}

	@Test
	@TestProperties(name = "Validate Device Field", paramsInclude = {"fieldType", "fieldLabel", "expectedValue", "checkboxState", "deviceName"})
	public void validateDeviceField() {
		validateField(WebUIUtils.selectedDeviceDriverId, fieldType, fieldLabel, expectedValue, checkboxState);
	}

	@Test
	@TestProperties(name = "Validate Popup Content", paramsInclude = {"expectedValue"})
	public void validatePopupContent() {
		try {
			if (restTestBase.getGlobalParamsMap().get(getPopupContentKey()) != null) {
				String actualContent = restTestBase.getGlobalParamsMap().get(getPopupContentKey());
				if (!actualContent.equals(expectedValue)) {
					report.report("Popup Validation Failed. Expected Content is: " + expectedValue + ", Actual Content is:" + actualContent, Reporter.FAIL);
				}
			} else {
				report.report("Failed to Validate Popup Content, it may not be visible", Reporter.FAIL);
			}
		} catch (Exception e) {
			report.report("Failed to Validate Popup Content, it may not be visible" + "\n" + parseExceptionBody(e), Reporter.FAIL);
		}finally {
			closePopupDialog();
		}
	}

	@Test
	@TestProperties(name = "Validate Popup Type", paramsInclude = {"expectedValue"})
	public void validatePopupType() {
		try {
			PopupEventHandler popupHandler = new PopupEventHandler();
			boolean need2ClosePopup = false;
			boolean isPopup = popupHandler.handle(need2ClosePopup);
			if (isPopup) {
				String actualType = WebUIPage.getPopup().getType().toString();
				if (!actualType.equals(expectedValue)) {
					report.report("Popup Validation Failed. Expected Type is: " + expectedValue + ", Actual Type is:" + actualType, Reporter.FAIL);
				}
			} else {
				report.report("Failed to Validate Popup Type, it may not be visible", Reporter.FAIL);
			}
		} catch (Exception e) {
			report.report("Failed to Validate Popup Type, it may not be visible" + "\n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

    @Test
    @TestProperties(name = "Validate DualList", paramsInclude = {"fieldLabel", "rightList", "leftList", "deviceName"})
    public void validateDualList() {
        boolean isValid = true;
        List<Widget> widgets = basicOperationsByNameIdHandler.findWidgetByNameId(WebUIUtils.VISION_DEVICE_DRIVER_ID, WebWidgetType.DualList, fieldLabel, FindByType.BY_NAME);
        if (widgets.isEmpty()) {
            report.report("Failed to find Field type: " + fieldType + " for Field label: " + fieldLabel + ", it may not be visible", Reporter.FAIL);
        }
        for (Widget widget : widgets) {
            WebUIDualList dualList = (WebUIDualList) widget;

            if (rightList != null && !rightList.toString().equals("")) {
                List<String> moveRightItems = Arrays.asList(rightList.split(","));
                for (String item : moveRightItems) {
                    if (!dualList.getRightItems().contains(item)) {
                        isValid = false;
                    }
                }
            }
            if (leftList != null && !leftList.toString().equals("")) {
                List<String> moveLeftItems = Arrays.asList(leftList.split(","));
                for (String item : moveLeftItems) {
                    if (!dualList.getLeftItems().contains(item)) {
                        isValid = false;
                    }
                }
            }
        }
        if (!isValid) {
            report.report("Failed to Validate Field type: " + fieldType + " for Field label: " + fieldLabel + ", it may not contain all listed items", Reporter.FAIL);
        }
    }

	private void validateField(String deviceDriverId, WebWidgetType fieldType, String fieldLabel, String expectedValue, CheckboxStateEnum checkboxState) {
		try {
			List<Widget> widgets = basicOperationsByNameIdHandler.findWidgetByNameId(deviceDriverId, fieldType, fieldLabel, FindByType.BY_NAME);
			if (widgets.isEmpty()) {
				report.report("Failed to get the Field type: " + fieldType + " for Field label: " +  fieldLabel + ", it may not be visible", Reporter.FAIL);
			}
			for (Widget widget : widgets) {
				WebElement webElement = WebUIUtils.fluentWaitDisplayed(widget.getLocator().getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
				if(webElement == null) {
					continue;
				}
				switch (fieldType) {
					case Text:
						String actualText = widget.getAttribute("value");
						if (!actualText.equals(expectedValue)) {
							report.report("TextField Validation Failed. Expected Text is: " + expectedValue + ", Actual Text is:" + actualText, Reporter.FAIL);
						}
						break;
					case Checkbox:
						WebUICheckbox checkbox = (WebUICheckbox)widget;
						boolean expectedSelection = checkboxState.equals(CheckboxStateEnum.Check) ? true : false;
						if (!((checkbox.isChecked() && expectedSelection) || (!checkbox.isChecked() && !expectedSelection))) {
							String actualSelection = checkbox.isChecked() ? "True" : "False";
							report.report("CheckBox Validation Failed. Expected status: " + expectedSelection + " Actual status is: " + actualSelection, Reporter.FAIL);
						}
						break;
					case Dropdown:
						WebUIDropdown dropdown = (WebUIDropdown)widget;
						dropdown.setWebElement(webElement);
						String actualDropdown = dropdown.getAttribute("value");
						if (!actualDropdown.equals(expectedValue)) {
							report.report("Dropdown Validation Failed. Expected Text is: " + expectedValue + ", Actual Text is:" + actualDropdown, Reporter.FAIL);
						}
						break;
					case RadioButton:
						WebUIRadioGroup radioGroup = (WebUIRadioGroup) widget;
						String actualValue = radioGroup.getValue();
						if (!actualValue.equals(expectedValue)) {
							report.report("RadioButton Validation Failed. Expected Text is: " + expectedValue + ", Actual Text is:" + actualValue, Reporter.FAIL);
						}
						break;
				}
			}
		} catch (Exception e) {
			report.report("Failed to get the Field type: " + fieldType + " for Field label: " +  fieldLabel + "\n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	@Test
	@TestProperties(name = "Joint Params", paramsInclude = {"firstGlobalParamName", "secondGlobalParamName", "resultGlobalParamName"})
	public void jointParams() throws Exception {
		try{
			String result = restTestBase.globalParamsMap.get(firstGlobalParamName) + restTestBase.globalParamsMap.get(secondGlobalParamName);
			restTestBase.globalParamsMap.put(resultGlobalParamName, result);
		} catch (Exception e) {
			report.report("Error in Joint Params " + e.getMessage(), Reporter.FAIL);
		}
	}

	@Test
	@TestProperties(name = "Param Checker", paramsInclude = {"qcTestId", "firstGlobalParamName", "secondGlobalParamName", "paramCheckOperation", "paramDiff"})
	public void paramChecker() throws Exception {
		try{
			String first = restTestBase.globalParamsMap.get(firstGlobalParamName);
			String second = restTestBase.globalParamsMap.get(secondGlobalParamName);
			switch (paramCheckOperation) {
				case EQ:
					if (!first.equals(second)) {
						String errMsg = String.format("Error in Param Checker, First: %s are NOT Equal to Second: %s",
								restTestBase.globalParamsMap.get(firstGlobalParamName), restTestBase.globalParamsMap.get(secondGlobalParamName));
						report.report(errMsg, Reporter.FAIL);
					}
					break;
			}

			long firstNum = Long.parseLong(first);
			long secondNum = Long.parseLong(second);
			switch (paramCheckOperation) {
				case GT:
					if (!(firstNum > secondNum)) {
						String errMsg = String.format("Error in Param Checker, First: %s are NOT Greater Than Second: %s",
								restTestBase.globalParamsMap.get(firstGlobalParamName), restTestBase.globalParamsMap.get(secondGlobalParamName));
						report.report(errMsg, Reporter.FAIL);
					}
					break;
				case LT:
					if (!(firstNum < secondNum)) {
						String errMsg = String.format("Error in Param Checker, First: %s are NOT Greater Than Second: %s",
								restTestBase.globalParamsMap.get(firstGlobalParamName), restTestBase.globalParamsMap.get(secondGlobalParamName));
						report.report(errMsg, Reporter.FAIL);
					}
					break;
				case Diff:
					if (Math.abs(firstNum - secondNum) > timeDiff) {
						String errMsg = String.format("Error in Param Checker, First No: %s are Different Than Second No: %s",
								restTestBase.globalParamsMap.get(firstGlobalParamName), restTestBase.globalParamsMap.get(secondGlobalParamName));
						report.report(errMsg, Reporter.FAIL);
					}
					break;
			}
		} catch (Exception e) {
			report.report("Error in Param Checker " + e.getMessage(), Reporter.FAIL);
		}
	}

	@Test
	@TestProperties(name = "Time Checker", paramsInclude = {"qcTestId", "firstGlobalParamName", "firstDateFormat", "secondGlobalParamName", "secondDateFormat", "paramCheckOperation", "timeDiff"})
	public void timeChecker() throws Exception {
		try{
			long firstTime = getDateInSecond(firstDateFormat, restTestBase.globalParamsMap.get(firstGlobalParamName));
			long secondTime = getDateInSecond(secondDateFormat, restTestBase.globalParamsMap.get(secondGlobalParamName));
			switch (paramCheckOperation) {
				case EQ:
					if (firstTime != secondTime) {
						String errMsg = String.format("Error in Time Checker, First Time: %s are NOT Equal to Second Time: %s",
								restTestBase.globalParamsMap.get(firstGlobalParamName), restTestBase.globalParamsMap.get(secondGlobalParamName));
						report.report(errMsg, Reporter.FAIL);
					}
					break;
				case GT:
					if (!(firstTime > secondTime)) {
						String errMsg = String.format("Error in Time Checker, First Time: %s are NOT Greater Than Second Time: %s",
								restTestBase.globalParamsMap.get(firstGlobalParamName), restTestBase.globalParamsMap.get(secondGlobalParamName));
						report.report(errMsg, Reporter.FAIL);
					}
					break;
				case LT:
					if (!(firstTime < secondTime)) {
						String errMsg = String.format("Error in Time Checker, First Time: %s are NOT Greater Than Second Time: %s",
								restTestBase.globalParamsMap.get(firstGlobalParamName), restTestBase.globalParamsMap.get(secondGlobalParamName));
						report.report(errMsg, Reporter.FAIL);
					}
					break;
				case Diff:
					if (Math.abs(firstTime - secondTime) > timeDiff) {
						String errMsg = String.format("Error in Time Checker, First Time: %s are Different Than Second Time: %s",
								restTestBase.globalParamsMap.get(firstGlobalParamName), restTestBase.globalParamsMap.get(secondGlobalParamName));
						report.report(errMsg, Reporter.FAIL);
					}
					break;
			}
		} catch (Exception e) {
			report.report("Error in Time Checker " + e.getMessage(), Reporter.FAIL);
		}
	}

	@Test
	@TestProperties(name = "validate Vision Table Record", paramsInclude = {"qcTestId", "fieldLabel", "rowKey", "rowValue"})
	public void validateVisionTableRecord() {
		if(!validateTableRecord(WebUIUtils.VISION_DEVICE_DRIVER_ID, fieldLabel, rowKey, rowValue)){
			report.report("No such record in this table: " + fieldLabel + ", it may not be visible", Reporter.FAIL);
		}
	}

	@Test
	@TestProperties(name = "validate Device Table Record", paramsInclude = {"qcTestId", "fieldLabel", "rowKey", "rowValue", "deviceName"})
	public void validateDeviceTableRecord() {
		if(!validateTableRecord(WebUIUtils.selectedDeviceDriverId, fieldLabel, rowKey, rowValue)){
			report.report("No such record in this table: " + fieldLabel + ", it may not be visible", Reporter.FAIL);
		}
	}

	public boolean validateTableRecord(String deviceDriverId, String fieldLabel, String rowKey, String rowValue) {
		int result = 0;
		try {
			List<Widget> widgets = basicOperationsByNameIdHandler.findWidgetByNameId(deviceDriverId, WebWidgetType.Table, fieldLabel, FindByType.BY_NAME);
			if (widgets.isEmpty()) {
				report.report("Failed to get Table for label: " + fieldLabel + ", it may not be visible", Reporter.FAIL);
			}
			outerloop:
			for (Widget widget : widgets) {
				if (widget == null || (widget != null && !widget.find(true, true))) {
					continue;
				}
				WebUITable table = (WebUITable) widget;
				result = table.getRowIndex(rowKey, rowValue);

			}
		} catch (Exception e) {
			report.report("Failed to get Table for label: " + fieldLabel + " \n" + parseExceptionBody(e), Reporter.FAIL);
		}
		if(result == -1) {
			return false;
		}
		else {
			return true;
		}
	}

	private long getDateInSecond(String dateFormat, String dateValue) {
		try {
			SimpleDateFormat format = new SimpleDateFormat(dateFormat);
			Date date = format.parse(dateValue);
			return date.getTime() / 1000;
		} catch (ParseException e) {
			report.report("Error in Getting Time " + e.getMessage(), Reporter.FAIL);
			return 0;
		}
	}

	public WebWidgetType getFieldType() { return fieldType; }
	@ParameterProperties(description = "Please, provide the Field Type of the WebElement you want to use!")
	public void setFieldType(WebWidgetType fieldType) { this.fieldType = fieldType; }

	public String getFieldLabel() { return fieldLabel; }
	@ParameterProperties(description = "Please, provide the Field Label of the WebElement you want to use!")
	public void setFieldLabel(String fieldLabel) { this.fieldLabel = fieldLabel; }

	public String getExpectedValue() {
		return expectedValue;
	}
	public void setExpectedValue(String expectedValue) {
		this.expectedValue = expectedValue;
	}

	public CheckboxStateEnum getCheckboxState() { return checkboxState; }
	@ParameterProperties(description = "Please, use this option only for Checkbox Option")
	public void setCheckboxState(CheckboxStateEnum checkboxState) { this.checkboxState = checkboxState; }

    public String getLeftList() {
        return leftList;
    }

    @ParameterProperties(description = "Please provide Item Names to move LEFT. Names must be separated by <,>!")
    public void setLeftList(String leftList) {
        this.leftList = leftList;
    }

    public String getRightList() {
        return rightList;
    }

    @ParameterProperties(description = "Please provide Item Names to move RIGHT. Names must be separated by <,>!")
    public void setRightList(String rightList) {
        this.rightList = rightList;
    }

	public String getFirstGlobalParamName() { return firstGlobalParamName; }
	public void setFirstGlobalParamName(String firstGlobalParamName) { this.firstGlobalParamName = firstGlobalParamName; }

	public String getSecondGlobalParamName() { return secondGlobalParamName; }
	public void setSecondGlobalParamName(String secondGlobalParamName) { this.secondGlobalParamName = secondGlobalParamName; }

	public String getResultGlobalParamName() { return resultGlobalParamName; }
	public void setResultGlobalParamName(String resultGlobalParamName) { this.resultGlobalParamName = resultGlobalParamName; }

	public String getFirstDateFormat() { return firstDateFormat; }
	public void setFirstDateFormat(String firstDateFormat) { this.firstDateFormat = firstDateFormat; }

	public String getSecondDateFormat() { return secondDateFormat; }
	public void setSecondDateFormat(String secondDateFormat) { this.secondDateFormat = secondDateFormat; }

	public NumberCheckOperationEnum getParamCheckOperation() { return paramCheckOperation; }
	public void setParamCheckOperation(NumberCheckOperationEnum paramCheckOperation) { this.paramCheckOperation = paramCheckOperation; }

	public String getParamDiff() { return String.valueOf(paramDiff); }
	@ParameterProperties(description = "Specify the Number Different")
	public void setParamDiff(String paramDiff) {
		if(paramDiff != null) {
			this.paramDiff = Long.valueOf(StringUtils.fixNumeric(paramDiff));
		}
	}

	public String getTimeDiff() { return String.valueOf(timeDiff); }
	@ParameterProperties(description = "Specify the Time Different in second")
	public void setTimeDiff(String timeDiff) {
		if(timeDiff != null) {
			this.timeDiff = Long.valueOf(StringUtils.fixNumeric(timeDiff));
		}
	}

	public String getRowKey() {
		return rowKey;
	}

	public void setRowKey(String rowKey) {
		this.rowKey = rowKey;
	}

	public String getRowValue() {
		return rowValue;
	}

	public void setRowValue(String rowValue) {
		this.rowValue = rowValue;
	}
}
