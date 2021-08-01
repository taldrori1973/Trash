package com.radware.vision.net;

import java.util.ArrayList;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.ParamsValidations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.RegexUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.utils.StringParametersUtils;
import com.radware.vision.root.RootVerifications;
import jsystem.extensions.analyzers.text.FindRegex;


import com.aqua.sysobj.conn.CliCommand;

/**
 * @author Hadar Elbaz
 */

public class Route {

    String netIp;
    String netMask;

    public static final String NET_ROUTE_SUB_MENU = "delete                  Removes a route entry or a default gateway.\n"
            + "get                     Displays route information.\n"
            + "set                     Sets a route entry or a default gateway.\n";

    public static final String NET_ROUTE_SET_SUB_MENU = "default                 Setss the default route.\n"
            + "host                    Sets a new host route\n"
            + "net                     Sets a new net route.\n";


    /**
     * net route get
     * Get the route table
     * Verify gateWay and iface for default
     *
     * @throws Exception
     */
    public static void verifyRouteDefault(String gateWay, String iface, RadwareServerCli serverCli) throws Exception {
        BaseTestUtils.reporter.report("Verify Route Default ");
        ParamsValidations.validateStringNotEmpty(gateWay);
        ParamsValidations.validateStringNotEmpty(iface);
        InvokeUtils.invokeCommand(null, Menu.net().route().get().build(), serverCli);
        serverCli.analyze(new FindRegex("0.0.0.0\\s+" + gateWay + "\\s+0.0.0.0\\s+UG\\s+0\\s+0\\s+0\\s+" + iface));
        BaseTestUtils.reporter.stopLevel();
    }


    /**
     * Verify route table values - not all parameters needs to be check
     * Use regular expression to include null inputs
     *
     * @throws Exception
     */
    public static void getRouteTable(String destination, String netMask, String gateWay, String iface, RadwareServerCli serverCli) throws Exception {
        BaseTestUtils.reporter.report("Get Route Table");
        if (destination == null) {
            destination = "\\d+\\.\\d+\\.\\d+\\.\\d+";
        }
        if (gateWay == null) {
            gateWay = "\\d+\\.\\d+\\.\\d+\\.\\d+";
        }
        if (netMask == null) {
            netMask = "\\d+\\.\\d+\\.\\d+\\.\\d+";
        }
        if (iface == null) {
            iface = "(G1|G2|G3)";
        }
        InvokeUtils.invokeCommand(null, Menu.net().route().get().build(), serverCli);
        serverCli.analyze(new FindRegex(destination + "\\s+" + gateWay + "\\s+" + netMask + "\\s+(UG|U|UGH)\\s+\\d+\\s+\\d+\\s+\\d+\\s+" + iface));
        BaseTestUtils.reporter.stopLevel();
    }

