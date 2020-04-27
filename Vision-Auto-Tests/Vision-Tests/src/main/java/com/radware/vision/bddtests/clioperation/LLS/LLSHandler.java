package com.radware.vision.bddtests.clioperation.LLS;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.cli.ServerCliBase;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.base.TestBase;
import com.radware.vision.systemManagement.models.ManagementInfo;
import com.radware.vision.vision_handlers.system.ConfigSync;
import com.radware.vision.vision_project_cli.RadwareServerCli;

import static com.radware.vision.base.WebUITestBase.getRestTestBase;
import static com.radware.vision.base.WebUITestBase.restTestBase;

public class LLSHandler {

    public static final String STANDALONE_INSTALL = "system lls install standalone -cloud-sync ";
    public static final String SERVICE_STATUS = "system lls service status";
    public static final String INSTALL_LOGS = "system lls logs install";
    public static final String SERVICE_START_CMD = "system lls service start";
    public static final String LLS_IS_RUNNING = "Local License Server is running";
    public static final String BACkUP_INSTALL = "system lls install backup -peer-host ";
    public static final String MAIN_INSTALL = "system lls install main -peer-host ";

    private static ManagementInfo managementInfo = TestBase.getVisionConfigurations().getManagementInfo();
    private static ClientConfigurationDto clientConfigurations = TestBase.getSutManager().getClientConfigurations();

