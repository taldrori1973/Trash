package com.radware.vision.bddtests.clioperation;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.cli.ServerCliBase;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.base.TestBase;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.utils.SutUtils;
//import com.radware.vision.vision_project_cli.RadwareServerCli;
//import com.radware.vision.vision_project_cli.RootServerCli;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;


public class ConsoleOperation extends BddCliTestBase {

    /* this for commands contain ? in the last command (help output) */
    @Then("^CLI Operations - Run Radware Session help command \"([^\"]*)\"$")
    public void runRadwareHelpCommand(String command) {
//kVision
//        if (command.contains("?")) {
//            CliOperations.runCommand(getRestTestBase().getRadwareServerCli(), command, CliOperations.DEFAULT_TIME_OUT, false, false, false, null, false);
//            CliOperations.runCommand(getRestTestBase().getRadwareServerCli(), "nothing", CliOperations.DEFAULT_TIME_OUT);
//        } else
//            runRadwareCommand(command);
    }

    @When("^CLI Operations - Run Radware Session command \"([^\"]*)\" on vision 2, timeout (\\d+)$")
    public void runRadwareCommandOnVision2(String command, Integer timeOut) {
        try {


            timeOut = timeOut != null ? timeOut : 30;
            //           kVision
//            String Host2 = restTestBase.getVisionServerHA().getHost_2();
//            ServerCliBase radwareServerCli = new RadwareServerCli(Host2, SutUtils.getCurrentVisionRestUserName(), SutUtils.getCurrentVisionRestUserPassword());
//            radwareServerCli.init();
//            radwareServerCli.connect();
//           kVision
//            CliOperations.runCommand(radwareServerCli, command, timeOut * 1000);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + command + ", on vision 2 " + "\n" + parseExceptionBody(e), Reporter.FAIL);

        }
    }

    @When("^CLI Operations - Run Radware Session command \"([^\"]*)\" timeout (\\d+)$")
    public void runRadwareCommand(String command, int timeout) {
        int sec = 1000;
//       kVision
//        CliOperations.runCommand(getRestTestBase().getRadwareServerCli(), command, timeout * sec);
    }

    @Then("^CLI Operations - Run Radware Session command \"([^\"]*)\"$")
    public void runRadwareCommand(String command) {
        try {
            Optional<RadwareServerCli> radwareServerCliOpt = TestBase.serversManagement.getRadwareServerCli();
            if (!radwareServerCliOpt.isPresent()) {
                throw new Exception("Radware Server Not found!");
            }
            CliOperations.runCommand(radwareServerCliOpt.get(), command);
        } catch (Exception e) {
            BaseTestUtils.report(String.format("Error: %s", e.getMessage()), Reporter.FAIL);
        }
    }

    @When("^CLI Operations - Run Root Session command \"(.*)\"$")
    public void runRootCommand(String command) {
        try {
            Optional<RootServerCli> rootServerCliOpt = TestBase.serversManagement.getRootServerCLI();
            if (!rootServerCliOpt.isPresent()) {
                throw new Exception("Root Server Not found!");
            }
            CliOperations.runCommand(rootServerCliOpt.get(), command);
        } catch (Exception e) {
            BaseTestUtils.report(String.format("Error: %s", e.getMessage()), Reporter.FAIL);
        }
    }

    @When("^CLI Operations - Run Root Session command \"(.*)\" timeout (\\d+)$")
    public void runRootCommand(String command, int timeout) {
        int sec = 1000;
//       kVision
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), command, timeout * sec);
    }

    @Then("^CLI Operations - Verify last output contains$")
    public void verifyLastOutput(List<String> output) {
        List<String> lastOutputItems = CliOperations.resultLines;
        StringBuilder result = new StringBuilder();
        for (String out : output) {
            for (int i = 0; i < lastOutputItems.size(); i++) {
                if (!lastOutputItems.get(i).contains(out)) {
                    result.append("Actual values not contains: ").append(Arrays.asList(out)).append("\n");
                    break;
                }
            }
        }
        if (!result.toString().equals("")) {
            BaseTestUtils.report(result.toString(), Reporter.FAIL);
        }
    }


    @Then("^CLI Operations - Verify interval of (\\d+) seconds in log \"(.*)\" for print \"(.*)\" with valid deviation of (\\d+)$")
    public void verifyLogPrintIntervalWithDeviation(int expectedInterval, String logFile, String relevantPrint, int validDeviation) {
        String strCommand = "echo $(date +%s -d $(grep \"" + relevantPrint + "\" " + logFile + " | tail -1 | awk '{print substr($2,0,8)}')) - " + " $(date +%s -d $(grep \"" + relevantPrint + "\" " + logFile + " | tail -2 | head -1 | awk '{print substr($2,0,8)}')) | bc";
        runRootCommand(strCommand);
        Integer intActualInterval = Integer.valueOf(CliOperations.resultLines.get(CliOperations.resultLines.size() - 1));
        CliOperations.verifyDeviationValidity(intActualInterval, expectedInterval, validDeviation);
    }

    @Then("^CLI Operations - Verify last output not contains$")
    public void verifyLastOutputNotContain(List<String> output) {
        List<String> lastOutputItems = CliOperations.resultLines;
        StringBuilder result = new StringBuilder();
        for (String out : output) {
            if (lastOutputItems.contains(out)) {
                result.append("Actual values contains: ").append(Arrays.asList(out)).append("\n");
            }
        }
        if (!result.toString().equals("")) {
            BaseTestUtils.report(result.toString(), Reporter.FAIL);
        }
    }

    @Then("^CLI Connect Root$")
    public void connectRootCLI() {
        try {
            //       kVision
//            RootServerCli rootServerCli = restTestBase.getRootServerCli();
//            rootServerCli.disconnect();
//            rootServerCli.connect();
        } catch (Exception e) {
            BaseTestUtils.report("failed to connect Root CLI: " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^CLI Connect Radware$")
    public void connectRadwareCLI() {
        try {
            //       kVision
//            RadwareServerCli radwareServerCli = restTestBase.getRadwareServerCli();
//            radwareServerCli.disconnect();
//            radwareServerCli.connect();
        } catch (Exception e) {
            BaseTestUtils.report("failed to connect Radware CLI: " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^CLI Operations - Verify that output contains regex \"(.*)\"( negative)?$")
    public void verifyLastOutputByRegex(String regex, String negative) {
        CliOperations.verifyLastOutputByRegex(regex);
    }

    @Then("^CLI Operations - Using \"(radware|root)\" User to Verify that output contains regex \"(.*)\"( negative)?$")
    public void verifyLastOutputByRegex(String user, String regex, String negative) {
//       kVision
//        if (user.equalsIgnoreCase("radware")) {
//            CliOperations.verifyLastOutputByRegex(regex, restTestBase.getRadwareServerCli());
//        } else if (user.equalsIgnoreCase("root")) {
//            CliOperations.verifyLastOutputByRegex(regex, restTestBase.getRootServerCli());
//        } else {
//            BaseTestUtils.report(user + " is not supported here!", Reporter.FAIL);
//        }
    }


    @Then("^CLI Operations - Verify that the output Lines number as expected (\\d+)$")
    public void verifyLinesNumber(int num) {
        CliOperations.verifyLinesNumber(num);
    }
}
