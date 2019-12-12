package com.radware.vision.infra.testhandlers.rbac.navigationRBAC;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.infra.base.pages.VisionServerMenuPane;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.WebUIStringsVision;
import org.openqa.selenium.support.How;

/**
 * Created by stanislava on 1/8/2015.
 */
public class RBACVisionNavigationHandler extends RBACHandlerBase {

    public static boolean verifyVisionSystemSubMenuExistence(String item) {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        menuPane.openVisionSystem();
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getVisionSystemSubMenuItem(item));
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }

    public static boolean verifyVisionPreferencesSubMenuExistence(String item) {
        VisionServerMenuPane menuPane = new VisionServerMenuPane();
        menuPane.openVisionPreferences();
        ComponentLocator itemLocator = new ComponentLocator(How.ID, WebUIStringsVision.getVisionPreferencesSubMenuItem(item));
        return WebUIUtils.findExpectedResult(itemLocator, expectedResultRBAC);
    }
}
