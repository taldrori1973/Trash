package com.radware.vision.bddtests.highavailability;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums.ConfigSyncMode;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.highavailability.HAHandler;
import cucumber.api.java.en.When;

public class UIHASteps extends VisionUITestBase {

    RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();

    public UIHASteps() throws Exception {
    }

    @When("^UI Switch to \"(.*)\" vision$")
    public void setTargetVisionUI(String mode) {
        try {
            ConfigSyncMode configSyncMode = ConfigSyncMode.valueOf(mode);
            String newIp = HAHandler.getDeviceIp(mode, radwareServerCli);
            HAHandler.setHost(configSyncMode, radwareServerCli, serversManagement.getRootServerCLI().get());
            restTestBase.getVisionRestClient().setDeviceIp(newIp);
            restTestBase.getVisionServer().setHost(newIp);
            webUtils.haSetUp(newIp);
            webUtils.logIn(getVisionServerIp());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
