package com.radware.vision.infra.tablepagesnavigation;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 10/13/2014.
 */
public class NavigateTable {

    public static void nextPage() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getNextPageButton());
        try {
            WebUIUtils.fluentWaitJSExecutor("arguments[0].click();", WebUIUtils.SHORT_WAIT_TIME, false, locator);
        } catch (Exception e) {
            BaseTestUtils.report(WebUIStringsVision.getNextPageButton() + "looks to be Disabled: " + e.getMessage() + "\n.", Reporter.FAIL);
        }
    }

    public static void prevPage() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getPrevPageButton());
        try {
            WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        } catch (Exception e) {
            BaseTestUtils.report(WebUIStringsVision.getPrevPageButton() + "looks to be Disabled: " + e.getMessage() + "\n.", Reporter.FAIL);
        }
    }

    public static void specificPage(String pageNum) {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getPageTextBox());
        try {
            WebElement textbox = WebUIUtils.fluentWaitDisplayedEnabled(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            textbox.clear();
            textbox.sendKeys(pageNum);
            textbox.sendKeys(Keys.ENTER);
        } catch (Exception e) {
            BaseTestUtils.report(locator.getLocatorValue() + "looks to be Disabled: " + e.getMessage() + "\n.", Reporter.FAIL);
        }
    }

    public static void firstPage() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getFirstPageButton());
        try {
            WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        } catch (Exception e) {
            BaseTestUtils.report(WebUIStringsVision.getFirstPageButton() + "looks to be Disabled: " + e.getMessage() + "\n.", Reporter.FAIL);
        }
    }

    public static void lastPage() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getLastPageButton());
        try {
            WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        } catch (Exception e) {
            BaseTestUtils.report(WebUIStringsVision.getLastPageButton() + "looks to be Disabled: " + e.getMessage() + "\n.", Reporter.FAIL);
        }
    }

    public static int getPageCount() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getPagesCount());
        int size = Integer.parseInt((new WebUIComponent(locator)).getWebElement(true).getText().substring(3));
        return size;
    }

    public static int getRowsTotal() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getTotalRows());
        String totalRows = (new WebUIComponent(locator)).getWebElement(true).getText();
        totalRows = totalRows.substring(totalRows.lastIndexOf(" ") + 1);

        return Integer.parseInt(totalRows);
    }

    public static int getCurrentPage() {
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getPageTextBox());
        WebElement element = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
        WebUITextField currentPageField = new WebUITextField(locator);
        currentPageField.setWebElement(element);

        return Integer.parseInt(currentPageField.getValue());
    }

}
