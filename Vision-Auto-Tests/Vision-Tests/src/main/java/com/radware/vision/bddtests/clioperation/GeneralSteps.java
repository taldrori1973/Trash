package com.radware.vision.bddtests.clioperation;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.utils.ExecuteShellCommands;
import com.radware.automation.tools.utils.LinuxServerCredential;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.automation.systemManagement.serversManagement.ServersManagement;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.ReportsForensicsAlerts.WebUiTools;
import com.radware.vision.bddtests.device.drivers.DeviceDrivers;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import joptsimple.internal.Strings;
import jsystem.framework.report.Reporter;

import java.util.List;
import java.util.stream.Collectors;

import static com.radware.vision.bddtests.device.drivers.DeviceDrivers.*;
import static com.radware.vision.infra.utils.ReportsUtils.addErrorMessage;
import static com.radware.vision.infra.utils.ReportsUtils.reportErrors;

public class GeneralSteps extends TestBase {

    @Given("^CLI Clear vision logs$")
    public static void clearAllLogs() {
        final String clearAllLogs = "echo 'cleared' $(date)|tee " +
                "/opt/radware/mgt-server/third-party/tomcat/logs/*.log" +
                " /opt/radware/storage/maintenance/logs/*.log " +
                "/opt/radware/mgt-server/third-party/jboss-4.2.3.GA/server/insite/log/server/*.log " +
                "/opt/radware/storage/mgt-server/third-party/tomcat2/logs/*.log " +
                "/opt/radware/storage/maintenance/upgrade/upgrade.log " +
                "/opt/radware/storage/maintenance/logs/backups/*.* " +
                "/opt/radware/storage/vdirect/server/logs/application/vdirect.log " +
                "/opt/radware/storage/elasticsearch/logs/*.log " +
                "/tmp/logs/Vision_install.log " +
                "/var/log/td-agent/td-agent.log " +
                "/opt/radware/storage/maintenance/logs/lls/lls_install_display.log " +
                "/opt/radware/storage/maintenance/logs/jboss_watchdog.log";
        CliOperations.runCommand(serversManagement.getRootServerCLI().get(), clearAllLogs);

    }

    /**
     * search if an expression exists in server logs by types
     *
     * @param selections - SearchLog list
     */
    @Then("^CLI Check if logs contains$")
    public void checkIfLogsContains(List<SearchLog> selections) {
        String command = "grep -Ei";
        String commandToSkip = " |grep -v ";

        if (!selections.get(0).logType.toString().equalsIgnoreCase("ALL")) {
            List<SearchLog> ignoreList = getIgnoreList(selections);

            List<SearchLog> searchList = getSearchList(selections);

            searchList.forEach(selection -> {
                String checkForErrors = String.format("%s \"%s\" %s", command, selection.expression, selection.logType.getServerLogType());
                List<SearchLog> myIgnored = ignoreList.stream().filter(o ->
                        o.logType.equals(selection.logType)).collect(Collectors.toList());

                for (SearchLog ignore : myIgnored)
                    checkForErrors = checkForErrors.concat(String.format("%s \"%s\"", commandToSkip, ignore.expression));

                searchExpressionInLog(selection, checkForErrors);
            });
        }
//        All
        else {
            List<SearchLog> ignoreList = getIgnoreList(selections);

            for (ServerLogType selection : ServerLogType.values()) {
                if (!selection.toString().equalsIgnoreCase("ALL")) {
                    selections.get(0).setLogType(selection);

                    String checkForErrors = String.format("%s \"%s\" %s", command, selections.get(0).expression, selection.getServerLogType());
                    List<SearchLog> myIgnored = ignoreList.stream().filter(o ->
                            o.logType.equals(selections.get(0).logType)).collect(Collectors.toList());

                    for (SearchLog ignore : myIgnored)
                        checkForErrors = checkForErrors.concat(commandToSkip + " " + ignore.expression);

                    searchExpressionInLog(selections.get(0), checkForErrors);
                }
            }
        }
        reportErrors();
    }


    private void searchExpressionInLog(SearchLog object, String command) {
        LinuxServerCredential rootCredentials = new LinuxServerCredential(clientConfigurations.getHostIp(), cliConfigurations.getRootServerCliUserName(), cliConfigurations.getRootServerCliPassword());
        ExecuteShellCommands executeShellCommands = ExecuteShellCommands.getInstance();
        executeShellCommands.runRemoteShellCommand(rootCredentials, command);
        String output = executeShellCommands.getShellCommandOutput();
        if (output.equals("") && object.isExpected.equals(MessageAction.EXPECTED))
            addErrorMessage(object.logType.toString() + ": does not contain -> " + object.expression);
        else if (!output.equals("") && object.isExpected.equals(MessageAction.NOT_EXPECTED)) {
            addErrorMessage(object.logType.toString() + ": contains -> " + object.expression + "\n" + output);
        }
    }

