package com.radware.vision.bddtests.clioperation.menu.system.visionserver;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.Deploy.UvisionServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.system.VisionServerCli;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.util.HashMap;

import static com.radware.vision.automation.Deploy.UvisionServer.*;

public class VisionServerSteps extends TestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();


    @When("^CLI wait to vision services up for (\\d+) seconds$")
    public void waitForVisionServerStarted(int visionServerStartTimeout) {
        try {
            long timeout = visionServerStartTimeout * 1000;
            if (!radwareServerCli.isConnected()) {
                radwareServerCli.connect();
            }
            waitForUvisionServerServicesStatus(radwareServerCli, UVISON_DEFAULT_SERVICES, timeout);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Vision Server SubMenu Test$")
    public void visionServerSubMenuTest() {
        try {
            CliOperations.checkSubMenu(radwareServerCli, Menu.system().visionServer().build(), VisionServerCli.SYSTEM_VISION_SERVER_SUB_MENU);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Server Start$")
    public void serverStart() {
        try {
            VisionServerCli.visionServerStart(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }


    }

    @When("^CLI Server Stop$")
    public void serverStop() {
        try {
            VisionServerCli.visionServerStop(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Stop vision server
     * Check status
     * Start vision server
     * Check status
     */
    @When("^CLI vision-server status$")
    public void visionServerStatus() {
        //todo: kvision add status when available
        try {
            VisionServerCli.visionServerStop(radwareServerCli);
            VisionServerCli.visionServerStart(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
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
        try {
            waitForUvisionServerServicesStatus(radwareServerCli, dockerServices, timeOut);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


}
