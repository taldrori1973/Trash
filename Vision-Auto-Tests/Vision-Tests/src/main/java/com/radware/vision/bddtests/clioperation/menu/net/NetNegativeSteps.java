package com.radware.vision.bddtests.clioperation.menu.net;

import com.radware.vision.automation.base.TestBase;
import com.radware.vision.vision_project_cli.menu.Menu;
import com.radware.vision.vision_tests.CliNegativeTests;
import cucumber.api.java.en.When;

import java.util.ArrayList;
import java.util.Arrays;


public class NetNegativeSteps extends TestBase {

    private CliNegativeTests cliNegativeTests = new CliNegativeTests();

    @When("^CLI Net Negative$")
    public void netNegative() throws Exception {
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invalidDataList = new ArrayList<>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegativeTests.run(Menu.net().build(), invalidDataList, CliNegativeTests.GoodErrorsList.NET_IP_NEGATIVE_LIST);
        cliNegativeTests.after();

    }
}
