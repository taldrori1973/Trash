package com.radware.vision.infra.testhandlers.alerts.AlertsUtils;

import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIComponent;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

import java.util.Arrays;
import java.util.List;

public class ModuleSetter {
    public static List<String> modulesAll = Arrays.asList("Vision Configuration", "Vision General", "Vision Control", "Device General", "Device Health Errors",
            "Device Security", "Vision Analytics Alerts", "Retention Alerts", "Security Reporting", "Trouble Ticket", "Operator Toolbox", "GEL License", "vDirect General");
    public WebUICheckbox moduleCheckBox;

    public void checkModules(List<String> modulesList) {
        for (String module : modulesList) {
            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsModuleCombo(module.toLowerCase().trim()));
            moduleCheckBox = new WebUICheckbox(locator);
            moduleCheckBox.setWebElement((new WebUIComponent(locator)).getWebElement());
            moduleCheckBox.check();
        }
    }

    public void uncheckModulesAll() {
        for (String s : modulesAll) {
            ComponentLocator locator = new ComponentLocator(How.ID, WebUIStringsVision.getAlertsModuleCombo(s.toLowerCase().trim()));
            moduleCheckBox = new WebUICheckbox(locator);
            moduleCheckBox.setWebElement((new WebUIComponent(locator)).getWebElement());
            moduleCheckBox.uncheck();
        }
    }
}