    @Then("^CLI Upload Device Driver For \"([^\"]*)\" Version \"([^\"]*)\"$")
    public void uploadDeviceDriver(SUTDeviceType deviceType, String version) {
        String jarFile = null;
        FileSteps f = new FileSteps();
        DeviceDrivers dd = new DeviceDrivers();
        switch (deviceType) {
            case Alteon:
                jarFile = dd.getAlteonVersionsMap().get(version);
                break;
            case DefensePro:
                jarFile = dd.getDpVersionsMap().get(version);
                break;
        }
        if (Strings.isNullOrEmpty(jarFile)) {
            BaseTestUtils.report("Unable to find device driver file for this version", Reporter.FAIL);
        }
        try {
            f.scp(DEFAULT_DEVICE_DRIVERS_PATH + SCRIPT_FILE_NAME, ServersManagement.ServerIds.GENERIC_LINUX_SERVER, ServersManagement.ServerIds.ROOT_SERVER_CLI, DEFAULT_DST_PATH);
            f.scp(DEFAULT_DEVICE_DRIVERS_PATH + jarFile, ServersManagement.ServerIds.GENERIC_LINUX_SERVER, ServersManagement.ServerIds.ROOT_SERVER_CLI, DEFAULT_DST_PATH);
            CliOperations.runCommand(serversManagement.getRootServerCLI().get(), DEFAULT_DST_PATH + SCRIPT_FILE_NAME + " " + DEFAULT_DST_PATH + jarFile, DEFAULT_TIME_OUT);

        } catch (Exception e) {
            BaseTestUtils.report("Failed to load device driver " + e.getMessage(), Reporter.FAIL);
        }


    }

    @Then("^Service Vision (restart|stop|start) and Wait (\\d+) Minute|Minutes$")
    public void serviceVisionRestartStopStart(String operation, int waitTime) {
        CliOperations.runCommand(serversManagement.getRootServerCLI().get(), "service vision " + operation, 90 * 1000);
        BasicOperationsHandler.delay(60 * waitTime);
    }

    @Then("^UI (UnSelect|Select) Element with label \"([^\"]*)\" and params \"([^\"]*)\"$")
    public void uiSelectElementWithLabelAndParams(String selectOrUnselect, String label, String params) throws Exception {
        WebUiTools.check(label, params, selectOrUnselect.equalsIgnoreCase("select"));
    }

    @Then("^UI Check and Select Report Menu Element with label \"([^\"]*)\"(?: and params \"([^\"]*)\")?$")
    public void checkAndClickElementWithLabelAndParams(String label, String params) throws Exception {
        WebUiTools.check(label, params, false);
    }

    private enum ServerLogType {
        ALL(""),
        TOMCAT("/opt/radware/mgt-server/third-party/tomcat/logs/*.log"),
        MAINTENANCE("/opt/radware/storage/maintenance/logs/*.log"),
        JBOSS("/opt/radware/mgt-server/third-party/jboss-4.2.3.GA/server/insite/log/server/*.log"),
        TOMCAT2("/opt/radware/storage/mgt-server/third-party/tomcat2/logs/*.log"),
        UPGRADE("/opt/radware/storage/maintenance/upgrade/upgrade.log"),
        BACKUP("/opt/radware/storage/maintenance/logs/backups/*.*"),
        VDIRECT("/opt/radware/storage/vdirect/server/logs/application/vdirect.log"),
        ES("/opt/radware/storage/elasticsearch/logs/*.log"),
        VISION_INSTALL("/tmp/logs/Vision_install.log"),
        FLUENTD("/var/log/td-agent/td-agent.log"),
        LLS("/opt/radware/storage/maintenance/logs/lls/lls_install_display.log"),
        JBOSS_WD("/opt/radware/storage/maintenance/logs/jboss_watchdog.log");

        private String serverLogType;

        ServerLogType(String serverLogType) {
            this.serverLogType = serverLogType;
        }

        private String getServerLogType() {
            return serverLogType;
        }
    }

    public static class SearchLog {
        ServerLogType logType;
        String expression;
        MessageAction isExpected;

        public void setLogType(ServerLogType logType) {
            this.logType = logType;
        }
    }


    private enum MessageAction {
        NOT_EXPECTED("false"),
        EXPECTED("true"),
        IGNORE("ignore");

        private String messageAction;

        MessageAction(String messageAction) {
            this.messageAction = messageAction;
        }

        private String getMessageAction() {
            return messageAction;
        }
    }

    private List<SearchLog> getIgnoreList(List<SearchLog> selections) {
        return selections.stream().filter(o ->
                o.isExpected.equals(MessageAction.IGNORE)).collect(Collectors.toList());
    }

    private List<SearchLog> getSearchList(List<SearchLog> selections) {
        return selections.stream().filter(o ->
                !o.isExpected.equals(MessageAction.IGNORE)).collect(Collectors.toList());
    }
}
