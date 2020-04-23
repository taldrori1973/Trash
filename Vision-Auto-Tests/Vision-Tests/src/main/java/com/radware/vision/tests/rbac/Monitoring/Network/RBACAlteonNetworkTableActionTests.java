package com.radware.vision.tests.rbac.Monitoring.Network;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.Monitoring.network.RBACAlteonNetworkTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.ViewTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 9/23/2014.
 */
public class RBACAlteonNetworkTableActionTests extends RBACTestBase {
    ViewTableActions physicalPortsTableAction = ViewTableActions.VIEW;
    ViewTableActions vrrpVirtualRoutersTableAction = ViewTableActions.VIEW;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify PhysicalPorts Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "physicalPortsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPhysicalPortsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("physicalPortsTableAction", physicalPortsTableAction.getTableAction().toString());

            if (!(RBACAlteonNetworkTableActionHandler.verifyPhysicalPortsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + physicalPortsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PhysicalPorts Disabled Table Action failed: " + physicalPortsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify VRRPVirtualRouters Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "vrrpVirtualRoutersTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyVRRPVirtualRoutersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("vrrpVirtualRoutersTableAction", vrrpVirtualRoutersTableAction.getTableAction().toString());

            if (!(RBACAlteonNetworkTableActionHandler.verifyVRRPVirtualRoutersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + vrrpVirtualRoutersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify VRRPVirtualRouters Disabled Table Action failed: " + vrrpVirtualRoutersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }



    public ViewTableActions getPhysicalPortsTableAction() {
        return physicalPortsTableAction;
    }

    public void setPhysicalPortsTableAction(ViewTableActions physicalPortsTableAction) {
        this.physicalPortsTableAction = physicalPortsTableAction;
    }

    public ViewTableActions getVrrpVirtualRoutersTableAction() {
        return vrrpVirtualRoutersTableAction;
    }

    public void setVrrpVirtualRoutersTableAction(ViewTableActions vrrpVirtualRoutersTableAction) {
        this.vrrpVirtualRoutersTableAction = vrrpVirtualRoutersTableAction;
    }

}
