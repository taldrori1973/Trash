package com.radware.vision.tests.GeneralOperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.api.Widget;
import com.radware.automation.webui.widgets.impl.*;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.CheckboxStateEnum;
import com.radware.vision.infra.enums.FindByType;
import com.radware.vision.infra.enums.TableOperationEnum;
import com.radware.vision.infra.enums.WebWidgetType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsByNameIdHandler;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

/**
 * Created by aviH on 8/9/2015.
 */

public class ByLabelOperations extends WebUITestBase {

	WebWidgetType.WebFieldType fieldType;
	String fieldLabel;
	String inputText;
	CheckboxStateEnum checkboxState;
	String moveLeftList;
	String moveRightList;
	String globalParamName = "";
	TableOperationEnum tableOperation;
	String rowKey;
	String rowValue;
	String tooltipOperation;
	String popupButtonLabel;
	boolean topTab = false;
	boolean enterKey = false;

	String dropDownItemId = "";

	BasicOperationsByNameIdHandler basicOperationsByNameIdHandler = new BasicOperationsByNameIdHandler();

	public WebElement getNavigationWebElement(String entry, String elementClass, String label){
		String xpathLocator = "//".concat(entry) + "[contains(text(), '" + label + "') and contains(@class,'" + elementClass + "')]";
		ComponentLocator treeLocation = new ComponentLocator(How.XPATH, xpathLocator);
		return WebUIUtils.fluentWaitDisplayed(treeLocation.getBy(), WebUIUtils.NAVIGATION_TREE_WAIT_TIME, false);
	}

