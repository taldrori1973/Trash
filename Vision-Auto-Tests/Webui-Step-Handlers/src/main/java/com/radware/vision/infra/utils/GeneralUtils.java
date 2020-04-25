package com.radware.vision.infra.utils;

import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.events.ReportWebDriverEventListener;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.widgets.api.popups.PopupContent;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.enums.WebElementType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.List;

public class GeneralUtils {

    public static String lineSeparator = System.lineSeparator();

    public static List<PopupContent> getLastPopupEvent() {
        List<PopupContent> popupErrors = null;
        if (WebUIDriver.getListenerManager().getWebUIDriverEventListener() != null) {
            popupErrors = ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).getLastPopupEvent();
        }
        return popupErrors;
    }

    public static void submitAndWait(int secondToWait) {

        WebUIVisionBasePage.submit();
        BasicOperationsHandler.delay(secondToWait);


    }

    public static void waitOperation(long timeout) {
        try {
            Thread.sleep(timeout);
        } catch (InterruptedException ie) {
            //	Ignore
        }
    }

    public static void waitOperation(String timeout) {
        try {
            waitOperation(Long.parseLong(timeout));
        } catch (NumberFormatException nfe) {
            waitOperation(1500);
        }
    }

    /**
     * closes the current tab and sets the driver listener on the first tab
     */
    public static void closeTab() {
        WebUIUtils.getDriver().close();
        List<String> tabs = new ArrayList<>(WebUIUtils.getDriver().getWindowHandles());
        WebUIUtils.getDriver().switchTo().window(tabs.get(0));
    }

    /**
     * @param tabNumber : the number of the tab to switch to
     */
    public static void switchToTab(int tabNumber) {
        List<String> tabs = new ArrayList<>(WebUIUtils.getDriver().getWindowHandles());
        WebUIUtils.getDriver().switchTo().window(tabs.get(tabNumber));
    }

    /**
     * @param webElementType   type of element looking for
     * @param value            the value of that element
     * @param operatorsEnum equals or contains
     * @return xpath
     */
    public static String buildGenericXpath(WebElementType webElementType, String value, OperatorsEnum operatorsEnum) {

        if (webElementType != WebElementType.XPATH) {

            StringBuilder stringBuilder = new StringBuilder("//*");
            if (operatorsEnum == OperatorsEnum.CONTAINS) {
                stringBuilder.append("[contains(@")
                        .append(webElementType.getAttributeValue())
                        .append(",")
                        .append("'")
                        .append(value)
                        .append("'")
                        .append(")]");

            } else {
                stringBuilder.append("[@")
                        .append(webElementType.getAttributeValue())
                        .append("=")
                        .append("'")
                        .append(value)
                        .append("'")
                        .append("]");


            }
            return stringBuilder.toString();
        }

        return value;
    }

    public static int getULLength(String label,String params){
        VisionDebugIdsManager.setLabel(label);
        if (params != null)
            VisionDebugIdsManager.setParams(params.split(","));

        WebElement element = WebUIVisionBasePage.getCurrentPage().getContainer().getWidget(label).getWebElement();
        if (element==null) throw new IllegalArgumentException("The Element with Label: "+label + "and Params: "+params+"was Not Found");
        if(element.getTagName().equals("ul")){
            return element.findElements(By.tagName("li")).size();
        }
        throw new IllegalArgumentException("The Element which found by Label: "+label + "and Params: "+params+" is "+element.getTagName()+" and Not ul");

    }
}
