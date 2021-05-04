package com.radware.vision.bddtests.remotessh;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.Operators.Comparator;
import com.radware.vision.automation.AutoUtils.Operators.OperatorsEnum;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.basicoperations.BasicOperationsSteps;
import com.radware.vision.bddtests.clioperation.FileSteps;
import com.radware.vision.automation.systemManagement.serversManagement.ServersManagement;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import enums.SUTEntryType;
import testutils.RemoteProcessExecutor;

import java.util.List;

import static com.radware.vision.automation.AutoUtils.Operators.Comparator.compareResults;
import static com.radware.vision.vision_handlers.NewVmHandler.waitForServerConnection;
import static java.lang.Integer.parseInt;

public class RemoteSshCommandsTests extends TestBase {

    @When("^run Remote Script \"(.*)\" at scriptPath \"(.*)\" on IP \"(.*)\" with script params \"(.*)\"$")
    public void runRemoteScript(String scriptName, String scriptPath, String remoteServerIP, String scriptParams) {
        String remoteUsername = "root";
        try {
            com.radware.vision.infra.utils.RemoteProcessExecutor remoteProcessExecutor = new com.radware.vision.infra.utils.RemoteProcessExecutor(remoteServerIP, remoteUsername);
            remoteProcessExecutor.execScript(scriptPath, scriptName.concat(" ").concat(scriptParams));
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run script: " + scriptPath + "/" + scriptName + "\n" + e.getMessage(), Reporter.WARNING);
        }
    }

    @When("^CLI Run remote linux Command \"(.*)\" on \"(.*)\" and halt (\\d+) seconds$")
    public void runRemoteCommand(String commandToExecute, ServersManagement.ServerIds sutEntryType, int waitTimeout) {
        try {
            RemoteProcessExecutor remoteProcessExecutor = new RemoteProcessExecutor("", "");
            remoteProcessExecutor.execCommand(commandToExecute, serversManagement.getServerById(sutEntryType));
            Thread.sleep(waitTimeout * 1000L);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to run command: " + commandToExecute, Reporter.FAIL);
        }
    }

