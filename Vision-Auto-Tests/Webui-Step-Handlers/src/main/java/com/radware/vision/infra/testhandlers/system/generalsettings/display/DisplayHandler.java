package com.radware.vision.infra.testhandlers.system.generalsettings.display;

import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.base.pages.system.generalsettings.display.Display;
import com.radware.vision.infra.base.pages.system.generalsettings.enums.GeneralSettingsEnum;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.WebUIStringsVision;

/**
 * Created by vadyms on 5/20/2015.
 */
public class DisplayHandler extends RBACHandlerBase {

    public static void updateLanguage(GeneralSettingsEnum.Language language) {
        Display display = openDisplayMenu();
        display.getDisplay().setLanguage(language);
        WebUIVisionBasePage.submit(WebUIStringsVision.getDisplaySubmitButton());
    }

    public static void updateTimeFormat(GeneralSettingsEnum.TimeFormat timeFormat) {
        BasicOperationsHandler.settings();
        Display display = openDisplayMenu();
        display.getDisplay().setTimeFormat(timeFormat);
        WebUIVisionBasePage.submit(WebUIStringsVision.getDisplaySubmitButton());

    }

    public static String getTimeFormat() {

        Display display = openDisplayMenu();
        return display.getTimeFormat();
    }

    public static Display openDisplayMenu() {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        return menuPane.openSystemGeneralSettings().displayMenu();
    }
}
