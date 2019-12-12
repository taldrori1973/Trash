package com.radware.vision.infra.utils;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.interactions.Actions;

public class MouseUtils {

    /**
     * move the mouse from its current position to given(x,y).
     *
     * @param x
     * @param y
     */
    public static void moveMouse(int x, int y) {

        WebDriver driver = WebUIUtils.getDriver();
        Actions action = new Actions(driver);
        action.moveByOffset(x, y);
        action.perform();
    }

    public static void hover(ComponentLocator component) {

        WebDriver driver = WebUIUtils.getDriver();
        Actions action = new Actions(driver);
        action.moveToElement(WebUIUtils.fluentWait(component.getBy()));
        action.perform();
    }

}
