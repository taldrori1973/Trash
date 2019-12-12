package com.radware.vision.infra.base.pages;

import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.base.pages.configuration.system.System;
import com.radware.vision.infra.base.pages.preferences.Preferences;
import com.radware.vision.infra.base.pages.system.deviceresources.DeviceResources;
import com.radware.vision.infra.base.pages.system.generalsettings.GeneralSettings;
import com.radware.vision.infra.base.pages.system.usermanagement.UserManagement;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

public class VisionServerMenuPane {
	
	public void openSystemPane() {
		BasicOperationsHandler.settings();
//		BasicOperationsHandler.delay(1);
		ComponentLocator systemPaneButtonLoc = new ComponentLocator(How.ID ,WebUIStrings.getLeftMenuPaneSystem());
		(new WebUIComponent(systemPaneButtonLoc)).click();
	}
	
	public void openPreferencesPane() {
		ComponentLocator locator = new ComponentLocator(How.ID ,WebUIStrings.getLeftMenuPanePreferences());
		(new WebUIComponent(locator)).click();
	}
	
	public GeneralSettings openSystemGeneralSettings() {
		openSystemPane();
		ComponentLocator locator = new ComponentLocator(How.ID ,WebUIStrings.getLeftMenuPaneSystemGeneralSettigns());
		(new WebUIComponent(locator)).click();
		return new GeneralSettings();
	}
	
	public UserManagement openSystemUserManagement() {
		openSystemPane();
		ComponentLocator locator = new ComponentLocator(How.ID ,WebUIStrings.getLeftMenuPaneSystemUserMgmt());
		(new WebUIComponent(locator)).click();
		return new UserManagement();
	}
	
	public DeviceResources openSystemDeviceResources() {
		openSystemPane();
		ComponentLocator locator = new ComponentLocator(How.ID ,WebUIStrings.getLeftMenuPaneSystemDeviceResources());
		(new WebUIComponent(locator)).click();
        return new DeviceResources();
	}
    public void openConfigurationPane() {
		ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getLeftMenuPaneConfiguration());
		(new WebUIComponent(locator)).click();
	}

	public void openMonitoringPane() {
		ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getLeftMenuPaneMonitoring());
		(new WebUIComponent(locator)).click();
	}

	public void openSecurityMonitoringPane() {
		ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getLeftMenuPaneSecurityMonitoring());
		(new WebUIComponent(locator)).click();
	}

	public System openSystem(){
        openConfigurationPane();
        ComponentLocator locator = new ComponentLocator(How.ID ,WebUIStringsVision.getLeftMenuPaneConfigurationSystem());
        (new WebUIComponent(locator)).click();
        return new System();
    }

	public System openVisionSystem() {
		BasicOperationsHandler.settings();
//		BasicOperationsHandler.delay(1);
		ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getLeftMenuPaneConfigurationVisionSystem());
		(new WebUIComponent(locator)).click();
		return new System();
	}

	public Preferences openVisionPreferences() {
		BasicOperationsHandler.settings();
//		BasicOperationsHandler.delay(1);
		ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getLeftMenuPaneConfigurationPreferences());
		(new WebUIComponent(locator)).click();
		return new Preferences();
	}

	public void managementAccessMenu() {
        ComponentLocator locator = new ComponentLocator(How.ID , WebUIStringsVision.getManagementAccessNode());
        if((new WebUIComponent(locator)).getWebElement().getAttribute("aria-expanded").contains("false")){
            (new WebUIComponent(locator)).click();
        }
    }

}
