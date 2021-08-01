package com.radware.vision.net;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.test_utils.StringParametersUtils;
import com.radware.automation.tools.utils.InvokeUtils;
import jsystem.extensions.analyzers.text.FindRegex;

import java.util.Arrays;

/**
 *
 * @author Hadar Elbaz
 */

public class Ip {

    public static final String NET_IP_MANAGEMENT_SUB_MENU = "set                     Sets the management interface of the device.\n";

    public static final String NET_IP_SUB_MENU = "delete                  Deletes an IP address entry.\n"
            + "get                     Displays network interface information.\n"
            + "management              Management device configuration.\n" + "set                     Creates an IP address entry.\n";

    /**
     * Get the server IP Verify port name, ip address, mask and if active
     *
     * @throws Exception - Generic Exception object
     */
    public static void getNetIp(String IpAddress, String netMask, String iface, boolean mgmtActive, RadwareServerCli baseServer)
            throws Exception {

        BaseTestUtils.reporter.startLevel("Get Net Ip ");
        InvokeUtils.invokeCommand(Menu.net().ip().get().build(), baseServer);
        if (mgmtActive) {
            baseServer.analyze(new FindRegex(iface + "\\s+\\*\\s+" + IpAddress + "\\s+" + netMask));
        } else {
            baseServer.analyze(new FindRegex(iface + "\\s+" + IpAddress + "\\s+" + netMask));
        }
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Set new IP Verify IP set succeeded
     *
     * @throws Exception - Generic Exception object
     */
    public static void setNetIp(String IpAddress, String netMask, String iface, RadwareServerCli radwareServerCli) throws Exception {

        BaseTestUtils.reporter.startLevel("Set Net Ip " + Arrays.toString(new String[]{IpAddress, netMask, iface}));
        String sendParams = StringParametersUtils.stringArrayParamsToString(new String[] { IpAddress, netMask, iface });
        CliOperations.runCommand(radwareServerCli, Menu.net().ip().set().build() + sendParams,  CliOperations.DEFAULT_TIME_OUT, false,
                false, true, "Failed setting IP Address");
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Delete ip interface, confirm with y
     *
     * @param iFace - interface to delete
     * @throws Exception - Generic Exception object
     */
    public static void ipDelete(String iFace, RadwareServerCli radwareServerCli) throws Exception {
        BaseTestUtils.reporter.startLevel("Ip Delete "+ iFace);
        CliOperations.runCommand(radwareServerCli, Menu.net().ip().delete().build() + " " + iFace, CliOperations.DEFAULT_TIME_OUT, true, true);
        CliOperations.runCommand(radwareServerCli, "y");
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Sets the management interface of the device. press y for approval and set timeout to 5 minutes
     *
     * @param iface
     *            - interface (G1\G2\G3)
     * @throws Exception - Generic Exception object
     */
    public static void managementSet(String iface, RadwareServerCli radwareServerCli) throws Exception {
        BaseTestUtils.reporter.startLevel("Management Set " + iface);
        //todo: set ignoreErrors back to false when DE67231 is resolved
        CliOperations.runCommand(radwareServerCli, Menu.net().ip().managementSet().build() + " " + iface, CliOperations.DEFAULT_TIME_OUT, true, true);
        CliOperations.runCommand(radwareServerCli, "y", CliOperations.DEFAULT_TIME_OUT);
        BaseTestUtils.reporter.stopLevel();
    }

}

