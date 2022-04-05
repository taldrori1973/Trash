package com.radware.vision.bddtests.clioperation.menu.net.nat;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.base.VisionCliTestBase;
import com.radware.vision.net.Nat;
import com.radware.vision.net.Net;
import com.radware.vision.root.RootVerifications;
import com.radware.vision.test_parameters.NetPortIp;
import cucumber.api.java.en.When;

public class NetNatSteps extends VisionCliTestBase {

    private NetPortIp[] netPortIpArray;
    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();

    /**
     * The Scenario :
     * 1.	net
     */
    @When("^CLI net Sub Menu$")
    public void netSubMenu() {
        try {
            Net.netSubMenuCheck(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * The Scenario :
     * 1.	Net nat set ip 23.23.23.23
     * 2.	Via root user /etc/init.d/iptables status and verify it
     * 3.	net nat set none
     * 4.	Via root user /etc/init.d/iptables status and verify it
     * 5.	Net nat get and verify it
     */
    @When("^CLI Net Nat Set IP$")
    public void netNatGetIP() {
        try {

            Nat.netNatSetIp("23.23.23.23", radwareServerCli);
            CliOperations.runCommand(rootServerCli, "iptables -t nat -L -n -v | grep \"23.23.23.23\"");
            CliOperations.verifyLastOutputByRegex("\\s+\\d+\\s+\\d+\\s+DNAT\\s+all\\s+\\W+\\W\\s+0.0.0.0/0\\s+23.23.23.23\\s+to:127.0.0.1");
            Nat.netNatSetNone(radwareServerCli);
            CliOperations.runCommand(radwareServerCli, "iptables -t nat -L -n -v | grep \"23.23.23.23\"");
            CliOperations.verifyLastOutputNotExistByRegex("\\s+\\d+\\s+\\d+\\s+DNAT\\s+all\\s+\\W+\\W\\s+0.0.0.0/0\\s+23.23.23.23\\s+to:127.0.0.1");
            Nat.netNatGet("No NAT is configured for the server.", radwareServerCli);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        
    }

    @When("^Net Nat Set none$")
    public void netNatSetNone() {
        try {

            Nat.netNatSetNone(radwareServerCli);
            Nat.netNatGet("No NAT is configured for the server.", radwareServerCli);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        
    }


    /**
     * The Scenario :
     * 1.	net nat set hostname natAutomationTest
     * 2.	Via root user cat /etc/hosts status and verify it
     * 3.	Net nat get and verify it
     */
    @When("^CLI Net Nat Get HostName$")
    public void netNatGetHostName() {
        try {

            String hostName = "natAutomationTest";
            Nat.netNatSetHostName(hostName, radwareServerCli);
            RootVerifications.verifyLinuxOSParamsViaRootText("cat /etc/hosts", "127.0.0.1 " + hostName, rootServerCli);
            Nat.netNatGet("Server hostname:" + hostName, radwareServerCli);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        
    }

    /**
     * The Scenario :
     * 1.	net nat
     */
    @When("^CLI Net Nat Sub Menu$")
    public void netNatSubMenu() {

        try {
            Nat.netNatSubMenuCheck(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * The Scenario :
     * 1.	net nat set
     */
    @When("^CLI Net Nat Set Sub Menu$")
    public void netNatSetSubMenu() {
        try {
            Nat.netNatSetSubMenuCheck(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


    /**
     * The Scenario :
     * 1.	net nat set hostname natAutomationTest
     * 2.	Via root user cat /etc/hosts status and verify it
     */
    @When("^CLI Net Nat Set Host Name$")
    public void netNatSetHostName() {
        try {

            String hostName = "natAutomationTest";
            Nat.netNatSetHostName(hostName, radwareServerCli);
            RootVerifications.verifyLinuxOSParamsViaRootText("cat /etc/hosts", "127.0.0.1 " + hostName, rootServerCli);
            Nat.netNatGet("Server hostname:" + hostName, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        
    }

    public NetPortIp[] getNetPortIpArray() {
        return netPortIpArray;
    }

    public void setNetPortIpArray(NetPortIp[] netPortIpArray) {
        this.netPortIpArray = netPortIpArray;
    }


}
