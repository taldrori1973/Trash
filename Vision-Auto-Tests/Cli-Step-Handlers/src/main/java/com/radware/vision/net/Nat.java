package com.radware.vision.net;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import jsystem.extensions.analyzers.text.FindRegex;
import jsystem.extensions.analyzers.text.FindText;

public class Nat {

    public static final String NET_NAT_SUB_MENU = "get                     Gets the NAT-host configuration for the server.\n"
            + "set                     Sets the NAT-host configuration for the server.\n";

    public static final String NET_NAT_SET_SUB_MENU = "hostname                Sets the NAT hostname for the APSolute Vision server.\n"
            + "ip                      Sets the NAT IP address for the APSolute Vision server.\n"
            + "none                    Removing server NAT configuration.\n";


    /**
     * net nat set ip "Ip Number"
     * restarting the server if there is a need
     */
    public static void netNatSetIp(String ip, RadwareServerCli radwareServerCli) throws Exception {

        BaseTestUtils.reporter.startLevel("Net Nat Set Ip " + ip);
        InvokeUtils.invokeCommand(null, Menu.net().nat().setIp().build() + " " + ip, radwareServerCli);
        radwareServerCli.analyze(new FindText("The server will be accessible to clients using the IP address <" + ip + ">"));
        InvokeUtils.invokeCommand(null, "y", radwareServerCli, 5 * 60 * 1000);
        radwareServerCli.analyze(new FindRegex("Starting APSolute Vision Application Server:(\\.*\\s*)*G\\[  OK  \\]|\\[FAILED\\]"));
        BaseTestUtils.reporter.stopLevel();
    }


    /**
     * net nat set none
     * restarting the server if there is a need
     */
    public static void netNatSetNone(RadwareServerCli radwareServerCli) throws Exception {

        BaseTestUtils.reporter.startLevel("Net Nat Set None");
        InvokeUtils.invokeCommand(null, Menu.net().nat().setNone().build(), radwareServerCli);
        radwareServerCli.analyze(new FindText("The server will be accessible to clients only using the internal Management IP address."));
        InvokeUtils.invokeCommand(null, "y", radwareServerCli, 5 * 60 * 1000);
        radwareServerCli.analyze(new FindRegex("Starting APSolute Vision Application Server:(\\.*\\s*)*G\\[  OK  \\]|\\[FAILED\\]"));
        BaseTestUtils.reporter.stopLevel();
    }


    /**
     * net nat set get
     */
    public static void netNatGet(String wantedOutput, RadwareServerCli radwareServerCli) throws Exception {
        BaseTestUtils.reporter.startLevel("Net Nat Get " + wantedOutput);
        InvokeUtils.invokeCommand(null, Menu.net().nat().get().build(), radwareServerCli);
        radwareServerCli.analyze(new FindText(wantedOutput));
        BaseTestUtils.reporter.stopLevel();
    }


    /**
     * net nat set set
     */
    public static void netNatSetSubMenuCheck(RadwareServerCli radwareServerCli) throws Exception {
        CliOperations.checkSubMenu(radwareServerCli, Menu.net().nat().set().build(), NET_NAT_SET_SUB_MENU);
    }


    /**
     * net nat set hostname natAutomationTest
     */
    public static void netNatSetHostName(String hostName, RadwareServerCli radwareServerCli) throws Exception {
        BaseTestUtils.reporter.startLevel("Net Nat Set Host Name" + hostName);
        InvokeUtils.invokeCommand(null, Menu.net().nat().setHostName().build() + " " + hostName, radwareServerCli);
        radwareServerCli.analyze(new FindText("The server will be accessible to clients using the hostname " + hostName));
        InvokeUtils.invokeCommand(null, "y", radwareServerCli, 5 * 60 * 1000);
        radwareServerCli.analyze(new FindRegex("Starting APSolute Vision Application Server:(\\.*\\s*)*G\\[  OK  \\]|\\[FAILED\\]"));
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * net nat set none
     */
    public static void netNatSubMenuCheck(RadwareServerCli radwareServer) throws Exception {

        CliOperations.checkSubMenu(radwareServer, Menu.net().nat().build(), NET_NAT_SUB_MENU);
    }


}
