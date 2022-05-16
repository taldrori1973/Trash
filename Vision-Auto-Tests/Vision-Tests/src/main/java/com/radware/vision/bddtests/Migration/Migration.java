package com.radware.vision.bddtests.Migration;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.*;
import com.radware.vision.automation.base.TestBase;
import cucumber.api.java.en.Given;

import java.util.Optional;

public class Migration extends TestBase {

    @Given("^CLI Operations - Run Root Session export command \"(.*)\"$")
    public void runRootExportCommand(String command) {

        try {

            String host = getSutManager().getpair().getPairIp();
            String user = getSutManager().getCliConfigurations().getRootServerCliUserName();
            String password = getSutManager().getCliConfigurations().getRootServerCliPassword();
            String remoteHost = getSutManager().getClientConfigurations().getHostIp();

            RootServerCli rootServerCli = new RootServerCli(host, user, password);
            rootServerCli.setRemoteHost(remoteHost);
            rootServerCli.connect();

            Optional<RootServerCli> rootServerCliOpt = serversManagement.getRootServerCLI();
            if (!rootServerCliOpt.isPresent()) {
                throw new Exception("Root Server Not found!");
            }
            CliOperations.runCommand(rootServerCli, command, 200000, true);

        } catch (Exception e) {
            BaseTestUtils.report(String.format("Error: %s", e.getMessage()), Reporter.FAIL);
        }
    }

    @Given("^CLI Operations - Run Root Session initial import command \"([^\"]*)\"$")
    public void runRootSessionInitialImportCommand(String command) {
        executeImportCommand(command, "yes", "no");
    }

    @Given("^CLI Operations - Run Root Session import command \"([^\"]*)\"$")
    public void runRootSessionImportCommand(String command) {
        executeImportCommand(command, "no", "yes");
    }

    public void executeImportCommand(String command, String setUpImport, String continueImport) {
        try {
            String host = getSutManager().getClientConfigurations().getHostIp();
            String user = getSutManager().getCliConfigurations().getRootServerCliUserName();
            String password = getSutManager().getCliConfigurations().getRootServerCliPassword();
            String pairIP = getSutManager().getpair().getPairIp();

            RootServerCli rootServerCli = new RootServerCli(host, user, password);
            rootServerCli.setPairIP(pairIP);
            rootServerCli.setSetUpImport(setUpImport);
            rootServerCli.setContinueImport(continueImport);
            rootServerCli.connect();

            Optional<RootServerCli> rootServerCliOpt = serversManagement.getRootServerCLI();
            if (!rootServerCliOpt.isPresent()) {
                throw new Exception("Root Server Not found!");
            }

            CliOperations.runCommand(rootServerCli, command, 1500000);
        } catch (Exception e) {
            BaseTestUtils.report(String.format("Error: %s", e.getMessage()), Reporter.FAIL);
        }
    }
}
