package com.radware.vision.automation.VisionAutoInfra.CLIInfra;


import ch.ethz.ssh2.log.Logger;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.RegexUtils;


import java.util.ArrayList;
import java.util.Arrays;

public final class CliOperations {
    public static final int DEFAULT_TIME_OUT = 60 * 1000;
    public static String lastOutput;
    public static ArrayList<String> resultLines;
    public static String lastRow;


    private CliOperations() {
    }

    public static void runCommand(ServerCliBase serverCliBase, String command) {
        runCommand(serverCliBase, command, DEFAULT_TIME_OUT);
    }

    public static void runCommand(ServerCliBase serverCliBase, String command, int timeout) {
        try {
            InvokeUtils.invokeCommand(null, command, serverCliBase, timeout);
            updateLastOutput(serverCliBase);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run the command: " + command + " With the following exception: " + e.getMessage(), Reporter.FAIL);
        }
    }


    public static void runCommand(ServerCliBase serverCliBase, String command, int timeout, boolean ignoreErrors) {
        try {
            InvokeUtils.invokeCommand(null, command, serverCliBase, timeout, ignoreErrors);
            updateLastOutput(serverCliBase);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run the command: " + command + " With the following exception: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void runCommand(ServerCliBase serverCliBase, String command, int timeout, boolean ignoreErrors, boolean silent) {
        try {
            InvokeUtils.invokeCommand(null, command, serverCliBase, timeout, ignoreErrors, silent);
            updateLastOutput(serverCliBase);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run the command: " + command + " With the following exception: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void runCommand(ServerCliBase serverCliBase, String command, int timeout, boolean ignoreErrors, boolean silent, boolean waitForPrompt) {
        try {
            InvokeUtils.invokeCommand(null, command, serverCliBase, timeout, ignoreErrors, silent, waitForPrompt);
            updateLastOutput(serverCliBase);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run the command: " + command + " With the following exception: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void runCommand(ServerCliBase serverCliBase, String command, int timeout, boolean ignoreErrors, boolean silent, boolean waitForPrompt, String error) {
        try {
            InvokeUtils.invokeCommand(null, command, serverCliBase, timeout, ignoreErrors, silent, waitForPrompt, error);
            updateLastOutput(serverCliBase);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run the command: " + command + " With the following exception: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void runCommand(ServerCliBase serverCliBase, String command, int timeout, boolean ignoreErrors, boolean silent, boolean waitForPrompt, String error, boolean addEnter) {
        try {
            InvokeUtils.invokeCommand(null, command, serverCliBase, timeout, ignoreErrors, silent, waitForPrompt, error, addEnter);
            updateLastOutput(serverCliBase);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run the command: " + command + " With the following exception: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void runCommand(ServerCliBase serverCliBase, String command, int timeout, boolean ignoreErrors, boolean silent, boolean waitForPrompt, String error, boolean addEnter, boolean suppressEcho) {
        try {
            InvokeUtils.invokeCommand(null, command, serverCliBase, timeout, ignoreErrors, silent, waitForPrompt, error, addEnter, suppressEcho);
            updateLastOutput(serverCliBase);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run the command: " + command + " With the following exception: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void verifyLinesNumber(int num) {
        int linesNum = CliOperations.resultLines.size();
        if (linesNum != num) {
            BaseTestUtils.report("Actual lines number: " + linesNum + " is different from expected number: " + num, Reporter.FAIL);
        }
    }

    // validate last output with fail reporter - must give server session that connected from
    public static void verifyLastOutputByRegex(String regex, ServerCliBase cliBase) {
        updateLastOutput(cliBase);
        verifyLastOutputByRegex(regex);
    }

    // validate last output with fail reporter - with last server session that connected from
    public static void verifyLastOutputByRegex(String regex) {
        verifyLastOutputByRegexWithOutput(regex, CliOperations.lastOutput);
    }

    // validate last output without fail reporter (just exception) - with last server session that connected from
    public static void verifyLastOutputByRegexWithoutFail(String regex) throws Exception {
        verifyLastOutputByRegexWithOutputWithoutFail(regex, CliOperations.lastOutput);
    }

    // validate given output (generic) with fail reporter - with last server session that connected from
    public static void verifyLastOutputByRegexWithOutput(String regex, String output) {
        try {
            verifyLastOutputByRegexWithOutputWithoutFail(regex, output);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    // validate given output (generic) without fail reporter (just exception) - with last server session that connected from
    public static void verifyLastOutputByRegexWithOutputWithoutFail(String regex, String output) throws Exception {
        StringBuilder result = new StringBuilder();
        boolean isContained = RegexUtils.isStringContainsThePattern(regex, output);
        if (!isContained) {
            result.append("Regex: " + "\"" + regex + "\"" + " not found in the actual output").
                    append("\n").
                    append("Actual output: ").append(Arrays.asList(output));
        }
        if (!result.toString().equals("")) {
            throw new Exception(result.toString());
        } else
            BaseTestUtils.report(regex + " is contained", Reporter.PASS);
    }

    public static void verifyDeviationValidity(int output, int expected, int deviation) {
        if ((output - expected) <= (Math.abs(deviation))) {
            BaseTestUtils.report("pass", Reporter.PASS);
        } else {
            BaseTestUtils.report("fail", Reporter.FAIL);
        }
    }

    private static void updateLastOutput(ServerCliBase cliBase) {
        CliOperations.lastOutput = cliBase.getTestAgainstObject() != null ? cliBase.getTestAgainstObject().toString() : "";
        CliOperations.resultLines = cliBase.getCmdOutput();
        CliOperations.lastRow = cliBase.getLastRow();


    }

    public static void checkSubMenu(RadwareServerCli radwareCliConnection, String radwareCmd, String expectedSubMenu) throws Exception {
        checkSubMenu(radwareCliConnection, radwareCmd, expectedSubMenu, true);
    }

    public static void checkSubMenu(RadwareServerCli radwareCliConnection, String radwareCmd, String expectedSubMenu, boolean sendEnter) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("check cmd Sub Menu");
            BaseTestUtils.reporter.report(expectedSubMenu);
            String[] expectedSubMenuArray = expectedSubMenu.split("[\\r\\n]+");
            if (sendEnter) {
                runCommand(radwareCliConnection, radwareCmd);
            } else {
                runCommand(radwareCliConnection, radwareCmd, 10000, true, false, true, (String)null, sendEnter);
            }

            new ArrayList();
            ArrayList<String> cmdOutputArray = radwareCliConnection.getCmdOutput();
            if (!cmdOutputArray.containsAll(Arrays.asList(expectedSubMenuArray))) {
                BaseTestUtils.reporter.report("Found sub-commands list: " + Arrays.asList(cmdOutputArray));
                throw new Exception(" Sub menu of cmd - " + radwareCmd + " - isn't equal to the length of the following: " + expectedSubMenu);
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }

    }

}

