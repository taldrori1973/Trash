package com.radware.vision.infra.testhandlers.baseoperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.api.Button;
import com.radware.automation.webui.widgets.api.Widget;
import com.radware.automation.webui.widgets.impl.*;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.FindByType;
import com.radware.vision.infra.enums.WebWidgetType;
import junit.framework.SystemTestCase;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by AviH on 9/6/2015.
 */
public class BasicOperationsByNameIdHandler extends WebUIBasePage {
	BasicOperationsHandler basicOperationsHandler = new BasicOperationsHandler();
	List<Widget> widgets = new LinkedList<Widget>();
	public List<Widget> findWidgetByNameId(String deviceDriverId, WebWidgetType widgetType, String fieldLabelId, FindByType findByType) {
		widgets.clear();
		List<Widget> visibleWidgets = new LinkedList<Widget>();
		List<String> widgetIDs = new LinkedList<String>();

		setCurrentContainer(deviceDriverId, true);
		for (Widget widget : container.getAllWidgets()) {
			// Check if widget is the correct type
			switch (widgetType) {
				case Button:
					if (!(widget instanceof Button)) continue;
					break;
				case Tab:
					if (!(widget instanceof WebUIVerticalTab)) continue;
					break;
				case Text:
					if (!(widget instanceof WebUITextField)) continue;
					break;
				case Checkbox:
					if (!(widget instanceof WebUICheckbox)) continue;
					break;
				case Dropdown:
					if (!(widget instanceof WebUIDropdown)) continue;
					break;
				case ImageControl:
					if (!(widget instanceof WebUIImageControl)) continue;
					break;
				case RadioButton:
					if (!(widget instanceof WebUIRadioGroup)) continue;
					break;
				case DualList:
					if (!(widget instanceof WebUIDualList)) continue;
					break;
				case Table:
					if (!(widget instanceof WebUITable)) continue;
					break;
			}


			switch (findByType) {
				case BY_NAME:
					getWidgetsByLabel(widget, widgetType, fieldLabelId);
					break;
				case BY_ID:
					getWidgetsById(widget, widgetType, fieldLabelId);
					break;

			}
		}

		for (Widget widget : widgets) {
			try {
				WebUIUtils.isWaitingForNonExistingElement = true;
				WebUIUtils.isScreenshotGenerationOperational = false;
				WebElement element = WebUIUtils.fluentWaitDisplayed(widget.getLocator().getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
				if (element == null) {
					continue;
				}
				else if(!widget.getWebElement().equals(element)) {
					continue;

				} else {
					//if(!widgetIDs.contains(widget.getRawId()) ) {
						visibleWidgets.add(widget);
						//widgetIDs.add(widget.getRawId());
					//}
					continue;
				}
			} catch (Exception e) {

			}
			finally {
				WebUIUtils.isWaitingForNonExistingElement = false;
				WebUIUtils.isScreenshotGenerationOperational = true;
			}
		}
		return visibleWidgets;
	}

	public void getWidgetsByLabel(Widget widget, WebWidgetType widgetType, String fieldLabel){
		if (widgetType == WebWidgetType.RadioButton) {
			WebUIRadioGroup radioGroup = (WebUIRadioGroup)widget;
			if (radioGroup.getItemIdByValue(fieldLabel) != null) {
				widgets.add(widget);
			}
		} else if(widget.getName() != null){
			String wName = widget.getName();
			if (wName.equals(fieldLabel)) {
				widgets.add(widget);
			} else if (widgetType == WebWidgetType.Table && !widgets.contains(widget) && !wName.equals("Alerts Table")){
				widgets.add(widget);
			}
		}
	}

	public void selectTableRecord(String deviceDriverId, String fieldLabel, String rowKey, String rowValue){
		selectTableRecord(deviceDriverId, fieldLabel, rowKey, rowValue, FindByType.BY_NAME);
	}
	public void selectTableRecord(String deviceDriverId, String fieldLabel, String rowKey, String rowValue, FindByType findTableType) {
		try {
			List<Widget> widgets = findWidgetByNameId(deviceDriverId, WebWidgetType.Table, fieldLabel, findTableType);
			if (widgets.isEmpty()) {
				BaseTestUtils.report("Failed to get Table for label: " + fieldLabel + ", it may not be visible", Reporter.FAIL);
			}
			outerloop:
			for (Widget widget : widgets) {
				if (widget == null || (widget != null && !widget.find(true, true))) {
					continue;
				}
				WebUITable table = (WebUITable) widget;
				int currRowIndex = table.getRowIndex(rowKey, rowValue);
				if(currRowIndex != -1) {
					table.selectRow(currRowIndex);
					//table.clickOnRow(currRowIndex);
					break;
				}

			}
		} catch (Exception e) {
			BaseTestUtils.report("Failed to get Table for label: " + fieldLabel + " \n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	public int getRowsAmountByKeyValue(String deviceDriverId, String fieldLabel, String rowKey, String rowValue, FindByType findTableType) {
		try {
			List<Widget> widgets = findWidgetByNameId(deviceDriverId, WebWidgetType.Table, fieldLabel, findTableType);
				if (widgets.isEmpty()) {
					BaseTestUtils.report("Failed to get Table for label: " + fieldLabel + ", it may not be visible", Reporter.FAIL);
				}
				for (Widget widget : widgets) {
					if (widget == null || (widget != null && !widget.find(true, true))) {
						continue;
					}
					WebUITable table = (WebUITable) widget;
					return table.getRowsAmountByKeyValue(rowKey, rowValue);

				}
			} catch (Exception e) {
			BaseTestUtils.report("Failed to get Table for label: " + fieldLabel + " \n" + parseExceptionBody(e), Reporter.FAIL);
		}
		return -1;
	}

	public int getRowsAmountPerPage(String deviceDriverId, String fieldLabel, FindByType findTableType) {
		try {
			List<Widget> widgets = findWidgetByNameId(deviceDriverId, WebWidgetType.Table, fieldLabel, findTableType);
			if (widgets.isEmpty()) {
				BaseTestUtils.report("Failed to get Table for label: " + fieldLabel + ", it may not be visible", Reporter.FAIL);
			}
			for (Widget widget : widgets) {
				if (widget == null || (widget != null && !widget.find(true, true))) {
					continue;
				}
				WebUITable table = (WebUITable) widget;
				return table.getRowsNumber();

			}
		} catch (Exception e) {
			BaseTestUtils.report("Failed to get Table for label: " + fieldLabel + " \n" + parseExceptionBody(e), Reporter.FAIL);
		}
		return -1;
	}

	public void selectTableRecordByIndex(String deviceDriverId, String fieldLabel, int index) {
		try {
			List<Widget> widgets = findWidgetByNameId(deviceDriverId, WebWidgetType.Table, fieldLabel, FindByType.BY_NAME);
			if (widgets.isEmpty()) {
				SystemTestCase.BaseTestUtils.report("Failed to get Table for label: " + fieldLabel + ", it may not be visible", Reporter.FAIL);
			}
			outerloop:
			for (Widget widget : widgets) {
				if (widget == null || (widget != null && !widget.find(true, true))) {
					continue;
				}
				WebUITable table = (WebUITable) widget;
				if(index == 0){
					index = table.getRowCount();
				}else{
					index = index-1;
				}
				table.selectRow(index);
				table.clickOnRow(index);

			}
		} catch (Exception e) {
			SystemTestCase.BaseTestUtils.report("Failed to get Table for label: " + fieldLabel + " \n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	public void getWidgetsById(Widget widget, WebWidgetType widgetType, String fieldId){
		if (widgetType == WebWidgetType.RadioButton) {
			WebUIRadioGroup radioGroup = (WebUIRadioGroup)widget;
				widgets.add(widget);
		} else {
			String wName = widget.getName();
			if (wName != null && wName.equals(fieldId)) {
				widgets.add(widget);
			} else if (wName != null && widgetType == WebWidgetType.Table && !widgets.contains(widget) && !wName.equals("Alerts Table")){
				widgets.add(widget);
			}
		}
	}

	public String findScreenXmlByLabel(String screenLabel) {
		return navigation.getScreenXml(screenLabel);
	}

	private String buildWidgetKey(String deviceDriverId, WebWidgetType widgetType, String fieldLabel) {
		return deviceDriverId + widgetType + fieldLabel;
	}

	protected String parseExceptionBody(Exception e) {
		StringBuffer exceptionBody = new StringBuffer();
		if (e instanceof Exception) {
			exceptionBody.append("Cause: ").append(e.getCause()).append("\n").
					append(" ,Message: ").append(e.getMessage()).append("\n").
					append(" ,Stack Trace: ").append(Arrays.asList(Arrays.asList(e.getStackTrace()))).append("\n");
		}
		if (e instanceof IllegalStateException) {
			exceptionBody.append("Additional Info: ").append((e).getLocalizedMessage());
		}
		return exceptionBody.toString();
	}

	public void validateDropDownOptionExistence(String textOption, String elementLabelId, String deviceDriverId, FindByType findByType){
		try {
			List<Widget> widgets = findWidgetByNameId(deviceDriverId, WebWidgetType.Dropdown, elementLabelId, findByType);
			if (widgets.isEmpty()) {
				BaseTestUtils.report("Failed to get Element for label: " + elementLabelId + ", it may not be visible", Reporter.FAIL);
			}
			for (Widget widget : widgets) {
				if (widget == null || (widget != null && !widget.find(true, true))) {
					continue;
				}
				WebUIDropdown dropdown = (WebUIDropdown) widget;
				if(!dropdown.validateOptionExistence(textOption)){
					BaseTestUtils.report("Provided textOption does NOT exist: " + textOption, Reporter.FAIL);
				}else{
					BaseTestUtils.report("Provided textOption Found: " + textOption, Reporter.PASS);
				}


			}
		} catch (Exception e) {
			BaseTestUtils.report("Failed to get Element for label: " + elementLabelId + " \n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	public void validateDropDownSelection(String textOption, String elementLabelId, String deviceDriverId, FindByType findByType){
		try {
			List<Widget> widgets = findWidgetByNameId(deviceDriverId, WebWidgetType.Dropdown, elementLabelId, findByType);
			if (widgets.isEmpty()) {
				BaseTestUtils.report("Failed to get Element for label: " + elementLabelId + ", it may not be visible", Reporter.FAIL);
			}
			for (Widget widget : widgets) {
				if (widget == null || (widget != null && !widget.find(true, true))) {
					continue;
				}
				WebUIDropdown dropdown = (WebUIDropdown) widget;
				if(!dropdown.validateSelection(textOption)){
					BaseTestUtils.report("Provided textOption is NOT selected: " + textOption, Reporter.FAIL);
				}else{
					BaseTestUtils.report("Provided textOption is Selected: " + textOption, Reporter.PASS);
				}


			}
		} catch (Exception e) {
			BaseTestUtils.report("Failed to get Element for label: " + elementLabelId + " \n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	public void validateCheckboxSelection(String elementId, boolean expectedCheckboxSelection) {
		try {
			WebElement element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
			if (element != null) {
				ComponentLocator locator = new ComponentLocator(How.ID, elementId);
				WebUICheckbox checkbox = new WebUICheckbox(locator);
				checkbox.setWebElement(element);
				if (!((checkbox.isChecked() && expectedCheckboxSelection) || (!checkbox.isChecked() && !expectedCheckboxSelection))) {
					BaseTestUtils.report("CheckBox Validation Failed. \n Expected status is checked = : " + expectedCheckboxSelection + "\n Actual status is: checked = " + checkbox.isChecked(), Reporter.FAIL);
				}
			}
		} catch (Exception e) {
			BaseTestUtils.report("Failed to validate CheckBox status: " + expectedCheckboxSelection + " from element: " + elementId + "\n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	public void validateCheckboxSelectionByLabel(String label, String params, boolean expectedCheckboxSelection) {
		try {
			VisionDebugIdsManager.setLabel(label);
			WebUICheckbox checkbox = (WebUICheckbox) WebUIVisionBasePage.getCurrentPage().getContainer().getCheckbox(label);
			if(params != null) {
				params = basicOperationsHandler.replaceParams(label, params);
				VisionDebugIdsManager.setParams(params);
				checkbox.getLocator().setLocatorValue(checkbox.getLocator().getLocatorValue().replaceAll("%s",VisionDebugIdsManager.getParams().get(0)));
			}
			if (checkbox != null) {
				if (!((checkbox.isChecked() && expectedCheckboxSelection) || (!checkbox.isChecked() && !expectedCheckboxSelection))) {
					BaseTestUtils.report("CheckBox Validation Failed. \n Expected status is checked = : " + expectedCheckboxSelection + "\n Actual status is: checked = " + checkbox.isChecked(), Reporter.FAIL);
				}
			}
			else{
				BaseTestUtils.report("Failed to find WebElement: " + expectedCheckboxSelection + " from element: " + label + "\n", Reporter.FAIL);
			}
		} catch (Exception e) {
			BaseTestUtils.report("Failed to validate CheckBox status: " + expectedCheckboxSelection + " from element: " + label + "\n" + parseExceptionBody(e), Reporter.FAIL);
		}
	}

	public void validateVisionDualList(String dualListID, String rightList, String leftList){
		ComponentLocator dualListLocator = new ComponentLocator(How.ID, dualListID);
		WebUIDualListScripts dualList = new WebUIDualListScripts(new WebUIComponent(dualListLocator));
		validateDualListItems(dualList, rightList, leftList);

	}

	public void validateDualListItems(WebUIDualList dualList, String rightList, String leftList){
		boolean isValid = true;
		if (dualList == null) {
			BaseTestUtils.report("Failed to Validate dualList : " + ", it may not be visible", Reporter.FAIL);
		}
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
		if (!isValid) {
			BaseTestUtils.report("Failed to Validate dualList leftList items: " + leftList + "and rightList items: " + rightList + ", it may not contain all listed items", Reporter.FAIL);
		}
	}
}
