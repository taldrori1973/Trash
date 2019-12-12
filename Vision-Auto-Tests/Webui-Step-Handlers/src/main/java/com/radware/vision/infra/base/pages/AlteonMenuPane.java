package com.radware.vision.infra.base.pages;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.base.pages.alteon.configuration.system.System;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by moaada on 7/27/2017.
 */
public class AlteonMenuPane {

    private static ComponentLocator locator;

    private static void click() {
        (new WebUIComponent(locator)).click();
    }

    public static void openConfiguration() {
        locator = new ComponentLocator(How.ID, WebUIStringsVision.getLeftMenuPaneConfiguration());
        click();
    }


    public static System openSystem() {
        openConfiguration();
        locator = new ComponentLocator(How.ID, WebUIStringsVision.getLeftMenuPaneConfigurationSystem());
        click();
        return new System();

    }
}
