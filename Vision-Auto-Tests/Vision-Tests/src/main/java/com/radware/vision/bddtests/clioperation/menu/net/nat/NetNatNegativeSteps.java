package com.radware.vision.bddtests.clioperation.menu.net.nat;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.CliNegative;
import com.radware.vision.net.Nat;
import cucumber.api.java.en.When;

import java.util.ArrayList;
import java.util.Arrays;

public class NetNatNegativeSteps extends TestBase {

    CliNegative cliNegative=new CliNegative();
    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();

    @When("^CLI Net Nat Set HostName Negative$")
    public void netNatSetHostNameNegative() throws Exception{
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.HOST_NAME));
        cliNegative.run(Menu.net().nat().setHostName().build(), invailedDataList , CliNegative.GoodErrorsList.NET_NAT_NEGATIVE_LIST);
        Nat.netNatSetNone(radwareServerCli);
        cliNegative.after();
    }

    @When("^CLI Net Nat Set IP Negative$")
    public void netNatSetIPNegative() throws Exception{
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.IP_NET_DNS));
        cliNegative.run(Menu.net().nat().setIp().build(), invailedDataList , CliNegative.GoodErrorsList.NET_NAT_NEGATIVE_LIST);
        Nat.netNatSetNone(radwareServerCli);
        cliNegative.after();
    }

    @When("^CLI Net Nat Get Negative$")
    public void netNatGetNegative() throws Exception{
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.NAME));
        cliNegative.run(Menu.net().nat().get().build(), invailedDataList , CliNegative.GoodErrorsList.NET_NAT_NEGATIVE_LIST);
        cliNegative.after();
    }

    @When("^CLI Net Nat Set Negative$")
    public void netNatSetNegative() throws Exception{
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegative.run(Menu.net().nat().set().build(), invailedDataList , CliNegative.GoodErrorsList.NET_NAT_NEGATIVE_LIST);
        cliNegative.after();
    }

    @When("^CLI Net Nat Negative$")
    public void netNatNegative() throws Exception{
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegative.run(Menu.net().nat().set().build(), invailedDataList , CliNegative.GoodErrorsList.NET_NAT_NEGATIVE_LIST);
        cliNegative.after();
    }


}
