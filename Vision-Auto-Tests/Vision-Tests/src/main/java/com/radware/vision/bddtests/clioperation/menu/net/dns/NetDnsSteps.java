package com.radware.vision.bddtests.clioperation.menu.net.dns;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.vision_handlers.net.Dns;
import com.radware.vision.bddtests.BddCliTestBase;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;


public class NetDnsSteps extends BddCliTestBase {

    /**
     * Test ' net dns set ' cmd sub menu
     *
     * @throws Exception
     * @author izikp
     */

    @Given("^CLI dns set sub menu$")
    public void dnsSetSubMenuTest() throws Exception {
        Dns.dnsSetSubMenuCheck(restTestBase.getRadwareServerCli());
    }

    /**
     * Test ' net dns ' cmd sub menu
     *
     * @throws Exception
     * @author izikp
     */
    @Given("^CLI dns sub menu$")
    public void dnsSubMenuTest() throws Exception {
        Dns.dnsSubMenuCheck(restTestBase.getRadwareServerCli());
    }

    /**
     * Test ' net dns set primary ' cmd
     *
     * @throws Exception
     * @author izikp
     */

    @When("^CLI net dns primary Set$")
    public void netDnsPrimarySetTest() throws Exception {
        String dnsIpPrimary = "11.11.11.11";
        Dns.setDnsPrimary(restTestBase.getRadwareServerCli(), dnsIpPrimary);
        Dns.verifyPrimaryDnsViaRoot(restTestBase.getRootServerCli(), dnsIpPrimary);
        afterMethod();

    }

    /**
     * Test  ' net dns set secondary ' cmd
     *
     * @throws Exception
     * @author izikp
     */
    @When("^CLI net dns seconderay set$")
    public void netDnsSeconderaySetTest() throws Exception {
        String dnsPrimaryIp = "21.21.21.21";
        String dnsSecondaryIP = "22.22.22.22";
        Dns.setDnsPrimary(restTestBase.getRadwareServerCli(), dnsPrimaryIp);
        Dns.setDnsSecondary(restTestBase.getRadwareServerCli(), dnsSecondaryIP);
        Dns.verifySecondaryDnsViaRoot(restTestBase.getRootServerCli(), dnsSecondaryIP);
        afterMethod();
    }

    /**
     * qcTestId = 7039
     * Test ' net dns set Tertiary ' cmd
     *
     * @throws Exception
     * @author izikp
     */
    @When("^CLI net dns tertiary set$")
    public void netDnsTertiarySetTest() throws Exception {
        String dnsPrimaryIp = "31.31.31.31";
        String dnsSecondaryIP = "32.32.32.32";
        String dnsTertiaryIP = "33.33.33.33";
        Dns.setDnsPrimary(restTestBase.getRadwareServerCli(), dnsPrimaryIp);
        Dns.setDnsSecondary(restTestBase.getRadwareServerCli(), dnsSecondaryIP);
        Dns.setDnsTertiary(restTestBase.getRadwareServerCli(), dnsTertiaryIP);
        Dns.verifyTertiaryDnsViaRoot(restTestBase.getRootServerCli(), dnsTertiaryIP);
        afterMethod();
    }


    /**
     * 1) Configuring all 3 DNSs, and verify each one was configured via root
     * 2) Delete the Primary DNS, and Verifying it was deleted, Doesn't appear via root and radware.
     * 3) Verify the Secondary and the Tertiary DNSs were shifting up in one place to Primary and Secondary.
     *
     * @throws Exception
     * @author izikp
     */
    @When("^CLI net dns delete primary$")
    public void netDnsDeletePrimaryTest() throws Exception {
        String dnsPrimaryIp = "41.41.41.41";
        String dnsSecondaryIP = "42.42.42.42";
        String dnsTertiaryIP = "43.43.43.43";
        Dns.setDnsPrimary(restTestBase.getRadwareServerCli(), dnsPrimaryIp);
        Dns.verifyPrimaryDnsViaRoot(restTestBase.getRootServerCli(), dnsPrimaryIp);
        Dns.setDnsSecondary(restTestBase.getRadwareServerCli(), dnsSecondaryIP);
        Dns.verifySecondaryDnsViaRoot(restTestBase.getRootServerCli(), dnsSecondaryIP);
        Dns.setDnsTertiary(restTestBase.getRadwareServerCli(), dnsTertiaryIP);
        Dns.verifyTertiaryDnsViaRoot(restTestBase.getRootServerCli(), dnsTertiaryIP);
        Dns.deleteDns(restTestBase.getRadwareServerCli(), Dns.DnsType.PRIMARY);
        Dns.verifyDnsIpIsDeleted(restTestBase.getRootServerCli(), restTestBase.getRadwareServerCli(), dnsPrimaryIp);
        Dns.verifyPrimaryDnsViaRoot(restTestBase.getRootServerCli(), dnsSecondaryIP);
        Dns.verifySecondaryDnsViaRoot(restTestBase.getRootServerCli(), dnsTertiaryIP);
        afterMethod();

    }

    /**
     * 1) Configuring all 3 DNSs, and verify each one was configured via root
     * 2) Delete the Secondary DNS, and Verifying it was deleted, Doesn't appear via root and radware.
     * 3) Verify the Tertiary DNS was shifting up in one place to Secondary place and Primary remain the same.
     *
     * @throws Exception
     * @author izikp
     */

