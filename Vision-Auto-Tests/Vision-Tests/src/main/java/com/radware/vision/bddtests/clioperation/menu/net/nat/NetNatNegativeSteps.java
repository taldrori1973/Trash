package com.radware.vision.bddtests.clioperation.menu.net.nat;

import com.radware.vision.automation.base.TestBase;
import com.radware.vision.vision_handlers.net.Nat;
import com.radware.vision.vision_project_cli.menu.Menu;
import com.radware.vision.vision_tests.CliNegativeTests;
import cucumber.api.java.en.When;

import java.util.ArrayList;
import java.util.Arrays;

public class NetNatNegativeSteps extends TestBase {

    CliNegativeTests cliNegativeTests=new CliNegativeTests();

    @When("^CLI Net Nat Set HostName Negative$")
    public void netNatSetHostNameNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.HOST_NAME));
        cliNegativeTests.run(Menu.net().nat().setHostName().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_NAT_NEGATIVE_LIST);
        Nat.netNatSetNone(restTestBase.getRadwareServerCli());
        cliNegativeTests.after();
    }

    @When("^CLI Net Nat Set IP Negative$")
    public void netNatSetIPNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_DNS));
        cliNegativeTests.run(Menu.net().nat().setIp().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_NAT_NEGATIVE_LIST);
        Nat.netNatSetNone(restTestBase.getRadwareServerCli());
        cliNegativeTests.after();
    }

    @When("^CLI Net Nat Get Negative$")
    public void netNatGetNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME));
        cliNegativeTests.run(Menu.net().nat().get().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_NAT_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    @When("^CLI Net Nat Set Negative$")
    public void netNatSetNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegativeTests.run(Menu.net().nat().set().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_NAT_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    @When("^CLI Net Nat Negative$")
    public void netNatNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegativeTests.run(Menu.net().nat().set().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_NAT_NEGATIVE_LIST);
        cliNegativeTests.after();
    }


}