    /*
     * if user type *pipe* it is mean the step replace it to "|"
     * */
    @When("^CLI Run remote linux Command on \"([^\"]*)\"(?: and wait (\\d+) seconds)?(?: and wait for prompt \"(True|False)\"(?: with timeOut (\\d+))?)?$")
    public void cliRunRemoteLinuxCommandOn(ServersManagement.ServerIds sutEntryType, Integer sleep, String waitForPrompt, Integer withTimeout, List<String> commandParts) {
        String commandToExecute = getExecuteCommand(commandParts);
        boolean waitForPromptBoolean = waitForPrompt == null || Boolean.parseBoolean(waitForPrompt);
        ServerCliBase server = TestBase.serversManagement.getServerById(sutEntryType);
        withTimeout = withTimeout == null ? 60 * 1000 : withTimeout;
        try {
            CliOperations.runCommand(server, commandToExecute, withTimeout, true, false, waitForPromptBoolean, null, true);
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
        visionIP(clientConfigurations.getHostIp());
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
            CliOperations.runCommand(serversManagement.getRootServerCLI().get(), commandToExecute, Integer.parseInt(timeOut) * 1000);
            commandToExecute = "/ADC_networkIndexVerification.sh " + deviceIp;

            CliOperations.runCommand(serversManagement.getRootServerCLI().get(), commandToExecute, Integer.parseInt(timeOut) * 1000);
            String actualResult = CliOperations.lastRow;
            if (!actualResult.equals("Success"))
                BaseTestUtils.report("ADC Aggregation verification failed on \"" + deviceIp + "\" with the following output \"" + actualResult + "\"", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + ServersManagement.ServerIds.ROOT_SERVER_CLI + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }


    @When("^Verify retention task of index aggregation for index \"([a-z]+[-][a-z]+[-][a-z]+)\"(?: with timeOut (\\d+))?$")
    public void verifyADCRetention(String indexName, String timeOut) {
        String[] delimiter = indexName.split("-");
        String commandToExecute = "/retentionVerification.sh " + delimiter[0] + " " + delimiter[1] + " " + delimiter[2];

        try {
            timeOut = timeOut != null ? timeOut : "120";
            CliOperations.runCommand(serversManagement.getRootServerCLI().get(), commandToExecute, Integer.parseInt(timeOut) * 1000);
            String actualResult = CliOperations.lastRow;
            if (!actualResult.equals("Success"))
                BaseTestUtils.report("ADC retention verification failed for index \"" + indexName + "\" with the following output \"" + actualResult + "\"", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + ServersManagement.ServerIds.ROOT_SERVER_CLI + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }


    @When("^Verify AW retention task of index aggregation for index \"([a-z]+[-][v2]+[-][a-z]+[-][a-z]+)\"(?: with timeOut (\\d+))?$")
    public void verifyAWRetention(String indexName, String timeOut) {
        String[] delimiter = indexName.split("-");
        String commandToExecute = "/retentionVerification_AppWall.sh " + delimiter[0] + " " + delimiter[1] + " " + delimiter[2] + " " + delimiter[3];
//        String commandToExecute = "/root/bla.sh " + deviceIp;

        try {
            timeOut = timeOut != null ? timeOut : "120";
            CliOperations.runCommand(serversManagement.getRootServerCLI().get(), commandToExecute, Integer.parseInt(timeOut) * 1000);
            String actualResult = CliOperations.lastRow;
            if (!actualResult.equals("Success"))
                BaseTestUtils.report("AW retention verification failed for index \"" + indexName + "\" with the following output \"" + actualResult + "\"", Reporter.FAIL);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + ServersManagement.ServerIds.ROOT_SERVER_CLI + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }


    @When("^CLI Run remote linux Command \"(.*)\" on \"(.*)\"(?: with timeOut (\\d+))?$")
    public void runCLICommand(String commandToExecute, ServersManagement.ServerIds serverId, Integer timeOut) {
        try {
            timeOut = timeOut != null ? timeOut : CliOperations.DEFAULT_TIME_OUT;
            CliOperations.runCommand(TestBase.serversManagement.getServerById(serverId), commandToExecute, timeOut * 1000);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + serverId + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Run remote linux Command on Vision 2 \"(.*)\" on \"(.*)\"(?: with timeOut (\\d+))?$")
    public void runCLICommandOnVision2(String commandToExecute, SUTEntryType sutEntryType, Integer timeOut) {
        try {
            timeOut = timeOut != null ? timeOut : 30;
//            kVision
//            String Host2 = restTestBase.getVisionServerHA().getHost_2();
//            ServerCliBase rootServerCli = new RootServerCli(Host2, restTestBase.getRootServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
//            rootServerCli.init();
//            rootServerCli.connect();
//          kvision
//            CliOperations.runCommand(rootServerCli, commandToExecute, timeOut * 1000);

        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + sutEntryType + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Run remote linux \"(root|radware)\" Command \"(.*)\" on \"(.*)\"(?: with timeOut (\\d+))?$")
    public void runCLICommand(String serverCli, String commandToExecute, String sutEntryType, String timeOut) throws Exception {
        ServerCliBase server = null;
        if (serverCli.equals("root")) {
            serversManagement.getRootServerCLI().get();
        } else if (serverCli.equals("radware")) {
            serversManagement.getRadwareServerCli().get();
        } else {
            BaseTestUtils.report(serverCli + " is not supported here!", Reporter.FAIL);
        }
        try {
            timeOut = timeOut != null ? timeOut : "30";
            CliOperations.runCommand(server, commandToExecute, Integer.parseInt(timeOut) * 1000);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + sutEntryType + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^Validate existence of Real Alteon Apps")
    public void realAlteonsAppsValidation() {
        FileSteps scp = new FileSteps();
        RootServerCli rootServerCli = serversManagement.getRootServerCLI().get();

        scp.scp("/home/radware/fetch_num_of_real_alteons_apps.sh", ServersManagement.ServerIds.LINUX_FILE_SERVER, ServersManagement.ServerIds.ROOT_SERVER_CLI, "/root");

        CliOperations.runCommand(serversManagement.getRootServerCLI().get(), "chmod +x /root/fetch_num_of_real_alteons_apps.sh");
        CliOperations.runCommand(serversManagement.getRootServerCLI().get(), "/root/fetch_num_of_real_alteons_apps.sh");
        String numOfApps = CliOperations.lastRow;
        runCLICommandAndValidateBiggerOrEqualResult("mysql -prad123 vision_ng -e \"select count(*) from dpm_virtual_services\" | grep -v + | tail -1", ServersManagement.ServerIds.ROOT_SERVER_CLI, OperatorsEnum.GTE, numOfApps, "", null, null);

    }

    @When("^CLI Run linux Command \"(.*)\" on \"(.*)\" and validate result (EQUALS|NOT_EQUALS|CONTAINS|GT|GTE|LT|LTE) \"(.*)\"( in any line)?(?: Wait For Prompt (\\d+) seconds)?(?: Retry (\\d+) seconds)?$")
    public void runCLICommandAndValidateBiggerOrEqualResult(String commandToExecute, ServersManagement.ServerIds serverId, OperatorsEnum operatorsEnum, String expectedResult, String inAnyLine, Integer waitForPrompt, Integer iRetryFor) {
        try {
            waitForPrompt = waitForPrompt != null ? waitForPrompt * 1000 : CliOperations.DEFAULT_TIME_OUT;
            boolean bTestSuccess;
            int iInterval = 5; //in seconds
            if(iRetryFor==null)
                iRetryFor=0;
            iRetryFor = iRetryFor * 1000;

            long startTime = System.currentTimeMillis();

            do {
                CliOperations.runCommand(TestBase.serversManagement.getServerById(serverId), commandToExecute, waitForPrompt);
                String actualResult = CliOperations.lastRow.trim();

                if (inAnyLine != null && !inAnyLine.isEmpty()) {
                    actualResult = CliOperations.lastOutput.trim();
                }

                bTestSuccess = compareResults(expectedResult, actualResult, operatorsEnum, null);

                if (bTestSuccess)
                    break;
                else
                    Thread.sleep(iInterval * 1000);
            } while (System.currentTimeMillis() - startTime < iRetryFor);
            if (!bTestSuccess)
                BaseTestUtils.report(Comparator.failureMessage, Reporter.FAIL);

        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + serverId + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^CLI Run remote \"(root|radware)\" Command \"(.*)\" on \"(.*)\" and validate result (EQUALS|CONTAINS|GT|GTE|LT|LTE) \"(.*)\"$")
    public void runCLICommandAndValidateBiggerOrEqualResultWithServerCli(String serverCli, String commandToExecute, String sutEntryType, OperatorsEnum operatorsEnum, String expectedResult) throws Exception {
        ServerCliBase server = null;
        if (serverCli.equals("root")) {
            server = serversManagement.getRootServerCLI().get();
        } else if (serverCli.equals("radware")) {
            server = serversManagement.getRadwareServerCli().get();
        } else {
            BaseTestUtils.report(serverCli + " is not supported here!", Reporter.FAIL);
        }
        try {
            CliOperations.runCommand(server, commandToExecute);
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
                    iactualResult = parseInt(actualResult.trim());
                    if (!(iactualResult > parseInt(expectedResult)))
                        BaseTestUtils.report("Actual is \"" + actualResult + "\" but is not greater than \"" + expectedResult + "\"", Reporter.FAIL);
                    break;
                case GTE:
                    iactualResult = parseInt(actualResult.trim());
                    if (!(iactualResult >= parseInt(expectedResult)))
                        BaseTestUtils.report("Actual is \"" + actualResult + "\" but is not equal or greater than \"" + expectedResult + "\"", Reporter.FAIL);
                    break;
                case LT:
                    iactualResult = parseInt(actualResult.trim());
                    if (!(iactualResult < parseInt(expectedResult)))
                        BaseTestUtils.report("Actual is \"" + actualResult + "\" but is not less than \"" + expectedResult + "\"", Reporter.FAIL);
                    break;
                case LTE:
                    iactualResult = parseInt(actualResult.trim());
                    if (!(iactualResult <= parseInt(expectedResult)))
                        BaseTestUtils.report("Actual is \"" + actualResult + "\" but is not equal or less than \"" + expectedResult + "\"", Reporter.FAIL);
                    break;
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " + sutEntryType + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }

    @Then("^CLI Activate Keep Reports Copy on File System Flag with Timeout (\\d+) Seconds(?: Then Sleep (\\d+) Seconds)?$")
    public void activateKeepReportsCopyOnFileSystemFlagWithTimeoutSeconds(int timeout, Integer sleepTime) {

        //first of all check what is the value of the vrm.scheduled.reports.delete.after.delivery , if it's false so no need to set the value again
        String cmdToGetValue = "grep vrm.scheduled.reports.delete.after.delivery /opt/radware/mgt-server/third-party/tomcat/conf/reporter.properties";
        boolean currentValue = true;//if something got wrong , set the value to false and restart the collectors

        runCLICommand(cmdToGetValue, ServersManagement.ServerIds.ROOT_SERVER_CLI, null);
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
                    ServersManagement.ServerIds.ROOT_SERVER_CLI, null);
            runCLICommand("/opt/radware/mgt-server/bin/collectors_service.sh restart",
                    ServersManagement.ServerIds.ROOT_SERVER_CLI, timeout);

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

        runCLICommand("rm -f /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.*",
                ServersManagement.ServerIds.ROOT_SERVER_CLI, null);
        runCLICommand("rm -f /opt/radware/mgt-server/third-party/tomcat/bin/*.csv",
                ServersManagement.ServerIds.ROOT_SERVER_CLI, null);

    }

    @Then("^CLI UnZIP Local Report ZIP File to CSV Files$")
    public void cliUnZIPLocalReportZIPFileToCSVFiles() {
        runCLICommand("cp /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip /opt/radware/storage/maintenance/",
                ServersManagement.ServerIds.ROOT_SERVER_CLI, null);
        runCLICommand("unzip -o -d /opt/radware/mgt-server/third-party/tomcat/bin/ /opt/radware/mgt-server/third-party/tomcat/bin/VRM_report_*.zip",
                ServersManagement.ServerIds.ROOT_SERVER_CLI, null);
    }

    @When("^CLI Send Traffic Events file \"(.*)\"$")
    public void runTrafficEventFile(String filename) {
        String commandToExecute = "";
        try {
            String serverIp = clientConfigurations.getHostIp();
            commandToExecute = String.format("python3 /home/radware/TED/cef/cef_messages_dir.py -a 1 -i \"%s\" -p \"5140\" -dir \"/home/radware/TED/automation/%s\" -t", serverIp, filename);

            int timeOut = 30;
            CliOperations.runCommand(serversManagement.getLinuxFileServer().get(),
                    commandToExecute, timeOut * 1000);

        } catch (Exception e) {
            BaseTestUtils.report("Failed to execute command: " + commandToExecute + ", on " +
                    ServersManagement.ServerIds.LINUX_FILE_SERVER + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Create a user domain in email server
     */
    @Given("^Setup email server$")
    public void emailSetup() {

        try {
            ServerCliBase serverCliBase = TestBase.getServersManagement().getLinuxFileServer().get();
            serverCliBase.connect();
            String domain = getSetUpDomain();
            String file = "/etc/postfix/virtual";
            int actualResult;
            String commandToExecute = String.format("grep -c \"%s\" %s", domain, file);
            CliOperations.runCommand(serverCliBase, commandToExecute, 10 * 1000);
            actualResult = parseInt(CliOperations.lastRow.trim());
            if(actualResult == 0) //need to add
            {
                commandToExecute = "sudo useradd " + domain;
                CliOperations.runCommand(serverCliBase, commandToExecute, 10 * 1000);
                commandToExecute = String.format("sudo touch /var/mail/%s", domain);
                CliOperations.runCommand(serverCliBase, commandToExecute, 10 * 1000);
                commandToExecute = String.format("sudo chown %s /var/mail/%s", domain, domain);
                CliOperations.runCommand(serverCliBase, commandToExecute, 10 * 1000);
                commandToExecute = String.format("sudo chmod 666 /var/mail/%s", domain);
                CliOperations.runCommand(serverCliBase, commandToExecute, 10 * 1000);
                String line = String.format("/@%s.local/   %s", domain, domain);
                commandToExecute = String.format("sudo chmod 666 %s", file);
                CliOperations.runCommand(serverCliBase, commandToExecute, 10 * 1000);
                commandToExecute = String.format("sudo grep -qF -- \"%s\" \"%s\" || echo \"%s\" >> \"%s\"", line, file, line, file);
                CliOperations.runCommand(serverCliBase, commandToExecute, 10 * 1000);
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
            ServerCliBase serverCliBase = TestBase.getServersManagement().getLinuxFileServer().get();
            serverCliBase.connect();
            String commandToExecute = String.format("echo \"cleared\" $(date) > /var/spool/mail/%s", user);
            CliOperations.runCommand(serverCliBase, commandToExecute, 10 * 1000);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * @return setup' IP address for email domain
     */
    private String getSetUpDomain() {
        return TestBase.getSutManager().getClientConfigurations().getHostIp();
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
            runCLICommandAndValidateBiggerOrEqualResult(commandToExecute, ServersManagement.ServerIds.LINUX_FILE_SERVER,
                    operatorsEnum, expectedResult, null, null, 200);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^CLI Reset radware password$")
    public static void resetPassword() {
        if (serversManagement.getRootServerCLI().get().isConnected()) {
            FileSteps f = new FileSteps();
            f.scp("/home/radware/Scripts/restore_radware_user_stand_alone.sh",
                    ServersManagement.ServerIds.LINUX_FILE_SERVER, ServersManagement.ServerIds.ROOT_SERVER_CLI, "/");
            CliOperations.runCommand(serversManagement.getRootServerCLI().get(),
                    "yes | /restore_radware_user_stand_alone.sh", CliOperations.DEFAULT_TIME_OUT);
        }
    }
    @Given("^CLI Wait for Vision Re-Connection(?: (\\d+) seconds)?$")
    public static void waitForVisionReConnection(Integer timeOut) {
        try {
            timeOut = timeOut == null? 300 : timeOut;
            waitForServerConnection(timeOut * 1000, serversManagement.getRootServerCLI().get());
        } catch (InterruptedException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

}
