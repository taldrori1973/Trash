package com.radware.vision.bddtests.highavailability;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.enums.ConfigSyncMode;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.infra.testhandlers.cli.highavailability.HAHandler;
import cucumber.api.java.en.When;

public class UIHASteps extends BddUITestBase{
    public UIHASteps() throws Exception {
    }

    @When("^UI Switch to \"(.*)\" vision$")
    public void setTargetVisionUI(String mode) {
        try {
            ConfigSyncMode configSyncMode = ConfigSyncMode.valueOf(mode);
            String newIp = HAHandler.getDeviceIp(restTestBase.getHaManager(), mode);
            restTestBase.getHaManager().setHost(configSyncMode);
            restTestBase.getVisionRestClient().setDeviceIp(newIp);
            restTestBase.getVisionServer().setHost(newIp);
            webUtils.haSetUp(newIp);
            webUtils.logIn(getVisionServerIp());
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
