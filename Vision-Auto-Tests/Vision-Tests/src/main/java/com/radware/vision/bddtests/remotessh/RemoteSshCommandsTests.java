package com.radware.vision.bddtests.remotessh;

import com.aqua.sysobj.conn.CliConnectionImpl;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.cli.LinuxFileServer;
import com.radware.automation.tools.cli.ServerCliBase;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.AutoUtils.Operators.Comparator;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.bddtests.basicoperations.BasicOperationsSteps;
import com.radware.vision.bddtests.clioperation.FileSteps;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.vision_handlers.NewVmHandler;
import com.radware.vision.vision_project_cli.RootServerCli;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import enums.SUTEntryType;
import testutils.RemoteProcessExecutor;

import java.util.List;

import static com.radware.vision.automation.AutoUtils.Operators.Comparator.compareResults;
import static enums.SUTEntryType.GENERIC_LINUX_SERVER;
import static enums.SUTEntryType.ROOT_SERVER_CLI;
import static java.lang.Integer.parseInt;

public class RemoteSshCommandsTests extends BddCliTestBase {

    @When("^run Remote Script \"(.*)\" at scriptPath \"(.*)\" on IP \"(.*)\" with script params \"(.*)\"$")
    public void runRemoteScript(String scriptName, String scriptPath, String remoteServerIP, String scriptParams) {
        String remoteUsername = "root";
        try {
            com.radware.vision.infra.utils.RemoteProcessExecutor remoteProcessExecutor = new com.radware.vision.infra.utils.RemoteProcessExecutor(remoteServerIP, remoteUsername);
            remoteProcessExecutor.execScript(scriptPath, scriptName.concat(" ").concat(scriptParams));
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run script: " + scriptPath + "/" + scriptName + "\n" + parseExceptionBody(e), Reporter.WARNING);
        }
    }

    @When("^CLI Run remote linux Command \"(.*)\" on \"(.*)\" and wait (\\d+) seconds$")
    public void runRemoteCommand(String commandToExecute, SUTEntryType sutEntryType, int waitTimeout) {
        try {
            RemoteProcessExecutor remoteProcessExecutor = new RemoteProcessExecutor("", "");
            remoteProcessExecutor.execCommand(commandToExecute, getSUTEntryType(sutEntryType));
            Thread.sleep(waitTimeout * 1000);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run command: " + commandToExecute, Reporter.FAIL);
        }
    }

    /*
     * if user type *pipe* it is mean the step replace it to "|"
     * */
    @When("^CLI Run remote linux Command on \"([^\"]*)\"(?: and wait (\\d+) seconds)?(?: and wait for prompt \"(True|False)\"(?: with timeOut (\\d+))?)?$")
    public void cliRunRemoteLinuxCommandOn(SUTEntryType sutEntryType, Integer sleep, String waitForPrompt, Integer withTimeout, List<String> commandParts) {
        String commandToExecute = getExecuteCommand(commandParts);
        boolean waitForPromptBoolean = waitForPrompt == null || Boolean.parseBoolean(waitForPrompt);
        CliConnectionImpl cli = getSUTEntryType(sutEntryType);
        withTimeout = withTimeout == null ? 60 * 1000 : withTimeout;
        try {
            InvokeUtils.invokeCommand(null, commandToExecute, cli, withTimeout, true, false, waitForPromptBoolean, null, true);
            if (sleep != null)
                Thread.sleep(sleep * 1000);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run command: " + commandToExecute, Reporter.FAIL);
        }
    }

    private String getExecuteCommand(List<String> commandParts) {

        StringBuilder targetCommand = new StringBuilder();
        for (String commandPart : commandParts) {
            switch (commandPart.charAt(0)) {
                case '\"': {
                    targetCommand.append(commandPart, 1, commandPart.length() - 1);
                    break;
                }
                case '#': {
                    targetCommand.append(Variables.valueOf(commandPart.substring(1)).getVariable());
                    break;
                }
            }
        }

        return targetCommand.toString();
    }

