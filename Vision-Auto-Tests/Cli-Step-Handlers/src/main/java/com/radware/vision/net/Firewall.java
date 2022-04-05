package com.radware.vision.net;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import jsystem.extensions.analyzers.text.FindText;
import jsystem.framework.report.Reporter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Firewall {

    public final static String FIREWALL_SUBMENU = "open-port               Firewall open port parameters.\n";

    public final static String FIREWALL_OPENPORT_SUBMENU = "list                    Lists the currently open TCP ports in the firewall.\n" +
            "set                     Opens or closes the specified TCP port in the firewall.\n";

    public final static String FIREWALL_OPEN_PORT_LIST = "Type            Port" + "\n" +
            "tcp             631" + "\n" +
            "tcp             22" + "\n" +
            "tcp             80" + "\n" +
            "tcp             443" + "\n" +
            "tcp             9216" + "\n" +
            "tcp             2214" + "\n" +
            "tcp             9443" + "\n";

    public static void checkFirewallSubmenu(RadwareServerCli radwareServerCli) throws Exception {
        CliOperations.checkSubMenu(radwareServerCli, Menu.net().firewall().build(), FIREWALL_SUBMENU);
    }

    public static void checkFirewallOpenPortSubmenu(RadwareServerCli radwareServerCli) throws Exception {
        CliOperations.checkSubMenu(radwareServerCli, Menu.net().firewall().openport().build(), FIREWALL_OPENPORT_SUBMENU);
    }

    public static void checkFirewallOpenPortListDefaults(RadwareServerCli radwareServerCli) throws Exception {
        CliOperations.checkSubMenu(radwareServerCli, Menu.net().firewall().openport().list().build(), FIREWALL_OPEN_PORT_LIST);
    }


    public static void checkFirewallOpenPortSetOpen(RadwareServerCli radwareServerCli, RootServerCli rootServerCli) throws Exception {
        String addedport = "9999";
        boolean isSuccess = false;
        int numOfRetries = 10;
        try {
            BaseTestUtils.reporter.startLevel("net firewall open-port set open");
            while (!isSuccess && numOfRetries > 0) {
                InvokeUtils.invokeCommand(null, Menu.net().firewall().openport().set().build() + " " + addedport + " " + "open", radwareServerCli, 20 * 1000);
                boolean isFinished = true;
                if (radwareServerCli.isAnalyzeSuccess(new FindText("This port already open in the firewall"))) {
                    addedport = String.valueOf(Integer.parseInt(addedport) + 1);
                    isFinished = false;
                    numOfRetries--;
                }
                if (!isSpecificPortOpen(listPorts(radwareServerCli), addedport) && isFinished) {
                    BaseTestUtils.reporter.report("Port: " + addedport, Reporter.FAIL);
                    break;
                }
                isSuccess = isFinished;
            }
        } finally {
            //Verify rule exist in iptables
            CliOperations.runCommand(rootServerCli, "iptables -L | grep " + addedport + " | awk '{print $7}' | head -1 " );
            CliOperations.verifyLastOutputByRegex("dpt:" + addedport);
            InvokeUtils.invokeCommand(null, Menu.net().firewall().openport().set().build() + " " + addedport + " " + "close", radwareServerCli, 20 * 1000);
            if (isSpecificPortOpen(listPorts(radwareServerCli), addedport)) {
                BaseTestUtils.reporter.report("Port: " + addedport, Reporter.FAIL);
            }
            BaseTestUtils.reporter.stopLevel();
        }

    }

    public static void checkFirewallOpenPortSetClose(RadwareServerCli radwareServerCli, RootServerCli rootServerCli) throws Exception {
        String addedport = "9999";
        InvokeUtils.invokeCommand(null, Menu.net().firewall().openport().set().build() + " " + addedport + " " + "close", radwareServerCli, 20 * 1000);
        if (radwareServerCli.isAnalyzeSuccess(new FindText("This port already open in the firewall"))) {
            BaseTestUtils.reporter.report("Port: " + addedport + " already exists", Reporter.FAIL);
        }
        if (isSpecificPortOpen(listPorts(radwareServerCli), addedport)) {
            BaseTestUtils.reporter.report("Port: " + addedport + " was not closed properly", Reporter.FAIL);
        }
        // Remove the added port
        // String deleteCommand =
        // "iptables -D  RH-Firewall-1-INPUT -p tcp -m tcp --sport 1024:65535 --dport "
        // + addedport + " -m state --state NEW -j ACCEPT";
        // InvokeUtils.invokeCommand(null, deleteCommand, rootServerCli, 3 * 1000);
        InvokeUtils.invokeCommand(null, Menu.net().firewall().openport().set().build() + " " + addedport + " open", radwareServerCli, 20 * 1000);
    }

    public static void checkFirewallOpenPortClose(RadwareServerCli radwareServerCli, RootServerCli rootServerCli) throws Exception {
        String addedport = "7777";
        boolean isSuccess = false;
        int numOfRetries = 10;
        try {
            BaseTestUtils.reporter.startLevel("net firewall open-port set open");
            while (!isSuccess && numOfRetries > 0) {
                boolean isFinished = true;
                InvokeUtils.invokeCommand(null, Menu.net().firewall().openport().set().build() + " " + addedport + " " + "open", radwareServerCli, 20 * 1000);
                if (radwareServerCli.isAnalyzeSuccess(new FindText("This port already open in the firewall"))) {
                    addedport = String.valueOf(Integer.parseInt(addedport) + 1);
                    isFinished = false;
                    numOfRetries--;
                }
                if (!isSpecificPortOpen(listPorts(radwareServerCli), addedport) && isFinished) {
                    BaseTestUtils.reporter.report("Port: " + addedport, Reporter.FAIL);
                    break;
                }
                isSuccess = isFinished;
            }
        } finally {
            InvokeUtils.invokeCommand(null, Menu.net().firewall().openport().set().build() + " " + addedport + " " + "close", radwareServerCli, 20 * 1000);
            CliOperations.runCommand(rootServerCli, "iptables -L | grep " + addedport + " | awk '{print $7}' | head -1 " );
            String iptablesOutput = rootServerCli.getOutputStr();
            if (isSpecificPortOpen(listPorts(radwareServerCli), addedport) || iptablesOutput.contains(addedport)) {
                BaseTestUtils.reporter.report("Port: " + addedport, Reporter.FAIL);
            }
            BaseTestUtils.reporter.stopLevel();
        }
    }

    public static String listPorts(RadwareServerCli radwareServerCli) {
        String output = "";
        try {
            radwareServerCli.cleanCliBuffer();
            InvokeUtils.invokeCommand(null, Menu.net().firewall().openport().list().build(), radwareServerCli, 3 * 1000);
            output = radwareServerCli.getTestAgainstObject().toString();
        } catch (Exception e) {
            BaseTestUtils.reporter.report("Failed to list open ports" + "\n" + e.getMessage(), Reporter.FAIL);
        }
        return output;
    }

    public static boolean isSpecificPortOpen(String rawList, String port) {
        List<String> portList = new ArrayList<String>(Arrays.asList(rawList.split("\r\n")));
        // Omit the first line - Header Line
        portList.remove(0);
        portList.remove(0);

        for (String currentPort : portList) {
            if (currentPort.split("\t").length == 2) {
                String portNumber = currentPort.split("\t")[1].trim();
                if (port.equals(portNumber)) {
                    return true;
                }
            }
        }
        return false;
    }
}

