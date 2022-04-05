package com.radware.vision.lls;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.ClientConfigurationDto;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums.LLSStateCMDs;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.system.ConfigSync;

import java.util.Locale;

public class LLSHandler {

    public static final String STANDALONE_INSTALL = "system lls install standalone -cloud-sync ";
    public static final String SERVICE_STATUS = "system lls service status";
    public static final String INSTALL_LOGS = "system lls logs install";
    public static final String LLS_STATE_DISABLED = "LLS service is disabled.";
    public static final String LLS_STATE_ENABLED = "LLS service is enabled.";
    public static final String LLS_STATE_CMD = "system lls state";
    public static final String SERVICE_START_CMD = "system lls service start";
    public static final String SERVICE_STOP_CMD = "system lls service stop";
    public static final String LLS_IS_RUNNING = "Local License Server is running";
    public static final String LLS_STOPPED_SUCCESS = "Removing config_kvision-lls_1 ... done";
    public static final String BACkUP_INSTALL = "system lls install backup -peer-host ";
    public static final String MAIN_INSTALL = "system lls install main -peer-host ";

    private static final ClientConfigurationDto clientConfigurations = TestBase.getSutManager().getClientConfigurations();

    public static void HAbackupInstall(String mode, int timeout) throws Exception {

        String mainIP = clientConfigurations.getHostIp();
        String backupIP = TestBase.restTestBase.getVisionServerHA().getHost_2();
        RadwareServerCli backupServerCli = new RadwareServerCli(backupIP, TestBase.restTestBase.getRadwareServerCli().getUser(), TestBase.restTestBase.getRadwareServerCli().getPassword());
        backupServerCli.init();
        backupServerCli.connect();
        String ConfigSyncMode = ConfigSync.getMode(backupServerCli);

        if (!ConfigSyncMode.equalsIgnoreCase("standby")) {
            throw new Exception("The Host2 machine is NOT standby.");
        }
//       kVision
//        CliOperations.runCommand(backupServerCli, "system lls service stop");
//        CliOperations.verifyLastOutputByRegex(".*Continue?.*\\(y/n\\).*");
//        CliOperations.runCommand(backupServerCli, "y", timeout);
//        String cmd = BACkUP_INSTALL + mainIP + " -cloud-sync " + mode;
//        CliOperations.runCommand(backupServerCli, cmd);
//        CliOperations.verifyLastOutputByRegex(".*Continue?.*\\(y/n\\).*");
//        CliOperations.runCommand(backupServerCli, "y", timeout);
        waitForInstallation(backupServerCli, timeout, "Local License Server is running");
        waitForInstallationInLogsHA(backupServerCli, timeout, "backup", mainIP, backupIP);
    }

