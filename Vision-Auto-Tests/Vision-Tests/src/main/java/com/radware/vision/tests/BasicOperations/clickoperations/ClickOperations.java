package com.radware.vision.tests.BasicOperations.clickoperations;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIDropdown;
import com.radware.automation.webui.widgets.impl.WebUIDualList;
import com.radware.automation.webui.widgets.impl.WebUIRadioGroup;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.DualListSides;
import com.radware.vision.infra.enums.FindByType;
import com.radware.vision.infra.enums.WebElementType;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.utils.GeneralUtils;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

import static com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler.checkIfElementExistAndDisplayed;
import static com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler.setWebListenerProperty;

/**
 * Created by urig on 5/20/2015.
 */
public class ClickOperations extends WebUITestBase {

    String elementId;
    String elementIdForRadioGroup;
    String inputText;
    String dropdownOptionText;
    boolean selectCheckbox = false;
    String xmlFileName;
    String elementText;
    String radioGroupItemText;
    int rowNumberToSelect = 0;
    String tableName;
    DualListSides dualListSide = DualListSides.SELECT_SIDE_TO_SELECT_FROM;
    String dualListItems;
    String dualListName;
    String dualListID;
    FindByType type = FindByType.BY_NAME;
    WebElementType elementType = WebElementType.Id;
    String rowId;
    int dropdownItemIndex;
    int waitBeforeAutoPopupClose = 0;
    boolean enterKey = false;


    public ClickOperations() {
        setCloseAllOpenedDialogsRequired(true);
    }

    @Test
    @TestProperties(name = "Click Web Element", paramsInclude = {"elementType", "elementId", "waitBeforeAutoPopupClose"})
    public void clickWebElement() {
        ClickOperationsHandler.clickWebElement(elementType, elementId, waitBeforeAutoPopupClose);
    }

    @Test
    @TestProperties(name = "Set Text to Element", paramsInclude = {"elementId", "inputText", "enterKey"})
    public void setTextToElement() {
        ClickOperationsHandler.setTextToElement(elementType, elementId, inputText, enterKey);
    }

    @Test
    @TestProperties(name = "Select Item From Dropdown", paramsInclude = {"elementId", "dropdownOptionText", "xmlFileName", "deviceName", "deviceDriverType"})
    public void selectItemFromDropdown() {
        ClickOperationsHandler.selectItemFromDropdown(elementId, dropdownOptionText, getDeviceDriverType().getDDType());
    }

