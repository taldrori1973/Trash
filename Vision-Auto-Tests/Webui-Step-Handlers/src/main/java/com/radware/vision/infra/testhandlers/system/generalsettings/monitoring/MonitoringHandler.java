package com.radware.vision.infra.testhandlers.system.generalsettings.monitoring;

import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.system.generalsettings.monitoring.Monitoring;
import com.radware.vision.infra.utils.WebUIStringsVision;

/**
 * Created by moaada on 7/16/2017.
 */
public class MonitoringHandler {

    public static void setPollingIntervalForReports(String value) throws TargetWebElementNotFoundException {

        Monitoring monitoring = openDisplayMenu();
        monitoring.getMonitoring().setPollingIntervalForReports(value);
        WebUIVisionBasePage.submit(WebUIStringsVision.getMonitoringSubmitButton());
    }

    public static String getPollingIntervalForReports() {

        Monitoring monitoring = openDisplayMenu();
        return monitoring.getMonitoring().getPollingIntervalForReports();
    }


    public static Monitoring openDisplayMenu() {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        return menuPane.openSystemGeneralSettings().monitoringMenu();
    }
}
