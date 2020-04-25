package com.radware.vision.tests.rbac.navigationRBAC;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.navigationRBAC.RBACDefenseProNavigationHandler;
import com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums.DefenseProConfigurationSubMenuItems;
import com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums.DefenseProMonitoringSubMenuItems;
import com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums.DefenseProSecurityMonitoringSubMenuItems;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

/**
 * Created by stanislava on 1/8/2015.
 */
public class RBACDefenseProNavigationTests extends RBACTestBase {

    DefenseProConfigurationSubMenuItems defenseProConfigurationSubMenuItem = DefenseProConfigurationSubMenuItems.SETUP;
    DefenseProMonitoringSubMenuItems defenseProMonitoringSubMenuItem = DefenseProMonitoringSubMenuItems.OPERATIONAL_STATUS;
    DefenseProSecurityMonitoringSubMenuItems defenseProSecurityMonitoringSubMenuItem = DefenseProSecurityMonitoringSubMenuItems.DASHBOARD_VIEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "Verify DefenseProConfigurationSubMenu Existence", paramsInclude = {"qcTestId", "expectedResult", "defenseProConfigurationSubMenuItem", "deviceName",
            "parentTree", "deviceIp"})
    public void verifyDefenseProConfigurationSubMenuExistence() {
        try {
            if ((!RBACDefenseProNavigationHandler.verifyDefenseProConfigurationSubMenuExistence(defenseProConfigurationSubMenuItem.getSubMenu(), getDeviceName(), parentTree.getTopologyTreeTab()))) {
                BaseTestUtils.report("Verify DefenseProConfigurationSubMenu: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify DefenseProConfigurationSubMenu Existence: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify DefenseProMonitoringSubMenu Existence", paramsInclude = {"qcTestId", "expectedResult", "defenseProMonitoringSubMenuItem", "deviceName",
            "parentTree", "deviceIp"})
    public void verifyDefenseProMonitoringSubMenuExistence() {
        try {
            if ((!RBACDefenseProNavigationHandler.verifyDefenseProMonitoringSubMenuExistence(defenseProMonitoringSubMenuItem.getSubMenu(), getDeviceName(), parentTree.getTopologyTreeTab()))) {
                BaseTestUtils.report("Verify DefenseProMonitoringSubMenu: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify DefenseProMonitoringSubMenu Existence: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify DefenseProSecurityMonitoringSubMenu Existence", paramsInclude = {"qcTestId", "expectedResult", "defenseProSecurityMonitoringSubMenuItem", "deviceName",
            "parentTree", "deviceIp"})
    public void verifyDefenseProSecurityMonitoringSubMenuExistence() {
        try {
            if ((!RBACDefenseProNavigationHandler.verifyDefenseProSecurityMonitoringSubMenuExistence(defenseProSecurityMonitoringSubMenuItem.getSubMenu(), getDeviceName(), parentTree.getTopologyTreeTab()))) {
                BaseTestUtils.report("Verify DefenseProSecurityMonitoringSubMenu: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify DefenseProSecurityMonitoringSubMenu Existence: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public DefenseProConfigurationSubMenuItems getDefenseProConfigurationSubMenuItem() {
        return defenseProConfigurationSubMenuItem;
    }

    public void setDefenseProConfigurationSubMenuItem(DefenseProConfigurationSubMenuItems defenseProConfigurationSubMenuItem) {
        this.defenseProConfigurationSubMenuItem = defenseProConfigurationSubMenuItem;
    }

    public DefenseProMonitoringSubMenuItems getDefenseProMonitoringSubMenuItem() {
        return defenseProMonitoringSubMenuItem;
    }

    public void setDefenseProMonitoringSubMenuItem(DefenseProMonitoringSubMenuItems defenseProMonitoringSubMenuItem) {
        this.defenseProMonitoringSubMenuItem = defenseProMonitoringSubMenuItem;
    }

    public DefenseProSecurityMonitoringSubMenuItems getDefenseProSecurityMonitoringSubMenuItem() {
        return defenseProSecurityMonitoringSubMenuItem;
    }

    public void setDefenseProSecurityMonitoringSubMenuItem(DefenseProSecurityMonitoringSubMenuItems defenseProSecurityMonitoringSubMenuItem) {
        this.defenseProSecurityMonitoringSubMenuItem = defenseProSecurityMonitoringSubMenuItem;
    }

}
