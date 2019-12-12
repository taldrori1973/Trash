package com.radware.vision.infra.base.pages.system.generalsettings.monitoring;

import com.radware.automation.webui.widgets.api.TextField;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by moaada on 7/13/2017.
 */
public class Monitoring extends WebUIVisionBasePage {

    private Monitoring monitoring;
    public final static String POLLING_INTERVAL_FOR_REPORTS = "Polling Interval for Reports";


    public Monitoring() {
        super("Monitoring", "MgtServer.Monitoring.xml", false);
        setPageLocatorHow(How.ID);
        setPageLocatorContent(WebUIStringsVision.getGeneralSettingsMonitoringNode());
    }

    public void setPollingIntervalForReports(String value) throws TargetWebElementNotFoundException {
        TextField pollingIntervalTextField = container.getTextField(POLLING_INTERVAL_FOR_REPORTS);
        pollingIntervalTextField.replaceContent(value);

    }

    public String getPollingIntervalForReports() {
        TextField pollingIntervalTextField = container.getTextField(POLLING_INTERVAL_FOR_REPORTS);
        return pollingIntervalTextField.getValue();

    }

    public Monitoring getMonitoring() {
        return monitoring != null ? monitoring : new Monitoring();
    }
}
