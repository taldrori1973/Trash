package com.radware.vision.infra.testhandlers.visionsettings.dashboards.applicationsladashboard;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

public class ApplicationSlaDashboardHandler {


    public static boolean IsPageVisible(Boolean visible) {

        WebUIVisionBasePage.navigateToPage("Dashboards");
        WebElement applicationSlaTab = WebUIUtils.fluentWait(new ComponentLocator(How.ID, "gwt-debug-ConfigTab_Tab").getBy(), WebUIUtils.SHORT_WAIT_TIME, false);

        if (visible && applicationSlaTab == null || !visible && applicationSlaTab != null) return false;

        return true;
    }
}
