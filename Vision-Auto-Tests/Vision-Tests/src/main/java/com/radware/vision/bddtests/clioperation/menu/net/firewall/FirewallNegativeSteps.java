package com.radware.vision.bddtests.clioperation.menu.net.firewall;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.vision_tests.CliNegativeTests;
import cucumber.api.java.en.Given;

import java.util.ArrayList;
import java.util.Arrays;

public class FirewallNegativeSteps extends TestBase {

    CliNegativeTests cliNegativeTests=new CliNegativeTests();

    @Given("^CLI Net Firewall open-port set negative$")
    public void openportSet() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.FIREWALL_OPENPORT_SET_NEGATIVE));
        cliNegativeTests.run(Menu.net().firewall().openport().set().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_FIREWALL_LIST);
        cliNegativeTests.after();
    }
}
