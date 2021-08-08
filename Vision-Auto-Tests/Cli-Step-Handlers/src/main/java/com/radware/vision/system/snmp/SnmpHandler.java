package com.radware.vision.system.snmp;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Menu;
import com.radware.vision.root.RootVerifications;
import com.radware.vision.test_utils.RegexUtils;
import jsystem.extensions.analyzers.text.FindRegex;
import jsystem.extensions.analyzers.text.FindText;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class SnmpHandler {

    static String dummyOID = "1.3.6.1.2.1.1.1.0";
    static String addCommunity = "testCommunity";
    
    public static void snmpCommunityAdd(String communityName, RadwareServerCli radwareServerCli) throws Exception {
        InvokeUtils.invokeCommand(Menu.system().snmp().community().add().build() + " " + communityName, radwareServerCli);
        radwareServerCli.analyze(new FindText("Community" + " " + communityName + " " + "was added."));
    }

    public static void snmpCommunityDelete(String communityName, RadwareServerCli radwareServerCli) throws Exception {
        InvokeUtils.invokeCommand(Menu.system().snmp().community().delete().build() + " " + communityName, radwareServerCli);
        radwareServerCli.analyze(new FindText("Community" + " " + communityName + " " + "was deleted."));
    }

    public static List<String> getCommunityList(RadwareServerCli radwareServerCli) {
        List<String> communities = new ArrayList<>();
        try {
            InvokeUtils.invokeCommand(Menu.system().snmp().community().list().build(), radwareServerCli);
            String pattern = "^(\\w+)\\s{2,}\\w+\\s{2,}(\\w+)\\s{2,}";
            communities = getItemsList(radwareServerCli, pattern);
        } catch (Exception e) {
            BaseTestUtils.reporter.report("Failed to get communities list" + "\n" + e.getMessage(), Reporter.FAIL);
        }
        return communities;
    }

    public static List<String> getTrapTargetList(RadwareServerCli radwareServerCli) {
        List<String> communities = new ArrayList<>();
        List<String> targets = new ArrayList<>();
        List<String> ports = new ArrayList<>();
        List<String> combinedItems = new ArrayList<>();
        try {
            InvokeUtils.invokeCommand(Menu.system().snmp().trap().target().list().build(), radwareServerCli);
            String patternTargets = "^(\\w+):\\d{1,5}\\s+\\w+";
            String patternComms = "^\\w+:\\d{1,5}\\s+(\\w+)";
            String patternPort = "^\\w+:(\\d{1,5})\\s+\\w+";
            targets = getItemsList(radwareServerCli, patternTargets);
            communities = getItemsList(radwareServerCli, patternComms);
            ports = getItemsList(radwareServerCli, patternPort);
            for (int i = 0; i < targets.size(); i++) {
                combinedItems.add(targets.get(i) + "|" + ports.get(i) + "|" + communities.get(i));
            }
        } catch (Exception e) {
            BaseTestUtils.reporter.report("Failed to get trap targets list" + "\n" + e.getMessage(), Reporter.FAIL);
        }
        return combinedItems;
    }

    public static void snmpStop(RadwareServerCli radwareServerCli, boolean validate) {
        try {
            InvokeUtils.invokeCommand(Menu.system().snmp().service().stop().build(), radwareServerCli);
            if (validate) {
                radwareServerCli.analyze(new FindRegex("The SNMP service was successfuly stopped."));
            }
        } catch (Exception e) {
            BaseTestUtils.reporter.report("Failed to stop snmp service: " + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void snmpStart(RadwareServerCli radwareServerCli, boolean validate) {
        try {
            InvokeUtils.invokeCommand(Menu.system().snmp().service().start().build(), radwareServerCli);
            if (validate) {
                radwareServerCli.analyze(new FindRegex("The SNMP service was successfully started."));
            }
        } catch (Exception e) {
            BaseTestUtils.reporter.report("Failed to start snmp service: " + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void snmpStatusStarted(RadwareServerCli radwareServerCli) throws Exception {
        InvokeUtils.invokeCommand(Menu.system().snmp().service().status().build(), radwareServerCli);
        innerSnmpStatus(true, radwareServerCli);
    }

    public static boolean snmpInitialStatus(RadwareServerCli radwareServerCli, RootServerCli rootServerCli) throws Exception {
        boolean snmpServerStarted = isSnmpServiceStarted(radwareServerCli);
        boolean snmpServicePortsOpen = areSnmpPortsOpen(rootServerCli);
        return snmpServerStarted && snmpServicePortsOpen;
    }

    public static void snmpStatusStopped(RadwareServerCli radwareServerCli) throws Exception {
        InvokeUtils.invokeCommand(Menu.system().snmp().service().status().build(), radwareServerCli);
        innerSnmpStatus(false, radwareServerCli);
    }

    private static void innerSnmpStatus(boolean isSnmpStarted, RadwareServerCli radwareServerCli) {
        if (isSnmpStarted) {
            radwareServerCli.analyze(new FindRegex("snmpd is active"));
        } else {
            radwareServerCli.analyze(new FindRegex("snmpd is inactive"));
        }
    }

    public static boolean isSnmpServiceStarted(RadwareServerCli radwareServerCli) {
        try {
            CliOperations.runCommand(radwareServerCli, Menu.system().snmp().service().status().build());
            if (radwareServerCli.isAnalyzeSuccess(new FindRegex("snmpd is active"))) {
                return true;
            }
        } catch (Exception e) {
            throw new IllegalStateException(e.getMessage());
        }
        return false;
    }

    public static boolean isIptablesServiceStarted(RootServerCli rootServerCli) throws Exception {
        InvokeUtils.invokeCommand("service iptables status", rootServerCli);
        if (rootServerCli.getTestAgainstObject().toString().contains("Firewall is not running")) {
            return false;
        }
        return true;
    }

    public static boolean areSnmpPortsOpen(RootServerCli rootServerCli) throws Exception {
        return RootVerifications.isIptableContainsKey("snmp", 2, rootServerCli);
    }

    public static void restartIptablesService(RootServerCli rootServerCli) throws Exception {
        InvokeUtils.invokeCommand("service iptables restart", rootServerCli);
    }

    public static boolean verifyExistingCommunities(List<String> communities, RadwareServerCli radwareServerCli) {
        List<String> list = getCommunityList(radwareServerCli);
        return (list != null && list.containsAll(communities));
    }

    public static boolean testSnmpConnection(String community, RadwareServerCli radwareServerCli) throws IOException {
        String dummyOID = "1.3.6.1.2.1.1.1.0";
        return SnmpComm.getSnmpResponse(community, dummyOID, radwareServerCli) != null;
    }

    public static void snmpHelp(String command, String helpText, RadwareServerCli radwareServerCli) throws Exception {
        try {
            CliOperations.checkSubMenu(radwareServerCli, command + " " + "?", helpText, false);
        } finally {
            InvokeUtils.invokeCommand("", radwareServerCli);
        }
    }

    public static void snmpTrapTargetDelete(RadwareServerCli radwareServerCli, String host, String community) {
        try {
            InvokeUtils.invokeCommand(null, Menu.system().snmp().trap().target().delete().build() + " " + host + " " + community, radwareServerCli, 10 * 1000);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to delete snmp trap target: " + host + ", " + community + "\n" + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void snmpTrapTargetAdd(RadwareServerCli radwareServerCli, String targetDns, String targetCommunity, String targetPort) throws Exception {
        InvokeUtils.invokeCommand(null, Menu.system().snmp().trap().target().add().build() + " " + targetDns + " " + targetCommunity + " " + targetPort, radwareServerCli, 10 * 1000);
        radwareServerCli.analyze(new FindText("A trap target with destination host " + targetDns + " and community " + targetCommunity + " was added."));
    }

    private static void verifyHelpText(String helpText, RadwareServerCli radwareServerCli) throws Exception {
        CliOperations.checkSubMenu(radwareServerCli, helpText, SnmpHelpTexts.helpSnmpCommunityAdd, true);
    }

    private static List<String> getItemsList(RadwareServerCli radwareServerCli, String regexSearchPattern) throws Exception {
        return RegexUtils.fromStringToArrayWithPattern(regexSearchPattern, radwareServerCli.getTestAgainstObject().toString());
    }

    public static void snmpStartValidation(RadwareServerCli radwareServerCli, RootServerCli rootServerCli) {
        StringBuilder testResult = new StringBuilder();
        try {
            snmpStop(radwareServerCli, false);
            snmpStart(radwareServerCli, true);
            updateDnsConfigurationFile(rootServerCli);
            if (!isSnmpServiceStarted(radwareServerCli)) {
                testResult.append("SNMP service was not started correctly");
            }
            if (!areSnmpPortsOpen(rootServerCli)) {
                testResult.append("SNMP firewall ports were not added correctly");
            }
            if (!isIptablesServiceStarted(rootServerCli)) {
                testResult.append("Firewall Service is not started.");
            }
            if (SnmpComm.getSnmpResponse("public", dummyOID, radwareServerCli) == null) {
                testResult.append("SNMP connection was not started correctly");
            }
            if (testResult.length() > 0) {
                BaseTestUtils.report("Start SNMP failed with the following errors: " + testResult.toString(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Starting SNMP Service failed with error: " + e.getMessage(), Reporter.FAIL);
        }
    }

    private static void updateDnsConfigurationFile(RootServerCli rootServerCli) throws Exception {
        InvokeUtils.invokeCommand("chmod 755 /etc/resolv.conf", rootServerCli);
        InvokeUtils.invokeCommand("sed -i '/nameserver 176.200.120.150/d' /etc/resolv.conf", rootServerCli);
        InvokeUtils.invokeCommand("sed -i '/nameserver 176.200.120.151/d' /etc/resolv.conf", rootServerCli);
        InvokeUtils.invokeCommand("sed -i '/NM_CONTROLLED=no/d' /etc/resolv.conf", rootServerCli);
        InvokeUtils.invokeCommand("echo \"nameserver 176.200.120.150\" >> /etc/resolv.conf", rootServerCli);
        InvokeUtils.invokeCommand("echo \"nameserver 176.200.120.151\" >> /etc/resolv.conf", rootServerCli);
        InvokeUtils.invokeCommand("echo \"NM_CONTROLLED=no\" >> /etc/resolv.conf", rootServerCli);

    }

    public static void snmpStopValidation(RadwareServerCli radwareServerCli, RootServerCli rootServerCli) {
        StringBuilder testResult = new StringBuilder();
        try {
            snmpStart(radwareServerCli, false);
            snmpStop(radwareServerCli, true);
            if (isSnmpServiceStarted(radwareServerCli)) {
                testResult.append("SNMP service was not stopped correctly");
            }
            if (areSnmpPortsOpen(rootServerCli)) {
                testResult.append("SNMP firewall ports were not added correctly");
            }
            if (SnmpComm.getSnmpResponse("public", dummyOID, radwareServerCli) != null) {
                testResult.append("SNMP connection was not blocked correctly");
            }
//            if(SnmpHandler.isIptablesServiceStarted(rootServerCli)) {
//                testResult.append("Firewall Service is not started.");
//            }
            if (testResult.length() > 0) {
                BaseTestUtils.report("Stop SNMP failed with the following errors: " + testResult.toString(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Stopping SNMP Service failed with error: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void snmpCommunityAddValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpCommunityAdd(addCommunity, radwareServerCli);
            if (!verifyExistingCommunities(Arrays.asList(new String[]{addCommunity}), radwareServerCli)) {
                BaseTestUtils.report("Community: " + addCommunity + " was not added correctly.", Reporter.FAIL);
            }
            if (!testSnmpConnection(addCommunity, radwareServerCli)) {
                BaseTestUtils.report("Could not get OIDs with community: " + addCommunity, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Add community: " + addCommunity + " " + "failed with the following errors: " + e.getMessage(), Reporter.FAIL);
        } finally {
            cleanCommunity(addCommunity, radwareServerCli);
        }
    }

    public static void snmpCommunityDeleteValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpCommunityAdd(addCommunity, radwareServerCli);
            snmpCommunityDelete(addCommunity, radwareServerCli);
            if (verifyExistingCommunities(Arrays.asList(new String[]{addCommunity}), radwareServerCli)) {
                BaseTestUtils.report("Community: " + addCommunity + " was not deleted correctly.", Reporter.FAIL);
            }
            if (testSnmpConnection(addCommunity, radwareServerCli)) {
                BaseTestUtils.report("community: " + addCommunity + " " + "succeeded in SNMP connection.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Add community: " + addCommunity + " " + "failed with the following errors: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void snmpCommunityListValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpCommunityAdd(addCommunity, radwareServerCli);
            snmpCommunityAdd(addCommunity + "1", radwareServerCli);
            snmpCommunityAdd(addCommunity + "2", radwareServerCli);
            if (!verifyExistingCommunities(Arrays.asList(new String[]{"public", addCommunity, addCommunity + "1", addCommunity + "2"}), radwareServerCli)) {
                BaseTestUtils.report("Failed to add community: " + addCommunity, Reporter.FAIL);
            }

        } catch (Exception e) {
            BaseTestUtils.report("List communities test failed with error: " + e.getMessage(), Reporter.FAIL);
        } finally {
            cleanCommunity(addCommunity, radwareServerCli);
            cleanCommunity(addCommunity + "1", radwareServerCli);
            cleanCommunity(addCommunity + "2", radwareServerCli);
        }
    }

    public static void iptablesServiceRestartValidation(RadwareServerCli radwareServerCli, RootServerCli rootServerCli) {
        try {
            snmpStart(radwareServerCli, false);
            restartIptablesService(rootServerCli);
            if (SnmpComm.getSnmpResponse("public", dummyOID, radwareServerCli) == null) {
                BaseTestUtils.report("SNMP Requests are failing after restarting iptables service.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Restarting iptables Service failed with error: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void snmpStatusInitialValidation(RadwareServerCli radwareServerCli, RootServerCli rootServerCli) {
        try {
            if (!snmpInitialStatus(radwareServerCli, rootServerCli)) {
                BaseTestUtils.report("Initial status was not as expected.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Initial status was not as expected: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void snmpStatusStartedValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpStop(radwareServerCli, false);
            snmpStart(radwareServerCli, false);
            snmpStatusStarted(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get snmp service status: " + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void snmpStatusStoppedValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpStart(radwareServerCli, false);
            snmpStop(radwareServerCli, false);
            snmpStatusStopped(radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get snmp service status: " + e.getMessage(), Reporter.FAIL);
        } finally {
            snmpStart(radwareServerCli, false);
        }
    }

    public static void helpSnmpValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpHelp(Menu.system().snmp().build(), SnmpHelpTexts.helpSnmp, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Help text for snmp was not as expected." + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void helpSnmpCommunityValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpHelp(Menu.system().snmp().community().build(), SnmpHelpTexts.helpSnmpCommunity, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Help text for snmp->community was not as expected." + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void helpSnmpCommunityAddValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpHelp(Menu.system().snmp().community().add().build(), SnmpHelpTexts.helpSnmpCommunityAdd, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Help text for snmp-->community-->add was not as expected." + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void helpSnmpCommunityDeleteValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpHelp(Menu.system().snmp().community().delete().build(), SnmpHelpTexts.helpSnmpCommunityDelete, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Help text for snmp-->community-->delete was not as expected." + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void helpSnmpCommunityListValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpHelp(Menu.system().snmp().community().list().build(), SnmpHelpTexts.helpSnmpCommunityList, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Help text for snmp-->community-->delete was not as expected." + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void helpSnmpTrapValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpHelp(Menu.system().snmp().trap().build(), SnmpHelpTexts.helpSnmpTrap, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Help text for snmp-->trap was not as expected." + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void helpSnmpTrapTargetValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpHelp(Menu.system().snmp().trap().target().build(), SnmpHelpTexts.helpSnmpTrapTarget, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Help text for snmp-->trap-->target was not as expected." + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void helpSnmpTrapTargetAddValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpHelp(Menu.system().snmp().trap().target().add().build(), SnmpHelpTexts.helpSnmpTrapTargetAdd, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Help text for snmp-->trap-->target-->add was not as expected." + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void helpSnmpTrapTargetDeleteValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpHelp(Menu.system().snmp().trap().target().delete().build(), SnmpHelpTexts.helpSnmpTrapTargetDelete, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Help text for snmp-->trap-->target-->delete was not as expected." + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void helpSnmpTrapTargetListValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpHelp(Menu.system().snmp().trap().target().list().build(), SnmpHelpTexts.helpSnmpTrapTargetList, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Help text for snmp-->trap-->target-->list was not as expected." + e.getMessage(), Reporter.FAIL);
        }
    }

    public static void snmpTrapTargetAddEmptyInitialValidation(RadwareServerCli radwareServerCli) {
        try {
            List<String> currentTrapTargets = getTrapTargetList(radwareServerCli);
            if (!currentTrapTargets.isEmpty()) {
                BaseTestUtils.report("Initial snmp trap target list was not empty\n" + "Found: " + currentTrapTargets, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("snmp trap target add failed.\n" + e.getMessage(), Reporter.FAIL);
        } finally {
            snmpTrapTargetDelete(radwareServerCli, "host1", "community1");
        }
    }

    public static void snmpTrapTargetAddAndListCustomPortValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpTrapTargetAdd(radwareServerCli, "host1", "community1", "444");
            List<String> currentTrapTargets = getTrapTargetList(radwareServerCli);
            if (!currentTrapTargets.contains("host1|444|community1")) {
                BaseTestUtils.report("snmp trap target (host1|444|community1) was not added properly\n" + "Found: " + currentTrapTargets, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("snmp trap target add failed.\n" + e.getMessage(), Reporter.FAIL);
        } finally {
            snmpTrapTargetDelete(radwareServerCli, "host1", "community1");
        }
    }

    public static void snmpTrapTargetAddAndListDefaultPortValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpTrapTargetDelete(radwareServerCli, "host1", "community1");
            snmpTrapTargetAdd(radwareServerCli, "host1", "community1", "");
            List<String> currentTrapTargets = getTrapTargetList(radwareServerCli);
            if (!currentTrapTargets.contains("host1|162|community1")) {
                BaseTestUtils.report("snmp trap target (host1|162|community1) was not added properly\n" + "Found: " + currentTrapTargets, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("snmp trap target add failed.\n" + e.getMessage(), Reporter.FAIL);
        } finally {
            snmpTrapTargetDelete(radwareServerCli, "host1", "community1");
        }
    }

    public static void snmpTrapTargetDeleteValidation(RadwareServerCli radwareServerCli) {
        try {
            snmpTrapTargetAdd(radwareServerCli, "host1", "community1", "111");
            snmpTrapTargetDelete(radwareServerCli, "host1", "community1");
            List<String> currentTrapTargets = getTrapTargetList(radwareServerCli);
            if (currentTrapTargets.contains("host1|community1")) {
                BaseTestUtils.report("snmp trap target (host1|community1) was not deleted properly\n" + "Found: " + currentTrapTargets, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("snmp trap target add failed.\n" + e.getMessage(), Reporter.FAIL);
        }
    }


    private static void cleanCommunity(String communityName, RadwareServerCli radwareServerCli) {
        try {
            snmpCommunityDelete(communityName, radwareServerCli);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to clean community: " + communityName + ". Further tests might fail.", Reporter.PASS);
        }
    }
}