    public static void getRouteTableNotExist(String destination, String netMask, String gateWay, String iface, RadwareServerCli serverCli) throws Exception {
        BaseTestUtils.reporter.report("Get Route Table Not Exist");
        if (destination == null) {
            destination = "\\d+\\.\\d+\\.\\d+\\.\\d+";
        }
        if (gateWay == null) {
            gateWay = "\\d+\\.\\d+\\.\\d+\\.\\d+";
        }
        if (netMask == null) {
            netMask = "\\d+\\.\\d+\\.\\d+\\.\\d+";
        }
        if (iface == null) {
            iface = "(G1|G2|G3)";
        }
        InvokeUtils.invokeCommand(null, Menu.net().route().get().build(), serverCli);

        if (com.radware.vision.utils.RegexUtils.isStringContainsThePattern(destination + "\\s+" + gateWay + "\\s+" + netMask + "\\s+(UG|U|UGH)\\s+\\d+\\s+\\d+\\s+\\d+\\s+" + iface, serverCli.getTestAgainstObject().toString())) {
            throw new Exception(destination + " founded.");
        }
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * net route set net [Net IP] [Netmask] [Gateway IP] [G1|G2|G3]
     * Sets a new net route.
     *
     * @throws Exception
     */
    public static void setNewNetRoute(String newNetIp, String newNetMask, String newGateWay, String newIface, RadwareServerCli serverCli) throws Exception {
        BaseTestUtils.reporter.report("Set New Net Route");
        ParamsValidations.validateStringNotEmpty(newNetIp);
        ParamsValidations.validateStringNotEmpty(newNetMask);
        ParamsValidations.validateStringNotEmpty(newGateWay);
        if (newIface == null) {
            newIface = " ";
        }
        String sendParams = StringParametersUtils.stringArrayParamsToString(new String[]{newNetIp, newNetMask, newGateWay, newIface});
        InvokeUtils.invokeCommand(null, Menu.net().route().setNet().build() + sendParams, serverCli,
                CliOperations.DEFAULT_TIME_OUT, false, false, true, "Failed setting route");
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * net route set host [Net IP] [Gateway IP] [G1|G2|G3]
     * Sets a new net route.
     *
     * @throws Exception
     */
    public static void setRouteHost(String netIp, String gateWay, String iface, RadwareServerCli serverCli) throws Exception {
        BaseTestUtils.reporter.report("Set Route Host");
        ParamsValidations.validateStringNotEmpty(netIp);
        ParamsValidations.validateStringNotEmpty(gateWay);
        if (iface == null) {
            iface = " ";
        }
        String sendParams = StringParametersUtils.stringArrayParamsToString(new String[]{netIp, gateWay, iface});
        InvokeUtils.invokeCommand(null, Menu.net().route().setHost().build() + sendParams, serverCli,
                CliOperations.DEFAULT_TIME_OUT, false, false, true, "Failed setting route");
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Set route default ip
     *
     * @throws Exception
     */
    public static void setRouteDefault(String ip, RadwareServerCli serverCli) throws Exception {
        BaseTestUtils.reporter.report("Set Route Default : " + ip);
        ParamsValidations.validateStringNotEmpty(ip);
        InvokeUtils.invokeCommand(null, Menu.net().route().setDefault().build() + " " + ip, serverCli);
        BaseTestUtils.reporter.stopLevel();
    }


    public static void routeDelete(String netIp, String netMask, String gateWay, String iface, RadwareServerCli serverCli) throws Exception {
        routeDelete(netIp, netMask, gateWay, iface, serverCli, true);
    }

    /**
     * Removes a route entry or a default gateway.
     *
     * @throws Exception
     */
    public static void routeDelete(String netIp, String netMask, String gateWay, String iface, RadwareServerCli serverCli, boolean isneedToCheckTheOutput) throws Exception {
        BaseTestUtils.reporter.report("Route Delete");
        ParamsValidations.validateIpStructure(netIp);
        ParamsValidations.validateIpStructure(netMask);
        ParamsValidations.validateIpStructure(gateWay);
        if (iface == null) {
            iface = " ";
        }
        String sendParams = StringParametersUtils.stringArrayParamsToString(new String[]{netIp, netMask, gateWay, iface});
        if (isneedToCheckTheOutput) {
            InvokeUtils.invokeCommand(null, Menu.net().route().delete().build() + " " + sendParams, serverCli,
                    CliOperations.DEFAULT_TIME_OUT, false, false, true, "Failed deleting route");
        } else {
            InvokeUtils.invokeCommand(null, Menu.net().route().delete().build() + " " + sendParams, serverCli);
        }
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Get route table with radware user
     * Verify that each line in this table appears in root user table using the command 'route -n'
     *
     * @param serverCli      - radware user cli connection
     * @param userConnection
     * @throws Exception
     */
    public static void verifyRouteTableWithRootUser(RadwareServerCli serverCli, RootServerCli userConnection) throws Exception {
        BaseTestUtils.reporter.report("Verify Route Table With Root User");
        InvokeUtils.invokeCommand(null, Menu.net().route().get().build(), serverCli);
        String ipReg = "\\d+\\.\\d+\\.\\d+\\.\\d";
        String tableLinePattern = "(" + ipReg + "\\s+" + ipReg + "\\s+" + ipReg + "\\s+" + "(U|UG|UGH)\\s+\\d\\s+\\d\\s+\\d\\s+(G1|G2|G3))";
        ArrayList<String> linesArray = RegexUtils.fromStringToArrayWithPattern(tableLinePattern, serverCli.getTestAgainstObject().toString());
        for (String line : linesArray) {
            if (line != null) {
                RootVerifications.verifyLinuxOSParamsViaRootText("route -n", line, userConnection);
            }
        }
        BaseTestUtils.reporter.stopLevel();
    }


}

