package com.radware.vision.bddtests.clioperation.menu.net.physicalInterface;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.CliNegative;
import com.radware.vision.net.Ip;
import cucumber.api.java.en.When;

import java.util.ArrayList;
import java.util.Arrays;

public class NetPhysicalInterfaceNegativeSteps extends TestBase {

    CliNegative cliNegative = new CliNegative();
    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();


    @When("^CLI Net Physical-Interface Set Negative$")
    public void netPhysicalInterfaceSetNegative() throws Exception{
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.INTERFACE));
        cliNegative.run(Menu.net().physicalInterface().set().build(), invailedDataList , CliNegative.GoodErrorsList.NET_IP_NEGATIVE_LIST);
        Ip.ipDelete("G3", radwareServerCli);
        cliNegative.after();
    }

    @When("^CLI Net Physical-Interface Negative$")
    public void netPhysicalInterfaceNegative() throws Exception{
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegative.run(Menu.net().physicalInterface().build(), invailedDataList , CliNegative.GoodErrorsList.NET_IP_NEGATIVE_LIST);

    }

    @When("^CLI Net Physical-Interface Get Negative$")
    public void netPhysicalInterfaceGetNegative() throws Exception{
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.TWO_INVALID));
        cliNegative.run(Menu.net().physicalInterface().get().build(), invailedDataList , CliNegative.GoodErrorsList.NET_IP_NEGATIVE_LIST);
        cliNegative.after();

    }
}
