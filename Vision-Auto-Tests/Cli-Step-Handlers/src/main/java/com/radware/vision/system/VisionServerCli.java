package com.radware.vision.system;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import jsystem.framework.report.Reporter;

import static com.radware.vision.automation.Deploy.UvisionServer.UVISON_DEFAULT_SERVICES;
import static com.radware.vision.automation.Deploy.UvisionServer.isUvisionReady;


public class VisionServerCli {

    public static final String SYSTEM_VISION_SERVER_SUB_MENU = "start                   Starts the APSolute Vision server.\n"
            + "status                  Shows the status of the APSolute Vision server.\n"
            + "stop                    Stops the APSolute Vision server.\n";

    /**
     * Starts the APSolute Vision server. Set timeout for 4 minutes Wait for: Starting APSolute Vision Application Server: ..............[
     * OK ] Starting httpd: Starting Apsolute Vision Reporter Service: [ OK ] Starting APSolute Vision Web Server [ OK ]
     *
     * @throws Exception
     */
    public static void visionServerStart(RadwareServerCli serverCli, RootServerCli rootServerCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Starting Vision Server");
            BaseTestUtils.reporter.report("Starting Vision Server");
            CliOperations.runCommand(serverCli, Menu.system().visionServer().start().build(), 60 * 10 * 1000, false, true);
            if (serverCli.getTestAgainstObject().toString().contains("The APSolute Vision server is already started.")) {
                BaseTestUtils.reporter.report("Vision Server is already started", Reporter.PASS);
            } else {
                BaseTestUtils.report("Vision Server has started...", Reporter.PASS);
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }

    }

    /**
     * Shows the status of the APSolute Vision server. startStop = start - Wait for: APSolute Vision Reporter Service is running ...
     * APSolute Vision Web Server is running... APSolute Vision Application Server is running... startStop = stop - Wait for: APSolute
     * Vision Reporter Service is stopped. APSolute Vision Web Server is stopped. APSolute Vision Application Server is stopped.
     *
     * @throws Exception
     */

    public static boolean isVisionServerRunning(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Is Vision Server Running ?");
            return isUvisionReady(serverCli, UVISON_DEFAULT_SERVICES);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * Stops the APSolute Vision server. Set timeout for 5 minutes
     *
     * @throws Exception
     */
    public static void visionServerStop(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Stopping Vision Server");
            CliOperations.runCommand(serverCli, Menu.system().visionServer().stop().build(), 30 * 10 * 1000);
            if(!isVisionServerRunning(serverCli)){
                BaseTestUtils.reporter.report("Vision Server Is Stopped", Reporter.PASS);
            } else {
                BaseTestUtils.reporter.report("Vision Server Still Running", Reporter.FAIL);
            }
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static void visionServerReboot(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Stopping Vision Server");
            CliOperations.runCommand(serverCli, Menu.reboot().build(), 5 * 1000);
            CliOperations.runCommand(serverCli, "y", 5 * 60 * 1000);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

}