	@Test
	@TestProperties(name = "Click Vision Navigation", paramsInclude = {"qcTestId", "fieldLabel"})
	public void clickVisionNavigation() {
		try {
			WebElement treeMenu = getNavigationWebElement("div", "gwt-TreeItem", fieldLabel);
			if(treeMenu == null){
				treeMenu = getNavigationWebElement("div", "gwt-StackLayoutPanelHeader", fieldLabel);
				if(treeMenu == null){
					treeMenu = getNavigationWebElement("td", "perspective_button", fieldLabel);
				}
			}
			if(treeMenu == null) {
				BaseTestUtils.report("Failed to Click on Vision Navigation Tree for label: " + fieldLabel + "\n", Reporter.FAIL);
			}else {
				treeMenu.click();
			}
		} catch (Exception e) {
			BaseTestUtils.report("Failed to Click on Vision Navigation Tree for label: " + fieldLabel + "\n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	@Test
	@TestProperties(name = "Get Vision Field", paramsInclude = {"qcTestId", "fieldType", "fieldLabel", "globalParamName"})
	public void getVisionField() {
		String result = getField(WebUIUtils.VISION_DEVICE_DRIVER_ID, fieldType, fieldLabel);
		restTestBase.globalParamsMap.put(globalParamName, result);
	}

	@Test
	@TestProperties(name = "Set Vision Field", paramsInclude = {"qcTestId", "fieldType", "fieldLabel", "inputText", "enterKey", "checkboxState", "dropDownItemId"})
	public void setVisionField() {
		setField(WebUIUtils.VISION_DEVICE_DRIVER_ID, fieldType, fieldLabel, inputText, checkboxState, enterKey, FindByType.BY_NAME, dropDownItemId);
	}

	@Test
	@TestProperties(name = "Vision Table Operation", paramsInclude = {"qcTestId", "fieldLabel", "tableOperation", "rowKey", "rowValue", "tooltipOperation"})
	public void visionTableOperation() {
		doTableOperation(WebUIUtils.VISION_DEVICE_DRIVER_ID, fieldLabel, tableOperation, rowKey, rowValue, tooltipOperation);
	}

	@Test
	@TestProperties(name = "Set DualList", paramsInclude = {"qcTestId", "fieldLabel", "moveLeftList", "moveRightList"})
	public void setDualList() {
		List<Widget> widgets = basicOperationsByNameIdHandler.findWidgetByNameId(WebUIUtils.VISION_DEVICE_DRIVER_ID, WebWidgetType.DualList, fieldLabel, FindByType.BY_NAME);
		if (widgets.isEmpty()) {
			BaseTestUtils.report("Failed to Set Field type: " + fieldType + " for Field label: " + fieldLabel + ", it may not be visible", Reporter.FAIL);
		}
		for (Widget widget : widgets) {
			WebUIDualList dualList = (WebUIDualList) widget;

			if (moveRightList != null && !moveRightList.toString().equals("")) {
				List<String> moveRightItems = Arrays.asList(moveRightList.split(","));
				for (String item : moveRightItems) {
					dualList.moveRight(item);
				}
			}
			if (moveLeftList != null && !moveLeftList.toString().equals("")) {
				List<String> moveLeftItems = Arrays.asList(moveLeftList.split(","));
				for (String item : moveLeftItems) {
					dualList.moveLeft(item);
				}
			}
		}
	}

	@Test
	@TestProperties(name = "Click Device Navigation", paramsInclude = {"qcTestId", "fieldLabel", "topTab"})
	public void clickDeviceNavigation() {
		try {
			String xpathLocator;
			if (topTab) {
				xpathLocator = "//td[contains(text(), '" + fieldLabel + "')]";
			} else {
				xpathLocator = "//div[contains(text(), '" + fieldLabel + "')]";
			}
			ComponentLocator treeLocation = new ComponentLocator(How.XPATH, xpathLocator);
			WebUIUtils.fluentWaitClick(treeLocation.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
		} catch (Exception e) {
			BaseTestUtils.report("Failed to Click on Device Navigation Tree for label: " + fieldLabel + ", \n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	@Test
	@TestProperties(name = "Get Device Field", paramsInclude = {"qcTestId", "fieldType", "fieldLabel", "globalParamName", "deviceName"})
	public void getDeviceField() {
		String result = getField(WebUIUtils.selectedDeviceDriverId, fieldType, fieldLabel);
		restTestBase.globalParamsMap.put(globalParamName, result);
	}

	@Test
	@TestProperties(name = "Set Device Field", paramsInclude = {"qcTestId", "fieldType", "fieldLabel", "inputText", "enterKey", "checkboxState", "deviceName"})
	public void setDeviceField() {
		setField(WebUIUtils.selectedDeviceDriverId, fieldType, fieldLabel, inputText, checkboxState, enterKey, FindByType.BY_NAME, "");
	}

	@Test
	@TestProperties(name = "Device Table Operation", paramsInclude = {"qcTestId", "fieldLabel", "tableOperation", "rowKey", "rowValue", "tooltipOperation", "deviceName"})
	public void deviceTableOperation() {
		doTableOperation(WebUIUtils.selectedDeviceDriverId, fieldLabel, tableOperation, rowKey, rowValue, tooltipOperation);
	}

	@Test
	@TestProperties(name = "Click Submit", paramsInclude = {"qcTestId"})
	public void clickSubmit() {
		try {
			String xpathLocator = "//button[contains(@id,'gwt-debug-') and (contains(@id,'_Submit'))]";
			ComponentLocator buttonLocation = new ComponentLocator(How.XPATH, xpathLocator);
			WebElement submitBtn = WebUIUtils.fluentWaitDisplayed(buttonLocation.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
			submitBtn.click();
		} catch (Exception e) {
			BaseTestUtils.report("Failed to click on Submit" + "\n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	@Test
	@TestProperties(name = "Click Cancel", paramsInclude = {"qcTestId"})
	public void clickCancel() {
		try {
			String xpathLocator = "//button[contains(@id,'gwt-debug-') and ((contains(@id,'_Cancel')) or (contains(@id,'_Close')))]";
			ComponentLocator buttonLocation = new ComponentLocator(How.XPATH, xpathLocator);
			WebElement submitBtn = WebUIUtils.fluentWaitDisplayed(buttonLocation.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
			submitBtn.click();
		} catch (Exception e) {
			BaseTestUtils.report("Failed to click on Cancel" + "\n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	@Test
	@TestProperties(name = "Click Popup Button", paramsInclude = {"qcTestId", "popupButtonLabel"})
	public void clickPopupButton() {
		try {
			String xpathLocator = "//button[contains(@id,'Dialog_Box_" + popupButtonLabel + "')]";
			ComponentLocator buttonLocation = new ComponentLocator(How.XPATH, xpathLocator);
			WebElement button = WebUIUtils.fluentWaitDisplayed(buttonLocation.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
			button.click();
		} catch (Exception e) {
			BaseTestUtils.report("Failed to click on Button " + popupButtonLabel + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	private void doTableOperation(String deviceDriverId, String fieldLabel, TableOperationEnum tableOperation, String rowKey, String rowValue, String tooltipOperation) {
		try {
			List<Widget> widgets = basicOperationsByNameIdHandler.findWidgetByNameId(deviceDriverId, WebWidgetType.Table, fieldLabel, FindByType.BY_NAME);
			if (widgets.isEmpty()) {
				BaseTestUtils.report("Failed to get Table for label: " + fieldLabel + ", it may not be visible", Reporter.FAIL);
			}
			// Remove Alerts Table
			Iterator<Widget> iter = widgets.iterator();
			while (iter.hasNext()) {
				Widget widget = iter.next();
				if (widget.getName().contains("Alerts") && !fieldLabel.contains("Alerts")) {
					iter.remove();
				}
			}

			if (widgets.size() > 1) {
				iter = widgets.iterator();
				while (iter.hasNext()) {
					Widget widget = iter.next();
					if (!widget.getName().equals(fieldLabel)) {
						iter.remove();
					}
				}
			}

			for (Widget widget : widgets) {
				if (widget == null || (widget != null && !widget.find(true, true))) continue;
				WebUITable table = (WebUITable) widget;
				switch (tableOperation) {
					case VIEW:
						table.viewRowByKeyValue(rowKey, rowValue);
						break;
					case ADD:
						table.addRow();
						break;
					case EDIT:
						table.editRowByKeyValue(rowKey, rowValue);
						break;
					case DELETE:
						table.deleteRowByKeyValue(rowKey, rowValue);
						break;
					case TOOLTIP_OPERATION:
						table.clickRowByKeyValue(rowKey, rowValue);
						String xpathLocator = "//td[contains(@title, '" + tooltipOperation + "')]";
						ComponentLocator treeLocation = new ComponentLocator(How.XPATH, xpathLocator);
						WebElement itemMenu = WebUIUtils.fluentWaitDisplayed(treeLocation.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
						itemMenu.click();
						break;
				}
			}
		} catch (Exception e) {
			BaseTestUtils.report("Failed to get Table for label: " + fieldLabel + " \n" + parseExceptionBody(e), Reporter.FAIL);
		}

	}

	private String getField(String deviceDriverId, WebWidgetType.WebFieldType fieldType, String fieldLabel) {
		try {
			WebWidgetType widgetType = WebWidgetType.valueOf(fieldType.name());
			List<Widget> widgets = basicOperationsByNameIdHandler.findWidgetByNameId(deviceDriverId, widgetType, fieldLabel, FindByType.BY_NAME);
			if (widgets.isEmpty()) {
				BaseTestUtils.report("Failed to Get Field type: " + fieldType + " for Field label: " + fieldLabel + ", it may not be visible", Reporter.FAIL);
			}
			for (Widget widget : widgets) {
				if (widget == null || (widget != null && !widget.find(true, true))) {
					continue;
				}
				switch (fieldType) {
					case Text:
						WebUITextField textField = new WebUITextField(widget.getLocator());
						return textField.getValue();
					case Button:
						return null;
					case Tab:
						return null;
					case Checkbox:
						WebUICheckbox checkbox = (WebUICheckbox)widget;
						boolean selectCheckbox = checkboxState.equals(CheckboxStateEnum.Check) ? true : false;
						if (selectCheckbox) {
							return "check";
						} else {
							return "uncheck";
						}
					case Dropdown:
						WebUIDropdown dropdown = (WebUIDropdown)widget;
						return dropdown.getValue();
					case RadioButton:
						WebUIRadioGroup radioGroup = (WebUIRadioGroup) widget;
						return radioGroup.getValue();
				}
				if(widgets.size() > 1){
					break;
				}
			}
		} catch(Exception e) {
			BaseTestUtils.report("Failed to Set Field type: " + fieldType + " for Field label: " + fieldLabel + " \n" + parseExceptionBody(e), Reporter.FAIL);
		}
		return null;
	}

	private void setField(String deviceDriverId, WebWidgetType.WebFieldType fieldType, String fieldLabelId, String inputText, CheckboxStateEnum checkboxState, boolean clickEnter, FindByType findByType, String dropDownIndex) {
		try {
			WebWidgetType widgetType = WebWidgetType.valueOf(fieldType.name());
			List<Widget> widgets = basicOperationsByNameIdHandler.findWidgetByNameId(deviceDriverId, widgetType, fieldLabelId, findByType);
			if (widgets.isEmpty()) {
				BaseTestUtils.report("Failed to Set Field type: " + fieldType + " for Field label: " + fieldLabelId + ", it may not be visible", Reporter.FAIL);
			}
			for (Widget widget : widgets) {
				switch (fieldType) {
					case Text:
							WebUITextField textField = new WebUITextField(widget.getLocator());
							textField.type(inputText, clickEnter);
						break;
					case Button:
						WebElement button = WebUIUtils.fluentWaitDisplayed(widget.getLocator().getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
							button.click();
						break;
					case Tab:
						WebUIVerticalTab tab = (WebUIVerticalTab)widget;
						tab.click();
						break;
					case Checkbox:
						WebUICheckbox checkbox = (WebUICheckbox)widget;
						boolean selectCheckbox = checkboxState.equals(CheckboxStateEnum.Check) ? true : false;
						if (selectCheckbox) {
							checkbox.check();
						} else {
							checkbox.uncheck();
						}
						break;
					case Dropdown:
							WebUIDropdown dropdown = (WebUIDropdown) widget;
						if(dropDownIndex != null && !dropDownIndex.equals("")){
							dropdown.selectOptionByIndex(Integer.parseInt(dropDownIndex));
						}else {
							dropdown.selectOptionByText(inputText);
						}
						break;
					case ImageControl:
						WebUIImageControl imageControl = (WebUIImageControl) widget;
						if(dropDownIndex != null && !dropDownIndex.equals("")){
							imageControl.selectOptionByIndex(Integer.parseInt(dropDownIndex) - 1);
						}
						break;
					case RadioButton:
							WebUIRadioGroup radioGroup = (WebUIRadioGroup) widget;
							radioGroup.selectOption(fieldLabelId);
						break;
				}
				if(widgets.size() > 1){
					break;
				}
			}
		} catch(Exception e) {
			BaseTestUtils.report("Failed to Set Field type: " + fieldType + " for Field label: " + fieldLabelId + " \n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	private static String normalizeDeviceDriverName(String DeviceDriverName) {
		String normalize = DeviceDriverName.substring(4);
		normalize = normalize.replace("_", "-");
		return normalize;
	}

	public WebWidgetType.WebFieldType getFieldType() { return fieldType; }
	@ParameterProperties(description = "Please, provide the Field Type of the WebElement you want to use!")
	public void setFieldType(WebWidgetType.WebFieldType fieldType) { this.fieldType = fieldType;}

	public String getFieldLabel() { return fieldLabel; }
	@ParameterProperties(description = "Please, provide the Field Label of the WebElement you want to use!")
	public void setFieldLabel(String fieldLabel) { this.fieldLabel = fieldLabel; }

	public String getInputText() {
		return inputText;
	}
	public void setInputText(String inputText) {
		this.inputText = inputText;
	}

	public CheckboxStateEnum getCheckboxState() { return checkboxState; }
	@ParameterProperties(description = "Please, use this option only for Checkbox Option")
	public void setCheckboxState(CheckboxStateEnum checkboxState) { this.checkboxState = checkboxState; }

    public String getMoveLeftList() {
        return moveLeftList;
    }
    @ParameterProperties(description = "Please provide Item Names to move LEFT. Names must be separated by <,>!")
    public void setMoveLeftList(String moveLeftList) {
        this.moveLeftList = moveLeftList;
    }

    public String getMoveRightList() {
        return moveRightList;
    }
    @ParameterProperties(description = "Please provide Item Names to move RIGHT. Names must be separated by <,>!")
    public void setMoveRightList(String moveRightList) {
        this.moveRightList = moveRightList;
    }

	public String getGlobalParamName() { return globalParamName; }
	@ParameterProperties(description = "Specify the Global Param Name to save")
	public void setGlobalParamName(String globalParamName) { this.globalParamName = globalParamName; }

	public TableOperationEnum getTableOperation() { return tableOperation; }
	public void setTableOperation(TableOperationEnum tableOperation) { this.tableOperation = tableOperation; }

	public String getRowKey() { return rowKey; }
	public void setRowKey(String rowKey) { this.rowKey = rowKey; }

	public String getRowValue() { return rowValue; }
	public void setRowValue(String rowValue) { this.rowValue = rowValue; }

	public String getTooltipOperation() { return tooltipOperation; }
	@ParameterProperties(description = "Select the Device TOP Tab Navigation")
	public void setTooltipOperation(String tooltipOperation) { this.tooltipOperation = tooltipOperation; }

	public String getPopupButtonLabel() { return popupButtonLabel; }
	public void setPopupButtonLabel(String popupButtonLabel) { this.popupButtonLabel = popupButtonLabel; }

	public boolean isTopTab() { return topTab; }
	public void setTopTab(boolean topTab) { this.topTab = topTab; }

	public boolean isEnterKey() {
		return enterKey;
	}

	@ParameterProperties(description = "Set to \"true\" in case you want Enter key to be pressed by the end of the test execution! (for Text box)")
	public void setEnterKey(boolean enterKey) {
		this.enterKey = enterKey;
	}

	public String getDropDownItemId() {
		return dropDownItemId;
	}
	@ParameterProperties(description = "To be used in dropDown related tests only - in case selection is to be made by index")
	public void setDropDownItemId(String dropDownItemId) {
		this.dropDownItemId = dropDownItemId;
	}
}
