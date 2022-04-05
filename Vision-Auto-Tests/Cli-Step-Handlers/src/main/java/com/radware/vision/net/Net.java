package com.radware.vision.net;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;

public class Net {

    public static final String NET_SUB_MENU = "dns                     DNS parameters.\n"
            + "firewall                Firewall parameters.\n"
            + "ip                      IP address configuration.\n"
            + "nat                     Configures the NAT settings for client-server access.\n"
            + "physical-interface      Physical interface parameters.\n"
            + "route                   Routing parameters.\n";


    /**
     * net - verify the answer
     */
    public static void netSubMenuCheck(RadwareServerCli radwareServer) throws Exception {
        CliOperations.checkSubMenu(radwareServer, Menu.net().build(), NET_SUB_MENU);
    }
}