    public enum Variables {

        visionIP(restTestBase.getRadwareServerCli().getHost());
        String variable;

        Variables(String variable) {
            this.variable = variable;
        }

        public String getVariable() {
            return variable;
        }
    }

    @When("^Verify ADC Network index aggregation on device \"(.*)\"(?: with timeOut (\\d+))?$")
    public void verifyADCAggregation(String deviceIp, String timeOut) {
        String commandToExecute = "/ADC_networkIndexManipulation.sh " + deviceIp;

        try {
            timeOut = timeOut != null ? timeOut : "180";
            CliOperations.runCommand(getSUTEntryTypeByServerCliBase(SUTEntryType.ROOT_SERVER_CLI), commandToExecute, Integer.parseInt(timeOut) * 1000);
            commandToExecute = "/ADC_networkIndexVerification.sh " + deviceIp;
            CliOperations.runCommand(getSUTEntryTypeByServerCliBase(SUTEntryType.ROOT_SERVER_CLI), commandToExecute, Integer.parseInt(timeOut) * 1000);
            String actualResult = CliOperations.lastRow;
            if (!actualResult.equals("Success"))
                BaseTestUtils.report("ADC Aggregation verification failed on \"" + deviceIp + "\" with the following output \"" + actualResult + "\"", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + getSUTEntryTypeByServerCliBase(SUTEntryType.ROOT_SERVER_CLI) + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    @When("^Verify retention task of index aggregation for index \"([a-z]+[-][a-z]+[-][a-z]+)\"(?: with timeOut (\\d+))?$")
    public void verifyADCRetention(String indexName, String timeOut) {
        String[] delimiter = indexName.split("-");
        String commandToExecute = "/retentionVerification.sh " + delimiter[0] + " " + delimiter[1] + " " + delimiter[2];

        try {
            timeOut = timeOut != null ? timeOut : "120";
            CliOperations.runCommand(getSUTEntryTypeByServerCliBase(SUTEntryType.ROOT_SERVER_CLI), commandToExecute, Integer.parseInt(timeOut) * 1000);
            String actualResult = CliOperations.lastRow;
            if (!actualResult.equals("Success"))
                BaseTestUtils.report("ADC retention verification failed for index \"" + indexName + "\" with the following output \"" + actualResult + "\"", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + getSUTEntryTypeByServerCliBase(SUTEntryType.ROOT_SERVER_CLI) + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    @When("^Verify AW retention task of index aggregation for index \"([a-z]+[-][v2]+[-][a-z]+[-][a-z]+)\"(?: with timeOut (\\d+))?$")
    public void verifyAWRetention(String indexName, String timeOut) {
        String[] delimiter = indexName.split("-");
        String commandToExecute = "/retentionVerification_AppWall.sh " + delimiter[0] + " " + delimiter[1] + " " + delimiter[2] + " " + delimiter[3];
//        String commandToExecute = "/root/bla.sh " + deviceIp;

        try {
            timeOut = timeOut != null ? timeOut : "120";
            CliOperations.runCommand(getSUTEntryTypeByServerCliBase(SUTEntryType.ROOT_SERVER_CLI), commandToExecute, Integer.parseInt(timeOut) * 1000);
            String actualResult = CliOperations.lastRow;
            if (!actualResult.equals("Success"))
                BaseTestUtils.report("AW retention verification failed for index \"" + indexName + "\" with the following output \"" + actualResult + "\"", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + getSUTEntryTypeByServerCliBase(SUTEntryType.ROOT_SERVER_CLI) + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    @When("^CLI Run remote linux Command \"(.*)\" on \"(.*)\"(?: with timeOut (\\d+))?$")
    public void runCLICommand(String commandToExecute, SUTEntryType sutEntryType, Integer timeOut) {
        try {
            timeOut = timeOut != null ? (timeOut * 1000) : CliOperations.DEFAULT_TIME_OUT;
            CliOperations.runCommand(getSUTEntryTypeByServerCliBase(sutEntryType), commandToExecute, timeOut);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + sutEntryType + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @When("^CLI Run remote linux Command on Vision 2 \"(.*)\" on \"(.*)\"(?: with timeOut (\\d+))?$")
    public void runCLICommandOnVision2(String commandToExecute, SUTEntryType sutEntryType, Integer timeOut) {
        try {
            timeOut = timeOut != null ? timeOut : 30;
            String Host2 = restTestBase.getVisionServerHA().getHost_2();
            ServerCliBase rootServerCli = new RootServerCli(Host2, restTestBase.getRootServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
            rootServerCli.init();
            rootServerCli.connect();
            CliOperations.runCommand(rootServerCli, commandToExecute, timeOut * 1000);

        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + sutEntryType + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @When("^CLI Run remote linux \"(root|radware)\" Command \"(.*)\" on \"(.*)\"(?: with timeOut (\\d+))?$")
    public void runCLICommand(String serverCli, String commandToExecute, String sutEntryType, String timeOut) throws Exception {
        LinuxFileServer runServerCli = new LinuxFileServer();
        if (serverCli.equals("root")) {
            runServerCli = new LinuxFileServer(getSUTEntryTypeByServerCliBase(SUTEntryType.getConstant(sutEntryType)).getHost(), "root", "radware");
            runServerCli.init();
        } else if (serverCli.equals("radware")) {
            runServerCli = new LinuxFileServer(getSUTEntryTypeByServerCliBase(SUTEntryType.getConstant(sutEntryType)).getHost(), "radware", "radware");
            runServerCli.init();
        } else {
            BaseTestUtils.report(serverCli + " is not supported here!", Reporter.FAIL);
        }
        try {
            timeOut = timeOut != null ? timeOut : "30";
            CliOperations.runCommand(runServerCli, commandToExecute, Integer.parseInt(timeOut) * 1000);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + sutEntryType + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @When("^Validate existence of Real Alteon Apps")
    public void realAlteonsAppsValidation() {
        FileSteps scp = new FileSteps();
        scp.scp("/home/radware/fetch_num_of_real_alteons_apps.sh", GENERIC_LINUX_SERVER, ROOT_SERVER_CLI, "/root");
        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "chmod +x /root/fetch_num_of_real_alteons_apps.sh");
        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "/root/fetch_num_of_real_alteons_apps.sh");
        String numOfApps = CliOperations.lastRow;
        runCLICommandAndValidateBiggerOrEqualResult("mysql -prad123 vision_ng -e \"select count(*) from dpm_virtual_services\" | grep -v + | tail -1", ROOT_SERVER_CLI, OperatorsEnum.GTE, numOfApps, "", null, null);

    }

    @When("^CLI Run linux Command \"(.*)\" on \"(.*)\" and validate result (EQUALS|NOT_EQUALS|CONTAINS|GT|GTE|LT|LTE) \"(.*)\"( in any line)?(?: Wait For Prompt (\\d+) seconds)?(?: Retry (\\d+) seconds)?$")
    public void runCLICommandAndValidateBiggerOrEqualResult(String commandToExecute, SUTEntryType sutEntryType, OperatorsEnum operatorsEnum, String expectedResult, String inAnyLine, Integer waitForPrompt, Integer iRetryFor) {
        try {
            waitForPrompt = waitForPrompt != null ? waitForPrompt * 1000 : CliOperations.DEFAULT_TIME_OUT;
            boolean bTestSuccess;
            int iInterval = 5;
            if(iRetryFor==null)
                iRetryFor=0;
            iRetryFor = iRetryFor * 1000;

            long startTime = System.currentTimeMillis();

            do {
                getSUTEntryTypeByServerCliBase(sutEntryType).connect();
                CliOperations.runCommand(getSUTEntryTypeByServerCliBase(sutEntryType), commandToExecute, waitForPrompt);
                String actualResult = CliOperations.lastRow.trim();

                if (inAnyLine != null && !inAnyLine.isEmpty()) {
                    actualResult = CliOperations.lastOutput.trim();
                }

                bTestSuccess = compareResults(expectedResult, actualResult, operatorsEnum, null);

                if (bTestSuccess)
                    break;
                sleep(iInterval * 1000);
            } while (System.currentTimeMillis() - startTime < iRetryFor);
            if (!bTestSuccess)
                BaseTestUtils.report(Comparator.failureMessage, Reporter.FAIL);

        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + sutEntryType + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @When("^CLI Run remote \"(root|radware)\" Command \"(.*)\" on \"(.*)\" and validate result (EQUALS|CONTAINS|GT|GTE|LT|LTE) \"(.*)\"$")
    public void runCLICommandAndValidateBiggerOrEqualResultWithServerCli(String serverCli, String commandToExecute, String sutEntryType, OperatorsEnum operatorsEnum, String expectedResult) throws Exception {
        LinuxFileServer runServerCli = new LinuxFileServer();
        if (serverCli.equals("root")) {
            runServerCli = new LinuxFileServer(getSUTEntryTypeByServerCliBase(SUTEntryType.getConstant(sutEntryType)).getHost(), "root", "radware");
            runServerCli.init();
        } else if (serverCli.equals("radware")) {
            runServerCli = new LinuxFileServer(getSUTEntryTypeByServerCliBase(SUTEntryType.getConstant(sutEntryType)).getHost(), "radware", "radware");
            runServerCli.init();
        } else {
            BaseTestUtils.report(serverCli + " is not supported here!", Reporter.FAIL);
        }
        try {
            CliOperations.runCommand(runServerCli, commandToExecute);
            String actualResult = CliOperations.lastRow;
            int iactualResult;
            switch (operatorsEnum) {
                case CONTAINS:
                    if (!actualResult.contains(expectedResult))
                        BaseTestUtils.report("Actual is \"" + actualResult + "\" but its not contain string \"" + expectedResult + "\"", Reporter.FAIL);
                    break;
                case EQUALS:
                    if (!actualResult.trim().equals(expectedResult))
                        BaseTestUtils.report("Actual is \"" + actualResult + "\" but is not equal to \"" + expectedResult + "\"", Reporter.FAIL);
                    break;
                case GT:
                    iactualResult = Integer.parseInt(actualResult.trim());
                    if (!(iactualResult > Integer.parseInt(expectedResult)))
                        BaseTestUtils.report("Actual is \"" + actualResult + "\" but is not greater than \"" + expectedResult + "\"", Reporter.FAIL);
                    break;
                case GTE:
                    iactualResult = Integer.parseInt(actualResult.trim());
                    if (!(iactualResult >= Integer.parseInt(expectedResult)))
                        BaseTestUtils.report("Actual is \"" + actualResult + "\" but is not equal or greater than \"" + expectedResult + "\"", Reporter.FAIL);
                    break;
                case LT:
                    iactualResult = Integer.parseInt(actualResult.trim());
                    if (!(iactualResult < Integer.parseInt(expectedResult)))
                        BaseTestUtils.report("Actual is \"" + actualResult + "\" but is not less than \"" + expectedResult + "\"", Reporter.FAIL);
                    break;
                case LTE:
                    iactualResult = Integer.parseInt(actualResult.trim());
                    if (!(iactualResult <= Integer.parseInt(expectedResult)))
                        BaseTestUtils.report("Actual is \"" + actualResult + "\" but is not equal or less than \"" + expectedResult + "\"", Reporter.FAIL);
                    break;
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + sutEntryType + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^CLI Activate Keep Reports Copy on File System Flag with Timeout (\\d+) Seconds(?: Then Sleep (\\d+) Seconds)?$")
    public void activateKeepReportsCopyOnFileSystemFlagWithTimeoutSeconds(int timeout, Integer sleepTime) {

        //first of all check what is the value of the vrm.scheduled.reports.delete.after.delivery , if it's false so no need to set the value again
        String cmdToGetValue = "grep vrm.scheduled.reports.delete.after.delivery /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties";
        boolean currentValue = true;//if something got wrong , set the value to false and restart the collectors

        runCLICommand(cmdToGetValue, ROOT_SERVER_CLI, null);
        String commandResult = CliOperations.lastRow;

        //if the file not found
        if (commandResult.contains("No such file or directory")) BaseTestUtils.report(commandResult, Reporter.FAIL);

        //if the value not exist in the file
        if (commandResult.equals(cmdToGetValue))
            BaseTestUtils.report("vrm.scheduled.reports.delete.after.delivery not found", Reporter.FAIL);

        //validate that the value found in the file
        if (commandResult.contains("vrm.scheduled.reports.delete.after.delivery=")) {
            String[] result = commandResult.split("=");

            //validate that there is an value equals to true or false after the "=" , and if yes , update the currentValue
            if (result.length == 2 && (result[1].equalsIgnoreCase("true") || result[1].equalsIgnoreCase("false")))
                currentValue = Boolean.parseBoolean(result[1]);

            //if not so the currentValue still equals to true and the following code will run

        }

        if (currentValue) {
            runCLICommand("sed -i 's/vrm.scheduled.reports.delete.after.delivery=.*$/vrm.scheduled.reports.delete.after.delivery=false/g' /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties",
                    SUTEntryType.ROOT_SERVER_CLI, null);
            runCLICommand("/opt/radware/mgt-server/bin/collectors_service.sh restart",
                    SUTEntryType.ROOT_SERVER_CLI, timeout);

            if (sleepTime != null) {
                try {
                    new BasicOperationsSteps().sleep(sleepTime);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @Then("^CLI Clear Old Reports on File System$")
    public void cliClearOldReportsOnFileSystem() {
        SUTEntryType ROOT_SERVER_CLI = SUTEntryType.ROOT_SERVER_CLI;

        runCLICommand("rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.*", ROOT_SERVER_CLI, null);
        runCLICommand("rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv", ROOT_SERVER_CLI, null);

    }

    @Then("^CLI UnZIP Local Report ZIP File to CSV Files$")
    public void cliUnZIPLocalReportZIPFileToCSVFiles() {
        runCLICommand("cp /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip /opt/radware/storage/maintenance/", ROOT_SERVER_CLI, null);
        runCLICommand("unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip", ROOT_SERVER_CLI, null);
    }

    @When("^CLI Send Traffic Events file \"(.*)\"$")
    public void runTrafficEventFile(String filename) {
        String commandToExecute = "";
        try {
            String serverIp = restTestBase.getRootServerCli().getHost();
            commandToExecute = String.format("python3 /home/radware/TED/cef/cef_messages_dir.py -a 1 -i \"%s\" -p \"5140\" -dir \"/home/radware/TED/automation/%s\" -t", serverIp, filename);

            int timeOut = 30;
            CliOperations.runCommand(getSUTEntryTypeByServerCliBase(GENERIC_LINUX_SERVER),
                    commandToExecute, timeOut * 1000);

        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " +
                    GENERIC_LINUX_SERVER + "\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * Create a user domain in email server
     */
    @Given("^Setup email server$")
    public void emailSetup() {

        try {
            getSUTEntryTypeByServerCliBase(GENERIC_LINUX_SERVER).connect();
            String domain = getSetUpDomain();
            String file = "/etc/postfix/virtual";
            int actualResult = -1;
            String commandToExecute = String.format("grep -c \"%s\" %s", domain, file);
            CliOperations.runCommand(getSUTEntryTypeByServerCliBase(GENERIC_LINUX_SERVER), commandToExecute, 10 * 1000);
            actualResult = parseInt(CliOperations.lastRow.trim());
            if(actualResult == 0) //need to add
            {
                commandToExecute = "sudo useradd " + domain;
                CliOperations.runCommand(getSUTEntryTypeByServerCliBase(GENERIC_LINUX_SERVER), commandToExecute, 10 * 1000);
                commandToExecute = String.format("sudo touch /var/mail/%s", domain);
                CliOperations.runCommand(getSUTEntryTypeByServerCliBase(GENERIC_LINUX_SERVER), commandToExecute, 10 * 1000);
                commandToExecute = String.format("sudo chown %s /var/mail/%s", domain, domain);
                CliOperations.runCommand(getSUTEntryTypeByServerCliBase(GENERIC_LINUX_SERVER), commandToExecute, 10 * 1000);
                commandToExecute = String.format("sudo chmod 666 /var/mail/%s", domain);
                CliOperations.runCommand(getSUTEntryTypeByServerCliBase(GENERIC_LINUX_SERVER), commandToExecute, 10 * 1000);
                String line = String.format("/@%s.local/   %s", domain, domain);
                commandToExecute = String.format("sudo chmod 666 %s", file);
                CliOperations.runCommand(getSUTEntryTypeByServerCliBase(GENERIC_LINUX_SERVER), commandToExecute, 10 * 1000);
                commandToExecute = String.format("sudo grep -qF -- \"%s\" \"%s\" || echo \"%s\" >> \"%s\"", line, file, line, file);
                CliOperations.runCommand(getSUTEntryTypeByServerCliBase(GENERIC_LINUX_SERVER), commandToExecute, 10 * 1000);
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * @param user - either "setup" that will use the setup IP address or any other domain
     */
    @Given("^Clear email history for user \"(setup|.*)\"$")
    public void clearUserInbox(String user) {
        if (user.equalsIgnoreCase("setup"))
            user = getSetUpDomain();

        try {
            getSUTEntryTypeByServerCliBase(GENERIC_LINUX_SERVER).connect();
            String commandToExecute = String.format("echo \"cleared\" $(date) > /var/spool/mail/%s", user);
            CliOperations.runCommand(getSUTEntryTypeByServerCliBase(GENERIC_LINUX_SERVER), commandToExecute, 10 * 1000);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * @return setup' IP address for email domain
     */
    private String getSetUpDomain() {
        return getSUTEntryTypeByServerCliBase(ROOT_SERVER_CLI).getHost();
    }

    /**
     * @param domain         - "setup" or any other domain
     * @param expression     - the query without the file path
     * @param operatorsEnum  - OperatorsEnum ENUM
     * @param expectedResult - cli last line output
     */
    @Given("^Validate \"(setup|.*)\" user eMail expression \"(.*)\" (EQUALS|NOT_EQUALS|CONTAINS|GT|GTE|LT|LTE) \"(.*)\"$")
    public void validateEmail(String domain, String expression, OperatorsEnum operatorsEnum, String expectedResult) {
        if (domain.equalsIgnoreCase("setup"))
            domain = getSetUpDomain();
        String commandToExecute = String.format("%s /var/spool/mail/%s |wc -l", expression, domain);
        try {
            runCLICommandAndValidateBiggerOrEqualResult(commandToExecute, GENERIC_LINUX_SERVER,
                    operatorsEnum, expectedResult, null, null, 200);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI Reset radware password$")
    public static void resetPassword() {
        if (restTestBase.getRootServerCli() != null && restTestBase.getRootServerCli().isConnected()) {
            FileSteps f = new FileSteps();
            f.scp("/home/radware/Scripts/restore_radware_user_stand_alone.sh", SUTEntryType.GENERIC_LINUX_SERVER, SUTEntryType.ROOT_SERVER_CLI, "/");
            CliOperations.runCommand(restTestBase.getRootServerCli(), "yes | /restore_radware_user_stand_alone.sh", CliOperations.DEFAULT_TIME_OUT);
        }
    }
    @Given("^CLI Wait for Vision Re-Connection(?: (\\d+) seconds)?$")
    public static void waitForVisionReConnection(Integer timeOut) {
        try {
            timeOut = timeOut == null? 300 : timeOut;
            NewVmHandler.waitForServerConnection(timeOut * 1000, restTestBase.getRootServerCli());
        } catch (InterruptedException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

}
