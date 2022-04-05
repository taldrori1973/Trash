package com.radware.vision.bddtests.clioperation.menu.net.firewall;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.net.Firewall;
import cucumber.api.java.en.Given;

public class FirewallSteps extends TestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();

    @Given("^CLI Net Firewall Submenu$")
    public void netFirewallSubmenu() {
        try {
            Firewall.checkFirewallSubmenu(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI Net Firewall open-port Submenu$")
    public void netFirewallOpenPortSubmenu() {
        try {
            Firewall.checkFirewallOpenPortSubmenu(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI Net Firewall open-port list - defaults$")
    public void netFirewallOpenPortListDefaults() {
        try {
            Firewall.checkFirewallOpenPortListDefaults(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI Net Firewall open-port set open$")
    public void netFirewallOpenPortSet() {
        try {
            Firewall.checkFirewallOpenPortSetOpen(radwareServerCli, rootServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI Net Firewall open-port set close$")
    public void netFirewallOpenPortClose() {
        try {
            Firewall.checkFirewallOpenPortClose(radwareServerCli, rootServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