    @When("^CLI net dns delete secondary$")
    public void netDnsDeleteSecondaryTest() throws Exception {
        String dnsPrimaryIp = "51.51.51.51";
        String dnsSecondaryIP = "52.52.52.52";
        String dnsTertiaryIP = "53.53.53.53";
        Dns.setDnsPrimary(restTestBase.getRadwareServerCli(), dnsPrimaryIp);
        Dns.verifyPrimaryDnsViaRoot(restTestBase.getRootServerCli(), dnsPrimaryIp);
        Dns.setDnsSecondary(restTestBase.getRadwareServerCli(), dnsSecondaryIP);
        Dns.verifySecondaryDnsViaRoot(restTestBase.getRootServerCli(), dnsSecondaryIP);
        Dns.setDnsTertiary(restTestBase.getRadwareServerCli(), dnsTertiaryIP);
        Dns.verifyTertiaryDnsViaRoot(restTestBase.getRootServerCli(), dnsTertiaryIP);
        Dns.deleteDns(restTestBase.getRadwareServerCli(), Dns.DnsType.SECONDERAY);
        Dns.verifyDnsIpIsDeleted(restTestBase.getRootServerCli(), restTestBase.getRadwareServerCli(), dnsSecondaryIP);
        Dns.verifyPrimaryDnsViaRoot(restTestBase.getRootServerCli(), dnsPrimaryIp);
        Dns.verifySecondaryDnsViaRoot(restTestBase.getRootServerCli(), dnsTertiaryIP);
        afterMethod();

    }


    /**
     * 1) Configuring all 3 DNSs, and verify each one was configured via root 2)
     * Delete the TERTIARY DNS, and Verifying it was deleted, Doesn't appear via
     * root and radware. 3) Verify the Primary and Secondary DNS remain the same
     * place.
     *
     * @throws Exception
     * @author izikp
     */
    @When("^CLI net dns delete tertiary$")
    public void netDnsDeleteTertiaryTest() throws Exception {
        String dnsPrimaryIp = "61.61.61.61";
        String dnsSecondaryIP = "62.62.62.62";
        String dnsTertiaryIP = "63.63.63.63";
        Dns.setDnsPrimary(restTestBase.getRadwareServerCli(), dnsPrimaryIp);
        Dns.verifyPrimaryDnsViaRoot(restTestBase.getRootServerCli(), dnsPrimaryIp);
        Dns.setDnsSecondary(restTestBase.getRadwareServerCli(), dnsSecondaryIP);
        Dns.verifySecondaryDnsViaRoot(restTestBase.getRootServerCli(), dnsSecondaryIP);
        Dns.setDnsTertiary(restTestBase.getRadwareServerCli(), dnsTertiaryIP);
        Dns.verifyTertiaryDnsViaRoot(restTestBase.getRootServerCli(), dnsTertiaryIP);
        Dns.deleteDns(restTestBase.getRadwareServerCli(), Dns.DnsType.TERTIARY);
        Dns.verifyDnsIpIsDeleted(restTestBase.getRootServerCli(), restTestBase.getRadwareServerCli(), dnsTertiaryIP);
        Dns.verifyPrimaryDnsViaRoot(restTestBase.getRootServerCli(), dnsPrimaryIp);
        Dns.verifySecondaryDnsViaRoot(restTestBase.getRootServerCli(), dnsSecondaryIP);
        afterMethod();

    }

    /**
     * 1) Configuring all 3 DNSs, and verify each one was configured via root
     * 2) Delete the Secondary DNS, and Verifying it was deleted, Doesn't appear via root and radware.
     * 3) Verify the Tertiary DNS was shifting up in one place to Secondary place and Primary remain the same.
     *
     * @throws Exception
     * @author izikp
     */

    @Then("^CLI net dns get$")
    public void netDnsGetTest() throws Exception {
        String dnsPrimaryIp = "71.71.71.71";
        String dnsSecondaryIP = "72.72.72.72";
        String dnsTertiaryIP = "73.73.73.73";
        Dns.setDnsPrimary(restTestBase.getRadwareServerCli(), dnsPrimaryIp);
        Dns.setDnsSecondary(restTestBase.getRadwareServerCli(), dnsSecondaryIP);
        Dns.setDnsTertiary(restTestBase.getRadwareServerCli(), dnsTertiaryIP);
        Dns.verifyPrimaryDnsViaRoot(restTestBase.getRootServerCli(), dnsPrimaryIp);
        Dns.verifySecondaryDnsViaRoot(restTestBase.getRootServerCli(), dnsSecondaryIP);
        Dns.verifyTertiaryDnsViaRoot(restTestBase.getRootServerCli(), dnsTertiaryIP);
        Dns.VerifyGetDnsEqualToRoot(restTestBase.getRadwareServerCli(), restTestBase.getRootServerCli());
        afterMethod();

    }

    /**
     * After - Deletes all DNS configuration, and reconfigure the Primary DNS
     * from SUT file.
     *
     *
     *
     */
    private void afterMethod() {

        try {
            Dns.deleteDns(restTestBase.getRadwareServerCli(), Dns.DnsType.TERTIARY);
            Dns.deleteDns(restTestBase.getRadwareServerCli(), Dns.DnsType.SECONDERAY);
            Dns.deleteDns(restTestBase.getRadwareServerCli(), Dns.DnsType.PRIMARY);
            Dns.setDnsPrimaryFromSut(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


}

