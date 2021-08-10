package com.radware.vision.automation.Deploy;


import com.aqua.sysobj.conn.CliConnectionImpl;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.ExecuteShellCommands;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.automation.tools.utils.LinuxServerCredential;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.ServerCliBase;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums.GlobalProperties;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.enums.ConfigSyncMode;
import com.radware.vision.system.ConfigSync;

import java.util.*;

/**
 * Created by stanislava on 6/25/2015.
 */
public class VisionServer {

    private final static String TARGET_UPGRADE_SERVER_FILE_FOLDER = "/opt/radware/storage/uploads/temp";
    private final static String UPGRADE_FAILED_MESSAGE = "The APSolute Vision upgrade process failed";
    private final static String GOING_TO_REBOOT = "Is reboot required: 0";
    private final static String SUCCESSFUL_UPGRADE = "The upgrade of APSolute Vision server has completed successfully";
    private final static String UPGRADE_FILE_PATH = "/opt/radware/storage/maintenance/logs/upgrade.log";

    public static void upgradeServerFile(RadwareServerCli radwareServerCli, RootServerCli rootServerCli,
                                         String upgradePassword,
                                         String file, String url) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("system upgrade full - Started");
            int timeout = 90;

            downloadUpgradeFile(rootServerCli, url);
            if (!InvokeUtils.isConnectionOpen(radwareServerCli)) radwareServerCli.connect();
            upgradePassword = upgradePassword == null ? "" : upgradePassword;
            radwareServerCli.setUpgradePassword(upgradePassword);
            int startUpgradeTimeOut = 20 * 60 * 1000;
            timeout = timeout * 60 * 1000;
            //Clear old file
            CliOperations.runCommand(rootServerCli, "mkdir /opt/radware/storage/maintenance/upgrade",
                    CliOperations.DEFAULT_TIME_OUT, false, false, true);
            CliOperations.runCommand(rootServerCli, "> " + UPGRADE_FILE_PATH, CliOperations.DEFAULT_TIME_OUT,
                    false, false, true);

