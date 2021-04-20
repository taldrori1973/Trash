package com.radware.vision.bddtests.clioperation.menu.net.physicalInterface;

import com.radware.vision.automation.base.TestBase;
import com.radware.vision.vision_handlers.net.Ip;
import com.radware.vision.vision_project_cli.menu.Menu;
import com.radware.vision.vision_tests.CliNegativeTests;
import cucumber.api.java.en.When;

import java.util.ArrayList;
import java.util.Arrays;

public class NetPhysicalInterfaceNegativeSteps extends TestBase {

    CliNegativeTests cliNegativeTests = new CliNegativeTests();

    @When("^CLI Net Physical-Interface Set Negative$")
    public void netPhysicalInterfaceSetNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.INTERFACE));
        cliNegativeTests.run(Menu.net().physicalInterface().set().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_IP_NEGATIVE_LIST);

        Ip.ipDelete("G2", restTestBase.getRadwareServerCli());
        Ip.ipDelete("G3", restTestBase.getRadwareServerCli());
        cliNegativeTests.after();
    }

    @When("^CLI Net Physical-Interface Negative$")
    public void netPhysicalInterfaceNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegativeTests.run(Menu.net().physicalInterface().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_IP_NEGATIVE_LIST);

    }

    @When("^CLI Net Physical-Interface Get Negative$")
    public void netPhysicalInterfaceGetNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.TWO_INVALID));
        cliNegativeTests.run(Menu.net().physicalInterface().get().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_IP_NEGATIVE_LIST);
        cliNegativeTests.after();

    }
}
