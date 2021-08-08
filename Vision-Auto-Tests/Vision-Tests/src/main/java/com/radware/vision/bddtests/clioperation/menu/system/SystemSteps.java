package com.radware.vision.bddtests.clioperation.menu.system;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.system.SystemGenerals;
import com.radware.vision.vision_project_cli.menu.Menu;
import cucumber.api.java.en.Then;

;

public class SystemSteps extends TestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();


    @Then("^CLI Verifying sub menu of system cmd$")
    public void system() {
        try {
            CliOperations.checkSubMenu(radwareServerCli, Menu.system().build(), SystemGenerals.SYSTEM_SUB_MENU);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }
}
