package com.radware.vision.bddtests.clioperation.menu.system.highavailability;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.highavailability.HAHandler;
import cucumber.api.java.en.When;

public class HASteps extends TestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();


    @When("^CLI Set config sync interval to (\\d+)$")
    public void setConfigSyncInterval(int interval) {
        HAHandler.setConfigSyncInterval(radwareServerCli, interval);
    }

    @When("^CLI Set config sync mode to \"(.*)\" with timeout (\\d+)$")
    public void setConfigSyncMode(String mode, int timeout) {
        int sec = 1000;
        HAHandler.setConfigSyncMode(radwareServerCli, mode, timeout*sec, "YES");
    }

    @When("^CLI Set config sync mode to \"(.*)\" without services with timeout (\\d+)$")
    public void setConfigSyncModeWithoutServices(String mode, int timeout) {
        int sec = 1000;
        HAHandler.setConfigSyncModeWithoutServices(radwareServerCli, mode, timeout * sec, "YES");
    }

    @When("^CLI Set config sync peer$")
    public void setConfigSyncPeer() {
        try {
            HAHandler.setConfigSyncPeer(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Set both visions disabled with timeout (\\d+)$")
    public void setBothVisionsDisabled(int timeout) {
        int sec = 1000;
        try {
            HAHandler.setBothVisionsDisabled( timeout*sec, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Switch to \"(.*)\" vision$")
    public void setTargetVision(String mode) {
        try {
            HAHandler.setTargetVision(mode, radwareServerCli, rootServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Make manual sync$")
    public void manualSync() {
        HAHandler.manualSync(radwareServerCli);
    }
}
