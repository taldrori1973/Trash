package com.radware.vision.net;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.ParamsValidations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.StringParametersUtils;
import com.radware.vision.test_parameters.Duplex;
import com.radware.vision.test_parameters.OnOff;
import jsystem.extensions.analyzers.text.FindRegex;
import jsystem.extensions.analyzers.text.FindText;

import java.util.ArrayList;
import java.util.Arrays;

public class PhysicalInterface {

    public static final String NET_PHYSICAL_INTERFACE_SUB_MENU = "get                     Gets physical interface parameters.\n"
            + "set                     Sets physical interface parameters\n";

    /**
     * Gets physical network interface parameters. Verify all ports appear
     *
     * @throws Exception
     */
    public static void verifyPortsAppear(String[] ports, RadwareServerCli serverCli) throws Exception {

        BaseTestUtils.reporter.report("Verify Ports Appear");
        InvokeUtils.invokeCommand(null, Menu.net().physicalInterface().get().build(), serverCli);
        for (String port : ports) {
            serverCli.analyze(new FindText(port));
        }
        BaseTestUtils.reporter.stopLevel();
    }

    public static void netPhysicalInterfaceSubMenuTest(RadwareServerCli radwareServerCli) throws Exception {
        CliOperations.checkSubMenu(radwareServerCli, com.radware.vision.vision_project_cli.menu.Menu.net().physicalInterface().build(), PhysicalInterface.NET_PHYSICAL_INTERFACE_SUB_MENU);
    }

    /**
     * Sets physical network interface parameters (speed, duplex, autoneg)
     *
     * @param port    - the port to set (G1\G2\G3)
     * @param speed   - speed for port (10\100\1000Mb/s) if speed=-1 don't set speed
     * @param duplex  - (half\full)
     * @param autoneg - Auto Negotiation On\Off
     * @throws Exception
     */
    public static void netPhysicalInterfaceSet(String port, int speed, Duplex duplex, OnOff autoneg, RadwareServerCli serverCli)
            throws Exception {
        BaseTestUtils.reporter.report("Net Physical Interface Set");
        ParamsValidations.validateStringNotEmpty(port);
        if (speed != -1) {
            ParamsValidations.validateNumberValue(speed, new ArrayList<Integer>(Arrays.asList(10, 100, 1000)));
            String speedStr = String.valueOf(speed);
            String parameters = StringParametersUtils.stringArrayParamsToString(new String[]{port, "speed", speedStr});
            InvokeUtils.invokeCommand(null, Menu.net().physicalInterface().set().build() + parameters, serverCli);
        }
        if (duplex != null) {
            String duplexStr = duplex.duplex;
            String parameters = StringParametersUtils.stringArrayParamsToString(new String[]{port, "duplex", duplexStr});
            InvokeUtils.invokeCommand(null, Menu.net().physicalInterface().set().build() + parameters, serverCli);
        }
        if (autoneg != null) {
            String autonegStr = autoneg.onOff;
            String parameters = StringParametersUtils.stringArrayParamsToString(new String[]{port, "autoneg", autonegStr});
            InvokeUtils.invokeCommand(null, Menu.net().physicalInterface().set().build() + parameters, serverCli);
        }
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Gets physical network interface parameters. Verify all parameters for port
     *
     * @throws Exception
     */
    public static void verifyPortParameters(String port, int speed, Duplex duplex, OnOff autoneg, RadwareServerCli serverCli)
            throws Exception {
        BaseTestUtils.reporter.report("Verify Port Parameters");
        ParamsValidations.validateStringNotEmpty(port);
        InvokeUtils.invokeCommand(null, Menu.net().physicalInterface().get().build(), serverCli);
        if (speed != -1) {
            serverCli.analyze(new FindRegex(port + "\\s+" + String.valueOf(speed) + "Mb/s"));
        }
        if (duplex != null) {
            serverCli.analyze(new FindRegex(port + "\\s+\\d+Mb/s\\s+" + duplex.duplex, false));
        }
        if (autoneg != null) {
            serverCli.analyze(new FindRegex(port + "\\s+\\d+Mb/s\\s+(Full|Half)\\s+" + autoneg.onOff, false));
        }
        BaseTestUtils.reporter.stopLevel();
    }
}
