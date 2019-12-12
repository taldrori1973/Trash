package com.radware.vision.infra.base.pages.configuration.system;


import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.base.pages.configuration.system.managementports.ManagementPorts;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 9/4/2014.
 */
public class System {
    public ManagementPorts managementPortsMenu() {
        return (ManagementPorts)new ManagementPorts().openPage();
    }
    public void managementAccessMenu() {
        ComponentLocator locator = new ComponentLocator(How.ID , WebUIStringsVision.getManagementAccessNode());
        if((new WebUIComponent(locator)).getWebElement().getAttribute("aria-expanded").contains("false")){
            (new WebUIComponent(locator)).click();
        }
    }
}
