package com.radware.vision.infra.testhandlers.alerts;

import basejunit.RestTestBase;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.infra.base.pages.alerts.Alerts;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.testhandlers.alerts.AlertsUtils.DeviceTypeSetter;
import com.radware.vision.infra.testhandlers.alerts.AlertsUtils.ModuleSetter;
import com.radware.vision.infra.testhandlers.alerts.AlertsUtils.SeveritySetter;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 10/5/2014.
 */
public class AlertsNegativeHandler {

    public static void severityCheckWarning() {
        alertsNegativeBase();
        SeveritySetter setter = new SeveritySetter();
        setter.uncheckSeverityAll();
        try {
            WebElement submit = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, WebUIStringsVision.getAlertsFIlterSubmitButton()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            if(submit != null) {
                WebUIUtils.setIsTriggerPopupSearchEvent(false);
                WebUIUtils.isIgnoreDisplayedPopup = true;
                submit.click();
            }
        } catch (Exception e) {
            RestTestBase.report.report("Test: " + "\n.", Reporter.FAIL);
        }finally {
            WebUIUtils.setIsTriggerPopupSearchEvent(true);
            WebUIUtils.isIgnoreDisplayedPopup = false;
        }
    }

    public static void closeConfigurationErrorDialogAndAlertsTable(){
        closeConfigurationErrorDialog();
        WebElement cancel = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, "gwt-debug-ConfigTab_EDIT_AlertBrowser.Filter_Close").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        cancel.click();
        closeAlertsTable();
    }

    private static void closeConfigurationErrorDialog(){
        WebElement close = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, WebUIStringsVision.getDialogBoxClose()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        close.click();
    }

    public static void moduleCheckWarning() {
        alertsNegativeBase();
        ModuleSetter setter = new ModuleSetter();
        setter.checkModules(ModuleSetter.modulesAll);
        setter.uncheckModulesAll();
        try {

            WebUIVisionBasePage.submit(WebUIStringsVision.getAlertsFIlterSubmitButton());
        } catch (Exception e) {
            RestTestBase.report.report("Test: " + "\n.", Reporter.FAIL);
        }
    }

    public static void deviceTypeCheckWarning() {
        alertsNegativeBase();
        DeviceTypeSetter setter = new DeviceTypeSetter();
        setter.uncheckDeviceTypeAll();
        try {

            WebUIVisionBasePage.submit(WebUIStringsVision.getAlertsFIlterSubmitButton());
        } catch (Exception e) {
            RestTestBase.report.report("Test: " + "\n.", Reporter.FAIL);
        }
    }

    private static void alertsNegativeBase() {
        Alerts alerts = new Alerts();
        alerts.alertsMaximize();
        alerts.filterAlertsClick();
    }

    private static void closeAlertsTable() {
        Alerts alerts = new Alerts();
        alerts.alertsMinimize();
    }

    public static boolean isConfigurationError(){
        String configError = "Configuration Error";
        ComponentLocator locator = new ComponentLocator(How.ID, WebUIStrings.getDialogBoxCaption());
        String messageCaption = WebUIUtils.fluentWaitGetText(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        return messageCaption.equals(configError);
    }
}
