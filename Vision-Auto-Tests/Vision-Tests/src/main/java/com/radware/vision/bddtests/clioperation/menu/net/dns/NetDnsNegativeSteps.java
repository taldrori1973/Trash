package com.radware.vision.bddtests.clioperation.menu.net.dns;

import com.radware.vision.vision_handlers.net.Dns;
import com.radware.vision.vision_project_cli.menu.Menu;
import com.radware.vision.vision_tests.CliNegativeTests;
import com.radware.vision.bddtests.BddCliTestBase;
import cucumber.api.java.en.Given;

import java.util.ArrayList;
import java.util.Arrays;


public class NetDnsNegativeSteps extends BddCliTestBase {

    CliNegativeTests cliNegativeTests = new CliNegativeTests();

    /**
     * Tests, with bad ip : Net Dns Primary Set Negative
     */
    @Given("^CLI Net Dns Primary Set Negative$")
    public void netDnsPrimarySetNegative() throws Exception {
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_DNS));
        cliNegativeTests.run(Menu.net().dns().setPrimary().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
        Dns.setDnsPrimaryFromSut(restTestBase.getRadwareServerCli());
        cliNegativeTests.after();

    }

    /**
     * Tests, with bad ip : Net Dns Seconderay Set Negative
     */
    @Given("^CLI Net Dns Seconderay Set Negative$")
    public void netDnsSeconderaySetNegative() throws Exception {
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_DNS));
        cliNegativeTests.run(Menu.net().dns().setSecondary().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
        Dns.deleteDns(restTestBase.getRadwareServerCli(), Dns.DnsType.SECONDERAY);
        cliNegativeTests.after();
    }

    /**
     * Tests, with bad ip : Net Dns Set Negative
     */
    @Given("^CLI Net Dns Set Negative$")
    public void netDnsSetNegative() throws Exception {
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_DNS_DELETE));
        cliNegativeTests.run(Menu.net().dns().set().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    /**
     * Tests, with bad ip : Net Dns Tertiary Set Negative
     */
    @Given("^CLI Net Dns Tertiary Set Negative$")
    public void netDnsTertiarySetNegative() throws Exception {
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_DNS));
        cliNegativeTests.run(Menu.net().dns().setTertiary().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
        Dns.deleteDns(restTestBase.getRadwareServerCli(), Dns.DnsType.TERTIARY);
        cliNegativeTests.after();
    }

    /**
     * Tests, with bad ip : net Dns Delete Primary
     */
    @Given("^CLI Net Dns Delete Primary Negative$")
    public void netDnsDeletePrimary() throws Exception {
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.BAD_STRING));
        cliNegativeTests.run(Menu.net().dns().deletePrimary().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    /**
     * Tests, with bad ip : net Dns Delete Seconderay
     */
    @Given("^CLI Net Dns Delete Seconderay Negative$")
    public void netDnsDeleteSeconderay() throws Exception {
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_DNS_DELETE));
        cliNegativeTests.run(Menu.net().dns().deleteSecondary().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    /**
     * Tests, with bad ip : net Dns Delete Tertiary
     */
    @Given("^CLI Net Dns Delete Tertiary Negative$")
    public void netDnsDeleteTertiary() throws Exception {
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_DNS_DELETE));
        cliNegativeTests.run(Menu.net().dns().deleteTertiary().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
        cliNegativeTests.after();
    }

    /**
     * Tests, with bad ip : Net Dns  Negative
     */
    @Given("^CLI Net Dns Negative$")
    public void netDnsNegative() throws Exception {
        cliNegativeTests.init();
        ArrayList<CliNegativeTests.InvalidInputDataType> invailedDataList = new ArrayList<CliNegativeTests.InvalidInputDataType>(Arrays.asList(CliNegativeTests.InvalidInputDataType.IP_NET_DNS_DELETE));
        cliNegativeTests.run(Menu.net().dns().build(), invailedDataList, CliNegativeTests.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
        cliNegativeTests.after();

    }


}
