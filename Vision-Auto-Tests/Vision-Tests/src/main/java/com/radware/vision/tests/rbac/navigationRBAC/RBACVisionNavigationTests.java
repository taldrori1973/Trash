package com.radware.vision.tests.rbac.navigationRBAC;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.testhandlers.rbac.navigationRBAC.RBACVisionNavigationHandler;
import com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums.PreferencesSubMenuItems;
import com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums.SystemSubMenuItems;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

/**
 * Created by stanislava on 1/8/2015.
 */
public class RBACVisionNavigationTests extends RBACTestBase {

    PreferencesSubMenuItems preferencesSubMenuItem = PreferencesSubMenuItems.USER_PREFERENCES;
    SystemSubMenuItems systemSubMenuItem = SystemSubMenuItems.DEVICE_RESOURCES;

    @Test
    @TestProperties(name = "Verify VisionSystemSubMenu Existence", paramsInclude = {"qcTestId", "expectedResult", "systemSubMenuItem"})
    public void verifyVisionSystemSubMenuExistence() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if ((!RBACVisionNavigationHandler.verifyVisionSystemSubMenuExistence(systemSubMenuItem.getElementId()))) {
                BaseTestUtils.report("Verify VisionSystemSubMenu: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify VisionSystemSubMenu Existence: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify VisionPreferencesSubMenu Existence", paramsInclude = {"qcTestId", "expectedResult", "preferencesSubMenuItem"})
    public void verifyVisionPreferencesSubMenuExistence() {
        try {
            RBACHandlerBase.expectedResultRBAC = expectedResult;
            if ((!RBACVisionNavigationHandler.verifyVisionPreferencesSubMenuExistence(preferencesSubMenuItem.getSubMenu()))) {
                BaseTestUtils.report("Verify VisionPreferencesSubMenu: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify VisionPreferencesSubMenu Existence: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public SystemSubMenuItems getSystemSubMenuItem() {
        return systemSubMenuItem;
    }

    public void setSystemSubMenuItem(SystemSubMenuItems systemSubMenuItem) {
        this.systemSubMenuItem = systemSubMenuItem;
    }

    public PreferencesSubMenuItems getPreferencesSubMenuItem() {
        return preferencesSubMenuItem;
    }

    public void setPreferencesSubMenuItem(PreferencesSubMenuItems preferencesSubMenuItem) {
        this.preferencesSubMenuItem = preferencesSubMenuItem;
    }
}
