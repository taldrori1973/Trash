package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts;

import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import org.openqa.selenium.WebElement;

public class WebUiTools {
    static final String checkedNotCheckedAttribute = "data-debug-checked";

    public static WebElement getWebElement(String label) {
        return getWebElement(label, "");
    }

    public static WebElement getWebElement(String label, String params) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        return WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
    }

    public static void check(String label, String param, boolean toCheck) throws Exception {
        WebElement checkElement = getWebElement(label, param);
        if (checkElement == null)
            throw new Exception("No Element with label " + label + " and params " + param);
        if (webElementHasAttribute(checkElement, "class") && checkElement.getAttribute("class").matches(".*selected.*|.*checked.*")||
                webElementHasAttribute(checkElement, checkedNotCheckedAttribute) && checkElement.getAttribute(checkedNotCheckedAttribute).matches(".*true.*|.*checked.*")
                    ^ toCheck)
            checkElement.click();

    }
    public static boolean webElementHasAttribute(WebElement webElement, String attribute) {
            try
            {
                webElement.getAttribute(attribute);
            }
            catch (Exception e)
            {
                return false;
            }
            return true;
    }
}
