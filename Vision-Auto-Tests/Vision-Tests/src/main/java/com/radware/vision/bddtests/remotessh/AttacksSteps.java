package com.radware.vision.bddtests.remotessh;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.LinuxFileServer;
import com.radware.vision.automation.base.TestBase;
import cucumber.api.java.en.Given;

public class AttacksSteps extends TestBase {
    private static AttacksSteps attacksSteps_instance = null;
    private LinuxFileServer linuxFileServer;

    public AttacksSteps(){
        setMyGenericLinux();
    }
    public static AttacksSteps getInstance(){
        if(attacksSteps_instance == null)
            attacksSteps_instance = new AttacksSteps();
        return attacksSteps_instance;
    }

    /**
     * Run perl script on simulator machine
     *
     * @param numOfAttacks - define the number of execution loops. 0 = infinite
     * @param fileName     - the input PCAP file name
     * @param deviceSetId  - the deviceSetId from the setup
     * @param ld           - OPTIONAL loop delay. delay in mSec between iterations. default 1000loop delay. delay in mSec between iterations. default 1000
     * @param waitTimeout  - OPTIONAL Delay before return default 0
     */
    @Given("^CLI simulate (\\d+) attacks of(?: (prefix))? type \"(.*)\" on (SetId|DeviceID) \"(.*)\"(?: with loopDelay (\\d+))?(?: and wait (\\d+) seconds)?( with attack ID)?( inSecondaryServer)?$")
    public void runSimulatorFromDevice(int numOfAttacks, String prefix, String fileName, String idType, String deviceSetId, Integer ld, Integer waitTimeout, String withAttackId, String inSecondaryServer) {
        String deviceIp;

        try {
            TreeDeviceManagementDto device =
                    (idType.equals("SetId")) ? sutManager.getTreeDeviceManagement(deviceSetId).orElse(null) :
                            (idType.equals("DeviceID")) ? sutManager.getTreeDeviceManagementFromDevices(deviceSetId).orElse(null) : null;
            assert device != null;
            deviceIp = device.getManagementIp();
            assert deviceIp != null;

            int loopDelay = 1000;
            int wait = 0;
            if (ld != null) {
                loopDelay = ld;
            }
            if (waitTimeout != null) {
                wait = waitTimeout;
            }
            if(prefix != null)
            {
                String[] ipDeviceS = deviceIp.split("\\.");
                if(ipDeviceS.length == 4)
                    fileName += String.format("_%s_%s", ipDeviceS[2], ipDeviceS[3]);
            }
            String commandToExecute = getCommandToExecute(deviceIp, numOfAttacks, loopDelay, fileName, withAttackId != null, inSecondaryServer != null);
            CliOperations.runCommand(linuxFileServer, commandToExecute, 30 * 1000, false, true, false);

            Thread.sleep(wait * 1000L);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to simulate attack: " + fileName, Reporter.FAIL);
        }
    }


    /**
     * kills all the attacks process to the current vision
     */

    @Given("^CLI kill all simulator attacks on (current vision|Secondary Server)")
    public void killAllAttacksOnVision(String server) {
        try {
            String visionIP = "";

            if (server.equals("current vision"))
                visionIP = clientConfigurations.getHostIp();
            else if (server.equals("Secondary Server"))
                visionIP = getSutManager().getpair().getPairIp();

            visionIP = visionIP.substring(visionIP.indexOf(".", visionIP.indexOf(".") + 1) + 1);
            String commandToExecute = "/home/radware/run-kill_all_DP_attacks.sh stop " + visionIP;
            CliOperations.runCommand(linuxFileServer, commandToExecute);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to kill simulators, " + e.getMessage(), Reporter.FAIL);
        }
    }

    private String getCommandToExecute(String deviceIp, int numOfAttacks, Integer loopDelay, String fileName, boolean withAttackId, boolean inSecondaryServer) {
        String fakeIpPrefix = "50.50";
        String visionIP;
        if (!inSecondaryServer)
            visionIP = clientConfigurations.getHostIp();
        else
            visionIP = getSutManager().getpair().getPairIp();

        String interFace;
        String commandToExecute = "";
        try {
            String gwMacAdress = linuxFileServer.getGwMacAddress();//"00:14:69:4c:70:42"; //172.19.1.1 GW mac
            String deviceSubNet = deviceIp.substring(0, deviceIp.indexOf(".", deviceIp.indexOf(".") + 1));
            String visionSubNet = visionIP.substring(0, visionIP.indexOf(".", visionIP.indexOf(".") + 1));
            String INTERFACE_SCRIPT_PATH = "/home/radware/getInterfaceByIP.sh";

            commandToExecute = "sudo " + INTERFACE_SCRIPT_PATH + " " + deviceSubNet;
            if (deviceIp.startsWith(fakeIpPrefix)) {
                visionIP = visionIP.replace(visionSubNet, fakeIpPrefix);
            } else {
                String isDeviceInterfaceExistInVision = "0";
//                if (isDeviceInterfaceExistInVision.equals("0"))
                    commandToExecute = "sudo  " + INTERFACE_SCRIPT_PATH + " " + visionSubNet;
//                else {
//                    commandToExecute = String.format("ifconfig | grep \"inet addr:%s\" | wc -l", deviceSubNet);
//                    CliOperations.runCommand(linuxFileServer, commandToExecute);
//                    isDeviceInterfaceExistInVision = CliOperations.lastRow;
//                    if (!isDeviceInterfaceExistInVision.equals("0")) {
//                        visionIP = visionIP.replace(visionSubNet, deviceSubNet);
//                    }
//                    commandToExecute = "sudo " + INTERFACE_SCRIPT_PATH + " " + deviceSubNet;
//                }
            }

            //Reconnect to avoid disturbing another simulator attack!!!
            linuxFileServer.connect();
            CliOperations.runCommand(linuxFileServer, commandToExecute);
            interFace = CliOperations.lastRow;

            commandToExecute = buildCommandToExecute(interFace, visionIP, deviceIp, numOfAttacks, loopDelay, fileName, gwMacAdress, withAttackId);

            //for the next generations
            linuxFileServer.connect();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to simulate attack: " + fileName + e.getMessage(), Reporter.FAIL);
        }
        return commandToExecute;
    }

    private String buildCommandToExecute(String interFace, String visionIP, String deviceIp, int numOfAttacks, Integer loopDelay, String fileName, String gwMacAddress, boolean withAttackId) {

        return "sudo perl sendfile.pl " + "-i " + interFace + " -d " + visionIP +
                " -si " + deviceIp + " -s " + numOfAttacks +
                " -ld " + loopDelay +
                (withAttackId ? " -ai 1 " : "") +
                " -f " + fileName + ".pcap" +
                " -dm " + gwMacAddress +
                " &";
    }

    private void setMyGenericLinux() {
        try {
            if (linuxFileServer == null) {
                if (!serversManagement.getLinuxFileServer().isPresent()) {
                    BaseTestUtils.report("The genericLinuxServer Not found!", Reporter.FAIL);
                }
                linuxFileServer = serversManagement.getLinuxFileServer().get();
            }
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }
}
