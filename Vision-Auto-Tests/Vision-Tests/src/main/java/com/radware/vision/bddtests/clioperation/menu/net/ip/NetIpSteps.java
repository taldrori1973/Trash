package com.radware.vision.bddtests.clioperation.menu.net.ip;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.utils.SutUtils;
import com.radware.vision.vision_handlers.common.InvokeCommon;
import com.radware.vision.vision_handlers.net.Ip;
import com.radware.vision.vision_handlers.root.RootVerifications;
import com.radware.vision.vision_project_cli.menu.Menu;
import cucumber.api.java.en.When;

public class NetIpSteps extends TestBase {

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
            Ip.setNetIp("77.77.77.77", "255.255.255.0", "G3", restTestBase.getRadwareServerCli());
            Ip.getNetIp("77.77.77.77", "255.255.255.0", "G3", false, restTestBase.getRadwareServerCli());
            Ip.setNetIp("88.88.88.77", "255.255.0.0", "G2", restTestBase.getRadwareServerCli());
            Ip.getNetIp("88.88.88.77", "255.255.0.0", "G2", false, restTestBase.getRadwareServerCli());
            Ip.managementSet("G3", restTestBase.getRadwareServerCli());
            Ip.getNetIp("77.77.77.77", "255.255.255.0", "G3", true, restTestBase.getRadwareServerCli());
            Ip.managementSet("G2", restTestBase.getRadwareServerCli());
            Ip.getNetIp("88.88.88.77", "255.255.0.0", "G2", true, restTestBase.getRadwareServerCli());
            Ip.managementSet("G1", restTestBase.getRadwareServerCli());
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
            Ip.setNetIp("77.77.77.77", "255.255.255.0", "G3", restTestBase.getRadwareServerCli());
            Ip.getNetIp("77.77.77.77", "255.255.255.0", "G3", false, restTestBase.getRadwareServerCli());
            Ip.setNetIp("88.88.88.77", "255.255.0.0", "G2", restTestBase.getRadwareServerCli());
            Ip.getNetIp("88.88.88.77", "255.255.0.0", "G2", false, restTestBase.getRadwareServerCli());
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
            Ip.managementSet("G1", restTestBase.getRadwareServerCli());
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
            Ip.ipDelete("G2", restTestBase.getRadwareServerCli());
            Ip.ipDelete("G3", restTestBase.getRadwareServerCli());
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
        InvokeCommon.checkSubMenu(restTestBase.getRadwareServerCli(), Menu.net().ip().build(), Ip.NET_IP_SUB_MENU);
    }

    /**
     * Test ' net ip management ' cmd sub menu
     *
     * @throws Exception
     */
    @When("^CLI Ip Management SubMenu Test$")
    public void ipManagementSubMenuTest() throws Exception {
        InvokeCommon.checkSubMenu(restTestBase.getRadwareServerCli(), Menu.net().ip().management().build(), Ip.NET_IP_MANAGEMENT_SUB_MENU);
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
            Ip.getNetIp("", "", "G3", false, restTestBase.getRadwareServerCli());
            Ip.getNetIp("", "", "G2", false, restTestBase.getRadwareServerCli());
            Ip.getNetIp(SutUtils.getCurrentVisionIp(), "255.255.0.0", "G1", true, restTestBase.getRadwareServerCli());

            //via root ...
            String[] wantedOutput = {"G1", "G3", "G2", "255.255.0.0", restTestBase.getRadwareServerCli().getHost()};
            RootVerifications.verifyLinuxOSParamsViaRootText("ifconfig", wantedOutput, restTestBase.getRootServerCli());

            RootVerifications.verifyLinuxOSParamsViaRootText("ls /etc/sysconfig/network-scripts/ | grep ifcfg-G -c", "3", restTestBase.getRootServerCli());

            String[] wantedOutput2 = {"ifcfg-G1", "ifcfg-G2", "ifcfg-G3"};
            RootVerifications.verifyLinuxOSParamsViaRootText("ls /etc/sysconfig/network-scripts/ | grep ifcfg-G", wantedOutput2, restTestBase.getRootServerCli());

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
            Ip.ipDelete("G2", restTestBase.getRadwareServerCli());
            Ip.ipDelete("G3", restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
