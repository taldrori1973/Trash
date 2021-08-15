package com.radware.vision.system;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.Deploy.UvisionServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import jsystem.extensions.analyzers.text.FindRegex;
import jsystem.extensions.analyzers.text.FindText;

import java.util.HashMap;

public class Database {

    public static final String SYSTEM_DATABASE_MAINTENANCE_SUB_MENU = "check                   Checks whether the database needs optimization.\n"
            + "driver_table            Database maintenance commands for the driver_table.\n"
            + "optimize                Optimizes the relevant tables.\n";

    public static final String SYSTEM_DATABASE_MAINTENANCE_DRIVER_TABLE_SUB_MENU = "delete                  Deletes all device drivers from the system.\n";

    public static final String SYSTEM_DATABASE_SUB_MENU = "access                  Manages the list of viewers of database tables.\n" +
            "clear                   Clears the database.\n" +
            "maintenance             Database maintenance commands.\n" +
            "start                   Starts the database service.\n" +
            "status                  Shows the status of the database service.\n" +
            "stop                    Stops the database service.\n";


    /**
     * Starts the db server. Set timeout for 4 minutes Wait for: Starting MySQL.. SUCCESS!
     *
     * @throws Exception
     */
    public static void startDBServer(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Starting db Server");
            CliOperations.runCommand(serverCli, Menu.system().database().start().build(), 60 * 4 * 1000);
            if (!serverCli.getTestAgainstObject().toString().contains("DB service is up already.")) {
                serverCli.analyze(new FindRegex("Starting kvision-infra-mariadb"));
                serverCli.analyze(new FindRegex("Starting kvision-infra-efk"));
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * try to stop the db Vision server.
     *
     * @throws Exception
     */
    public static void stopDBServer(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("stopping db Server");
            CliOperations.runCommand(serverCli, Menu.system().database().stop().build());
            if (!serverCli.getTestAgainstObject().toString().contains("DB service is down already.")) {
                serverCli.analyze(new FindRegex("Stopping DB."));
            }

        } finally {
            BaseTestUtils.reporter.stopLevel();
        }

    }

    /**
     * Shows the status of the db Vision server
     *
     * @throws Exception
     */
    public static void validateDBServicesStatus(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Db Server Status");
            //todo: kvision change to system database status when it's available
            CliOperations.runCommand(serverCli, Menu.system().visionServer().status().build());
            HashMap<UvisionServer.DockerServices, UvisionServer.DockerServiceStatus> databaseServices = new HashMap<>();
            UvisionServer.DockerServiceStatus upAndHealthy = new UvisionServer.DockerServiceStatus(UvisionServer.DockerState.UP, UvisionServer.DockerHealthState.HEALTHY);
            databaseServices.put(UvisionServer.DockerServices.CONFIG_KVISION_INFRA_MARIADB, upAndHealthy);
            databaseServices.put(UvisionServer.DockerServices.CONFIG_KVISION_INFRA_EFK, upAndHealthy);
            UvisionServer.waitForUvisionServerServicesStatus(serverCli, databaseServices, 30 * 1000);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static boolean isDBServicesRunning(RadwareServerCli radwareServerCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Db Server Status");
            boolean mariaDB = UvisionServer.isServiceReady(radwareServerCli, UvisionServer.DockerServices.CONFIG_KVISION_INFRA_MARIADB);
            boolean elasticSearch = UvisionServer.isServiceReady(radwareServerCli, UvisionServer.DockerServices.CONFIG_KVISION_INFRA_EFK);
            return mariaDB && elasticSearch;
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * Execute the CMD (takes 2 min): system database maintenance driver_table deleteExecute the CMD (takes 2 min): system database
     * maintenance driver_table deleteExecute the CMD (takes 2 min): system database maintenance driver_table delete Clears the vision
     * server database
     *
     * @throws Exception
     */
    public static void systemDBClear(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("system DB Clear");
            CliOperations.runCommand(serverCli, Menu.system().database().clear().build(), 3 * 60 * 1000);
            if (serverCli.getTestAgainstObject().toString().contains("Restart Vision server?")
                    || serverCli.getTestAgainstObject().toString().contains("Continue ?")) {
                CliOperations.runCommand(serverCli, "y", 6 * 60 * 1000);
            }
            serverCli.analyze(new FindText("Database cleared successfully."));
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * Optimizes the relevant tables.
     *
     * @throws Exception
     */
    public static void setDatabaseMaintenanceOptimize(RadwareServerCli serverCli) throws Exception {
        CliOperations.runCommand(serverCli, Menu.system().database().maintenance().optimize().build());
    }

    /**
     * Shows the Device Performance Monitor version and verify with user input
     *
     * @param ip
     * @throws Exception
     */
    public static void setDBAccessWithIp(String ip, RadwareServerCli serverCli) throws Exception {
        CliOperations.runCommand(serverCli, Menu.system().database().access().grant().build() + " " + ip);
    }

    /**
     * system database maintenance driver_table delete DataBase with 2 minutes timeout exception
     */
    public static void systemDBMaintenanceDriverTableDelete(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("System DB Maintenance Driver Table Delete");
            CliOperations.runCommand(serverCli, Menu.system().database().maintenance().driver_table().delete().build(),
                    2 * 60 * 1000);
            CliOperations.runCommand(serverCli, "y", 5 * 60 * 1000);
            serverCli.analyze(new FindRegex("Starting APSolute Vision Application Server:(\\.*\\s*)*G\\[  OK  \\]|\\[FAILED\\]"));
            serverCli.analyze(new FindRegex("You can access Vision Server via (\\d*\\.*\\d*\\.*\\d*\\.*\\d*)"));
            //serverCli.analyze(new FindText("Reloading httpd:"));
            serverCli.analyze(new FindRegex("Starting Apsolute Vision Reporter Service:\\s*G\\[  OK  \\]"));
            serverCli.analyze(new FindRegex("Starting APSolute Vision Web Server\\s*G\\[  OK  \\]"));
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * Run system database access grant without given ip and ignore errors Expect to receive ERROR: Host IP not specified since no ip is
     * configured
     */
    public static void systemDBAccessGrantWithoutIp(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("System DB Access Grant Without Ip");
            CliOperations.runCommand(serverCli, Menu.system().database().access().grant().build(), CliOperations.DEFAULT_TIME_OUT,
                    true);
            if (!serverCli.getTestAgainstObject().toString().contains("ERROR: Host IP not specified")) {
                throw new Exception("'ERROR: Host IP not specified' message is missing");
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }

    }

    /**
     * Run system database access grant with ip
     */
    public static void systemDBAccessGrantWithIp(String ip, RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("System DB Access Grant With Ip : " + ip);
            CliOperations.runCommand(serverCli, Menu.system().database().access().grant().build() + " " + ip);
            serverCli.analyze(new FindText("The IP address " + ip + " was added to the database-viewer list."));
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * Run system database access revoke with ip
     */
    public static void systemDBRemoveAccessIp(String ip, RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("System DB Remove Access Ip : " + ip);
            CliOperations.runCommand(serverCli, Menu.system().database().access().revoke().build() + " " + ip);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * Run system database access display return true if ip is found, false if not
     */
    public static boolean verifyIpAccessToDB(String ip, RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Verify Ip Access To DB" + ip);
            CliOperations.runCommand(serverCli, Menu.system().database().access().display().build());
            if (serverCli.getTestAgainstObject().toString().contains(ip)) {
                return true;
            }
            return false;
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * Verify correct view for the external viewer user
     * @throws Exception
     */

}
