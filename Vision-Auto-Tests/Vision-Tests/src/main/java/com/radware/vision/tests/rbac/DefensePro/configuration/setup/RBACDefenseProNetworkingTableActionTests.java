package com.radware.vision.tests.rbac.DefensePro.configuration.setup;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.setup.RBACDefenseProNetworkingTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 9/28/2014.
 */
public class RBACDefenseProNetworkingTableActionTests extends RBACTestBase {

    BaseTableActions portPairsTableAction = BaseTableActions.NEW;
    EditTableActions portConfigurationTableAction = EditTableActions.EDIT;
    EditTableActions linkAggregationTableAction = EditTableActions.EDIT;
    BaseTableActions portMirroringTableAction = BaseTableActions.NEW;
    BaseTableActions sslInspectionTableAction = BaseTableActions.NEW;
    BaseTableActions l4PortsTableAction = BaseTableActions.NEW;
    BaseTableActions ipManagementTableAction = BaseTableActions.NEW;
    BaseTableActions ipRoutingTableAction = BaseTableActions.NEW;
    BaseTableActions arpTableTableAction = BaseTableActions.NEW;
    EditTableActions icmpTableAction = EditTableActions.EDIT;
    BaseTableActions dnsTableAction = BaseTableActions.NEW;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify PortPairs Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "portPairsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPortPairsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("portPairsTableAction", portPairsTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkingTableActionHandler.verifyPortPairsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + portPairsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PortPairs Disabled Table Action failed: " + portPairsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify PortConfiguration Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "portConfigurationTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPortConfigurationDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("portConfigurationTableAction", portConfigurationTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkingTableActionHandler.verifyPortConfigurationTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + portConfigurationTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PortConfiguration Disabled Table Action failed: " + portConfigurationTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify LinkAggregation Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "linkAggregationTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyLinkAggregationDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("linkAggregationTableAction", linkAggregationTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkingTableActionHandler.verifyLinkAggregationTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + linkAggregationTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify LinkAggregation Disabled Table Action failed: " + linkAggregationTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify PortMirroring Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "portMirroringTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPortMirroringDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("portMirroringTableAction", portMirroringTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkingTableActionHandler.verifyPortMirroringTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + portMirroringTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PortMirroring Disabled Table Action failed: " + portMirroringTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SSLInspection Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "sslInspectionTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySSLInspectionDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("sslInspectionTableAction", sslInspectionTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkingTableActionHandler.verifySSLInspectionTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + sslInspectionTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify SSLInspection Disabled Table Action failed: " + sslInspectionTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    //===========
    @Test
    @TestProperties(name = "verify L4Ports Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "l4PortsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyL4PortsDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("l4PortsTableAction", l4PortsTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkingTableActionHandler.verifyL4PortsTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + l4PortsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify L4Ports Disabled Table Action failed: " + l4PortsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify IPManagement Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "ipManagementTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyIPManagementDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ipManagementTableAction", ipManagementTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkingTableActionHandler.verifyIpManagementTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ipManagementTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify IPManagement Disabled Table Action failed: " + ipManagementTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify IPRouting Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "ipRoutingTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyIPRoutingDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("ipRoutingTableAction", ipRoutingTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkingTableActionHandler.verifyIpRoutingTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + ipRoutingTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify IPRouting Disabled Table Action failed: " + ipRoutingTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ICMP Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "icmpTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyICMPDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("icmpTableAction", icmpTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkingTableActionHandler.verifyICMPTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + icmpTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ICMP Disabled Table Action failed: " + icmpTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify ARPTable Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "arpTableTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyARPTableDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("arpTableTableAction", arpTableTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkingTableActionHandler.verifyARPTableTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + arpTableTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify ARPTable Disabled Table Action failed: " + arpTableTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify DNS Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "dnsTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyDNSDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("dnsTableAction", dnsTableAction.getTableAction().toString());

            if (!(RBACDefenseProNetworkingTableActionHandler.verifyDNSTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + dnsTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify DNS Disabled Table Action failed: " + dnsTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }



    public BaseTableActions getPortPairsTableAction() {
        return portPairsTableAction;
    }

    public void setPortPairsTableAction(BaseTableActions portPairsTableAction) {
        this.portPairsTableAction = portPairsTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

    public EditTableActions getLinkAggregationTableAction() {
        return linkAggregationTableAction;
    }

    public void setLinkAggregationTableAction(EditTableActions linkAggregationTableAction) {
        this.linkAggregationTableAction = linkAggregationTableAction;
    }

    public BaseTableActions getPortMirroringTableAction() {
        return portMirroringTableAction;
    }

    public void setPortMirroringTableAction(BaseTableActions portMirroringTableAction) {
        this.portMirroringTableAction = portMirroringTableAction;
    }

    public BaseTableActions getSslInspectionTableAction() {
        return sslInspectionTableAction;
    }

    public void setSslInspectionTableAction(BaseTableActions sslInspectionTableAction) {
        this.sslInspectionTableAction = sslInspectionTableAction;
    }

    public BaseTableActions getL4PortsTableAction() {
        return l4PortsTableAction;
    }

    public void setL4PortsTableAction(BaseTableActions l4PortsTableAction) {
        this.l4PortsTableAction = l4PortsTableAction;
    }

    public BaseTableActions getIpManagementTableAction() {
        return ipManagementTableAction;
    }

    public void setIpManagementTableAction(BaseTableActions ipManagementTableAction) {
        this.ipManagementTableAction = ipManagementTableAction;
    }

    public BaseTableActions getIpRoutingTableAction() {
        return ipRoutingTableAction;
    }

    public void setIpRoutingTableAction(BaseTableActions ipRoutingTableAction) {
        this.ipRoutingTableAction = ipRoutingTableAction;
    }

    public BaseTableActions getArpTableTableAction() {
        return arpTableTableAction;
    }

    public void setArpTableTableAction(BaseTableActions arpTableTableAction) {
        this.arpTableTableAction = arpTableTableAction;
    }

    public EditTableActions getIcmpTableAction() {
        return icmpTableAction;
    }

    public void setIcmpTableAction(EditTableActions icmpTableAction) {
        this.icmpTableAction = icmpTableAction;
    }

    public BaseTableActions getDnsTableAction() {
        return dnsTableAction;
    }

    public void setDnsTableAction(BaseTableActions dnsTableAction) {
        this.dnsTableAction = dnsTableAction;
    }

    public EditTableActions getPortConfigurationTableAction() {
        return portConfigurationTableAction;
    }

    public void setPortConfigurationTableAction(EditTableActions portConfigurationTableAction) {
        this.portConfigurationTableAction = portConfigurationTableAction;
    }
}
