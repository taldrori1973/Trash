package com.radware.vision.bddtests.clioperation.menu.net;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.net.Net;
import cucumber.api.java.en.Given;

public class NetSteps extends TestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();

    @Given("^CLI net sub menu$")
    public void netSubMenuTest() throws Exception {
        Net.netSubMenuCheck(radwareServerCli);
    }

//    /**
//     * Define primary DNS server
//     * Verify expected Dns ip primary
//     * Get the server IP
//     * Verify port name, ip address, mask and if active
//     * Verify server version and build number
//     * Get the route table
//     * Verify gateWay and interface
//     * Sets a new net route. (net route set net [Net IP] [Netmask] [Gateway IP] [G1|G2|G3])
//     * <p>
//     * Verify timeZone
//     *
//     * @throws Exception
//     */
//
//    @Then("^CLI net commands$")
//    public void netTest() {
//        try {
//
//            updatePortalVisionBuildAndVersion();
//            String buildNumber = managementInfo.getBuild();
//            String versionNumebr = managementInfo.getVersion();
//
//            Dns.setDnsPrimaryFromSut(restTestBase.getRadwareServerCli());
//            Dns.getDnsPrimary(restTestBase.getRadwareServerCli());
//            Ip.getNetIp(SutUtils.getCurrentVisionIp(), "255.255.0.0", "G1", true, restTestBase.getRadwareServerCli());
//            Version.verifyServerVersion(versionNumebr, buildNumber, restTestBase.getRadwareServerCli(), restTestBase.getRootServerCli());
//            Route.verifyRouteDefault("172.17.1.1", "G1", restTestBase.getRadwareServerCli());
//            Route.setNewNetRoute("172.17.0.0", "255.255.0.0", "172.17.1.5", "G1", restTestBase.getRadwareServerCli());
////            VisionServer.visionServerStartAndVerify(restTestBase.getRadwareServerCli());
////            VisionServer.visionServerStopAndVerify(restTestBase.getRadwareServerCli());
////            VisionServer.visionServerStatus(StartStop.STOP, restTestBase.getRadwareServerCli());
////            VisionServer.visionServerStartAndVerify(restTestBase.getRadwareServerCli());
////			VisionServer.visionServerStatus(StartStop.START, restTestBase.getRadwareServerCli());
////            Timezone.verifyTimezone("Etc/UTC", restTestBase.getRadwareServerCli());
//        } catch (Exception e) {
//            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
//        }
//
//        afterMethod();
//
//    }

//    private void afterMethod() {
//        try {
////            VisionServer.visionServerStartAndVerify(restTestBase.getRadwareServerCli());
//            Route.routeDelete("172.17.0.0", "255.255.0.0", "172.17.1.5", "G1", restTestBase.getRadwareServerCli());
//        } catch (Exception e) {
//            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
//        }
//    }

}
