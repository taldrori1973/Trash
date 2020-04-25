package com.radware.vision.bddtests.clioperation.menu.net.route;

import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.vision_handlers.common.InvokeCommon;
import com.radware.vision.vision_handlers.root.RootVerifications;
import com.radware.vision.vision_project_cli.menu.Menu;
import com.radware.vision.vision_tests.CliNegativeTests;
import cucumber.api.java.en.When;

import java.util.ArrayList;
import java.util.Arrays;

public class NetRouteNegativeSteps extends BddCliTestBase {

    CliNegativeTests cliNegativeTests = new CliNegativeTests();

    /**
     * check the invalid input parameters and the returned messages
     * takes 68 sec !!!!!!!!!!!!!!!!
     * */
    @When("^CLI Net Route Set Ip Host Negative Input$")
    public void netRouteSetIpNegativeTest() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_ROUTH,CliNegativeTests.InvalidInputDataType.NETMASK, CliNegativeTests.InvalidInputDataType.INTERFACE));
        cliNegativeTests.run(Menu.net().route().setHost().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegativeTests.after();

    }


    /**
     * check the invalid input parameters and the returned messages
     * takes 196 sec !!!!!!!!!!!!!!!!
     * */
    @When("^CLI Net Route Set Net Negative Input$")
    public void netRouteSetNetNegativeTest() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NET,CliNegativeTests.InvalidInputDataType.NETMASK,CliNegativeTests.InvalidInputDataType.IP_NET_ROUTH ,CliNegativeTests.InvalidInputDataType.INTERFACE));
        cliNegativeTests.run(Menu.net().route().setNet().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    /**
     * check the invalid input parameters and the returned messages
     * */
    @When("^CLI Net Route Set Default Negative Input$")
    public void netRouteSetDefaultNegativeTest() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_ROUTH));
        cliNegativeTests.run(Menu.net().route().setDefault().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    /**
     * check the invalid input parameters and the returned messages
     * */
    @When("^CLI Net Route Set Host Negative Input$")
    public void netRouteSetHostNegativeTest() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_ROUTH));
        cliNegativeTests.run(Menu.net().route().setHost().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    @When("^CLI Net Route Delete Negative Input$")
    public void netRouteDeleteNegativeTest() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_ROUTH));
        cliNegativeTests.run(Menu.net().route().delete().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    @When("^CLI Net Route Get Negative Input$")
    public void netRouteGetNegativeTest() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.TWO_INVALID));
        cliNegativeTests.run(Menu.net().route().get().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    @When("^CLI Net Route Set Negative Input$")
    public void netRouteSetNegativeTest() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegativeTests.run(Menu.net().route().set().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    @When("^CLI Net Route Negative Input$")
    public void netRouteNegativeTest() throws Exception{
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.NAME_WITHOUT_EMPTY));
        cliNegativeTests.run(Menu.net().route().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_ROUTH_NEGATIVE_LIST);
        cliNegativeTests.after();
    }



    /**
     * The Scenario :
     * 1.	net route set host - Bad Parameters, Use "net route set host ?"
     * 2.	net route set host bad_ip 255.255.0.0 G1
     * 3.	net route set host 11.11.11.11 10.205.1.5 G4
     * 4.	net route set host 192.168.332.11 10.205.1.5 G2
     * 5.	net route set host 172.16.4.11 99.99.99.99
     * 6.	net route set host 88.1.1.1 136.4.1.333
     *
     * @throws Exception
     */
    NetRouteSteps netRouteSteps = new NetRouteSteps();
    @When("^CLI Net Route Set Host Negative-Bad Parameters$")
    public void netRouteSetHostNegativeBadParameters() throws Exception {
        cliNegativeTests.init();

        InvokeCommon.invokeCommandAndFindResult(Menu.net().route().setHost().build(), "Bad Parameters, Use \"net route set host ?\"", restTestBase.getRadwareServerCli());

        InvokeCommon.invokeCommandAndFindResult(Menu.net().route().setHost().build() + " bad_ip 255.255.0.0 G1", new ArrayList<String>(Arrays.asList("Unknown host", "Failed setting route")), restTestBase.getRadwareServerCli());

        InvokeCommon.invokeCommandAndFindResult(Menu.net().route().setHost().build() + " 11.11.11.11 10.205.1.5 G4", "Failed setting route", restTestBase.getRadwareServerCli());
        RootVerifications.verifyLinuxOSParamsNotExistViaRootRegex("route -n", "11.11.11.11", restTestBase.getRootServerCli());

        InvokeCommon.invokeCommandAndFindResult(Menu.net().route().setHost().build() + " 192.168.332.11 10.205.1.5 G2", new ArrayList<String>(Arrays.asList("Unknown host", "Failed setting route")), restTestBase.getRadwareServerCli());

        InvokeCommon.invokeCommandAndFindResult(Menu.net().route().setHost().build() + " 172.16.4.11 99.99.99.99", new ArrayList<String>(Arrays.asList("Network is unreachable", "Failed setting route")), restTestBase.getRadwareServerCli());
        RootVerifications.verifyLinuxOSParamsNotExistViaRootRegex("route -n", "172.16.4.11", restTestBase.getRootServerCli());

        InvokeCommon.invokeCommandAndFindResult(Menu.net().route().setHost().build() + " 88.1.1.1 136.4.1.333", new ArrayList<String>(Arrays.asList("Unknown host", "Failed setting route")), restTestBase.getRadwareServerCli());

        RootVerifications.verifyLinuxOSParamsNotExistViaRootRegex("route -n", "88.1.1.1", restTestBase.getRootServerCli());
        netRouteSteps.afterMethod();
        cliNegativeTests.after();

    }
}
