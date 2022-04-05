package com.radware.vision.bddtests.clioperation.menu.net.dns;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.CliNegative;
import com.radware.vision.net.Dns;
import cucumber.api.java.en.Given;

import java.util.ArrayList;
import java.util.Arrays;


public class NetDnsNegativeSteps extends TestBase {

    CliNegative cliNegative = new CliNegative();
    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();

    /**
     * Tests, with bad ip : Net Dns Primary Set Negative
     */
    @Given("^CLI Net Dns Primary Set Negative$")
    public void netDnsPrimarySetNegative() {
        try {
            cliNegative.init();
            ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.IP_NET_DNS));
            cliNegative.run(Menu.net().dns().setPrimary().build(), invailedDataList, CliNegative.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
            Dns.setDnsPrimaryFromSut(radwareServerCli);
            cliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }

    /**
     * Tests, with bad ip : Net Dns Seconderay Set Negative
     */
    @Given("^CLI Net Dns Seconderay Set Negative$")
    public void netDnsSeconderaySetNegative() {
        try {
            cliNegative.init();
            ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.IP_NET_DNS));
            cliNegative.run(Menu.net().dns().setSecondary().build(), invailedDataList, CliNegative.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
            Dns.deleteDns(radwareServerCli, Dns.DnsType.SECONDERAY);
            cliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Tests, with bad ip : Net Dns Set Negative
     */
    @Given("^CLI Net Dns Set Negative$")
    public void netDnsSetNegative() {
        try {
            cliNegative.init();
            ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.IP_NET_DNS_DELETE));
            cliNegative.run(Menu.net().dns().set().build(), invailedDataList, CliNegative.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
            cliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Tests, with bad ip : Net Dns Tertiary Set Negative
     */
    @Given("^CLI Net Dns Tertiary Set Negative$")
    public void netDnsTertiarySetNegative() {
        try {
            cliNegative.init();
            ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.IP_NET_DNS));
            cliNegative.run(Menu.net().dns().setTertiary().build(), invailedDataList, CliNegative.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
            Dns.deleteDns(radwareServerCli, Dns.DnsType.TERTIARY);
            cliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Tests, with bad ip : net Dns Delete Primary
     */
    @Given("^CLI Net Dns Delete Primary Negative$")
    public void netDnsDeletePrimary() {
        try {
            cliNegative.init();
            ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.BAD_STRING));
            cliNegative.run(Menu.net().dns().deletePrimary().build(), invailedDataList, CliNegative.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
            cliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Tests, with bad ip : net Dns Delete Seconderay
     */
    @Given("^CLI Net Dns Delete Seconderay Negative$")
    public void netDnsDeleteSeconderay() {
        try {
            cliNegative.init();
            ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.IP_NET_DNS_DELETE));
            cliNegative.run(Menu.net().dns().deleteSecondary().build(), invailedDataList, CliNegative.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
            cliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Tests, with bad ip : net Dns Delete Tertiary
     */
    @Given("^CLI Net Dns Delete Tertiary Negative$")
    public void netDnsDeleteTertiary() {
        try {
            cliNegative.init();
            ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.IP_NET_DNS_DELETE));
            cliNegative.run(Menu.net().dns().deleteTertiary().build(), invailedDataList, CliNegative.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
            cliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Tests, with bad ip : Net Dns  Negative
     */
    @Given("^CLI Net Dns Negative$")
    public void netDnsNegative() {
        try {
            cliNegative.init();
            ArrayList<CliNegative.InvalidInputDataType> invailedDataList = new ArrayList<>(Arrays.asList(CliNegative.InvalidInputDataType.IP_NET_DNS_DELETE));
            cliNegative.run(Menu.net().dns().build(), invailedDataList, CliNegative.GoodErrorsList.NET_DNS_NEGATIVE_LIST);
            cliNegative.after();
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }


}
