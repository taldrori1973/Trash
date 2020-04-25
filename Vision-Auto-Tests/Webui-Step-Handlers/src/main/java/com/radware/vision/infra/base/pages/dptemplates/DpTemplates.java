package com.radware.vision.infra.base.pages.dptemplates;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.automation.webui.widgets.impl.table.WebUIRow;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.DpConfigurationTemplatesColumns;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.Keys;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.How;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.util.List;
import java.util.*;

public class DpTemplates extends WebUIVisionBasePage {
    static Map<DpConfigurationTemplatesColumns, String> templatesTableHeadersSearchLocators = new HashMap<DpConfigurationTemplatesColumns, String>();

    static {
        templatesTableHeadersSearchLocators.put(DpConfigurationTemplatesColumns.SOURCE_DEVICE_NAME, "gwt-debug-deviceName_Widget-input");
        templatesTableHeadersSearchLocators.put(DpConfigurationTemplatesColumns.FILE_NAME, "gwt-debug-name_SearchControl");
        templatesTableHeadersSearchLocators.put(DpConfigurationTemplatesColumns.FILE_TYPE, "gwt-debug-exportedFileType_Widget-input");
        templatesTableHeadersSearchLocators.put(DpConfigurationTemplatesColumns.EXPORT_DATE, "gwt-debug-downloadTime_SearchControl");
    }

    String tableId = "DPConfigurationTemplatesTable";

    public DpTemplates() {
        super("DefencePro Configuration Templates", "DPConfigTemplates.DPConfigurationTemplates.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getAlertsTab());
    }

    public static void uploadFileToServerButtonClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getDpTemplatesTableNewButton());
        (new WebUIComponent(locator)).click();

    }

    public static void downloadSelectedFileButtonClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getDpTemplatesTableDownloadButton());
        (new WebUIComponent(locator)).click();
//        try {//===================== The browser should be configured to automatically execute previously specified action (Stas)
//            clickSaveFileRadioButton();
//        } catch (Exception e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }

    }

    public static void sendToDevicesButtonClick() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getDpTemplatesTableSendToDevicesButton());
        WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
    }

    public static void setSearchDropdown(DpConfigurationTemplatesColumns columnName, String optionTest) {
        ComponentLocator locator;

        if (optionTest != null && !optionTest.isEmpty()) {
            locator = new ComponentLocator(How.ID, templatesTableHeadersSearchLocators.get(columnName));
            WebUITextField textField = new WebUITextField(locator);
            textField.setWebElement(new WebUIComponent(locator).getWebElement());
            Actions actions = new Actions(WebUIUtils.getDriver());
            actions.sendKeys(textField.getWebElement(), optionTest);
            actions.sendKeys(Keys.ENTER);
            actions.perform();
        }
    }

    public static void clickSearchButton() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getDpTemplatesApplyFilter());
        (new WebUIComponent(locator)).click();
    }

    private static void clickSaveFileRadioButton() throws Exception {

        // native key strokes for CTRL, V and ENTER keys
        try {
//            Robot robot = new Robot();
//            robot.delay(1000);
//            robot.keyPress(KeyEvent.VK_DOWN);
            Robot enterRobot = new Robot();
            enterRobot.delay(1000);
            enterRobot.keyPress(KeyEvent.VK_ENTER);

        } catch (AWTException e) {
            throw new Exception("Could NOT select ", e);
        }
    }

    public void selectTemplate(String columnName, String columnValue) {
        WebUITable table = (WebUITable) container.getTableById(tableId);
        table.clickRowByKeyValue(columnName, columnValue);
    }

    public void deleteTemplate(String columnName, String columnValue) {
        WebUITable table = (WebUITable) container.getTableById(tableId);
        table.deleteRowByKeyValue(columnName, columnValue);
    }

    public void deleteAllTemplates() {
        WebUITable table = (WebUITable) container.getTableById(tableId);
        table.deleteAll();
    }

    public void clickDeleteButton() {

        try {
            WebUIUtils.setIsTriggerPopupSearchEvent(false);
            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getDpTemplatesTableDeleteButton());
            (new WebUIComponent(locator)).click();
        } finally {
            WebUIUtils.setIsTriggerPopupSearchEvent(true);
        }
    }

    public void selectMultipleTemplate(String columnName, String columnValuesList) {
        WebUITable table = (WebUITable) container.getTableById(tableId);
        table.setWaitForTableToLoad(true);
        List<String> list = new ArrayList<String>();
        table.analyzeTable("div");
        if (columnValuesList != null) {
            list = Arrays.asList(columnValuesList.split(","));
        }

        List<ComponentLocator> rowLocators = new ArrayList<ComponentLocator>();
        for (WebUIRow locator : table.getRows(list, columnName)) {
            rowLocators.add(locator.getLocator());
        }
        WebUIUtils.clickMultiSelectByLocator(rowLocators, table.getWebElement());
    }

    public WebUITable getTemplatesTable() {
        WebUITable table = (WebUITable) container.getTableById(tableId);
        table.setWaitForTableToLoad(false);
        return table;
    }


    public enum DefenceConfigurationTemplatesTree {

        DEFENCE_CONFIGURATION_TEMPLATES("gwt-debug-DefensePro_TemplatesNode-content"),
        NETWORK_PROTECTION("gwt-debug-NetworkProtectionNode-content"),
        SERVER_PROTECTION("gwt-debug-ServerProtectionNode-content");

        private String id;

        DefenceConfigurationTemplatesTree(String id) {
            this.id = id;
        }

        public String getId() {
            return id;
        }
    }
}
