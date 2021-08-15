package com.radware.vision.bddtests.clioperation.menu.system.database;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.system.Database;
import cucumber.api.java.en.When;

public class DatabaseSteps extends TestBase {

    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    private final RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();

    /**
     * Test the system database submenu
     *
     * @throws Exception
     */
    @When("^CLI System Database Sub Menu Test$")
    public void databaseCheckSubMenu() {
        try {
            CliOperations.checkSubMenu(radwareServerCli, Menu.system().database().build() + " ?", Database.SYSTEM_DATABASE_SUB_MENU);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Check the system database status
     *
     * @throws Exception
     */
    @When("^CLI System Database Status$")
    public void validateSystemDataBaseStatus() {
        try {
            Database.validateDBServicesStatus(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Stop the system database and verify
     */
    @When("^CLI System Database Stop$")
    public void systemDatabaseStop() {
        try {
            Database.stopDBServer(radwareServerCli);
            if (Database.isDBServicesRunning(radwareServerCli)) {
                BaseTestUtils.report("Database services are still running...", Reporter.FAIL);
            } else {
                BaseTestUtils.report("Database services are stopped as expected", Reporter.PASS);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Start the system database and verify
     */
    @When("^CLI System Database Start$")
    public void systemDatabaseStart() {
        try {
            Database.startDBServer(radwareServerCli);
            Database.validateDBServicesStatus(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }


}
