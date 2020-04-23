package com.radware.vision.tests.rbac.navigationRBAC;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.navigationRBAC.RBACAlteonNavigationHandler;
import com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums.AlteonConfigurationSubMenuItems;
import com.radware.vision.infra.testhandlers.rbac.navigationRBAC.enums.AlteonMonitoringSubMenuItems;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

/**
 * Created by stanislava on 1/8/2015.
 */
public class RBACAlteonNavigationTests extends RBACTestBase {
    AlteonConfigurationSubMenuItems configurationSubMenuItem = AlteonConfigurationSubMenuItems.SYSTEM;
    AlteonMonitoringSubMenuItems monitoringSubMenuItem = AlteonMonitoringSubMenuItems.SYSTEM;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "Verify AlteonConfigurationSubMenu Existence", paramsInclude = {"qcTestId", "expectedResult", "configurationSubMenuItem", "deviceName",
            "parentTree", "deviceIp"})
    public void verifyAlteonConfigurationSubMenuExistence() {
        try {
            if ((!RBACAlteonNavigationHandler.verifyAlteonConfigurationSubMenuExistence(configurationSubMenuItem.getSubMenu(), getDeviceName(), parentTree.getTopologyTreeTab()))) {
                BaseTestUtils.report("Verify AlteonConfigurationSubMenu: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify AlteonConfigurationSubMenu Existence: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Verify AlteonMonitoringSubMenu Existence", paramsInclude = {"qcTestId", "expectedResult", "monitoringSubMenuItem", "deviceName",
            "parentTree", "deviceIp"})
    public void verifyAlteonMonitoringSubMenuExistence() {
        try {
            if ((!RBACAlteonNavigationHandler.verifyAlteonMonitoringSubMenuExistence(monitoringSubMenuItem.getSubMenu(), getDeviceName(), parentTree.getTopologyTreeTab()))) {
                BaseTestUtils.report("Verify AlteonMonitoringSubMenu: " + " was not " + expectedResult + " as expected." + "\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Verify AlteonMonitoringSubMenu Existence: " + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    //======================================================

    public AlteonConfigurationSubMenuItems getConfigurationSubMenuItem() {
        return configurationSubMenuItem;
    }

    public void setConfigurationSubMenuItem(AlteonConfigurationSubMenuItems configurationSubMenuItem) {
        this.configurationSubMenuItem = configurationSubMenuItem;
    }

    public AlteonMonitoringSubMenuItems getMonitoringSubMenuItem() {
        return monitoringSubMenuItem;
    }

    public void setMonitoringSubMenuItem(AlteonMonitoringSubMenuItems monitoringSubMenuItem) {
        this.monitoringSubMenuItem = monitoringSubMenuItem;
    }

}
