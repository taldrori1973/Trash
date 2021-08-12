package com.radware.vision.system;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.ParamsValidations;
import jsystem.extensions.analyzers.text.FindRegex;
import utils.RegexUtils;

import java.util.ArrayList;

public class Version {
    
    /**
     * Get the server's version Verify version and build number
     *
     * @return
     * @throws Exception
     */
    public static void verifyServerVersion(String systemVersion, String systemBuild, RadwareServerCli serverCli, RootServerCli rootCli)
            throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Verify Server Version");
            ParamsValidations.validateStringNotEmpty(systemVersion);
            ParamsValidations.validateStringNotEmpty(systemBuild);
            CliOperations.runCommand(serverCli, Menu.system().version().build());
            serverCli.analyze(new FindRegex("APSolute Vision\\s+" + systemVersion + "\\s+\\(build " + systemBuild + "\\)"));
            serverCli.analyze(new FindRegex("AVR version:\\s+" + getAvrVersion(rootCli)));
            serverCli.analyze(new FindRegex("DPM version:\\s+" + getAvrVersion(rootCli)));
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static String getAvrVersion(RootServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Get Avr Version");
            CliOperations.runCommand(serverCli, "rpm -q avr");

            return serverCli.getCmdOutput().get(0);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static String getDpmVersion(RootServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Get Dpm Version");
            CliOperations.runCommand(serverCli, "more /opt/radware/novis/version.txt");

            return serverCli.getCmdOutput().get(0);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

    /**
     * Get the server's version return [systemVersion].[systemBuild]
     *
     * @throws Exception
     */
    public static String getServerVersion(RadwareServerCli serverCli) throws Exception {
        try {
            BaseTestUtils.reporter.startLevel("Get Server Version");
            CliOperations.runCommand(serverCli, Menu.system().version().build());
            String pattern = "APSolute Vision (\\d+\\.\\d+\\.\\d+) \\(build (\\d+)\\)";
            ArrayList<String> groups = RegexUtils.getGroupsWithPattern(pattern, serverCli.getTestAgainstObject().toString());
            return groups.get(0) + "." + groups.get(1);
        } finally {
            BaseTestUtils.reporter.stopLevel();
        }
    }

}
