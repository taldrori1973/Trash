package com.radware.vision.infra.base.pages.alerts;

import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.automation.webui.widgets.impl.WebUIVerticalTab;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 10/5/2014.
 */
public class AlertBrowser extends WebUIVisionBasePage {
    public Display display;

    public AlertBrowser() {
        super("APSolute Vision Auditing Settings", "MgtServer.AlertBrowser.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getAlertBrowserNode());
    }

    private void switchToDisplayTab() {
        WebUIVerticalTab displayTab = (WebUIVerticalTab) container.getVerticalTab("Display");
        String classValue = displayTab.getWebElement().getAttribute("class");
        if (!(classValue.contains("selected")))
            displayTab.click();
    }

    public class Display {
        private Display() {
        }

        public void setRefreshInterval(String refreshInterval) {
            switchToDisplayTab();
            WebUITextField confirmPasswordField = (WebUITextField) container.getTextField("Refresh Interval");
            setTextFieldIfNotEmpty(confirmPasswordField, refreshInterval);
        }

        public void setLastCriticalAlertNumber(String lastCriticalAlertNumber) {
            switchToDisplayTab();
            WebUITextField confirmPasswordField = (WebUITextField) container.getTextField("Last Critical Alert Number");
            setTextFieldIfNotEmpty(confirmPasswordField, lastCriticalAlertNumber);
        }
    }

    public Display getDisplay() {
        if (this.display != null)
            return this.display;
        else
            return new Display();
    }

    private void setTextFieldIfNotEmpty(WebUITextField taskElement, String value) {
        if (value != null && !value.isEmpty()) {
            taskElement.type(value);
        }
    }

}
