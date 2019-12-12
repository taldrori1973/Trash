package com.radware.vision.bddtests.clioperation.menu.net.firewall;

import com.radware.vision.vision_handlers.net.Firewall;
import com.radware.vision.vision_tests.CliNegativeTests;
import com.radware.vision.bddtests.BddCliTestBase;
import cucumber.api.java.en.Given;

public class FirewallSteps extends BddCliTestBase {

    CliNegativeTests cliNegativeTests=new CliNegativeTests();

    @Given("^CLI Net Firewall Submenu$")
    public void netFirewallSubmenu() throws Exception {
        cliNegativeTests.init();
        Firewall.checkFirewallSubment(restTestBase.getRadwareServerCli());
        cliNegativeTests.after();
    }

    @Given("^CLI Net Firewall open-port Submenu$")
    public void netFirewallOpenPortSubmenu() throws Exception {
        cliNegativeTests.init();
        Firewall.checkFirewallOpenPortSubment(restTestBase.getRadwareServerCli());
        cliNegativeTests.after();
    }

    @Given("^CLI Net Firewall open-port list - defaults$")
    public void netFirewallOpenPortListDefaults() throws Exception {
        cliNegativeTests.init();
        Firewall.checkFirewallOpenPortListDefaults(restTestBase.getRadwareServerCli());
        cliNegativeTests.after();
    }

    @Given("^CLI Net Firewall open-port set open$")
    public void netFirewallOpenPortSet() throws Exception {
        cliNegativeTests.init();
        Firewall.checkFirewallOpenPortSetOpen(restTestBase.getRadwareServerCli(), restTestBase.getRootServerCli());
        cliNegativeTests.after();
    }

    @Given("^CLI Net Firewall open-port set close$")
    public void netFirewallOpenPortClose() throws Exception {
        cliNegativeTests.init();
        Firewall.checkFirewallOpenPortClose(restTestBase.getRadwareServerCli(), restTestBase.getRootServerCli());
        cliNegativeTests.after();
    }
}
