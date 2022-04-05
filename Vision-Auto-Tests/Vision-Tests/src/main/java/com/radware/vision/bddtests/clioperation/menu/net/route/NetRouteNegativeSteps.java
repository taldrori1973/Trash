package com.radware.vision.bddtests.clioperation.menu.net.route;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.CliNegative;
import com.radware.vision.root.RootVerifications;
import com.radware.vision.vision_handlers.common.InvokeCommon;
import cucumber.api.java.en.When;

import java.util.ArrayList;
import java.util.Arrays;

public class NetRouteNegativeSteps extends TestBase {

    CliNegative cliNegative = new CliNegative();
    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();

    /**
     * check the invalid input parameters and the returned messages
     * takes 68 sec !!!!!!!!!!!!!!!!
     */
    @When("^CLI Net Route Set Ip Host Negative Input$")
    public void netRouteSetIpNegativeTest() throws Exception {
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(
                CliNegative.InvalidInputDataType.IP_NET_ROUTH, CliNegative.InvalidInputDataType.NETMASK,
                CliNegative.InvalidInputDataType.INTERFACE));
        cliNegative.run(Menu.net().route().setHost().build(), invailedDataList, CliNegative.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegative.after();

    }


    /**
     * check the invalid input parameters and the returned messages
     * takes 196 sec !!!!!!!!!!!!!!!!
     */
    @When("^CLI Net Route Set Net Negative Input$")
    public void netRouteSetNetNegativeTest() throws Exception {
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(
                CliNegative.InvalidInputDataType.NET, CliNegative.InvalidInputDataType.NETMASK, CliNegative.InvalidInputDataType.IP_NET_ROUTH,
                CliNegative.InvalidInputDataType.INTERFACE));
        cliNegative.run(Menu.net().route().setNet().build(), invailedDataList, CliNegative.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegative.after();
    }

    /**
     * check the invalid input parameters and the returned messages
     */
    @When("^CLI Net Route Set Default Negative Input$")
    public void netRouteSetDefaultNegativeTest() throws Exception {
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.IP_NET_ROUTH));
        cliNegative.run(Menu.net().route().setDefault().build(), invailedDataList, CliNegative.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegative.after();
    }

    /**
     * check the invalid input parameters and the returned messages
     */
    @When("^CLI Net Route Set Host Negative Input$")
    public void netRouteSetHostNegativeTest() throws Exception {
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.IP_NET_ROUTH));
        cliNegative.run(Menu.net().route().setHost().build(), invailedDataList, CliNegative.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegative.after();
    }

    @When("^CLI Net Route Delete Negative Input$")
    public void netRouteDeleteNegativeTest() throws Exception {
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.IP_NET_ROUTH));
        cliNegative.run(Menu.net().route().delete().build(), invailedDataList, CliNegative.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegative.after();
    }

    @When("^CLI Net Route Get Negative Input$")
    public void netRouteGetNegativeTest() throws Exception {
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.TWO_INVALID));
        cliNegative.run(Menu.net().route().get().build(), invailedDataList, CliNegative.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegative.after();
    }

    @When("^CLI Net Route Set Negative Input$")
    public void netRouteSetNegativeTest() throws Exception {
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegative.run(Menu.net().route().set().build(), invailedDataList, CliNegative.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegative.after();
    }

    @When("^CLI Net Route Negative Input$")
    public void netRouteNegativeTest() throws Exception {
        cliNegative.init();
        ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegative.run(Menu.net().route().build(), invailedDataList, CliNegative.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegative.after();
    }

}
