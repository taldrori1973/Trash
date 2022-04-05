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
        CliOperations.runCommand(radwareServerCli, Menu.net().nat().setIp().build() + " " + ip, 6 * 1000, false, false, false);
        boolean info1 = radwareServerCli.isAnalyzeSuccess(new FindText("The server will be accessible to clients using the IP address <" + ip + ">"));
        CliOperations.runCommand(radwareServerCli, "y", 5 * 60 * 1000);
        BaseTestUtils.reporter.stopLevel();
    }


    /**
     * net nat set none
     * restarting the server if there is a need
     */
    public static void netNatSetNone(RadwareServerCli radwareServerCli) throws Exception {

        BaseTestUtils.reporter.startLevel("Net Nat Set None");
        CliOperations.runCommand(radwareServerCli, Menu.net().nat().setNone().build(), 6 * 1000, false, false, false);
        radwareServerCli.isAnalyzeSuccess(new FindText("The server will be accessible to clients only using the internal Management IP address."));
        CliOperations.runCommand(radwareServerCli, "y", 5 * 60 * 1000);
        BaseTestUtils.reporter.stopLevel();
    }


    /**
     * net nat set get
     */
    public static void netNatGet(String wantedOutput, RadwareServerCli radwareServerCli) throws Exception {
        BaseTestUtils.reporter.startLevel("Net Nat Get " + wantedOutput);
        CliOperations.runCommand(radwareServerCli, Menu.net().nat().get().build());
        radwareServerCli.isAnalyzeSuccess(new FindText(wantedOutput));
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
        CliOperations.runCommand(radwareServerCli, Menu.net().nat().setHostName().build() + " " + hostName, 6 * 1000, false, false, false);
        radwareServerCli.isAnalyzeSuccess(new FindText("The server will be accessible to clients using the hostname " + hostName));
        CliOperations.runCommand(radwareServerCli, "y", 5 * 60 * 1000);
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * net nat set none
     */
    public static void netNatSubMenuCheck(RadwareServerCli radwareServer) throws Exception {

        CliOperations.checkSubMenu(radwareServer, Menu.net().nat().build(), NET_NAT_SUB_MENU);
    }


}
