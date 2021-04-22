package com.radware.vision.automation.AutoUtils.vision_handlers;

import com.aqua.sysobj.conn.CliConnectionImpl;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.AutoUtils.vision_handlers.vision_tests.CliTests;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.enums.ConfigSyncMode;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.configSync.ConfigSync;
import jsystem.extensions.analyzers.text.FindText;

import java.util.*;

/**
 * @author Hadar Elbaz
 */

public class VisionServer {

    public static final String SYSTEM_VISION_SERVER_SUB_MENU = "start                   Starts the APSolute Vision server.\n"
            + "status                  Shows the status of the APSolute Vision server.\n"
            + "stop                    Stops the APSolute Vision server.\n";


    //Starts the vision server services
    public static void visionServerStartAndVerify(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Starting Vision Server");
            InvokeUtils.invokeCommand(null, Menu.system().visionServer().start().build(), serverCli, 20 * 60 * 1000);

            long startTime = System.currentTimeMillis();
            while (System.currentTimeMillis() - startTime < 150 * 1000) {

                try {
                    if (VisionServer.isVisionServerRunningHA(serverCli))
                        return;
                    Thread.sleep(5 * 1000);
                } catch (Exception e) {
                    BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
                }
            }

            throw new Exception("there is one or more services are stopped");
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }


    }

    /**
     * Shows the status of the APSolute Vision server. startStop = start - Wait for: APSolute Vision Reporter Service is running ...
     * APSolute Vision Web Server is running... APSolute Vision Application Server is running... startStop = stop - Wait for: APSolute
     * Vision Reporter Service is stopped. APSolute Vision Web Server is stopped. APSolute Vision Application Server is stopped.
     *
     * @throws Exception - Generic exception
     */
    public static void visionServerStatus(StartStop startStop, RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Vision Server Status.");
            BaseTestUtils.reporter.report("Vision Server Status.");
            InvokeUtils.invokeCommand(null, Menu.system().visionServer().status().build(), serverCli);
            switch (startStop) {
                case START: {
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.REPORTER.getValue(), ServiceStatus.RUNNING.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.AMQP.getValue(),ServiceStatus.RUNNING.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.DPM.getValue(), ServiceStatus.RUNNING.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.CONFIGURATION.getValue(), ServiceStatus.RUNNING.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.COLLECTOR.getValue(), ServiceStatus.RUNNING.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.NEW_REPORTER.getValue(), ServiceStatus.RUNNING.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.ALERTS.getValue(), ServiceStatus.RUNNING.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.SCHEDULER.getValue(), ServiceStatus.RUNNING.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.CONFIGURATION_SYNC.getValue(), ServiceStatus.RUNNING.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.VDIRECT.getValue(), ServiceStatus.RUNNING.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.VRM_COLLECTOR.getValue(), ServiceStatus.STOPPED.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.VRM_VISUALIZATION.getValue(), ServiceStatus.STOPPED.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.LLS.getValue(), ServiceStatus.STOPPED.getStatus())));
                    //serverCli.analyze(new FindText("td-agent is runningG[  OK  ]"));
                    break;
                }
                case STOP: {
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.REPORTER.getValue(), ServiceStatus.STOPPED)));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.AMQP.getValue(), ServiceStatus.STOPPED.getStatus())));
                    //serverCli.analyze(new FindText("DPM is stopped."));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.CONFIGURATION.getValue(), ServiceStatus.STOPPED.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.COLLECTOR.getValue(), ServiceStatus.STOPPED.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.NEW_REPORTER.getValue(), ServiceStatus.STOPPED.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.ALERTS.getValue(), ServiceStatus.STOPPED.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.SCHEDULER.getValue(), ServiceStatus.STOPPED.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.CONFIGURATION_SYNC.getValue(), ServiceStatus.STOPPED.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.VDIRECT.getValue(), ServiceStatus.NOT_RUNNING.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.VRM_COLLECTOR.getValue(), ServiceStatus.STOPPED.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.VRM_VISUALIZATION.getValue(), ServiceStatus.STOPPED.getStatus())));
                    serverCli.analyze(new FindText(String.format("%s %s",
                            VisionServices.LLS.getValue(), ServiceStatus.STOPPED.getStatus())));
                    //serverCli.analyze(new FindText("td-agent is not runningG[FAILED]"));

                }
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static boolean isVisionReadyForUpgrade(CliConnectionImpl serverCli){
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

    public static boolean isVisionServerRunning(CliConnectionImpl serverCli) {
        try {
            serverCli.connect();
            InvokeUtils.invokeCommand(null, Menu.system().visionServer().status().build(), serverCli, 2 * 60 * 1000, true);
            String status = serverCli.getTestAgainstObject().toString();
            if (status == null) {
                return false;
            }

            boolean APSoluteVisionReporterStarted = status.contains(String.format("%s %s",
                    VisionServices.REPORTER.getValue(), ServiceStatus.RUNNING.getStatus()));
            boolean AMQPServerStarted = status.contains(String.format("%s %s",
                    VisionServices.AMQP.getValue(), ServiceStatus.RUNNING.getStatus()));
            boolean ConfigurationServerStarted = status.contains(String.format("%s %s",
                    VisionServices.CONFIGURATION.getValue(), ServiceStatus.RUNNING.getStatus()));
            boolean CollectorServerStarted = status.contains(String.format("%s %s",
                    VisionServices.COLLECTOR.getValue(), ServiceStatus.RUNNING.getStatus()));
            boolean RadwarevDirectServerStarted = status.contains(String.format("%s %s",
                    VisionServices.NEW_REPORTER.getValue(), ServiceStatus.RUNNING.getStatus()));
            boolean AlertsServerStarted = status.contains(String.format("%s %s",
                    VisionServices.ALERTS.getValue(), ServiceStatus.RUNNING.getStatus()));
            boolean SchedulerServerStarted = status.contains(String.format("%s %s",
                    VisionServices.SCHEDULER.getValue(), ServiceStatus.RUNNING.getStatus()));
            boolean ConfigurationSynchronizationServerStarted = status.contains(String.format("%s %s",
                    VisionServices.CONFIGURATION_SYNC.getValue(),ServiceStatus.RUNNING.getStatus()));
            boolean TorFeedServiceIsRunning = status.contains(String.format("%s %s",
                    VisionServices.TOR.getValue(), ServiceStatus.RUNNING.getStatus()));
            boolean NewReporterServerStarted = status.contains(String.format("%s %s",
                    VisionServices.VDIRECT.getValue(), ServiceStatus.RUNNING.getStatus()));
            boolean VRMCollectorIsRunning = status.contains(String.format("%s %s",
                    VisionServices.VRM_COLLECTOR.getValue(), ServiceStatus.STOPPED.getStatus()));
            boolean VRMVisualizationServiceIsRunning = status.contains(String.format("%s %s",
                    VisionServices.VRM_VISUALIZATION.getValue(), ServiceStatus.STOPPED.getStatus()));

            return APSoluteVisionReporterStarted &&
                    AMQPServerStarted &&
                    ConfigurationServerStarted &&
                    CollectorServerStarted &&
                    AlertsServerStarted &&
                    SchedulerServerStarted &&
                    ConfigurationSynchronizationServerStarted &&
                    NewReporterServerStarted &&
                    RadwarevDirectServerStarted &&
                    TorFeedServiceIsRunning &&
                    VRMCollectorIsRunning &&
                    VRMVisualizationServiceIsRunning;
            //&& TedAgentIsRunning;
        } catch (Exception e) {
            return false;
        }
    }


    //runs the command system vision-server status
    //checks if the there services are appropriate to the mode
    //the only service the does not matter is the dpm (because its a license)

    /**
     * runs the command system vision-server status
     * checks if the there services are appropriate to the mode
     * the only service the does not matter is the dpm (because its a license)
     *
     * @param serverCli Radware CLI object
     * @return true if all relevant services are up
     * @throws Exception Exception
     */
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

        InvokeUtils.invokeCommand(null, Menu.system().visionServer().status().build(), serverCli, 120 * 1000);
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

    //if all services stopped returns true else returns false
    private static boolean isAllServicesStopped(RadwareServerCli serverCli) throws Exception {

        //if true -->all services down
        boolean flag = false;
        //all service that are running will be add the this list
        List<String> runningServices = new ArrayList<>();
        if (!serverCli.isConnected()) {
            serverCli.connect();
        }

        BaseTestUtils.reporter.startLevel("Checking if all services are stopped");
        BaseTestUtils.reporter.report("Checking if all services are stopped");


        InvokeUtils.invokeCommand(null, Menu.system().visionServer().status().build(), serverCli);
        ArrayList<String> response = serverCli.getCmdOutput();
        for (String s : response) {
            if (s.contains("is running")) {
                runningServices.add(s);
            }
        }


        if (runningServices.size() == 0) {
            flag = true;
            BaseTestUtils.reporter.report("All services are down!");
        } else
            BaseTestUtils.reporter.report("Running Services: " + runningServices);


        return flag;
    }

    public static void visionServerStopAndVerify(RadwareServerCli serverCli) throws Exception {

        BaseTestUtils.reporter.startLevel("Stopping Vision Server");
        BaseTestUtils.reporter.report("Stopping Vision Server");
        InvokeUtils.invokeCommand(null, Menu.system().visionServer().stop().build(), serverCli, 10 * 60 * 1000);

        long startTime = System.currentTimeMillis();
        while (System.currentTimeMillis() - startTime < 30 * 1000) {

            try {
                if (VisionServer.isAllServicesStopped(serverCli))
                    break;
                Thread.sleep(5 * 1000);
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }

        if (!isAllServicesStopped(serverCli))
            throw new Exception("there is one or more services are running");


    }


    public static void visionServerReboot(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Stopping Vision Server");
            BaseTestUtils.reporter.report("Stopping Vision Server");
            InvokeUtils.invokeCommand(null, Menu.reboot().build(), serverCli, 5 * 1000);
            InvokeUtils.invokeCommand(null, "y", serverCli, CliTests.DEFAULT_TIME_WAIT_FOR_VISION_SERVICES_RESTART);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }


    public static boolean waitForVisionServerServicesToStart(CliConnectionImpl cliConnection, long timeout) throws Exception {
        long startTime = System.currentTimeMillis();
        do {
            if (VisionServer.isVisionServerRunning(cliConnection))
                return true;
            Thread.sleep(15 * 1000);
        }
        while (System.currentTimeMillis() - startTime < timeout);
        return false;
    }

    public static boolean waitForVisionServerServicesToStartHA(CliConnectionImpl cliConnection, long timeout) throws Exception {
        long startTime = System.currentTimeMillis();
        do {

            if (VisionServer.isVisionServerRunningHA((RadwareServerCli) cliConnection))
                return true;
            Thread.sleep(15 * 1000);
        }
        while (System.currentTimeMillis() - startTime < timeout);
        return false;
    }

    public static boolean waitForVisionServerReadinessForUpgrade(CliConnectionImpl cliConnection, long timeout) throws Exception {
        long startTime = System.currentTimeMillis();
        do {

            if (VisionServer.isVisionReadyForUpgrade((RadwareServerCli) cliConnection))
                return true;
            Thread.sleep(15 * 1000);
        }
        while (System.currentTimeMillis() - startTime < timeout);
        return false;
    }

    //runs command in the root--> vision service status
    //and returns /start/stop/other according to the result
    public static StartStop getApplicationServerStatus(RootServerCli rootServerCli) throws Exception {
        String status;
        StartStop startStop;

        rootServerCli.connect();
        try {
            InvokeUtils.invokeCommand("service vision status", rootServerCli);
            if (rootServerCli.getTestAgainstObject() == null) {
                throw new Exception("failed to run command : service vision status");
            }
            status = rootServerCli.getTestAgainstObject().toString();

            if (status.contains(ServiceStatus.RUNNING.getStatus()))
                startStop = StartStop.START;
            else if (status.contains(ServiceStatus.STOPPED.getStatus()))
                startStop = StartStop.STOP;
            else {
                startStop = StartStop.OTHER;
            }


        } catch (Exception e) {
            throw new Exception("Failed to run command in root: service vision status" + e.getMessage());
        }

        return startStop;
    }

    // return if the AVR service running or not.
    public static boolean isAVRServiceRunning(RadwareServerCli radwareCli) throws Exception {
        InvokeUtils.invokeCommand(null, Menu.system().visionServer().status().build(), radwareCli);
        return radwareCli.getOutputStr().contains("APSolute Vision Reporter is running");
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
        if(!lAddedServices.isEmpty() || !lRemovedServices.isEmpty())
            errorMessage = String.format("Service list was changed:\nNew line/s found: %s\nMissing service/s found: %s",
                    lAddedServices.toString(),lRemovedServices.toString());
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
