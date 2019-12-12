package com.radware.vision.infra.testhandlers.alerts.AlertsUtils;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.Arrays;
import java.util.List;

public class ModuleSetter {
	public static List<String> modulesAll = Arrays.asList(new String[]{"Vision Configuration", "Vision General", "Vision Control", "Device General",
			"Device Security", "Security Reporting", "Trouble Ticket", "Operator Toolbox"});
    public WebUICheckbox moduleCheckBox;

    public void checkModules(List<String> modulesList) {
		for(int i = 0;i < modulesList.size();i++)
		{
            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsModuleCombo(modulesList.get(i).toLowerCase().trim()));
            moduleCheckBox = new WebUICheckbox(locator);
            moduleCheckBox.setWebElement((new WebUIComponent(locator)).getWebElement());
            moduleCheckBox.check();

        }
	}
	
	public void uncheckModulesAll() {
		for(int i = 0;i < modulesAll.size();i++)
		{
			ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsModuleCombo(modulesAll.get(i).toLowerCase().trim()));
            moduleCheckBox = new WebUICheckbox(locator);
            moduleCheckBox.setWebElement((new WebUIComponent(locator)).getWebElement());
            moduleCheckBox.uncheck();
		}
	}
}
