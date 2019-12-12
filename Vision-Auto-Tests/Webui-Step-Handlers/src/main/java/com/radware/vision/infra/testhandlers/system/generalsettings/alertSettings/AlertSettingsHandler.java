package com.radware.vision.infra.testhandlers.system.generalsettings.alertSettings;

import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.alerts.AlertBrowser;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.utils.WebUIStringsVision;

/**
 * Created by stanislava on 10/5/2014.
 */
public class AlertSettingsHandler {
    public static void setRefreshInterval(String refreshInterval) {
        AlertBrowser alertBrowser = openAlertBrowserMenu();
        alertBrowser.getDisplay().setRefreshInterval(refreshInterval);
        WebUIVisionBasePage.submit(WebUIStringsVision.getAlertsBrowserSubmitButton());
    }

    public static void setLastCriticalAlertNumber(String lastCriticalAlertNumber) {
        AlertBrowser alertBrowser = openAlertBrowserMenu();
//        BasicOperationsHandler.delay(1.5);
        alertBrowser.getDisplay().setLastCriticalAlertNumber(lastCriticalAlertNumber);
        WebUIVisionBasePage.submit(WebUIStringsVision.getAlertsBrowserSubmitButton());
    }

    public static AlertBrowser openAlertBrowserMenu() {
//        AreYouSureDialogBox box = new AreYouSureDialogBox();
//        if(box != null){
//            box.yesButtonClick();
//        }
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        return menuPane.openSystemGeneralSettings().AlertBrowserMenu();
    }
}
