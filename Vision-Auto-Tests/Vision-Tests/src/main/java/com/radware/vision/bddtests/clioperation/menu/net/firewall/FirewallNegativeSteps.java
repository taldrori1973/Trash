package com.radware.vision.bddtests.clioperation.menu.net.firewall;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.CliNegative;
import cucumber.api.java.en.Given;

import java.util.ArrayList;
import java.util.Collections;

public class FirewallNegativeSteps extends TestBase {

    CliNegative cliNegative = new CliNegative();

    @Given("^CLI Net Firewall open-port set Negative$")
    public void openPortSet(){
        try {
            cliNegative.init();
            ArrayList<CliNegative.InvalidInputDataType> invalidDataList = new ArrayList<>(Collections.singletonList(CliNegative.InvalidInputDataType.FIREWALL_OPENPORT_SET_NEGATIVE));
            cliNegative.run(Menu.net().firewall().openport().set().build(), invalidDataList , " open", CliNegative.GoodErrorsList.NET_FIREWALL_LIST);
            cliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
