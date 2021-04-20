package com.radware.vision.bddtests.clioperation.menu.system.highavailability;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.infra.testhandlers.cli.highavailability.HAHandler;
import cucumber.api.java.en.When;

public class HATests extends TestBase {

    @When("^CLI Set config sync interval to (\\d+)$")
    public void setConfigSyncInterval(int interval) {
        HAHandler.setConfigSyncInterval(restTestBase.getRadwareServerCli(), interval);
    }

    @When("^CLI Set config sync mode to \"(.*)\" with timeout (\\d+)$")
    public void setConfigSyncMode(String mode, int timeout) {
        int sec = 1000;
        HAHandler.setConfigSyncMode(restTestBase.getRadwareServerCli(), mode, timeout*sec, "YES");
    }

    @When("^CLI Set config sync mode to \"(.*)\" without services with timeout (\\d+)$")
    public void setConfigSyncModeWithoutServices(String mode, int timeout) {
        int sec = 1000;
        HAHandler.setConfigSyncModeWithoutServices(restTestBase.getRadwareServerCli(), mode, timeout * sec, "YES");
    }

    @When("^CLI Set config sync peer$")
    public void setConfigSyncPeer() {
        try {
            HAHandler.setConfigSyncPeer(restTestBase.getRadwareServerCli(), null, restTestBase.getVisionServerHA());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Set both visions disabled with timeout (\\d+)$")
    public void setBothVisionsDisabled(int timeout) {
        int sec = 1000;
        try {
            HAHandler.setBothVisionsDisabled(restTestBase.getHaManager(), restTestBase.getVisionServerHA(), timeout*sec);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Switch to \"(.*)\" vision$")
    public void setTargetVision(String mode) {
        try {
            HAHandler.setTargetVision(restTestBase.getHaManager(), mode);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Make manual sync$")
    public void manualSync() {
        HAHandler.manualSync(restTestBase.getRadwareServerCli());
    }
}
