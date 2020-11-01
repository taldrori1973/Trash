package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts;

import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import org.openqa.selenium.WebElement;

import java.util.List;

public class WebUiTools {
    static final String checkedNotCheckedAttribute = "data-debug-checked";
    static final String ariaChecked = "aria-checked";

    public static WebElement getWebElement(String label) {
        return getWebElement(label, "");
    }

    public static WebElement getWebElement(String label, String params) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        return WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
    }
    public static List<WebElement> getWebElements(String label, String params) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        return WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
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
    public static void check(String label, String param, boolean isToCheck) throws Exception {
        WebElement checkElement = getWebElement(label, param);
        if (checkElement == null)
            throw new Exception("No Element with label " + label + " and params " + param);
        checkWebElement(checkElement, isToCheck);

    }

    private static void checkWebElement( WebElement checkElement, boolean isToCheck) {
        if ((webElementHasAttribute(checkElement, "class") && checkElement.getAttribute("class").matches(".*selected.*|.*checked.*")||
                webElementHasAttribute(checkElement, checkedNotCheckedAttribute) && checkElement.getAttribute(checkedNotCheckedAttribute).matches(".*true.*|.*checked.*")||
                webElementHasAttribute(checkElement, ariaChecked) && checkElement.getAttribute(ariaChecked).matches(".*true.*|.*checked.*"))
                ^ isToCheck)
            checkElement.click();
    }
}
