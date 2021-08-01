package com.radware.vision.bddtests.clioperation.menu.net.ip;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.net.Ip;
import com.radware.vision.root.RootVerifications;
import com.radware.vision.utils.SutUtils;
import com.radware.vision.vision_project_cli.menu.Menu;
import cucumber.api.java.en.When;

public class NetIpSteps extends TestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();
    
    /**
     * set new net port ip's and verify.
     * replace management ports
     *
     * @throws Exception
     */
    @When("^CLI net ip test$")
    public void netIpTest() {
        afterMethod();
        try {
            Ip.setNetIp("77.77.77.77", "255.255.255.0", "G3", radwareServerCli);
            Ip.getNetIp("77.77.77.77", "255.255.255.0", "G3", false, radwareServerCli);
            Ip.setNetIp("88.88.88.77", "255.255.0.0", "G2", radwareServerCli);
            Ip.getNetIp("88.88.88.77", "255.255.0.0", "G2", false, radwareServerCli);
            Ip.managementSet("G3", radwareServerCli);
            Ip.getNetIp("77.77.77.77", "255.255.255.0", "G3", true, radwareServerCli);
            Ip.managementSet("G2", radwareServerCli);
            Ip.getNetIp("88.88.88.77", "255.255.0.0", "G2", true, radwareServerCli);
            Ip.managementSet("G1", radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    /**
     * set new net port ip's and verify.
     *
     * @throws Exception
     */
    @When("^CLI net ip set$")
    public void netIpSet() {
        afterMethod();
        try {
            Ip.setNetIp("77.77.77.77", "255.255.255.0", "G3", radwareServerCli);
            Ip.getNetIp("77.77.77.77", "255.255.255.0", "G3", false, radwareServerCli);
            Ip.setNetIp("88.88.88.77", "255.255.0.0", "G2", radwareServerCli);
            Ip.getNetIp("88.88.88.77", "255.255.0.0", "G2", false, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    /**
     * set G1 to management ip
     *
     * @throws Exception
     */
    @When("^CLI Net Ip Management$")
    public void netIpManagement() {
        afterMethod();
        try {
            Ip.managementSet("G1", radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    /**
     * set new management net port ip
     *
     * @throws Exception
     */
    @When("^CLI Net Ip Delete$")
    public void netIpDelete() {
        try {
            Ip.ipDelete("G2", radwareServerCli);
            Ip.ipDelete("G3", radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Test ' net ip ' cmd sub menu
     *
     * @throws Exception
     */
    @When("^CLI Ip Sub Menu Test$")
    public void ipSubMenuTest() throws Exception {
        CliOperations.checkSubMenu(radwareServerCli, Menu.net().ip().build(), Ip.NET_IP_SUB_MENU);
    }

    /**
     * Test ' net ip management ' cmd sub menu
     *
     * @throws Exception
     */
    @When("^CLI Ip Management SubMenu Test$")
    public void ipManagementSubMenuTest() throws Exception {
        CliOperations.checkSubMenu(radwareServerCli, Menu.net().ip().management().build(), Ip.NET_IP_MANAGEMENT_SUB_MENU);
    }

    /**
     * The Scenario :
     * 1.	net ip get - check the output
     * 2.	via root ifconfig and check the output
     * 3. 	via root ls /etc/sysconfig/network-scripts/ | grep ifcfg-G -c
     * 4. 	via root ls /etc/sysconfig/network-scripts/ | grep ifcfg-G
     * 5.	via root ifconfig G1 and check the output
     * 6.	via root ifconfig G2 and check the output
     * 7.	via root ifconfig G3 and check the output
     */
    @When("^CLI Net Ip Get$")
    public void netIpGet() {
        afterMethod();
        try {
            //net ip get - check the output
            Ip.getNetIp("", "", "G3", false, radwareServerCli);
            Ip.getNetIp("", "", "G2", false, radwareServerCli);
            Ip.getNetIp(SutUtils.getCurrentVisionIp(), "255.255.0.0", "G1", true, radwareServerCli);

            //via root ...
            String[] wantedOutput = {"G1", "G3", "G2", "255.255.0.0", radwareServerCli.getHost()};
            RootVerifications.verifyLinuxOSParamsViaRootText("ifconfig", wantedOutput, rootServerCli);

            RootVerifications.verifyLinuxOSParamsViaRootText("cat /etc/netplan/00-installer-config.yaml | grep -E G'[0-9]+': -c", "3", rootServerCli);

            String[] wantedOutput2 = {"G1:", "G2:", "G3:"};
            RootVerifications.verifyLinuxOSParamsViaRootText("cat /etc/netplan/00-installer-config.yaml | grep -E G'[0-9]+':", wantedOutput2, rootServerCli);

            // Removed since the MAC Address is changed each VM deployment
//			String [] wantedOutput3 = {radwareServerCli.getHost(), "255.255.0.0", "G1","HWaddr 00:0C:29:DD:"};
//			RootVerifications.verifyLinuxOSParamsViaRootText("ifconfig G1", wantedOutput3, rootServerCli);

//			String [] wantedOutput4 = {"G2","HWaddr 00:50:56:9E:"};
//			RootVerifications.verifyLinuxOSParamsViaRootText("ifconfig G2", wantedOutput4, rootServerCli);
//
//			String [] wantedOutput5 = {"G3","HWaddr 00:50:56:9E:"};
//			RootVerifications.verifyLinuxOSParamsViaRootText("ifconfig G3", wantedOutput5, rootServerCli);

        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        afterMethod();
    }

    public void afterMethod() {
        try {
            Ip.ipDelete("G2", radwareServerCli);
            Ip.ipDelete("G3", radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