    @Test
    @TestProperties(name = "Select Item From Dropdown by Index", paramsInclude = {"elementId", "dropdownItemIndex", "deviceDriverType"})
    public void selectItemFromDropdownByIndex() {
        try {
            if (!checkIfElementExistAndDisplayed(GeneralUtils.buildGenericXpath(WebElementType.Id, elementId, OperatorsEnum.EQUALS))) {
                throw new Exception("Element not found");
            }
            WebElement element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, elementId).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            updateWidgetsContainer(getDeviceDriverType().getDDType());
            if (element != null) {
                WebUIDropdown dropdown = new WebUIDropdown();
                dropdown.setWebElement(element);
                dropdown.setLocator(new ComponentLocator(How.ID, elementId));
                dropdown.selectOptionByIndex(dropdownItemIndex - 1);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to select item: " + dropdownOptionText + " from element: " + elementId, Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Click Web Element By Text", paramsInclude = {"elementText", "waitBeforeAutoPopupClose"})
    public void clickWebElementByText() {
        try {
            setWebListenerProperty(waitBeforeAutoPopupClose);
            String xpath = "//*[contains(text(), '" + elementText + "')]";
            WebElement element = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.XPATH, xpath).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            if (element != null) {
                element.click();
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to find item by text: " + elementText, Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Set Checkbox Selection", paramsInclude = {"elementId", "selectCheckbox"})
    public void setCheckboxSelection() {
        try {
            if (!checkIfElementExistAndDisplayed(GeneralUtils.buildGenericXpath(WebElementType.Id, elementId, OperatorsEnum.EQUALS))) {
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

    @Test
    @TestProperties(name = "Set Radio Button", paramsInclude = {"elementIdForRadioGroup", "radioGroupItemText", "deviceDriverType"})
    public void setRadioButton() {
        try {
            if (!checkIfElementExistAndDisplayed(GeneralUtils.buildGenericXpath(WebElementType.Id, elementId, OperatorsEnum.EQUALS))) {
                throw new Exception("Element not found");
            }
            updateWidgetsContainer(getDeviceDriverType().getDDType());
            ComponentLocator locator = new ComponentLocator(How.ID, elementIdForRadioGroup);
            WebElement element = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            LinkedList<String> radioGroupOptions = new LinkedList<String>();
            if (element != null) {
                WebUIRadioGroup radio = new WebUIRadioGroup(locator);

                radio.setWebElement(element);
                radioGroupOptions.addAll(Arrays.asList((radio.getInnerText().split(" "))));

                if (radioGroupOptions.contains(radioGroupItemText)) {
                    radio.selectOption(radioGroupItemText);
                } else {
                    BaseTestUtils.report("Failed to set Radio button : " + radioGroupItemText + " you have provided is out of range " + elementId + "\n", Reporter.FAIL);
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to set Radio button : " + radioGroupItemText + " from element: " + elementId + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Click On Table Row", paramsInclude = {"deviceDriverType", "rowNumberToSelect", "rowId", "deviceName"})
    public void clickTableRow() {
        try {
            WebUIUtils.setIsTriggerPopupSearchEvent(false);
            updateWidgetsContainer(getDeviceDriverType().getDDType());
            WebUITable table = (WebUITable) WebUIUtils.widgetsContainer.getTableById(rowId);
            table.analyzeTable("div");
            table.clickOnRow(rowNumberToSelect - 1);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to find item by text: " + elementText, Reporter.FAIL);
        } finally {
            WebUIUtils.setIsTriggerPopupSearchEvent(true);
        }
    }

    @Test
    @TestProperties(name = "Move DualList Items", paramsInclude = {"deviceDriverType", "dualListName", "dualListID", "dualListItems", "dualListSide", "type"})
    public void moveDualListItems() {
        try {
            updateWidgetsContainer(getDeviceDriverType().getDDType());
            WebUIDualList dualList;
            if (type == FindByType.BY_NAME) {
                dualList = (WebUIDualList) WebUIUtils.widgetsContainer.getDualList(dualListName);
            } else {
                dualList = (WebUIDualList) WebUIUtils.widgetsContainer.getDualListById(dualListID);
            }
            List<String> itemsToMoveList = new ArrayList<String>();
            if (dualListItems != null) {
                itemsToMoveList = Arrays.asList(dualListItems.split(","));
            }
            if (dualListSide.equals(DualListSides.LEFT)) {
                for (String item : itemsToMoveList) {
                    dualList.moveRight(item);
                }
            } else if (dualListSide.equals(DualListSides.RIGHT)) {
                for (String item : itemsToMoveList) {
                    dualList.moveLeft(item);
                }
            }

        } catch (Exception e) {
            BaseTestUtils.report("Failed to find item by text: " + elementText, Reporter.FAIL);
        }
    }

    public void updateWidgetsContainer(String deviceDriverId) {
        WebUIBasePage webUIBasePage = new WebUIBasePage();
        webUIBasePage.setCurrentContainer(deviceDriverId, true);
    }

    public String getDualListName() {
        return dualListName;
    }

    public void setDualListName(String dualListName) {
        this.dualListName = dualListName;
    }

    public DualListSides getDualListSide() {
        return dualListSide;
    }

    @ParameterProperties(description = "Please select a side to move FROM!")
    public void setDualListSide(DualListSides dualListSide) {
        this.dualListSide = dualListSide;
    }

    public String getDualListItems() {
        return dualListItems;
    }

    @ParameterProperties(description = "Please provide Item Names to move. Names must be separated by <,>!")
    public void setDualListItems(String dualListItems) {
        this.dualListItems = dualListItems;
    }

    public String getRowNumberToSelect() {
        return String.valueOf(rowNumberToSelect);
    }

    public void setRowNumberToSelect(String rowNumberToSelect) {
        if (rowNumberToSelect != null) {
            this.rowNumberToSelect = Integer.valueOf(StringUtils.fixNumeric(rowNumberToSelect));
        }
    }

    public String getDropdownItemIndex() {
        return String.valueOf(dropdownItemIndex);
    }

    public void setDropdownItemIndex(String dropdownItemIndex) {
        if (dropdownItemIndex != null) {
            this.dropdownItemIndex = Integer.valueOf(StringUtils.fixNumeric(dropdownItemIndex));
        }
    }

    public String getTableName() {
        return tableName;
    }

    public void setTableName(String tableName) {
        this.tableName = tableName;
    }

    public String getRadioGroupItemText() {
        return radioGroupItemText;
    }

    @ParameterProperties(description = "Please, provide the Radio Option text to select!")
    public void setRadioGroupItemText(String radioGroupItemText) {
        this.radioGroupItemText = radioGroupItemText;
    }

    public String getElementIdForRadioGroup() {
        return elementIdForRadioGroup;
    }

    @ParameterProperties(description = "Please, provide the RadioGroup element ID(means Parent ID)!")
    public void setElementIdForRadioGroup(String elementIdForRadioGroup) {
        this.elementIdForRadioGroup = elementIdForRadioGroup;
    }

    public String getXmlFileName() {
        return xmlFileName;
    }

    public void setXmlFileName(String xmlFileName) {
        this.xmlFileName = xmlFileName;
    }

    public String getInputText() {
        return inputText;
    }

    public void setInputText(String inputText) {
        this.inputText = inputText;
    }

    public String getElementId() {
        return elementId;
    }

    @ParameterProperties(description = "Please, provide the Attribute Name of the WebElement you want to use!")
    public void setElementId(String elementId) {
        this.elementId = elementId;
    }

    public String getDropdownOptionText() {
        return dropdownOptionText;
    }

    public void setDropdownOptionText(String dropdownOptionText) {
        this.dropdownOptionText = dropdownOptionText;
    }

    public boolean getSelectCheckbox() {
        return selectCheckbox;
    }

    public void setSelectCheckbox(boolean selectCheckbox) {
        this.selectCheckbox = selectCheckbox;
    }

    public String getElementText() {
        return elementText;
    }

    public void setElementText(String elementText) {
        this.elementText = elementText;
    }

    public WebElementType getElementType() {
        return elementType;
    }

    public void setElementType(WebElementType elementType) {
        this.elementType = elementType;
    }

    public String getRowId() {
        return rowId;
    }

    public void setRowId(String rowId) {
        this.rowId = rowId;
    }

    public boolean isEnterKey() {
        return enterKey;
    }

    public void setEnterKey(boolean enterKey) {
        this.enterKey = enterKey;
    }

    public String getWaitBeforeAutoPopupClose() {
        return String.valueOf(waitBeforeAutoPopupClose);
    }

    public void setWaitBeforeAutoPopupClose(String waitBeforeAutoPopupClose) {
        try {
            this.waitBeforeAutoPopupClose = Integer.valueOf(StringUtils.fixNumeric(waitBeforeAutoPopupClose));
        } catch (Exception e) {
//            Ignore
        }
    }

    public FindByType getType() {
        return this.type;
    }

    @ParameterProperties(description = "Please, select how to find the dual list ")
    public void setType(FindByType type) {
        this.type = type;
    }

    public String getDualListID() {
        return this.dualListID;
    }

    public void setDualListID(String dualListID) {
        this.dualListID = dualListID;
    }
}
