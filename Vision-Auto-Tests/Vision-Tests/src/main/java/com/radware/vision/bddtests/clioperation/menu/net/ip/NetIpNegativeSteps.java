package com.radware.vision.bddtests.clioperation.menu.net.ip;

import com.radware.vision.vision_handlers.net.Ip;
import com.radware.vision.vision_project_cli.menu.Menu;
import com.radware.vision.vision_tests.CliNegativeTests;
import com.radware.vision.bddtests.BddCliTestBase;
import cucumber.api.java.en.Given;

import java.util.ArrayList;
import java.util.Arrays;

public class NetIpNegativeSteps extends BddCliTestBase {

    CliNegativeTests cliNegativeTests=new CliNegativeTests();

    @Given("^CLI Net Ip Set Negative$")
    public void netIPSetNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_DNS,CliNegativeTests.InvalidInputDataType.NETMASK,CliNegativeTests.InvalidInputDataType.INTERFACE));
        cliNegativeTests.run(Menu.net().ip().set().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_IP_NEGATIVE_LIST);

        Ip.ipDelete("G2", restTestBase.getRadwareServerCli());
        Ip.ipDelete("G3", restTestBase.getRadwareServerCli());
        cliNegativeTests.after();
    }

    @Given("^CLI Net Ip Management Set Negative$")
    public void netIPManagementSetNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.INTERFACE));
        cliNegativeTests.run(Menu.net().ip().managementSet().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_IP_NEGATIVE_LIST);

        Ip.ipDelete("G2", restTestBase.getRadwareServerCli());
        Ip.ipDelete("G3", restTestBase.getRadwareServerCli());
        cliNegativeTests.after();
    }

    @Given("^CLI Net Ip Delete Negative$")
    public void netIPDeleteNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.INTERFACE));
        cliNegativeTests.run(Menu.net().ip().delete().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_IP_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    @Given("^CLI Net Ip Get Negative$")
    public void netIPGetNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.BAD_STRING));
        cliNegativeTests.run(Menu.net().ip().get().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_IP_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    @Given("^CLI Net Ip Managment Negative$")
    public void netIPManagmentNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME));
        cliNegativeTests.run(Menu.net().ip().management().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_IP_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    @Given("^CLI Net Ip Negative$")
    public void netIpNegative() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegativeTests.run(Menu.net().ip().build(), invailedDataList , CliNegativeTests.GoodErrorsList.NET_IP_NEGATIVE_LIST);
        cliNegativeTests.after();
    }
}
