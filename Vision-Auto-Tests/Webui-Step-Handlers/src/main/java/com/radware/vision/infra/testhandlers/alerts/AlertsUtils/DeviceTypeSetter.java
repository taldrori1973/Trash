package com.radware.vision.infra.testhandlers.alerts.AlertsUtils;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.Arrays;
import java.util.List;

public class DeviceTypeSetter {
    public List<String> deviceTypeAll = Arrays.asList(new String[]{"defensepro", "Alteon", "insite", "appwall", "linkproof", "defense_flow"});//insite=vision
    public WebUICheckbox checkBox;
    ComponentLocator locator;
    public void checkDeviceTypeList(List<String> deviceTypes) {
        try {
            for (int i = 0; i < deviceTypes.size(); i++) {
                {
                    for (int j = 0; j < deviceTypeAll.size(); j++) {
                        if ((deviceTypeAll.get(j).toLowerCase()).contains(deviceTypes.get(i).toLowerCase()) || (deviceTypes.get(i).toLowerCase()).contains("vision")) {
                            if ((deviceTypes.get(i).toLowerCase()).contains("vision")) {
                                locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsDeviceTypeCombo(deviceTypeAll.get(2).toLowerCase().trim()));
                            } else {
                                locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsDeviceTypeCombo(deviceTypeAll.get(j).toLowerCase().trim()));
                            }
                            checkBox = new WebUICheckbox(locator);
                            checkBox.setWebElement((new WebUIComponent(locator)).getWebElement());
                            checkBox.check();
                        }
                    }

                }
            }
        } catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

    public void uncheckDeviceTypeAll() {
        try {
            for (int i = 0; i < deviceTypeAll.size(); i++) {
                ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsDeviceTypeCombo(deviceTypeAll.get(i).toLowerCase().trim()));
                WebUIComponent webUIComponent = new WebUIComponent(locator);
                checkBox = new WebUICheckbox(locator);
                checkBox.setWebElement((webUIComponent).getWebElement());
                checkBox.uncheck();
            }
        }
        catch(Exception e) {
            throw new IllegalStateException(e);
        }
	}
}
