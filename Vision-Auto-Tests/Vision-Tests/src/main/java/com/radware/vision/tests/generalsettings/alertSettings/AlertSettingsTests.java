package com.radware.vision.tests.generalsettings.alertSettings;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.testhandlers.alerts.AlertsValidationHandler;
import com.radware.vision.infra.testhandlers.system.generalsettings.alertSettings.AlertSettingsHandler;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;
import testhandlers.Device;

/**
 * Created by stanislava on 10/5/2014.
 */
public class AlertSettingsTests extends WebUITestBase {

    public String refreshInterval;
    public String LastCriticalAlertNumber;

    @Test
    @TestProperties(name = "set  RefreshInterval", paramsInclude = {"qcTestId", "refreshInterval"})
    public void setRefreshInterval() {
        try {
            AlertSettingsHandler.setRefreshInterval(refreshInterval);
        } catch (Exception e) {
            BaseTestUtils.report("Set <refreshInterval>:" + refreshInterval + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "set  LastCriticalAlertNumber", paramsInclude = {"qcTestId", "LastCriticalAlertNumber"})
    public void setLastCriticalAlertNumber() {
        try {
            AlertSettingsHandler.setLastCriticalAlertNumber(LastCriticalAlertNumber);
        } catch (Exception e) {
            BaseTestUtils.report("Set <LastCriticalAlertNumber>:" + LastCriticalAlertNumber + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    //@ParameterProperties(description = "alertsFilter Test must be correctly applied prior to running this validation Test!!!")
    @Test
    @TestProperties(name = "validate LastCriticalAlertNumber", paramsInclude = {"qcTestId"})
    public void validateLastCriticalAlertNumber() {
        try {
            if (!AlertsValidationHandler.validateCriticalAlerts(getVisionRestClient())) {
                BaseTestUtils.report("LastCriticalAlertNumber validation has failed: " + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Validate <LastCriticalAlertNumber>:" + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "validate RefreshInterval", paramsInclude = {"qcTestId", "refreshInterval"})
    public void validateRefreshInterval() {
        try {
            long actualRefreshTime = AlertsValidationHandler.validateRefreshInterval(getVisionRestClient(), com.radware.vision.pojomodel.helpers.constants.ImConstants$VisionMgtPortEnumPojo.G1);
            if (!(actualRefreshTime < (Integer.parseInt(refreshInterval) + 2) && actualRefreshTime > (Integer.parseInt(refreshInterval) - 2))) {
                BaseTestUtils.report("RefreshInterval validation has failed: " + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Validate <RefreshInterval>:" + " " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
        Device.deleteDeviceById(getVisionRestClient(), "refreshIntervalTestDevice");
    }

    public String getRefreshInterval() {
        return refreshInterval;
    }

    @ParameterProperties(description = "Specify refreshInterval to validate (in seconds)!")
    public void setRefreshInterval(String refreshInterval) {
        this.refreshInterval = refreshInterval;
    }

    public String getLastCriticalAlertNumber() {
        return LastCriticalAlertNumber;
    }

    public void setLastCriticalAlertNumber(String lastCriticalAlertNumber) {
        LastCriticalAlertNumber = lastCriticalAlertNumber;
    }
}
