package com.radware.vision.tests.alerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.events.ReportWebDriverEventListener;
import com.radware.automation.webui.webdriver.WebUIDriver;
import com.radware.automation.webui.widgets.api.popups.PopupContent;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.testhandlers.alerts.AlertsNegativeHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.util.List;

/**
 * Created by stanislava on 10/5/2014.
 */
public class AlertsNegativeTests extends WebUITestBase {


    @Test
    @TestProperties(name = "severity Check Negative", paramsInclude = {"qcTestId"})
    public void severityCheckNegative() {
        try {
            AlertsNegativeHandler.severityCheckWarning();
            List<PopupContent> popupErrors = ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).getLastPopupEvent();
            int popupSize = popupErrors.size();
            if (popupSize > 0) {
                BaseTestUtils.report("Warning is presented upon an incorrect <severity> setup: " + "\n.", Reporter.PASS);
                ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).clearLastPopupEventList();
            } else {
                BaseTestUtils.report("No Warning is presented upon an incorrect <severity> setup: At least one option must be selected!" + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("At least one severity check box must remain <checked>: " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "module Check Negative", paramsInclude = {"qcTestId"})
    public void moduleCheckNegative() {
        try {
            AlertsNegativeHandler.moduleCheckWarning();
            List<PopupContent> popupErrors = ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).getLastPopupEvent();
            int popupSize = popupErrors.size();
            if (popupSize > 0) {
                BaseTestUtils.report("Warning is presented upon an incorrect <module> setup: " + "\n.", Reporter.PASS);
                ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).clearLastPopupEventList();
            } else {
                BaseTestUtils.report("No Warning is presented upon an incorrect <module> setup: At least one option must be selected!" + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("At least one <module> check box must remain checked: " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "deviceType Check Negative", paramsInclude = {"qcTestId"})
    public void deviceTypeCheckNegative() {
        try {
            AlertsNegativeHandler.deviceTypeCheckWarning();
            List<PopupContent> popupErrors = ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).getLastPopupEvent();
            int popupSize = popupErrors.size();
            if (popupSize > 0) {
                BaseTestUtils.report("Warning is presented upon an incorrect deviceType setup: " + "\n.", Reporter.PASS);
                ((ReportWebDriverEventListener) WebUIDriver.getListenerManager().getWebUIDriverEventListener()).clearLastPopupEventList();
            } else {
                BaseTestUtils.report("No Warning is presented upon an incorrect deviceType setup: At least one option must be selected!" + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("At least one deviceType check box must remain checked: " + "failed with the following error:\n" + e.getMessage() + "\n" + e.getCause(), Reporter.FAIL);
        }
        finally {
            WebUIUtils.getDriver().close();
            WebUIDriver.setDriver(null);
            WebUIUtils.logIn(getVisionServerIp());
            try {
                BasicOperationsHandler.login("radware", "radware");
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
