package com.radware.vision.tests.rbac.configuration.network;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.configuration.network.RBACAlteonHighAvailabilityTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.infra.testhandlers.rbac.enums.ViewBaseTableActions;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonHighAvailabilityTableActionTests extends RBACTestBase {

    BaseTableActions virtualRoutersTableAction = BaseTableActions.NEW;
    BaseTableActions serviceBasedTableAction = BaseTableActions.NEW;
    BaseTableActions vrrpAuthenticationTableAction = BaseTableActions.NEW;
    BaseTableActions syncTableAction = BaseTableActions.NEW;
    ViewBaseTableActions peerTrafficForwardingTableAction = ViewBaseTableActions.VIEW;
    EditTableActions portProcessingTableAction = EditTableActions.EDIT;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }
    //=================== High Availability ======================
    @Test
    @TestProperties(name = "verify VirtualRouters Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "virtualRoutersTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyVirtualRoutersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("virtualRoutersTableAction", virtualRoutersTableAction.getTableAction().toString());

            if (!(RBACAlteonHighAvailabilityTableActionHandler.verifyVirtualRoutersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + virtualRoutersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify VirtualRouters Disabled Table Action failed: " + virtualRoutersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ServiceBased Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "serviceBasedTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyServiceBasedDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("serviceBasedTableAction", serviceBasedTableAction.getTableAction().toString());

            if (!(RBACAlteonHighAvailabilityTableActionHandler.verifyServiceBasedTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + serviceBasedTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify VirtualRouterGroups Disabled Table Action failed: " + serviceBasedTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify VRRPAuthentication Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "vrrpAuthenticationTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyVRRPAuthenticationDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("vrrpAuthenticationTableAction", vrrpAuthenticationTableAction.getTableAction().toString());

            if (!(RBACAlteonHighAvailabilityTableActionHandler.verifyVRRPAuthenticationTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + vrrpAuthenticationTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify VRRPAuthentication Disabled Table Action failed: " + vrrpAuthenticationTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Sync Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "syncTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySyncDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("syncTableAction", syncTableAction.getTableAction().toString());

            if (!(RBACAlteonHighAvailabilityTableActionHandler.verifySyncTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + syncTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Sync Disabled Table Action failed: " + syncTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify PeerTrafficForwarding Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "peerTrafficForwardingTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPeerTrafficForwardingDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("peerTrafficForwardingTableAction", peerTrafficForwardingTableAction.getTableAction().toString());

            if (!(RBACAlteonHighAvailabilityTableActionHandler.verifyPeerTrafficForwardingTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + peerTrafficForwardingTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PeerTrafficForwarding Disabled Table Action failed: " + peerTrafficForwardingTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify PortProcessing Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "portProcessingTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPortProcessingDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("portProcessingTableAction", portProcessingTableAction.getTableAction().toString());

            if (!(RBACAlteonHighAvailabilityTableActionHandler.verifyPortProcessingTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + portProcessingTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PortProcessing Disabled Table Action failed: " + portProcessingTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    public BaseTableActions getVirtualRoutersTableAction() {
        return virtualRoutersTableAction;
    }

    public void setVirtualRoutersTableAction(BaseTableActions virtualRoutersTableAction) {
        this.virtualRoutersTableAction = virtualRoutersTableAction;
    }

    public BaseTableActions getVrrpAuthenticationTableAction() {
        return vrrpAuthenticationTableAction;
    }

    public void setVrrpAuthenticationTableAction(BaseTableActions vrrpAuthenticationTableAction) {
        this.vrrpAuthenticationTableAction = vrrpAuthenticationTableAction;
    }

    public BaseTableActions getSyncTableAction() {
        return syncTableAction;
    }

    public void setSyncTableAction(BaseTableActions syncTableAction) {
        this.syncTableAction = syncTableAction;
    }

    public ViewBaseTableActions getPeerTrafficForwardingTableAction() {
        return peerTrafficForwardingTableAction;
    }

    public void setPeerTrafficForwardingTableAction(ViewBaseTableActions peerTrafficForwardingTableAction) {
        this.peerTrafficForwardingTableAction = peerTrafficForwardingTableAction;
    }

    public EditTableActions getPortProcessingTableAction() {
        return portProcessingTableAction;
    }

    public void setPortProcessingTableAction(EditTableActions portProcessingTableAction) {
        this.portProcessingTableAction = portProcessingTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

    public BaseTableActions getServiceBasedTableAction() {
        return serviceBasedTableAction;
    }

    public void setServiceBasedTableAction(BaseTableActions serviceBasedTableAction) {
        this.serviceBasedTableAction = serviceBasedTableAction;
    }
}
