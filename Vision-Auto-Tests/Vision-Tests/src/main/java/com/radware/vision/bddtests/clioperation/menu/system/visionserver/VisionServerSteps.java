package com.radware.vision.bddtests.clioperation.menu.system.visionserver;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.Deploy.UvisionServer;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.infra.testhandlers.cli.highavailability.HAHandler;
import com.radware.vision.vision_handlers.common.InvokeCommon;
import com.radware.vision.vision_handlers.system.VisionServer;
import com.radware.vision.vision_project_cli.menu.Menu;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import jsystem.extensions.analyzers.text.FindText;

import java.util.HashMap;

import static com.radware.vision.automation.Deploy.UvisionServer.UVISON_DEFAULT_SERVICES;
import static com.radware.vision.automation.Deploy.UvisionServer.waitForUvisionServerServicesStatus;

public class VisionServerSteps extends TestBase {

    @When("^CLI wait to vision services up for (\\d+) seconds$")
    public void waitForVisionServerStarted(int visionServerStartTimeout) throws Exception {
        long timeout = visionServerStartTimeout * 1000;
        if (!restTestBase.getRadwareServerCli().isConnected()) {
            restTestBase.getRadwareServerCli().connect();
        }
        if (!VisionServer.waitForVisionServerServicesToStart(restTestBase.getRadwareServerCli(), timeout))
            BaseTestUtils.report("Not all services are up till timeout", Reporter.FAIL);
    }

    @When("^CLI Vision Server SubMenu Test$")
    public void visionServerSubMenuTest() throws Exception {
        InvokeCommon.checkSubMenu(restTestBase.getRadwareServerCli(), Menu.system().visionServer().build(), VisionServer.SYSTEM_VISION_SERVER_SUB_MENU);
    }

    @When("^CLI Server Start$")
    public void serverStart() {
        try {
            returnToStart();
            VisionServer.visionServerStartAndVerify(restTestBase.getRadwareServerCli());
            BaseTestUtils.report("", Reporter.PASS);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }


    }

    @When("^CLI Server Stop$")
    public void serverStop() {
        try {
            reStop();
            VisionServer.visionServerStopAndVerify(restTestBase.getRadwareServerCli());
            BaseTestUtils.report("", Reporter.PASS);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        returnToStart();
    }

    /**
     * Stop vision server
     * Start vision server
     *
     * @throws Exception
     */

    @When("^CLI vision-server start$")
    public void visionServerStart() throws Exception {
        returnToStart();
        VisionServer.visionServerStartAndVerify(restTestBase.getRadwareServerCli());
        InvokeUtils.invokeCommand(null, "ps -ef | grep radware", restTestBase.getRootServerCli());
        restTestBase.getRootServerCli().analyze(new FindText("mgt-server"));
    }

    /**
     * Stop vision server
     *
     * @throws Exception
     */

    @When("^CLI vision-server stop$")
    public void visionServerStop() throws Exception {
        reStop();
        VisionServer.visionServerStartAndVerify(restTestBase.getRadwareServerCli());
        VisionServer.visionServerStopAndVerify(restTestBase.getRadwareServerCli());
        InvokeUtils.invokeCommand(null, "ps -ef | grep radware", restTestBase.getRootServerCli());
        restTestBase.getRootServerCli().analyze(new FindText("mysql"));
        restTestBase.getRootServerCli().analyze(new FindText("hw_monitoring"));
        returnToStart();
    }

    /**
     * Stop vision server
     * Check status
     * Start vision server
     * Check status
     */
    @When("^CLI vision-server status$")
    public void visionServerStatus() throws Exception {
        VisionServer.visionServerStartAndVerify(restTestBase.getRadwareServerCli());
        VisionServer.visionServerStopAndVerify(restTestBase.getRadwareServerCli());
        VisionServer.visionServerStartAndVerify(restTestBase.getRadwareServerCli());
        returnToStart();
    }

    /**
     * return the services status
     */
    @When("^CLI get vision-server status$")
    public void getVisionServerStatus() throws Exception {
        InvokeUtils.invokeCommand(null, Menu.system().visionServer().status().build(), restTestBase.getRadwareServerCli());
        BaseTestUtils.report(restTestBase.getRadwareServerCli().getOutputStr(), Reporter.PASS);
    }

    @Then("^CLI validate service \"(\\w+)\"(?: status is \"(\\w+)\")?(?: and health is \"(\\w+)\")?(?: retry for (\\d+) seconds)?$")
    public void validateUvisionDockerService(String dockerService,
                                             String dockerState,
                                             String dockerHealthState,
                                             Integer timeOut) {

        HashMap<UvisionServer.DockerServices, UvisionServer.DockerServiceStatus> dockerServices = new HashMap<>();
        UvisionServer.DockerHealthState healthState;
        UvisionServer.DockerState state;
        if (timeOut == null)
            timeOut = 0;
        if (dockerService.equalsIgnoreCase("all"))
            dockerServices = UVISON_DEFAULT_SERVICES;
        else {
            if (dockerHealthState == null)
                healthState = UvisionServer.DockerHealthState.NONE;
            else
                healthState = UvisionServer.DockerHealthState.valueOf(dockerHealthState);

            state = UvisionServer.DockerState.valueOf(dockerState);
            dockerServices.put(UvisionServer.DockerServices.valueOf(dockerService),
                    new UvisionServer.DockerServiceStatus(state, healthState));
        }
        waitForUvisionServerServicesStatus(serversManagement.getRadwareServerCli().get(), dockerServices, timeOut);
    }

    private void returnToStart() {
        try {
            int sec = 1000;
            int timeout = 1000;
            HAHandler.setConfigSyncMode(restTestBase.getRadwareServerCli(), "active", timeout * sec, "YES");
            String commandToExecute = "system vision-server start";
//           kVision
//            CliOperations.runCommand(restTestBase.getRadwareServerCli(), commandToExecute, 420*sec);
            waitForVisionServerStarted(360);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    private void reStop() {
        try {
            int sec = 1000;
            int timeout = 1000;
            HAHandler.setConfigSyncMode(restTestBase.getRadwareServerCli(), "disabled", timeout * sec, "YES");
            String commandToExecute = "system vision-server stop";
//           kVision
//            CliOperations.runCommand(restTestBase.getRadwareServerCli(), commandToExecute, 150 *sec);
            waitForVisionServerStarted(360);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


}