    public static void waitForInstallationInLogsHA(ServerCliBase serverCliBase, long timeout, String type, String mainIP, String backupIP) throws Exception {
        long startTime = System.currentTimeMillis();
        timeout *= 1000;
        while (System.currentTimeMillis() - startTime < timeout) {
            try {
                serverCliBase.connect();
//               kVision
//                CliOperations.runCommand(serverCliBase, INSTALL_LOGS, 3 * 60 * 1000);


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
//       kVision
//        CliOperations.runCommand(restTestBase.getRadwareServerCli(), SERVICE_STATUS, 3 * 60 * 1000);
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
        BaseTestUtils.reporter.report("timeout pass, with no sucess, the main url or the backup url is not configured.", Reporter.FAIL);
    }

    public static void HAMainInstall(String mode, int timeout) throws Exception {

        String mainIP = clientConfigurations.getHostIp();
        String backup = TestBase.restTestBase.getVisionServerHA().getHost_2();
        RadwareServerCli backupServerCli = new RadwareServerCli(backup, TestBase.restTestBase.getRadwareServerCli().getUser(), TestBase.restTestBase.getRadwareServerCli().getPassword());
        backupServerCli.init();
        backupServerCli.connect();
        waitForInstallation(backupServerCli, timeout, "Local License Server is running");
        RadwareServerCli mainServerCli = new RadwareServerCli(mainIP, TestBase.restTestBase.getRadwareServerCli().getUser(), TestBase.restTestBase.getRadwareServerCli().getPassword());
        mainServerCli.init();
        mainServerCli.disconnect();
        mainServerCli.connect();
        String ConfigSyncMode = ConfigSync.getMode(mainServerCli);

        if (!ConfigSyncMode.equalsIgnoreCase("active")) {
            throw new Exception("The Host1 machine is NOT active.");
        }
//       kVision
//        CliOperations.runCommand(mainServerCli, "system lls service stop");
//        CliOperations.verifyLastOutputByRegex(".*Continue?.*\\(y/n\\).*");
//        CliOperations.runCommand(mainServerCli, "y", timeout);
//        String cmd = MAIN_INSTALL + backup + " -cloud-sync " + mode;
//        CliOperations.runCommand(mainServerCli, cmd);
//        CliOperations.verifyLastOutputByRegex(".*Continue?.*\\(y/n\\).*");
//        CliOperations.runCommand(mainServerCli, "y", timeout);
        waitForInstallation(null, timeout, "Local License Server is running");
        waitForInstallationInLogsHA(mainServerCli, timeout, "main", mainIP, backup);
    }


    public static void standaloneInstall(RadwareServerCli radwareServerCli, String mode, int timeout) throws Exception {
//       kVision
        llsServiceStop(radwareServerCli, 300);
        CliOperations.runCommand(radwareServerCli, "echo 'cleared' $(date)|tee /opt/radware/storage/maintenance/logs/lls/lls_install_display.log");
        CliOperations.runCommand(radwareServerCli, STANDALONE_INSTALL + mode);
        CliOperations.runCommand(radwareServerCli, "y");
        BaseTestUtils.reporter.startLevel("LLS Install started," + mode + "mode");
        waitForInstallation(radwareServerCli, timeout, "ServerID:");
    }

    public static void waitForInstallation(RadwareServerCli serverCli , long timeout, String expected) throws Exception {
        long startTime = System.currentTimeMillis();
        timeout *= 1000;
        while (System.currentTimeMillis() - startTime < timeout) {
            try {
                ServerCliBase radwareServerCli;
                if (serverCli == null) {
                    radwareServerCli = TestBase.getServersManagement().getRadwareServerCli().get();
                } else {
                    radwareServerCli = serverCli;
                }
//              kVision
                CliOperations.runCommand(radwareServerCli, SERVICE_STATUS);

//                CliOperations.verifyLastOutputByRegex(expected);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(expected, CliOperations.lastOutput);
                return;
            } catch (Exception e) {
                Thread.sleep(50000);
            }
        }
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
//      kVision
//        CliOperations.runCommand(restTestBase.getRadwareServerCli(), INSTALL_LOGS, 3 * 60 * 1000);
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
        BaseTestUtils.reporter.report("timeout pass,with no sucess, Local License Server is NOT running", Reporter.FAIL);
    }

    public static void waitForLicenseActivation(ServerCliBase serverCliBase, long timeout, String entitlementID) throws Exception {
        long startTime = System.currentTimeMillis();
        timeout *= 1000;
        while (System.currentTimeMillis() - startTime < timeout) {
            try {
//              kVision
//                CliOperations.runCommand(radwareServerCli, SERVICE_STATUS);


//                CliOperations.verifyLastOutputByRegex(expected);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(entitlementID, CliOperations.lastOutput);
                return;
            } catch (Exception e) {
                Thread.sleep(50000);
            }
        }
        BaseTestUtils.reporter.report("timeout pass in waiting for activation license in machine: " + serverCliBase.getHost(), Reporter.FAIL);
    }


    public static void llsServiceStart(RadwareServerCli radwareServerCli, long timeout) throws Exception {
        timeout *= 1000;
        long startTime = System.currentTimeMillis();

        CliOperations.runCommand(radwareServerCli, SERVICE_START_CMD);
        if (CliOperations.lastOutput.contains("FailOverRole: MAIN")){
            BaseTestUtils.reporter.report("LLS Service is already running", Reporter.PASS);
            return;
        }
        CliOperations.runCommand(radwareServerCli, "y");

        while (System.currentTimeMillis() - startTime < timeout) {
            try {
                CliOperations.runCommand(radwareServerCli,SERVICE_STATUS);
                if(CliOperations.lastOutput.contains("FailOverRole: MAIN"))
                    return;
                Thread.sleep(10000);
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }
        BaseTestUtils.reporter.report("timeout pass with no success, LLS Service is Not running.", Reporter.FAIL);
    }

    public static void llsServiceStop(RadwareServerCli radwareServerCli, long timeout) throws Exception {
        timeout *= 1000;
        long startTime = System.currentTimeMillis();

        CliOperations.runCommand(radwareServerCli, SERVICE_STOP_CMD);
        CliOperations.runCommand(radwareServerCli, "y");
        if (CliOperations.lastOutput.contains("No stopped containers")){
            BaseTestUtils.reporter.report("LLS Service is already stopped", Reporter.PASS);
            return;
        }
        while (System.currentTimeMillis() - startTime < timeout) {
            try {
//               kVision
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(LLS_STOPPED_SUCCESS, CliOperations.lastOutput);
                return;
            } catch (Exception e) {
                Thread.sleep(30000);
            }
        }
        BaseTestUtils.reporter.report("timeout pass with no success, LLS Service is not stopped.", Reporter.FAIL);
    }

    public static void llsSetState (RadwareServerCli radwareServerCli, long timeout, LLSStateCMDs cmd) throws Exception {
        timeout *= 1000;
        long startTime = System.currentTimeMillis();

        CliOperations.runCommand(radwareServerCli, LLS_STATE_CMD + " " + cmd.getCmd());
        CliOperations.runCommand(radwareServerCli, "y");

        while (System.currentTimeMillis() - startTime < timeout) {
            try {
                CliOperations.runCommand(radwareServerCli, LLS_STATE_CMD + " " + LLSStateCMDs.GET.getCmd());
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail("LLS service is " + cmd.getCmd() + "d", CliOperations.lastOutput);
                return;
            } catch (Exception e) {
                Thread.sleep(2000);
            }
        }
    }


    public static void validateURLHA(String type, long timeout) throws Exception {

        String mainIP = clientConfigurations.getHostIp();
        String backupIP = TestBase.restTestBase.getVisionServerHA().getHost_2();
        RadwareServerCli serverCli;
        if (type.equalsIgnoreCase("main")) {
            serverCli = new RadwareServerCli(mainIP, TestBase.restTestBase.getRadwareServerCli().getUser(), TestBase.restTestBase.getRadwareServerCli().getPassword());

        } else {
            serverCli = new RadwareServerCli(backupIP, TestBase.restTestBase.getRadwareServerCli().getUser(), TestBase.restTestBase.getRadwareServerCli().getPassword());

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
//               kVision
//                CliOperations.runCommand(getRestTestBase().getRadwareServerCli(), INSTALL_LOGS, 3 * 60 * 1000);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(".*\"main\" : \"http://" + mainIP + ":7070\"", CliOperations.lastOutput);
                CliOperations.verifyLastOutputByRegexWithOutputWithoutFail(".*Auto Configuration successful*", CliOperations.lastOutput);
                return;
            } catch (Exception e) {
                Thread.sleep(50000);
            }
        }
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
//       kVision
//        CliOperations.runCommand(restTestBase.getRadwareServerCli(), SERVICE_STATUS, 3 * 60 * 1000);
        BaseTestUtils.reporter.report(CliOperations.lastOutput, Reporter.PASS_NOR_FAIL);
        BaseTestUtils.reporter.report("timeout pass, The main url is not configured.", Reporter.FAIL);
    }

}
