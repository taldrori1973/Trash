package com.radware.vision.bddtests.clioperation.menu.net.nat;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.test_parameters.NetPortIp;
import com.radware.vision.vision_handlers.net.Nat;
import com.radware.vision.vision_handlers.net.Net;
import com.radware.vision.vision_handlers.root.RootVerifications;
import com.radware.vision.bddtests.BddCliTestBase;
import cucumber.api.java.en.When;

public class NetNatSteps extends BddCliTestBase {

    private NetPortIp[] netPortIpArray;

    /**
     * The Scenario :
     * 1.	net
     */
    @When("^CLI net Sub Menu$")
    public void netSubMenu() throws Exception {
        Net.netSubMenuCheck(restTestBase.getRadwareServerCli());
    }

    /**
     * The Scenario :
     * 1.	Net nat set ip 23.23.23.23
     * 2.	Via root user /etc/init.d/iptables status and verify it
     * 3.	net nat set none
     * 4.	Via root user /etc/init.d/iptables status and verify it
     * 5.	Net nat get and verify it
     */
    @When("^CLI Net Nat Get IP$")
    public void netNatGetIP() {
        try {

            Nat.netNatSetIp("23.23.23.23", restTestBase.getRadwareServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootRegex("/etc/init.d/iptables status", "1\\s+DNAT\\s+all\\s+--\\s+0.0.0.0/0\\s+23.23.23.23\\s+to:127.0.0.1", restTestBase.getRootServerCli());
            Nat.netNatSetNone(restTestBase.getRadwareServerCli());
            RootVerifications.verifyLinuxOSParamsNotExistViaRootRegex("/etc/init.d/iptables status", "1\\s+DNAT\\s+all\\s+--\\s+0.0.0.0/0\\s+23.23.23.23\\s+to:127.0.0.1", restTestBase.getRootServerCli());
            Nat.netNatGet("No NAT is configured for the server.", restTestBase.getRadwareServerCli());

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        AfterMethod();
    }


    /**
     * The Scenario :
     * 1.	Net nat set ip 23.23.23.23
     * 2.	Via root user /etc/init.d/iptables status and verify it
     * 3.	Net nat get and verify it
     */
    @When("^CLI Net Nat Get None$")
    public void netNatGetNone() {
        try {

            Nat.netNatSetIp("23.23.23.23", restTestBase.getRadwareServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootRegex("/etc/init.d/iptables status", "1\\s+DNAT\\s+all\\s+--\\s+0.0.0.0/0\\s+23.23.23.23\\s+to:127.0.0.1", restTestBase.getRootServerCli());
            Nat.netNatGet("Server NAT host IP: <23.23.23.23>", restTestBase.getRadwareServerCli());

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        AfterMethod();
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
            Nat.netNatSetHostName(hostName, restTestBase.getRadwareServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootText("cat /etc/hosts", "127.0.0.1 " + hostName, restTestBase.getRootServerCli());
            Nat.netNatGet("Server hostname:" + hostName, restTestBase.getRadwareServerCli());

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        AfterMethod();
    }

    /**
     * The Scenario :
     * 1.	net nat
     */
    @When("^CLI Net Nat Sub Menu$")
    public void netNatSubMenu() {

        try {
            Nat.netNatSubMenuCheck(restTestBase.getRadwareServerCli());
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
            Nat.netNatSetSubMenuCheck(restTestBase.getRadwareServerCli());
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
     */
    @When("^CLI Net Nat Set None$")
    public void netNatSetNone() {
        try {

            Nat.netNatSetIp("23.23.23.23", restTestBase.getRadwareServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootRegex("/etc/init.d/iptables status", "1\\s+DNAT\\s+all\\s+--\\s+0.0.0.0/0\\s+23.23.23.23\\s+to:127.0.0.1", restTestBase.getRootServerCli());
            Nat.netNatSetNone(restTestBase.getRadwareServerCli());
            RootVerifications.verifyLinuxOSParamsNotExistViaRootRegex("/etc/init.d/iptables status", "1\\s+DNAT\\s+all\\s+--\\s+0.0.0.0/0\\s+23.23.23.23\\s+to:127.0.0.1", restTestBase.getRootServerCli());

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        AfterMethod();
    }

    /**
     * The Scenario :
     * 1.	Net nat set ip 23.23.23.23
     * 2.	Via root user /etc/init.d/iptables status and verify it
     */
    @When("^CLI Net Nat Set IP$")
    public void netNatSetIP() {
        try {

            Nat.netNatSetIp("23.23.23.23", restTestBase.getRadwareServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootRegex("/etc/init.d/iptables status", "1\\s+DNAT\\s+all\\s+--\\s+0.0.0.0/0\\s+23.23.23.23\\s+to:127.0.0.1", restTestBase.getRootServerCli());
            doTheVisionLabRestart = true;
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        AfterMethod();
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
            Nat.netNatSetHostName(hostName, restTestBase.getRadwareServerCli());
            RootVerifications.verifyLinuxOSParamsViaRootText("cat /etc/hosts", "127.0.0.1 " + hostName, restTestBase.getRootServerCli());

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        AfterMethod();
    }

    public NetPortIp[] getNetPortIpArray() {
        return netPortIpArray;
    }

    public void setNetPortIpArray(NetPortIp[] netPortIpArray) {
        this.netPortIpArray = netPortIpArray;
    }


    private void AfterMethod() {

        try {
            Nat.netNatSetNone(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }
}
