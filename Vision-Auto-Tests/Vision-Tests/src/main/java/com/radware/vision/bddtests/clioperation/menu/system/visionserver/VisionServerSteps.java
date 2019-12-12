package com.radware.vision.bddtests.clioperation.menu.system.visionserver;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.vision_handlers.common.InvokeCommon;
import com.radware.vision.vision_handlers.system.VisionServer;
import com.radware.vision.vision_project_cli.menu.Menu;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.infra.testhandlers.cli.highavailability.HAHandler;
import cucumber.api.java.en.When;
import jsystem.extensions.analyzers.text.FindText;

public class VisionServerSteps extends BddCliTestBase {

    @When("^CLI wait to vision services up for (\\d+) seconds$")
    public void waitForVisionServerStarted(int visionServerStartTimeout) throws Exception {
        long timeout = visionServerStartTimeout * 1000;
        if (!restTestBase.getRadwareServerCli().isConnected()) {
            restTestBase.getRadwareServerCli().connect();
        }
        VisionServer.waitForVisionServerServicesToStart(restTestBase.getRadwareServerCli(), timeout);
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
     *
     *
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

    private void returnToStart() {
        try {
            int sec = 1000;
            int timeout = 1000;
            HAHandler.setConfigSyncMode(restTestBase.getRadwareServerCli(), "active", timeout * sec, "YES");
            String commandToExecute = "system vision-server start";
            CliOperations.runCommand(restTestBase.getRadwareServerCli(), commandToExecute, 420*sec);
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
            CliOperations.runCommand(restTestBase.getRadwareServerCli(), commandToExecute, 150 *sec);
            waitForVisionServerStarted(360);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


}
