package com.radware.vision.bddtests.clioperation.menu.system.cleanup;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.vision_handlers.system.CleanupHandler;
import com.radware.vision.bddtests.BddCliTestBase;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.When;

public class Cleanup extends BddCliTestBase {

    @When("^CLI Cleanup without server Ip the vision HA setup$")
    public void systemCleanupWithoutServerIp_HA() {
        try {
            CleanupHandler.systemCleanupWithoutServerIp_HA(restTestBase.getHaManager(), restTestBase.getVisionServerHA(), restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report("Cleanup operation failed with the following error: " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI cleanup without server Ip the vision$")
    public void cliCleanupWithoutServerIpTheVision() {

        try {
            com.radware.vision.vision_handlers.system.Cleanup.cleanupWithoutServerIp(restTestBase.getRadwareServerCli());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
