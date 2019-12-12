package com.radware.vision.infra.base.pages;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.base.pages.defensepro.configuration.setup.Setup;
import com.radware.vision.infra.utils.WebUIStringsDp;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by moaada on 7/26/2017.
 */
public class DpMenuPane {

    private static ComponentLocator locator;

    private static void click() {
        (new WebUIComponent(locator)).click();
    }


    public static void openConfiguration() {
        locator = new ComponentLocator(How.ID, WebUIStringsVision.getLeftMenuPaneConfiguration());
        click();
    }

    public static Setup openSetup() {
        openConfiguration();
        locator = new ComponentLocator(How.ID, WebUIStringsDp.getSetup());
        click();
        return new Setup();

    }


}
