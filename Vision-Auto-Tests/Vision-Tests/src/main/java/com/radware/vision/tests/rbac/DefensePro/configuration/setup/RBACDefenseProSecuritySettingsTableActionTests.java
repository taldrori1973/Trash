package com.radware.vision.tests.rbac.DefensePro.configuration.setup;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.rbac.defensePro.configuration.setup.RBACDefenseProSecuritySettingsTableActionHandler;
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
 * Created by stanislava on 10/1/2014.
 */
public class RBACDefenseProSecuritySettingsTableActionTests extends RBACTestBase {

    EditTableActions bdosEarlyBlockingTableAction = EditTableActions.EDIT;
    EditTableActions bdosFootprintBypassTableAction = EditTableActions.EDIT;
    EditTableActions bdosPacketHeaderSelectionTableAction = EditTableActions.EDIT;
    EditTableActions dnsEarlyBlockingTableAction = EditTableActions.EDIT;
    EditTableActions dnsFootprintBypassTableAction = EditTableActions.EDIT;
    EditTableActions dnsPacketHeaderSelectionTableAction = EditTableActions.EDIT;
    EditTableActions sslParametersTableAction = EditTableActions.EDIT;
    EditTableActions packetAnomalyTableAction = EditTableActions.EDIT;

    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify BDoSFootprintBypass Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "bdosFootprintBypassTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyBDoSFootprintBypassDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("bdosFootprintBypassTableAction", bdosFootprintBypassTableAction.getTableAction().toString());

            if (!(RBACDefenseProSecuritySettingsTableActionHandler.verifyBDoSFootprintBypassTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + bdosFootprintBypassTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify BDoSFootprintBypass Disabled Table Action failed: " + bdosFootprintBypassTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify BDoSEarlyBlocking Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "bdosEarlyBlockingTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyBDoSEarlyBlockingDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("bdosEarlyBlockingTableAction", bdosEarlyBlockingTableAction.getTableAction().toString());

            if (!(RBACDefenseProSecuritySettingsTableActionHandler.verifyBDoSEarlyBlockingTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + bdosEarlyBlockingTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify BDoSEarlyBlocking Disabled Table Action failed: " + bdosEarlyBlockingTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify BDoSPacketHeaderSelection Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "bdosPacketHeaderSelectionTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyBDoSPacketHeaderSelectionDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("bdosPacketHeaderSelectionTableAction", bdosPacketHeaderSelectionTableAction.getTableAction().toString());

            if (!(RBACDefenseProSecuritySettingsTableActionHandler.verifyBDoSPacketHeaderSelectionTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + bdosPacketHeaderSelectionTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify BDoSPacketHeaderSelection Disabled Table Action failed: " + bdosPacketHeaderSelectionTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify DNSFootprintBypass Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "dnsFootprintBypassTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyDNSFootprintBypassDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("dnsFootprintBypassTableAction", dnsFootprintBypassTableAction.getTableAction().toString());

            if (!(RBACDefenseProSecuritySettingsTableActionHandler.verifyDNSFootprintBypassTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + dnsFootprintBypassTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify DNSFootprintBypass Disabled Table Action failed: " + dnsFootprintBypassTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify DNSEarlyBlocking Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "dnsEarlyBlockingTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyDNSEarlyBlockingDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("dnsEarlyBlockingTableAction", dnsEarlyBlockingTableAction.getTableAction().toString());

            if (!(RBACDefenseProSecuritySettingsTableActionHandler.verifyDNSEarlyBlockingTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + dnsEarlyBlockingTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify DNSEarlyBlocking Disabled Table Action failed: " + dnsEarlyBlockingTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify DNSPacketHeaderSelection Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "dnsPacketHeaderSelectionTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyDNSPacketHeaderSelectionDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("dnsPacketHeaderSelectionTableAction", dnsPacketHeaderSelectionTableAction.getTableAction().toString());

            if (!(RBACDefenseProSecuritySettingsTableActionHandler.verifyDNSPacketHeaderSelectionTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + dnsPacketHeaderSelectionTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify DNSPacketHeaderSelection Disabled Table Action failed: " + dnsPacketHeaderSelectionTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify SSLParameters Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "dnsPacketHeaderSelectionTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifySSLParametersDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("sslParametersTableAction", sslParametersTableAction.getTableAction().toString());

            if (!(RBACDefenseProSecuritySettingsTableActionHandler.verifySSLParametersTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + sslParametersTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify SSLParameters Disabled Table Action failed: " + sslParametersTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify PacketAnomaly Disabled Table Action", paramsInclude = {"qcTestId", "deviceName", "parentTree", "packetAnomalyTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyPacketAnomalyHeaderSelectionDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("packetAnomalyTableAction", packetAnomalyTableAction.getTableAction().toString());

            if (!(RBACDefenseProSecuritySettingsTableActionHandler.verifyPacketAnomalyTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + packetAnomalyTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify PacketAnomaly Disabled Table Action failed: " + packetAnomalyTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    public EditTableActions getBdosEarlyBlockingTableAction() {
        return bdosEarlyBlockingTableAction;
    }

    public void setBdosEarlyBlockingTableAction(EditTableActions bdosEarlyBlockingTableAction) {
        this.bdosEarlyBlockingTableAction = bdosEarlyBlockingTableAction;
    }

    public EditTableActions getBdosFootprintBypassTableAction() {
        return bdosFootprintBypassTableAction;
    }

    public void setBdosFootprintBypassTableAction(EditTableActions bdosFootprintBypassTableAction) {
        this.bdosFootprintBypassTableAction = bdosFootprintBypassTableAction;
    }

    public EditTableActions getBdosPacketHeaderSelectionTableAction() {
        return bdosPacketHeaderSelectionTableAction;
    }

    public void setBdosPacketHeaderSelectionTableAction(EditTableActions bdosPacketHeaderSelectionTableAction) {
        this.bdosPacketHeaderSelectionTableAction = bdosPacketHeaderSelectionTableAction;
    }

    public EditTableActions getDnsEarlyBlockingTableAction() {
        return dnsEarlyBlockingTableAction;
    }

    public void setDnsEarlyBlockingTableAction(EditTableActions dnsEarlyBlockingTableAction) {
        this.dnsEarlyBlockingTableAction = dnsEarlyBlockingTableAction;
    }

    public EditTableActions getDnsFootprintBypassTableAction() {
        return dnsFootprintBypassTableAction;
    }

    public void setDnsFootprintBypassTableAction(EditTableActions dnsFootprintBypassTableAction) {
        this.dnsFootprintBypassTableAction = dnsFootprintBypassTableAction;
    }

    public EditTableActions getDnsPacketHeaderSelectionTableAction() {
        return dnsPacketHeaderSelectionTableAction;
    }

    public void setDnsPacketHeaderSelectionTableAction(EditTableActions dnsPacketHeaderSelectionTableAction) {
        this.dnsPacketHeaderSelectionTableAction = dnsPacketHeaderSelectionTableAction;
    }

    public EditTableActions getSslParametersTableAction() {
        return sslParametersTableAction;
    }

    public void setSslParametersTableAction(EditTableActions sslParametersTableAction) {
        this.sslParametersTableAction = sslParametersTableAction;
    }

    public EditTableActions getPacketAnomalyTableAction() {
        return packetAnomalyTableAction;
    }

    public void setPacketAnomalyTableAction(EditTableActions packetAnomalyTableAction) {
        this.packetAnomalyTableAction = packetAnomalyTableAction;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }
}
