package com.radware.vision.bddtests.clioperation.menu.net.firewall;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.net.Firewall;
import com.radware.vision.vision_tests.CliNegativeTests;
import cucumber.api.java.en.Given;

public class FirewallSteps extends TestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
    
    CliNegativeTests cliNegativeTests=new CliNegativeTests();

    @Given("^CLI Net Firewall Submenu$")
    public void netFirewallSubmenu() throws Exception {
        cliNegativeTests.init();
        Firewall.checkFirewallSubmenu(radwareServerCli);
        cliNegativeTests.after();
    }

    @Given("^CLI Net Firewall open-port Submenu$")
    public void netFirewallOpenPortSubmenu() throws Exception {
        cliNegativeTests.init();
        Firewall.checkFirewallOpenPortSubmenu(radwareServerCli);
        cliNegativeTests.after();
    }

    @Given("^CLI Net Firewall open-port list - defaults$")
    public void netFirewallOpenPortListDefaults() throws Exception {
        cliNegativeTests.init();
        Firewall.checkFirewallOpenPortListDefaults(radwareServerCli);
        cliNegativeTests.after();
    }

    @Given("^CLI Net Firewall open-port set open$")
    public void netFirewallOpenPortSet() throws Exception {
        cliNegativeTests.init();
        Firewall.checkFirewallOpenPortSetOpen(radwareServerCli, rootServerCli);
        cliNegativeTests.after();
    }

    @Given("^CLI Net Firewall open-port set close$")
    public void netFirewallOpenPortClose() throws Exception {
        cliNegativeTests.init();
        Firewall.checkFirewallOpenPortClose(radwareServerCli, rootServerCli);
        cliNegativeTests.after();
    }
}
