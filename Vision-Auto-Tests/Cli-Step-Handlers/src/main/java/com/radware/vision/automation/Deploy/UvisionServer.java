package com.radware.vision.automation.Deploy;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import jsystem.framework.report.Reporter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UvisionServer {
    /**
     * The default services and their status.
     * To be used after fresh install, upgrade or restart/boot
     */
    public static final HashMap<DockerServices, DockerServiceStatus> UVISON_DEFAULT_SERVICES = new HashMap<DockerServices, DockerServiceStatus>() {{
        put(DockerServices.CONFIG_KVISION_DC_NGINX, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_FORMATTER, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_RT_ALERT, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_REPORTER, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_COLLECTOR, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_VRM, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_CONFIG_SYNC_SERVICE, new DockerServiceStatus(DockerState.UP, DockerHealthState.NONE));
        put(DockerServices.CONFIG_KVISION_VDIRECT, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_SCHEDULER, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_TOR_FEED, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_CONFIGURATION_SERVICE, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_ALERTS, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_LLS, new DockerServiceStatus(DockerState.UP, DockerHealthState.NONE));
        put(DockerServices.CONFIG_KVISION_TED, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_HELP, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_INFRA_EFK, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_WEBUI, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_INFRA_MARIADB, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_INFRA_AUTOHEAL, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
        put(DockerServices.CONFIG_KVISION_INFRA_IPV6NAT, new DockerServiceStatus(DockerState.UP, DockerHealthState.NONE));
        put(DockerServices.CONFIG_KVISION_INFRA_RABBITMQ, new DockerServiceStatus(DockerState.UP, DockerHealthState.NONE));
        put(DockerServices.CONFIG_KVISION_INFRA_FLUENTD, new DockerServiceStatus(DockerState.UP, DockerHealthState.NONE));
    }};

    /**
     * Docker state and Health state
     */
    public static class DockerServiceStatus {
        private final DockerState dockerState;
        private final DockerHealthState dockerHealthState;

        public DockerState getDockerState() {
            return dockerState;
        }

        public DockerHealthState getDockerHealthState() {
            return dockerHealthState;
        }

        public DockerServiceStatus(DockerState state, DockerHealthState healthState) {
            this.dockerState = state;
            this.dockerHealthState = healthState;
        }
    }

    /**
     * UP or DOWN
     */
    public enum DockerState {

        UP("Up"),
        DOWN("Down");

        private final String state;

        DockerState(String state) {
            this.state = state;
        }

        private String getState() {
            return this.state;
        }

    }

    /**
     * start or stop or restart
     */
    public enum DockerServiceAction {

        START("start"),
        STOP("stop"),
        RESTART("restart");

        private final String action;

        DockerServiceAction(String state) {
            this.action = state;
        }

        private String getState() {
            return this.action;
        }

    }

    /**
     * Healthy, Unhealthy, Starting
     */
    public enum DockerHealthState {
        HEALTHY("healthy"),
        UNHEALTHY("unhealthy"),
        STARTING("health: starting"),
        NONE("");
        private final String state;

        DockerHealthState(String state) {
            this.state = state;
        }

        private String getState() {
            return this.state;
        }
    }

    /**
     * Services list
     */
    public enum DockerServices {
        CONFIG_KVISION_DC_NGINX("config_kvision-dc-nginx"),
        CONFIG_KVISION_FORMATTER("config_kvision-formatter"),
        CONFIG_KVISION_RT_ALERT("config_kvision-rt-alert"),
        CONFIG_KVISION_REPORTER("config_kvision-reporter"),
        CONFIG_KVISION_COLLECTOR("config_kvision-collector"),
        CONFIG_KVISION_VRM("config_kvision-vrm"),
        CONFIG_KVISION_ALERTS("config_kvision-alerts"),
        CONFIG_KVISION_CONFIGURATION_SERVICE("config_kvision-configuration-service"),
        CONFIG_KVISION_SCHEDULER("config_kvision-scheduler"),
        CONFIG_KVISION_TOR_FEED("config_kvision-tor-feed"),
        CONFIG_KVISION_CONFIG_SYNC_SERVICE("config_kvision-config-sync-service"),
        CONFIG_KVISION_VDIRECT("config_kvision-vdirect"),
        CONFIG_KVISION_INFRA_AVR("config_kvision-infra-avr"),
        CONFIG_KVISION_INFRA_EFK("config_kvision-infra-efk"),
        CONFIG_KVISION_HELP("config_kvision-help"),
        CONFIG_KVISION_LLS("config_kvision-lls"),
        CONFIG_KVISION_INFRA_RABBITMQ("config_kvision-infra-rabbitmq"),
        CONFIG_KVISION_INFRA_IPV6NAT("config_kvision-infra-ipv6nat"),
        CONFIG_KVISION_TED("config_kvision-ted"),
        CONFIG_KVISION_INFRA_FLUENTD("config_kvision-infra-fluentd"),
        CONFIG_KVISION_INFRA_MARIADB("config_kvision-infra-mariadb"),
        CONFIG_KVISION_INFRA_AUTOHEAL("config_kvision-infra-autoheal"),
        CONFIG_KVISION_WEBUI("config_kvision-webui"),
        PROCESS_EXPORTER("process-exporter"),
        PROMETHEUS("prometheus"),
        GRAFANA("grafana"),
        ES_EXPORTER("es-exporter"),
        MYSQK_EXPORTER("mysql-exporter"),
        NODE_EXPORTER("node-exporter");

        private final String dockerService;

        DockerServices(String Service) {
            this.dockerService = Service;
        }

        private String getService() {
            return this.dockerService;
        }
    }

    /**
     * Validate list of services to validate their state
     *
     * @param radwareServerCli - RadwareServerCli object
     * @param servicesMap      - map of all the services to validate
     * @return - true if all as expected else false
     */
    public static boolean isUvisionReady(RadwareServerCli radwareServerCli, HashMap<DockerServices, DockerServiceStatus> servicesMap) {
        CliOperations.runCommand(radwareServerCli, Menu.system().visionServer().status().build(), 120 * 1000);
        ArrayList<String> response = radwareServerCli.getCmdOutput();

        final boolean[] stat = {true};

        servicesMap.forEach((k, v) -> {
                    stat[0] = stat[0] & isServiceReady(response, k, v);
                }
        );
        return stat[0];
    }

    public static boolean isServiceReady(RadwareServerCli radwareServerCli, DockerServices dockerService) {
        CliOperations.runCommand(radwareServerCli, Menu.system().visionServer().status().build(), 120 * 1000);
        return isServiceReady(radwareServerCli.getCmdOutput(), dockerService, new DockerServiceStatus(DockerState.UP, DockerHealthState.HEALTHY));
    }

    /**
     * Validate a service status
     *
     * @param response            - Output of "system vision-server status"
     * @param dockerService       - Service to validate
     * @param dockerServiceStatus - Service expected status
     * @return True if match else false
     */
    public static boolean isServiceReady(ArrayList<String> response, DockerServices dockerService,
                                         DockerServiceStatus dockerServiceStatus) {
        boolean status = false;
        String patternStr = dockerServiceStatus.dockerState.getState();
        String line = response.stream().filter(c -> c.contains(dockerService.getService())).findFirst().orElse(null);
        if (line == null) {
            BaseTestUtils.reportInfoMessage("Service: " + dockerService.getService() + " was not found in output:\n" + response);
            return false;
        }
        try {
            Matcher matcher = Pattern.compile(patternStr).matcher(line);
            while (matcher.find()) {
                patternStr = dockerServiceStatus.dockerHealthState.getState();
                matcher = Pattern.compile(patternStr).matcher(line);
                while (matcher.find()) {
                    status = true;
                }
            }
            if (!status) {
                String message = String.format("Service: %s, expected to have %s-%s. actual: %s",
                        dockerService.getService(), dockerServiceStatus.getDockerState(),
                        dockerServiceStatus.getDockerHealthState(), line);
                BaseTestUtils.reportInfoMessage(message);

            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
        return status;
    }

    /**
     * Check services status till timeout
     *
     * @param radwareServerCli - RadwareServerCli object
     * @param sevicesMap       - Map of all services to validate
     * @param timeout          - timeout in seconds
     */
    public static void waitForUvisionServerServicesStatus(RadwareServerCli radwareServerCli, HashMap<DockerServices, DockerServiceStatus> sevicesMap, long timeout) {
        timeout = timeout * 1000;
        long startTime = System.currentTimeMillis();
        do {

            if (isUvisionReady(radwareServerCli, sevicesMap)) {
                BaseTestUtils.reportInfoMessage("All services are up: UVISION is ready");
                return;
            }
            try {
                Thread.sleep(15 * 1000);
            } catch (InterruptedException e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }
        while (System.currentTimeMillis() - startTime < timeout);
        BaseTestUtils.report("Not all services are up till timeout", Reporter.FAIL);
    }

    //todo: kvision maybe temporary WA for internal docker network
    public static void modifyDockerNetwork(RootServerCli rootServerCli) {
        try {
            CliOperations.runCommand(rootServerCli, "cd /deploy/config");
            CliOperations.runCommand(rootServerCli, "docker-compose stop", 60 * 1000);
            CliOperations.runCommand(rootServerCli, "wget -O /etc/docker/daemon.json ftp://radware:radware@172.17.164.10://home/radware/ftp/daemon.json");
            CliOperations.runCommand(rootServerCli, "service docker restart");
            CliOperations.runCommand(rootServerCli, "docker-compose up -d");
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    public static void doActionForService(RootServerCli rootServerCli, String service, DockerServiceAction dockerServiceAction)
    {
        StringBuilder command = new StringBuilder();
        command.append("docker ").append(dockerServiceAction.action).append(" ").append(service);
        CliOperations.runCommand(rootServerCli, command.toString(), 120 * 1000);
        ArrayList<String> response = rootServerCli.getCmdOutput();

        if(response.stream().filter(a->a.contains(service)).count() != 1)
            BaseTestUtils.report("Test ERROR", Reporter.FAIL);
    }

}
