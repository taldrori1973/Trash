package com.radware.vision.infra.base.pages.navigation;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.infra.enums.EqualsOrContains;
import com.radware.vision.infra.enums.UpperBarItems;
import com.radware.vision.infra.enums.WebElementType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.utils.GeneralUtils;
import org.openqa.selenium.By;
import org.openqa.selenium.support.How;

import java.util.Objects;

/**
 * Created by AviH on 13/01/2016.
 */

public class WebUIUpperBar {
    public static void doSelect(UpperBarItems item, boolean select, boolean needVerify) {
        doSelect(item, select, needVerify, false);
    }

    public static void select(UpperBarItems item) {
        select(item, false);
    }

    public static void select(UpperBarItems item, boolean negative) {
        Objects.requireNonNull(item);
        doSelect(item, true, true, negative);
    }

    public static void selectNoVerify(UpperBarItems item) {
        doSelect(item, true, false);
    }

    public static void unSelect(UpperBarItems item) {
        doSelect(item, false, false);
    }

    private static void doSelect(UpperBarItems item, boolean select, boolean needVerify, boolean negative) {
        Boolean[] toggles = item.getToggles();
        String[] menuIds = item.getMenuIds().split(",");
        String[] verifyIds = item.getVerifyIds().split(",");
        for (int index = 0; index < menuIds.length; index++) {
            ComponentLocator locator = new ComponentLocator(How.ID, menuIds[index]);
            BasicOperationsHandler.delay(2);
            if (select) {
                if ((!isSelected(locator) && toggles[index]) || !toggles[index]) {

                    if (item.equals(UpperBarItems.ToolBox_Advanced)) {
                        ComponentLocator toolbox = new ComponentLocator(How.ID, UpperBarItems.ToolBox.getMenuIds());
                        if (!WebUIUtils.isItemSelected(toolbox))
                            WebUIUtils.fluentWaitClick(toolbox.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

                    }


                    if (item.equals(UpperBarItems.AVR) || item.equals(UpperBarItems.CLOUD_DDOS_PORTAL) || item.equals(UpperBarItems.V_DIRECT)
                            || item.equals(UpperBarItems.security_control_center) || item.equals(UpperBarItems.DPM)) {

                        WebUIUtils.fluentWaitClick(By.id(UpperBarItems.TOOLTIP.getMenuIds()), WebUIUtils.SHORT_WAIT_TIME, false);

                    }

                    if (item.equals(UpperBarItems.EAAF_Dashboard) || item.equals(UpperBarItems.GEL_Dashboard))
                    {
                        VisionDebugIdsManager.setTab(item.getName());
                        WebUIUtils.fluentWaitClick(By.id(UpperBarItems.TOOLTIP.getMenuIds()), WebUIUtils.DEFAULT_WAIT_TIME, false);
                    }

                    if (item.equals(UpperBarItems.AMS) || item.equals(UpperBarItems.ADC)) {
                        WebUIUtils.fluentWaitClick(By.id(UpperBarItems.ANALYTICS.getMenuIds()), WebUIUtils.SHORT_WAIT_TIME, false);
                    }
                    if (negative) {
                        WebUIUtils.setIsTriggerPopupSearchEvent(false);
                    }
                    WebUIUtils.fluentWait(locator.getBy()).click();
                    WebUIUtils.setIsTriggerPopupSearchEvent(true);


                    if (!needVerify || verifyIds.length <= index) continue;
                    String verifyId = verifyIds[index];
                    //Find a specific element in ui for verification
                    if (!verifyId.isEmpty()) {
                        int count = 0;
                        String verifyElementXpath = "";


                        if (!item.equals(UpperBarItems.DPM)) {
                            verifyElementXpath = GeneralUtils.buildGenericXpath(WebElementType.Id, verifyId, EqualsOrContains.EQUALS);
                        } else {
                            GeneralUtils.switchToTab(1);
                            verifyElementXpath = verifyId;
                        }
                        boolean elementExists;
                        do {
                            elementExists = ClickOperationsHandler.checkIfElementExistAndDisplayed(verifyElementXpath);
                            if (!elementExists) {
                                BasicOperationsHandler.delay(0.1);
                                elementExists = ClickOperationsHandler.checkIfElementExistAndDisplayed(verifyElementXpath);
                            }

                        } while (!elementExists && count++ < 5);
                        if (item.equals(UpperBarItems.DPM)) {
                            GeneralUtils.closeTab();
                        }
                        if (!elementExists) {
                            BaseTestUtils.report("Failed to select Upper Bar item: " + menuIds[index], Reporter.FAIL);
                        }
                    }
                }
            } else {
                if ((isSelected(locator) && toggles[index]) || toggles[index]) {
                    WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
                    ClickOperationsHandler.clickWebElement(WebElementType.Id, locator.getLocatorValue(), 0);
                }
            }
        }
    }

    private static boolean isSelected(ComponentLocator locator) {
        String attr = WebUIUtils.fluentWaitAttribute(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false, "class", null);
        if (attr == null) {
            return false;
        }
        String classStr = WebUIUtils.fluentWaitAttribute(locator.getBy(), WebUIUtils.SHORT_WAIT_TIME, false, "class", null).toLowerCase();
        if (classStr.contains("-selected") || classStr.contains("-triggered")) {
            return true;
        } else {
            return false;
        }
    }
}
