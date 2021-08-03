package com.radware.vision.bddtests.clioperation.menu.net.firewall;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.net.Firewall;
import cucumber.api.java.en.Given;

public class FirewallSteps extends TestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();

    @Given("^CLI Net Firewall Submenu$")
    public void netFirewallSubmenu() throws Exception {
        Firewall.checkFirewallSubmenu(radwareServerCli);
    }

    @Given("^CLI Net Firewall open-port Submenu$")
    public void netFirewallOpenPortSubmenu() throws Exception {
        Firewall.checkFirewallOpenPortSubmenu(radwareServerCli);
    }

    @Given("^CLI Net Firewall open-port list - defaults$")
    public void netFirewallOpenPortListDefaults() throws Exception {
        Firewall.checkFirewallOpenPortListDefaults(radwareServerCli);
    }

    @Given("^CLI Net Firewall open-port set open$")
    public void netFirewallOpenPortSet() throws Exception {
        Firewall.checkFirewallOpenPortSetOpen(radwareServerCli, rootServerCli);
    }

    @Given("^CLI Net Firewall open-port set close$")
    public void netFirewallOpenPortClose() throws Exception {
        Firewall.checkFirewallOpenPortClose(radwareServerCli, rootServerCli);
    }
}