    public static void HAbackupInstall(String mode, int timeout) throws Exception {

        String mainIP = clientConfigurations.getHostIp();
        String backupIP = restTestBase.getVisionServerHA().getHost_2();
        RadwareServerCli backupServerCli = new RadwareServerCli(backupIP, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
        backupServerCli.init();
        backupServerCli.connect();
        String ConfigSyncMode = ConfigSync.getMode(backupServerCli);

        if (!ConfigSyncMode.equalsIgnoreCase("standby")) {
            throw new Exception("The Host2 machine is NOT standby.");
        }
        CliOperations.runCommand(backupServerCli, "system lls service stop");
        CliOperations.verifyLastOutputByRegex(".*Continue?.*\\(y/n\\).*");
        CliOperations.runCommand(backupServerCli, "y", timeout);
        String cmd = BACkUP_INSTALL + mainIP + " -cloud-sync " + mode;
        CliOperations.runCommand(backupServerCli, cmd);
        CliOperations.verifyLastOutputByRegex(".*Continue?.*\\(y/n\\).*");
        CliOperations.runCommand(backupServerCli, "y", timeout);
        waitForInstallation(backupServerCli, timeout, "Local License Server is running");
        waitForInstallationInLogsHA(backupServerCli, timeout, "backup", mainIP, backupIP);
    }

    public static void waitForInstallationInLogsHA(ServerCliBase serverCliBase, long timeout, String type, String mainIP, String backupIP) throws Exception {
        long startTime = System.currentTimeMillis();
        timeout *= 1000;
        while (System.currentTimeMillis() - startTime < timeout) {
            try {
                serverCliBase.connect();
                CliOperations.runCommand(serverCliBase, INSTALL_LOGS, 3 * 60 * 1000);
//                CliOperations.verifyLastOutputByRegex(expected);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(".*LLS HA role: " + type, CliOperations.lastOutput);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(".*\"main\" : \"http://" + mainIP + ":7070\"", CliOperations.lastOutput);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(".*\"backup\" : \"http://" + backupIP + ":7070\"", CliOperations.lastOutput);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(".*Auto Configuration successful*", CliOperations.lastOutput);
                return;
            } catch (Exception e) {
                Thread.sleep(50000);
            }
        }
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
        CliOperations.runCommand(restTestBase.getRadwareServerCli(), SERVICE_STATUS, 3 * 60 * 1000);
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
        BaseTestUtils.reporter.report("timeout pass, with no sucess, the main url or the backup url is not configured.", Reporter.FAIL);
    }

    public static void HAMainInstall(String mode, int timeout) throws Exception {

        String mainIP = clientConfigurations.getHostIp();
        String backup = restTestBase.getVisionServerHA().getHost_2();
        RadwareServerCli backupServerCli = new RadwareServerCli(backup, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
        backupServerCli.init();
        backupServerCli.connect();
        waitForInstallation(backupServerCli, timeout, "Local License Server is running");
        RadwareServerCli mainServerCli = new RadwareServerCli(mainIP, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());
        mainServerCli.init();
        mainServerCli.disconnect();
        mainServerCli.connect();
        String ConfigSyncMode = ConfigSync.getMode(mainServerCli);

        if (!ConfigSyncMode.equalsIgnoreCase("active")) {
            throw new Exception("The Host1 machine is NOT active.");
        }
        CliOperations.runCommand(mainServerCli, "system lls service stop");
        CliOperations.verifyLastOutputByRegex(".*Continue?.*\\(y/n\\).*");
        CliOperations.runCommand(mainServerCli, "y", timeout);
        String cmd = MAIN_INSTALL + backup + " -cloud-sync " + mode;
        CliOperations.runCommand(mainServerCli, cmd);
        CliOperations.verifyLastOutputByRegex(".*Continue?.*\\(y/n\\).*");
        CliOperations.runCommand(mainServerCli, "y", timeout);
        waitForInstallation(null, timeout, "Local License Server is running");
        waitForInstallationInLogsHA(mainServerCli, timeout, "main", mainIP, backup);
    }


    public static void standaloneInstall(String mode, int timeout) throws Exception {
        CliOperations.runCommand(getRestTestBase().getRadwareServerCli(), "system lls service stop");
        CliOperations.verifyLastOutputByRegex(".*Continue?.*\\(y/n\\).*");
        CliOperations.runCommand(getRestTestBase().getRadwareServerCli(), "y", timeout);
        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "echo 'cleared' $(date)|tee /opt/radware/storage/maintenance/logs/lls/lls_install_display.log");
        CliOperations.runCommand(restTestBase.getRadwareServerCli(), STANDALONE_INSTALL + mode);
        CliOperations.verifyLastOutputByRegex(".*Continue?.*\\(y/n\\).*");
        CliOperations.runCommand(restTestBase.getRadwareServerCli(), "y");
        BaseTestUtils.reporter.startLevel("LLS Install started," + mode + "mode");
        waitForInstallation(null, timeout, "Local License Server is running");
    }

    public static void waitForInstallation(ServerCliBase serverCliBase, long timeout, String expected) throws Exception {
        long startTime = System.currentTimeMillis();
        timeout *= 1000;
        while (System.currentTimeMillis() - startTime < timeout) {
            try {
                ServerCliBase radwareServerCli;
                if (serverCliBase == null) {
                    radwareServerCli = restTestBase.getRadwareServerCli();
                } else {
                    radwareServerCli = serverCliBase;
                }
                CliOperations.runCommand(radwareServerCli, SERVICE_STATUS);
//                CliOperations.verifyLastOutputByRegex(expected);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(expected, CliOperations.lastOutput);
                return;
            } catch (Exception e) {
                Thread.sleep(50000);
            }
        }
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
        CliOperations.runCommand(restTestBase.getRadwareServerCli(), INSTALL_LOGS, 3 * 60 * 1000);
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
        BaseTestUtils.reporter.report("timeout pass,with no sucess, Local License Server is NOT running", Reporter.FAIL);
    }

    public static void waitForLicenseActivation(ServerCliBase serverCliBase, long timeout, String entitlementID) throws Exception {
        long startTime = System.currentTimeMillis();
        timeout *= 1000;
        while (System.currentTimeMillis() - startTime < timeout) {
            try {
                ServerCliBase radwareServerCli;
                if (serverCliBase == null) {
                    radwareServerCli = restTestBase.getRadwareServerCli();
                } else {
                    radwareServerCli = serverCliBase;
                }
                CliOperations.runCommand(radwareServerCli, SERVICE_STATUS);
//                CliOperations.verifyLastOutputByRegex(expected);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(entitlementID, CliOperations.lastOutput);
                return;
            } catch (Exception e) {
                Thread.sleep(50000);
            }
        }
        BaseTestUtils.reporter.report("timeout pass in waiting for activation license in machine: " + serverCliBase.getHost(), Reporter.FAIL);
    }


    public static void llsServiceStart(long timeout) throws Exception {
        timeout *= 1000;
        long startTime = System.currentTimeMillis();
        CliOperations.runCommand(restTestBase.getRadwareServerCli(), SERVICE_START_CMD);
        CliOperations.verifyLastOutputByRegex(".*Continue?.*\\(y/n\\).*");
        CliOperations.runCommand(restTestBase.getRadwareServerCli(), "y");
        while (System.currentTimeMillis() - startTime < timeout) {
            try {
                CliOperations.runCommand(restTestBase.getRadwareServerCli(), SERVICE_STATUS);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(LLS_IS_RUNNING, CliOperations.lastOutput);
                return;
            } catch (Exception e) {
                Thread.sleep(30000);
            }
        }
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
        CliOperations.runCommand(restTestBase.getRadwareServerCli(), INSTALL_LOGS, 3 * 60 * 1000);
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
        BaseTestUtils.reporter.report("timeout pass with no success, LLS Service is Not running.", Reporter.FAIL);
    }


    public static void validateURLHA(String type, long timeout) throws Exception {

        String mainIP = clientConfigurations.getHostIp();
        String backupIP = restTestBase.getVisionServerHA().getHost_2();
        RadwareServerCli serverCli;
        if (type.equalsIgnoreCase("main")) {
            serverCli = new RadwareServerCli(mainIP, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());

        } else {
            serverCli = new RadwareServerCli(backupIP, restTestBase.getRadwareServerCli().getUser(), restTestBase.getRadwareServerCli().getPassword());

        }
        serverCli.init();
        serverCli.connect();
        waitForInstallationInLogsHA(serverCli, timeout, type, mainIP, backupIP);
    }

    public static void validateURLStandalone(long timeout) throws Exception {
        long startTime = System.currentTimeMillis();
        timeout *= 1000;
        String mainIP = clientConfigurations.getHostIp();
        while (System.currentTimeMillis() - startTime < timeout) {
            try {
                CliOperations.runCommand(getRestTestBase().getRadwareServerCli(), INSTALL_LOGS, 3 * 60 * 1000);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(".*\"main\" : \"http://" + mainIP + ":7070\"", CliOperations.lastOutput);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(".*Auto Configuration successful*", CliOperations.lastOutput);
                return;
            } catch (Exception e) {
                Thread.sleep(50000);
            }
        }
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
        CliOperations.runCommand(restTestBase.getRadwareServerCli(), SERVICE_STATUS, 3 * 60 * 1000);
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
        BaseTestUtils.reporter.report("timeout pass, The main url is not configured.", Reporter.FAIL);
    }

}
