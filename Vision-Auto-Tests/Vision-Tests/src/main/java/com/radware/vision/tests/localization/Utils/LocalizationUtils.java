package com.radware.vision.tests.localization.Utils;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

/**
 * Created by StanislavA on 5/28/2015.
 */
public class LocalizationUtils {

    public static boolean clickOnTab(String id) {
        ComponentLocator locator = new ComponentLocator(How.ID, id);
        WebElement element = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (element != null) {
            element.click();
        } else {
            return false;
        }
        return true;
    }
}
