package com.radware.vision.infra.testhandlers.alerts.AlertsUtils;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.Arrays;
import java.util.List;

public class AcknowledgementSetter {
	public static final List<String> ackStatusAll = Arrays.asList(new String[]{"acknowledged", "unAcknowledged" });
    public WebUICheckbox checkBox;

    public void checkAckStatusList(List<String> ackStatus) {
        for (int i = 0; i < ackStatusAll.size(); i++) {
            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsAckStatusCombo(ackStatusAll.get(i).trim()));
            checkBox = new WebUICheckbox(locator);
            checkBox.setWebElement((new WebUIComponent(locator)).getWebElement());
            checkBox.check();
        }
        if (ackStatus.size() == 1) {
            if (ackStatus.get(0).equalsIgnoreCase(ackStatusAll.get(0))) {
                ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsAckStatusCombo(ackStatusAll.get(1).trim()));
                checkBox = new WebUICheckbox(locator);
                checkBox.setWebElement((new WebUIComponent(locator)).getWebElement());
                checkBox.uncheck();
            } else if (ackStatus.get(0).equalsIgnoreCase(ackStatusAll.get(1))) {
                ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsAckStatusCombo(ackStatusAll.get(0).trim()));
                checkBox = new WebUICheckbox(locator);
                checkBox.setWebElement((new WebUIComponent(locator)).getWebElement());
                checkBox.uncheck();
            }
        }
    }

    public void uncheckAckStatusAll() {
		for(int i = 0;i < ackStatusAll.size();i++)
		{
			ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsAckStatusCombo(ackStatusAll.get(i).trim()));
            checkBox = new WebUICheckbox(locator);
            checkBox.setWebElement((new WebUIComponent(locator)).getWebElement());
			checkBox.uncheck();
		}
	}
}
