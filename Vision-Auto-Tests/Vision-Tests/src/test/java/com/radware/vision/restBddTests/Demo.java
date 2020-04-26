package com.radware.vision.restBddTests;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.LinuxFileServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.base.TestBase;
import com.radware.vision.bddtests.BddRestTestBase;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import cucumber.api.java.en.Then;

public class Demo extends BddRestTestBase {
    @Then("^Send request$")
    public void sendRequest() throws NoSuchFieldException {
//        CurrentVisionRestAPI genericVisionRestAPI = new CurrentVisionRestAPI("Vision/SystemConfigItemList.json", "Get Local Users");
//
//        RestResponse response = genericVisionRestAPI.sendRequest();
//        System.out.println();
//
//        VisionConfigurations visionConfigurations = new VisionConfigurations();
//        VisionConfigurations.getBuild();

    }

    @Then("^SUT Test$")
    public void sutTest() {
        SUTManager sutManager = TestBase.getSutManager();
        LinuxFileServer linuxFileServer = serversManagement.getLinuxFileServer();
        try {
            InvokeUtils.invokeCommand(null, "ls", linuxFileServer, 60 * 1000);
            updateLastOutput(linuxFileServer);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run the command:   With the following exception: " + e.getMessage(), Reporter.FAIL);
        }


    }

    private static void updateLastOutput(ServerCliBase cliBase) {
        CliOperations.lastOutput = cliBase.getTestAgainstObject() != null ? cliBase.getTestAgainstObject().toString() : "";
        CliOperations.resultLines = cliBase.getCmdOutput();
        CliOperations.lastRow = cliBase.getLastRow();


    }
}
