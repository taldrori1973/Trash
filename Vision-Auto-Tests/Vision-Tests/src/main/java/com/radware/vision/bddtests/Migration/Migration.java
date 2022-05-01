package com.radware.vision.bddtests.Migration;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.*;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.automation.systemManagement.serversManagement.ServersManagement;
import cucumber.api.java.en.Given;
import java.util.Optional;

public class Migration extends TestBase {

    @Given("^CLI Operations - Run Root Session export command \"(.*)\"$")
    public void runRootExportCommand(String command) {

        try {
            Optional<RootServerCli> rootServerCliOpt = serversManagement.getRootServerCLI();

            String ip = getSutManager().getpair().getPairIp();
            String userName = getSutManager().getCliConfigurations().getRootServerCliUserName();
            String password = getSutManager().getCliConfigurations().getRootServerCliPassword();
            String remoteHost = getSutManager().getClientConfigurations().getHostIp();

            CVisionExportScriptPrompts cVisionExportScriptPrompts = new CVisionExportScriptPrompts(ip, userName, password, remoteHost);
            cVisionExportScriptPrompts.setHost(ip);
            cVisionExportScriptPrompts.setUser(userName);
            cVisionExportScriptPrompts.setPassword(password);

            cVisionExportScriptPrompts.connect();
            if (!rootServerCliOpt.isPresent()) {
                throw new Exception("Root Server Not found!");
            }
            CliOperations.runCommand(cVisionExportScriptPrompts, command, 190000);
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
            Optional<RootServerCli> rootServerCliOpt = serversManagement.getRootServerCLI();
            String pairIP = getSutManager().getpair().getPairIp();
            String userName = getSutManager().getCliConfigurations().getRootServerCliUserName();
            String password = getSutManager().getCliConfigurations().getRootServerCliPassword();
            String ip = getSutManager().getClientConfigurations().getHostIp();
            UVisionImportScriptPrompt uVisionImportScriptPrompt = new UVisionImportScriptPrompt(ip, userName, password, pairIP, setUpImport, continueImport);
            uVisionImportScriptPrompt.setHost(ip);
            uVisionImportScriptPrompt.setUser(userName);
            uVisionImportScriptPrompt.setPassword(password);

            uVisionImportScriptPrompt.connect();
            if (!rootServerCliOpt.isPresent()) {
                throw new Exception("Root Server Not found!");
            }
            CliOperations.runCommand(uVisionImportScriptPrompt, command, 1500000);
        } catch (Exception e) {
            BaseTestUtils.report(String.format("Error: %s", e.getMessage()), Reporter.FAIL);
        }
    }

    @Given("^CLI Run command \"([^\"]*)\" on Simulator to insert indices starting with id (\\d+) in Secondary Server$")
    public void cliRunCommandOnSimulatorToInsertIndicesInSecondaryServer(String command, int indexID) {

        try {
            String pairIp = getSutManager().getpair().getPairIp();
            command = command + " " + indexID + " " + pairIp;

            CliOperations.runCommand(serversManagement.getLinuxFileServer().orElse(null),
                    "cd /home/radware/scripts/cvisionPopulate");

            CliOperations.runCommand(serversManagement.getLinuxFileServer().orElse(null),
                    command);

        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + command + ", on " +
                    ServersManagement.ServerIds.GENERIC_LINUX_SERVER + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }
}
