package com.radware.vision.tests.generalsettings.monitoring;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.testhandlers.system.generalsettings.monitoring.MonitoringHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by moaada on 7/16/2017.
 */
public class MonitoringTests extends WebUITestBase {

    String pollingIntervalForReports;


    @Test
    @TestProperties(name = "Set polling interval for reports", paramsInclude = "pollingIntervalForReports")
    public void setPollingIntervalForReports() throws TargetWebElementNotFoundException {

        MonitoringHandler.setPollingIntervalForReports(pollingIntervalForReports);
        if (MonitoringHandler.getPollingIntervalForReports().equals(pollingIntervalForReports)) {
            BaseTestUtils.report("setting polling interval for reports to: " + pollingIntervalForReports + " has succeeded", Reporter.PASS);
        } else {
            BaseTestUtils.report("setting polling interval for reports to: " + pollingIntervalForReports + " has failed", Reporter.FAIL);
        }

    }


    public String getPollingIntervalForReports() {
        return pollingIntervalForReports;
    }

    public void setPollingIntervalForReports(String pollingIntervalForReports) {
        this.pollingIntervalForReports = pollingIntervalForReports;
    }

}