            // Run the system upgrade command
            radwareServerCli.connect(); // in-case connect on init is false.
            CliOperations.runCommand(radwareServerCli, Menu.system().upgrade().full().build() + " " + file,
                    startUpgradeTimeOut, false, false, true);
            waitTillUpgradeComplete(rootServerCli, timeout);
            if (radwareServerCli.getTestAgainstObject().toString().contains(UPGRADE_FAILED_MESSAGE)) {
                BaseTestUtils.report("Upgrade Failed with the following error:\n" +
                        radwareServerCli.getTestAgainstObject(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("System Upgrade failed with the following error: " + e.getMessage() + "\n"
                    + Arrays.asList(e.getStackTrace()), Reporter.FAIL);

        } finally {
            BaseTestUtils.reporter.stopLevel();
            radwareServerCli.disconnect();
            rootServerCli.disconnect();
        }
    }

    public static void downloadUpgradeFile(RootServerCli rootServerCli, String visionServerUrl) throws Exception {
        if (!InvokeUtils.isConnectionOpen(rootServerCli)) rootServerCli.connect();

        //remove the validation - so no need for password
        CliOperations.runCommand(rootServerCli, "rm -rf /opt/radware/box/bin/pw2_check");
        //Clear upload temp folder
        CliOperations.runCommand(rootServerCli, "rm -f /uploads/temp/*", CliOperations.DEFAULT_TIME_OUT,
                false, false, true);
        //Downloading the file to the target folder
        CliOperations.runCommand(rootServerCli, "cd " + TARGET_UPGRADE_SERVER_FILE_FOLDER);
        BaseTestUtils.report("Starting download image from:" + visionServerUrl, Reporter.PASS_NOR_FAIL);
        InvokeUtils.invokeCommand(null, "wget" + " " + "\"" + visionServerUrl + "\"" + " " + ".",
                rootServerCli, GlobalProperties.VISION_OPERATIONS_TIMEOUT);
        BaseTestUtils.report("Download image completed", Reporter.PASS_NOR_FAIL);

    }

    /**
     * @param rootServerCli RootServerCli object
     * @return - true if upgrade terminated successfully
     */

    private static boolean didUpgradeFinish(RootServerCli rootServerCli) {
        LinuxServerCredential rootCredentials = new LinuxServerCredential(rootServerCli.getHost(),
                rootServerCli.getUser(), rootServerCli.getPassword());
        ExecuteShellCommands executeShellCommands = ExecuteShellCommands.getInstance();
        try {
            String grep = "grep \"%s\" %s |wc -l";
            String command = String.format(grep, SUCCESSFUL_UPGRADE, UPGRADE_FILE_PATH);
            executeShellCommands.runRemoteShellCommand(rootCredentials, command);
            String output = executeShellCommands.getShellCommandOutput().trim();
            if (output.equals("1")) {
                BaseTestUtils.report("UPGRADE finished SUCCESSFULLY", Reporter.PASS_NOR_FAIL);
                return true;
            }
            command = String.format(grep, UPGRADE_FAILED_MESSAGE, UPGRADE_FILE_PATH);
            executeShellCommands.runRemoteShellCommand(rootCredentials, command);
            output = executeShellCommands.getShellCommandOutput().trim();
            if (!output.equals("0")) {
                BaseTestUtils.report(String.format("UPGRADE finished with an error:\n%s", output), Reporter.FAIL);
            }
        } catch (RuntimeException e) {
            BaseTestUtils.report("WARNING:" + e.getMessage(), Reporter.PASS_NOR_FAIL);
        } catch (Exception e2) {
            BaseTestUtils.report(e2.getMessage(), Reporter.FAIL);
        }
        return false;
    }

    /**
     * @param rootServerCli RootServerCli object
     * @param timeout       in mSec
     */
    private static void waitTillUpgradeComplete(RootServerCli rootServerCli, int timeout) {
        long startTime = System.currentTimeMillis();
        boolean isResetNeeded = false;
        BaseTestUtils.report(String.format("Waiting for upgrade to finish within %d minutes",
                (timeout / (60 * 1000))), Reporter.PASS_NOR_FAIL);
        while (System.currentTimeMillis() - startTime < timeout) {
            try {
                if (!isResetNeeded)
                    isResetNeeded = isGoingToReboot(rootServerCli);
                if (didUpgradeFinish(rootServerCli)) {
                    if (isResetNeeded) {
                        BaseTestUtils.report("Upgrade finished. Reboot in process", Reporter.PASS_NOR_FAIL);
                        Thread.sleep(5 * 60 * 1000);
                    }
                    return;
                }
                Thread.sleep(5000);
            } catch (InterruptedException e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }
        BaseTestUtils.report("Upgrade did not finish till timeout", Reporter.FAIL);
    }

    /**
     * @param rootServerCli - RootServerCli object
     * @return - true if found GOING_TO_REBOOT string more than once
     */
    private static boolean isGoingToReboot(RootServerCli rootServerCli) {
        LinuxServerCredential rootCredentials = new LinuxServerCredential(rootServerCli.getHost(),
                rootServerCli.getUser(), rootServerCli.getPassword());

        try {
            ExecuteShellCommands executeShellCommands = ExecuteShellCommands.getInstance();
            executeShellCommands.runRemoteShellCommand(rootCredentials, "grep \"" + GOING_TO_REBOOT +
                    "\" " + UPGRADE_FILE_PATH + " | wc -l");

            String output = executeShellCommands.getShellCommandOutput().trim();
            if (Integer.parseInt(output) > 0) {
                BaseTestUtils.report("Upgrade requires reboot!!!", Reporter.PASS_NOR_FAIL);
                return true;
            }
        } catch (NumberFormatException e) {
            BaseTestUtils.report("WARNING: Number format exception.\n" + e.getMessage(), Reporter.PASS_NOR_FAIL);
        } catch (Exception e) {
            BaseTestUtils.report("WARNING:" + e.getMessage(), Reporter.PASS_NOR_FAIL);
        }
        return false;
    }

    public static boolean waitForServerConnection(long timeout, ServerCliBase connection) throws InterruptedException {
        long startTime = System.currentTimeMillis();
        while (System.currentTimeMillis() - startTime < timeout) {
            try {
                connection.connect();
                return true;
            } catch (Exception e) {
                Thread.sleep(10000);
            }
        }
        return false;
    }

    public static boolean waitForVisionServerServicesToStartHA(RadwareServerCli radwareServerCli, long timeout) throws Exception {
        long startTime = System.currentTimeMillis();
        do {

            if (isVisionServerRunningHA(radwareServerCli))
                return true;
            Thread.sleep(15 * 1000);
        }
        while (System.currentTimeMillis() - startTime < timeout);
        return false;
    }

    public static boolean waitForVisionServerServicesToStart(CliConnectionImpl cliConnection, long timeout) throws Exception {
        long startTime = System.currentTimeMillis();
        do {
            if (com.radware.vision.vision_handlers.system.VisionServer.isVisionServerRunning(cliConnection))
                return true;
            Thread.sleep(15 * 1000);
        }
        while (System.currentTimeMillis() - startTime < timeout);
        return false;
    }

    public static boolean waitForVisionServerReadinessForUpgrade(CliConnectionImpl cliConnection, long timeout) throws Exception {
        long startTime = System.currentTimeMillis();
        do {

            if (isVisionReadyForUpgrade(cliConnection))
                return true;
            Thread.sleep(15 * 1000);
        }
        while (System.currentTimeMillis() - startTime < timeout);
        return false;
    }

    public static boolean isVisionReadyForUpgrade(CliConnectionImpl serverCli) {
        try {
            serverCli.connect();
            InvokeUtils.invokeCommand(null, Menu.system().visionServer().status().build(), serverCli, 2 * 60 * 1000, true);
            String status = serverCli.getTestAgainstObject().toString();
            if (status == null) {
                return false;
            }

            boolean APSoluteVisionReporterStarted = status.contains(String.format("%s %s",
                    VisionServices.COLLECTOR.getValue(), ServiceStatus.RUNNING.getStatus()));
            boolean ConfigurationServerStarted = status.contains(String.format("%s %s",
                    VisionServices.CONFIGURATION.getValue(), ServiceStatus.RUNNING.getStatus()));
            return APSoluteVisionReporterStarted &&
                    ConfigurationServerStarted;
            //&& TedAgentIsRunning;
        } catch (Exception e) {
            return false;
        }

    }

    public static boolean isVisionServerRunningHA(RadwareServerCli serverCli) throws Exception {

        //if true -->all relevant services up
        boolean flag = false;
        //all service that are stopped or not running will be add the this list
        List<String> stoppedServices = new ArrayList<>();
        if (!serverCli.isConnected()) {
            serverCli.connect();
        }

        BaseTestUtils.reporter.startLevel("Checking vision server status");
        //Get the mode of the vision
        String currentMode = ConfigSync.getMode(serverCli);

        CliOperations.runCommand(serverCli, Menu.system().visionServer().status().build(), 120 * 1000);
        ArrayList<String> response = serverCli.getCmdOutput();

        validateNumberOfServices(response);

        for (String s : response) {
            if ((s.contains(ServiceStatus.STOPPED.getStatus()) || s.contains(ServiceStatus.NOT_RUNNING.getStatus()) /*|| s.contains("FAILED")*/) &&
                    (!s.contains(VisionServices.VRM_VISUALIZATION.getValue()) &&
                            !s.contains(VisionServices.VRM_COLLECTOR.getValue()) &&
                            !s.contains(VisionServices.LLS.getValue()) &&
                            !s.contains(VisionServices.HEALTH.getValue()) && //TODO remove after service will work as expected
                            !s.contains(VisionServices.TD.getValue()))) {
                if (!s.contains(VisionServices.DPM.getValue())) {
                    if (currentMode.equals(ConfigSyncMode.ACTIVE.getMode()) || currentMode.equals(ConfigSyncMode.DISABLED.getMode())) {
                        stoppedServices.add(s);
                    } else if (currentMode.equals(ConfigSyncMode.STANDBY.getMode())) {
                        if (!(s.contains(VisionServices.CONFIGURATION.getValue()) ||
                                s.contains(VisionServices.SCHEDULER.getValue()))) {
                            stoppedServices.add(s);
                        }
                    } else {
                        /* Unknown configuration-synchronization */
                        BaseTestUtils.reportInfoMessage("Can't tell server's current synchronization mode: " + currentMode);
                        return false;
                    }
                }
            }
        }


        if (stoppedServices.size() == 0) {
            flag = true;
            BaseTestUtils.reportInfoMessage("All relevant services to mode " + currentMode + " are up");
        } else {
            BaseTestUtils.reportInfoMessage("Stopped services are: " + stoppedServices);
        }
        BaseTestUtils.reporter.stopLevel();


        return flag;
    }

    private static void validateNumberOfServices(ArrayList<String> lService) {
        Map<String, String> servicesMap = new HashMap<>();
        for (VisionServices service : VisionServices.values()) {
            servicesMap.put(service.name(), service.getValue());
        }
        ArrayList<String> lAddedServices = new ArrayList<>(lService);
        Map<String, String> lRemovedServices = new HashMap<>(servicesMap);
        for (String line : lService) {
            for (Map.Entry<String, String> service : servicesMap.entrySet()) {
                if (line.contains(service.getValue())) {
                    lAddedServices.remove(line);
                    lRemovedServices.remove(service.getKey());
                    break;
                }
            }
        }

        String errorMessage = "";
        if (!lAddedServices.isEmpty() || !lRemovedServices.isEmpty())
            errorMessage = String.format("Service list was changed:\nNew line/s found: %s\nMissing service/s found: %s",
                    lAddedServices.toString(), lRemovedServices.toString());
        if (!errorMessage.isEmpty())
            BaseTestUtils.report(errorMessage, Reporter.FAIL);
    }

    public enum VisionServices {
        REPORTER("APSolute Vision Reporter"),
        AMQP("AMQP service"),
        DPM("DPM"),
        CONFIGURATION("Configuration server"),
        COLLECTOR("Collector service"),
        NEW_REPORTER("New Reporter service"),
        ALERTS("Alerts service"),
        SCHEDULER("Scheduler service"),
        CONFIGURATION_SYNC("Configuration Synchronization service"),
        TOR("Tor feed service"),
        VDIRECT("Radware vDirect"),
        VRM_COLLECTOR("VRM SSL Inspection collector service"),
        VRM_VISUALIZATION("VRM SSL Inspection visualization service"),
        VRM_REPORTING("VRM reporting engine is"),
        HEALTH("Vision health engine"),
        TD("td-agent"),
        LLS("Local License Server");

        private final String _visionService;

        VisionServices(String visionService) {
            this._visionService = visionService;
        }

        private String getValue() {
            return _visionService;
        }
    }

    public enum ServiceStatus {
        STOPPED("is stopped"),
        NOT_RUNNING("is not running"),
        RUNNING("is running");

        private final String status;

        ServiceStatus(String status) {
            this.status = status;
        }

        private String getStatus() {
            return this.status;
        }
    }

}

