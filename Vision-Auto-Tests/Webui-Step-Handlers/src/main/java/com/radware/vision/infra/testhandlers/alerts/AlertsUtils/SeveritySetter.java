package com.radware.vision.infra.testhandlers.alerts.AlertsUtils;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.Arrays;
import java.util.List;

public class SeveritySetter {
	public List<String> severityAll = Arrays.asList(new String[]{"critical", "major", "minor", "warning", "info"});
    public WebUICheckbox severityCheckBox;

    public void checkSeverityList(List<String> severityList) {
		for(int i = 0;i < severityList.size();i++)
		{
			if(severityList.get(i).contains(severityAll.get(4))) severityList.set(i, severityAll.get(4));
            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsSeverityCombo(severityList.get(i).toLowerCase().trim()));
            severityCheckBox = new WebUICheckbox(locator);
                    severityCheckBox.setWebElement((new WebUIComponent(locator)).getWebElement());
                    severityCheckBox.check();
        }
	}
	
	public void uncheckSeverityAll() {
		for(int i = 0;i < severityAll.size();i++)
		{
			ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsSeverityCombo(severityAll.get(i).toLowerCase().trim()));
			severityCheckBox = new WebUICheckbox(locator);
			severityCheckBox.setWebElement((new WebUIComponent(locator)).getWebElement());
			severityCheckBox.uncheck();
		}
	}
}
