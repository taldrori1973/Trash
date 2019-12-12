package com.radware.vision.bddtests.visionsettings;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.bddtests.BddUITestBase;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

public class VisionSettingsBase extends BddUITestBase {
    public VisionSettingsBase() throws Exception {
    }

    protected boolean clickMenu(String subMenuOption, String optionName) {
        String elementId = "gwt-debug-TopicsNode_am." + subMenuOption + "." + optionName + "-content";
        ComponentLocator locator = new ComponentLocator(How.ID, elementId);
        WebElement element = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (element != null) {
            element.click();
        } else {
            return false;
        }
        return true;
    }

    protected boolean clickMenu(String elementId) {
        ComponentLocator locator = new ComponentLocator(How.ID, elementId);
        WebElement element = WebUIUtils.fluentWaitDisplayed(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        if (element != null) {
            element.click();
        } else {
            return false;
        }
        return true;
    }
}
