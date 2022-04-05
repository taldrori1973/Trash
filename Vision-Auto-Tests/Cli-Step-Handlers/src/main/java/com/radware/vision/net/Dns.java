package com.radware.vision.net;

import com.aqua.sysobj.conn.CliCommand;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import jsystem.extensions.analyzers.text.FindRegex;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author Hadar Elbaz
 */

public class Dns {


    private static final String NET_DNS_SUB_MENU = "delete                  Deletes DNS server entries.\n"
            + "get                     Displays the DNS table.\n"
            + "set                     Creates DNS servers entries.\n";

    private static final String NET_DNS_SET_SUB_MENU = "primary                 Creates the primary DNS server entry.\n"
            + "secondary               Creates the secondary DNS server entry.\n"
            + "tertiary                Creates the tertiary DNS server entry.";

    public enum DnsType {
        PRIMARY("primary"), SECONDERAY("secondary"), TERTIARY("tertiary");

        public String dnsType;

        DnsType(String dnsType) {
            this.dnsType = dnsType;
        }
    }

    /**
     * Define primary DNS server from sut file
     *
     * @throws Exception - Generic Exception object
     */
    public static void setDnsPrimaryFromSut(RadwareServerCli serverCli) throws Exception {
        BaseTestUtils.reporter.startLevel("Set Dns Primary " + serverCli.getDnsServerIp());
        InvokeUtils.invokeCommand(null, Menu.net().dns().setPrimary().build() + " " + serverCli.getDnsServerIp(), serverCli);
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Get primary DNS server Verify expected result ip (dns ip value located in sut file)
     *
     * @throws Exception - Generic Exception object
     */
    public static void getDnsPrimary(RadwareServerCli serverCli) throws Exception {
        BaseTestUtils.reporter.startLevel("Set Dns Primary ");
        InvokeUtils.invokeCommand(null, Menu.net().dns().get().build(), serverCli);
        serverCli.analyze(new FindRegex("Primary\\s+" + serverCli.getDnsServerIp()));
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Define primary DNS server with IP
     *
     * @throws Exception - Generic Exception object
     * @author izikp
     */
    public static void setDnsPrimary(RadwareServerCli serverCli, String dnsIP) throws Exception {
        BaseTestUtils.reporter.startLevel("Set Dns Primary " + dnsIP);
        InvokeUtils.invokeCommand(null, Menu.net().dns().setPrimary().build() + " " + dnsIP, serverCli);
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Define secondary DNS server with IP
     *
     * @throws Exception - Generic Exception object
     * @author izikp
     */
    public static void setDnsTertiary(RadwareServerCli serverCli, String dnsIP) throws Exception {
        BaseTestUtils.reporter.startLevel("Set Dns Tertiary " + dnsIP);
        InvokeUtils.invokeCommand(null, Menu.net().dns().setTertiary().build() + " " + dnsIP, serverCli);
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Define secondary DNS server with IP
     *
     * @throws Exception - Generic Exception object
     * @author izikp
     */
    public static void setDnsSecondary(RadwareServerCli serverCli, String dnsIP) throws Exception {
        BaseTestUtils.reporter.startLevel("Set Dns Secondary " + dnsIP);
        InvokeUtils.invokeCommand(null, Menu.net().dns().setSecondary().build() + " " + dnsIP, serverCli);
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Delete DNS server with the cmd - ' net dns delete ... '
     *
     * @throws Exception - Generic Exception object
     * @author izikp
     */
    public static void deleteDns(RadwareServerCli serverCli, DnsType dnsType) throws Exception {
        BaseTestUtils.reporter.startLevel("Delete Dns " + dnsType.dnsType);
        switch (dnsType) {
            case PRIMARY:
                InvokeUtils.invokeCommand(null, Menu.net().dns().deletePrimary().build(), serverCli);
                break;
            case SECONDERAY:
                InvokeUtils.invokeCommand(null, Menu.net().dns().deleteSecondary().build(), serverCli);
                break;
            case TERTIARY:
                InvokeUtils.invokeCommand(null, Menu.net().dns().deleteTertiary().build(), serverCli);
                break;
            default:
                throw new Exception(" Invalid DNS Type, valid options are : " + Arrays.toString(DnsType.values()));
        }
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Verify expected Primary Dns result ip equals to root /etc/resolve.conf file
     *
     * @throws Exception - Generic Exception object
     * @author izikp
     */
    public static void verifyPrimaryDnsViaRoot(RootServerCli rootConnection, String radwarePrimaryDnsIP) throws Exception {
        BaseTestUtils.reporter.startLevel("Verify Primary Dns Via Root " + radwarePrimaryDnsIP);
        String netplanPath = "/etc/netplan/00-installer-config.yaml";
        String textToGrep = "nameservers -A2";
        CliOperations.getLinuxCatGrep(rootConnection, netplanPath, textToGrep);
        CliOperations.verifyLastOutputByRegex(radwarePrimaryDnsIP, rootConnection);
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Verify expected Primary Dns result ip equals to root /etc/resolve.conf file
     *
     * @throws Exception - Generic Exception object
     * @author izikp
     */
    public static void verifyDnsIpIsDeleted(RootServerCli rootCliConnection, RadwareServerCli radwareCliConnection, String dnsIP)
            throws Exception {
        BaseTestUtils.reporter.startLevel("Verify Dns Ip Is Deleted " + dnsIP);
        InvokeUtils.invokeCommand(null, Menu.net().dns().get().build(), radwareCliConnection, CliCommand.getDefaultTimeout(), false, false,
                true, dnsIP);
        InvokeUtils.invokeCommand(null, "cat /etc/netplan/00-installer-config.yaml", rootCliConnection, CliCommand.getDefaultTimeout(), false, false, true,
                dnsIP);
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Verify expected result Secondary Dns ip equals to root /etc/resolve.conf file
     *
     * @throws Exception - Generic Exception object
     * @author izikp
     */
    public static void verifySecondaryDnsViaRoot(RootServerCli rootConnection, String radwareSecondaryDnsIP) throws Exception {
        BaseTestUtils.reporter.startLevel("Verify Secondary Dns Ip Is Deleted " + radwareSecondaryDnsIP);
        String netplanPath = "/etc/netplan/00-installer-config.yaml";
        String textToGrep = "nameservers -A3";
        CliOperations.getLinuxCatGrep(rootConnection, netplanPath, textToGrep);
        CliOperations.verifyLastOutputByRegex(radwareSecondaryDnsIP, rootConnection);
        BaseTestUtils.reporter.stopLevel();
    }

    /**
     * Verify expected result Tertiary Dns ip equals to root /etc/resolve.conf file
     *
     * @throws Exception - Generic Exception object
     * @author izikp
     */
    public static void verifyTertiaryDnsViaRoot(RootServerCli rootConnection, String radwareTertiaryDnsIP) throws Exception {
        BaseTestUtils.reporter.startLevel("Verify Tertiary Dns Ip Is Deleted " + radwareTertiaryDnsIP);
        String netplanPath = "/etc/netplan/00-installer-config.yaml";
        String textToGrep = "nameservers -A4";
        CliOperations.getLinuxCatGrep(rootConnection, netplanPath, textToGrep);
        CliOperations.verifyLastOutputByRegex(radwareTertiaryDnsIP, rootConnection);
        BaseTestUtils.reporter.stopLevel();
    }

    public static void VerifyGetDnsEqualToRoot(RadwareServerCli radwareCliConnection, RootServerCli rootConnection) throws Exception {
        BaseTestUtils.reporter.startLevel("Verify Get Dns Equal To Root");
        String netplanPath = "/etc/netplan/00-installer-config.yaml";
        String textToGrep = "nameservers -A4";
        CliOperations.getLinuxCatGrep(rootConnection, netplanPath, textToGrep);
        String[] rootLines = CliOperations.resultLines.toArray(new String[0]);
        InvokeUtils.invokeCommand(null, Menu.net().dns().get().build(), radwareCliConnection);
        ArrayList<String> netDnsGetOutPut = radwareCliConnection.getCmdOutput();
        netDnsGetOutPut.remove(0);
        for (int i = 0; i < netDnsGetOutPut.size(); i++) {
            List<String> rootDNSIpLines = Arrays.stream(rootLines).distinct().filter(line -> line.matches(".*\\d.*")).collect(Collectors.toList());
            String[] rootOneLine = rootDNSIpLines.get(i).split("\\s+");
            String rootDnsIP = rootOneLine[2];
            String[] radwareOneLine = netDnsGetOutPut.get(i).split("\\s+");
            String radwareDnsIP = radwareOneLine[1];
            if (!radwareDnsIP.equals(rootDnsIP)) {
                throw new Exception("'net dns get' cmd output and /etc/netplan/00-installer-config.yaml have a mismatch");
            }
        }
        BaseTestUtils.reporter.stopLevel();

    }

    /**
     * Verify sub menu of 'net dns' cmd
     *
     * @throws Exception - Generic Exception object
     * @author izikp
     */
    public static void dnsSubMenuCheck(RadwareServerCli radwareCliConnection) {
        try {
            CliOperations.checkSubMenu(radwareCliConnection, Menu.net().dns().build(), NET_DNS_SUB_MENU);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    /**
     * Verify sub menu of 'net dns set' cmd
     *
     * @author izikp
     */
    public static void dnsSetSubMenuCheck(RadwareServerCli radwareCliConnection) {
        try {
            CliOperations.checkSubMenu(radwareCliConnection, Menu.net().dns().build() + " set", NET_DNS_SET_SUB_MENU);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }

}
