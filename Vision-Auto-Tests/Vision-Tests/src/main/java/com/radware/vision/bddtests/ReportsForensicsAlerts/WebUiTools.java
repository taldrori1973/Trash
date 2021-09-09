package com.radware.vision.bddtests.ReportsForensicsAlerts;

import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import org.openqa.selenium.ElementNotInteractableException;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebElement;

import java.util.Arrays;
import java.util.List;

public class WebUiTools {
    public static final String checkedNotCheckedAttribute = "data-debug-checked";
    public static final String ariaChecked = "aria-checked";

    public static WebElement getWebElement(String label) {
        return getWebElement(label, "");
    }

    public static WebElement getWebElement(String label, String params) {
        return WebUIUtils.fluentWait(getComponentLocator(label, params).getBy());
    }
    public static WebElement getWebElement(String label, String []params) {
//        return WebUIUtils.fluentWait(getComponentLocator(label, params).getBy());
        return WebUIUtils.fluentWait(getComponentLocatorgetByEqualsXpathLocator(label, params).getBy());
    }

    public static ComponentLocator getComponentLocator(String label, String [] param)
    {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(param);
        return ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId());
    }

    public static ComponentLocator getComponentLocatorgetByEqualsXpathLocator(String label, String [] param)
    {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(param);
        return ComponentLocatorFactory.getEqualsXpathLocator(VisionDebugIdsManager.getDataDebugId());
    }

    public static List<WebElement> getWebElements(String label, String ... params) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        return WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
    }

    public static ComponentLocator getComponentLocator(String label, String param)
    {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(param.split(","));
        return ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId());
    }

    public static boolean webElementHasAttribute(WebElement webElement, String attribute) {
            try
            {
                return webElement.getAttribute(attribute) != null;
            }
            catch (Exception e)
            {
                return false;
            }
    }

    public static void checkElements(String label, String param, boolean isToBeChecked) {
        List<WebElement> elements = getWebElements(label, param);
        for (WebElement element : elements)
            checkWebElement(element, isToBeChecked);
    }
    public static void check(String label, List<Object> params, boolean isToBeChecked) {
        for (Object param:params)
            checkWebElement(getWebElement(label, param.toString()), isToBeChecked);
    }
    public static void check(String label, String [] param, boolean isToCheck) throws Exception {
//        WebElement checkElement = getClickabledWebElement(getWebElement(label, param));
        WebElement checkElement = getClickabledWebElement(getWebElement(label, param));
        WebUIUtils.scrollIntoView(checkElement, false);
        if (checkElement == null)
            throw new Exception("No Element with label " + label + " and params " + Arrays.toString(param));
        checkWebElement(checkElement, isToCheck);
    }

    public static void check(String label, String param, boolean isToCheck) throws Exception {
        check(label, new String[]{param}, isToCheck);
    }

    private static void checkWebElement( WebElement checkElement, boolean isToCheck) {
        if (isElementChecked(checkElement)
                ^ isToCheck) {
            clickWebElement(checkElement);
        }
    }

    public static boolean isElementChecked(WebElement checkElement) {
        return webElementHasAttribute(checkElement, checkedNotCheckedAttribute) && checkElement.getAttribute(checkedNotCheckedAttribute).matches(".*true.*|.*checked.*")||
                webElementHasAttribute(checkElement, ariaChecked) && checkElement.getAttribute(ariaChecked).matches(".*true.*|.*checked.*")||
                webElementHasAttribute(checkElement, "class") && checkElement.getAttribute("class").matches(".*selected.*|.*checked.*|on")||
                webElementHasAttribute(checkElement, "checked");
    }

    public static void clickWebElement(WebElement webElement) {
        try
        {
            webElement.click();
        }catch (Exception e)
        {
//            webElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
            webElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getEqualsXpathLocator(VisionDebugIdsManager.getDataDebugId()).getBy());
            try
            {
                WebUIUtils.scrollIntoView(webElement);
                WebUIUtils.sleep(4);
                webElement.click();
            }catch (ElementNotInteractableException eNIE)
            {
                ((JavascriptExecutor) WebUIUtils.getDriver()).executeScript("arguments[0].click();", webElement);
            }
        }
    }

    protected static WebElement getClickabledWebElement(WebElement webElement) {
    //    List<WebElement> webElements = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        List<WebElement> webElements = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getEqualsXpathLocator(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (webElements.size()>1)
        {
            int i;
            for(i=0; i< webElements.size(); i++)
            {
                try
                {
//                    WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).get(i).click();
//                    WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).get(i).click();
                    WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getEqualsXpathLocator(VisionDebugIdsManager.getDataDebugId()).getBy()).get(i).click();
                    WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getEqualsXpathLocator(VisionDebugIdsManager.getDataDebugId()).getBy()).get(i).click();
                    break;
                }catch (Exception e)
                {

                }
            }
//            return WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).get(i);
            return  WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getEqualsXpathLocator(VisionDebugIdsManager.getDataDebugId()).getBy()).get(i);

        }
        return webElement;
    }
}
