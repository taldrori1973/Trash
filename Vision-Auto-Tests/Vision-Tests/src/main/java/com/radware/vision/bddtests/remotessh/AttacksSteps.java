package com.radware.vision.bddtests.remotessh;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.LinuxFileServer;
import com.radware.vision.automation.base.TestBase;
import cucumber.api.java.en.Given;

import java.util.Optional;

public class AttacksSteps extends TestBase {


    /**
     * Run perl script on simulator machine
     *
     * @param numOfAttacks - define the number of execution loops. 0 = infinite
     * @param fileName     - the input PCAP file name
     * @param deviceSetId  - the deviceSetId from the setup
     * @param ld           - OPTIONAL loop delay. delay in mSec between iterations. default 1000loop delay. delay in mSec between iterations. default 1000
     * @param waitTimeout  - OPTIONAL Delay before return default 0
     */
    @Given("^CLI simulate (\\d+) attacks of type \"(.*)\" on (SetId|DeviceID) \"(.*)\"(?: with loopDelay (\\d+))?(?: and wait (\\d+) seconds)?( with attack ID)?$")
    public void runSimulatorFromDevice(int numOfAttacks, String fileName, String idType, String deviceSetId, Integer ld, Integer waitTimeout, String withAttackId) {
        String deviceIp = "";

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
            String commandToExecute = getCommandToExecute(deviceIp, numOfAttacks, loopDelay, fileName, withAttackId != null);
            Optional<LinuxFileServer> genericLinuxServerOpt = serversManagement.getLinuxFileServer();
            if (!genericLinuxServerOpt.isPresent()) {
                throw new Exception("The genericLinuxServer Not found!");
            }
            CliOperations.runCommand(genericLinuxServerOpt.get(), commandToExecute, 30 * 1000, false, true, false);

            Thread.sleep(wait * 1000);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to simulate attack: " + fileName, Reporter.FAIL);
        }
    }


    /**
     * kills all the attacks process to the current vision
     */

    @Given("^CLI kill all simulator attacks on current vision")
    public void killAllAttacksOnVision() {
        try {
            String visionIP = clientConfigurations.getHostIp();
            Optional<LinuxFileServer> genericLinuxServerOpt = serversManagement.getLinuxFileServer();
            if (!genericLinuxServerOpt.isPresent()) {
                throw new Exception("The genericLinuxServer Not found!");
            }
            // fetch the last two octets
            visionIP = visionIP.substring(visionIP.indexOf(".", visionIP.indexOf(".") + 1) + 1, visionIP.length());
            String commandToExecute = "/home/radware/run-kill_all_DP_attacks.sh stop " + visionIP;
            CliOperations.runCommand(serversManagement.getLinuxFileServer().get(), commandToExecute);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to kill simulators, " + e.getMessage(), Reporter.FAIL);
        }
    }

    private String getCommandToExecute(String deviceIp, int numOfAttacks, Integer loopDelay, String fileName, boolean withAttackId) {
        String fakeIpPrefix = "50.50";
        String visionIP = clientConfigurations.getHostIp();
        String interFace;
        String gwMacAdress = getServersManagement().getLinuxFileServer().get().getGwMacAddress();//"00:14:69:4c:70:42"; //172.19.1.1 GW mac
        String commandToExecute = "";
        Optional<LinuxFileServer> genericLinuxServer = TestBase.serversManagement.getLinuxFileServer();
        try {
            commandToExecute = "sudo /home/radware/getInterfaceByIP.sh " + deviceIp.substring(0, deviceIp.indexOf(".", deviceIp.indexOf(".") + 1));
            if (deviceIp.startsWith(fakeIpPrefix)) {
                visionIP = visionIP.replace(visionIP.substring(0, visionIP.indexOf(".", visionIP.indexOf(".") + 1)), fakeIpPrefix);
            } else {
                String isDeviceInterfaceExistInVision = "0";
                if (isDeviceInterfaceExistInVision.equals("0"))
                    commandToExecute = "sudo /home/radware/getInterfaceByIP.sh " + visionIP.substring(0, visionIP.indexOf(".", visionIP.indexOf(".") + 1));
                else {
                    commandToExecute = String.format("ifconfig | grep \"inet addr:%s\" | wc -l", deviceIp.substring(0, deviceIp.indexOf(".", deviceIp.indexOf(".") + 1)));
                    CliOperations.runCommand(genericLinuxServer.get(), commandToExecute);
                    isDeviceInterfaceExistInVision = CliOperations.lastRow;
                    if (!isDeviceInterfaceExistInVision.equals("0")) {
                        visionIP = visionIP.replace(visionIP.substring(0, visionIP.indexOf(".", visionIP.indexOf(".") + 1)), deviceIp.substring(0, deviceIp.indexOf(".", deviceIp.indexOf(".") + 1)));
                    }
                    commandToExecute = "sudo /home/radware/getInterfaceByIP.sh " + deviceIp.substring(0, deviceIp.indexOf(".", deviceIp.indexOf(".") + 1));
                }
            }

            //Reconnect to avoid disturbing another simulator attack!!!
            genericLinuxServer.get().connect();
            CliOperations.runCommand(genericLinuxServer.get(), commandToExecute);
            interFace = CliOperations.lastRow;

            commandToExecute = buildCommandToExecute(interFace, visionIP, deviceIp, numOfAttacks, loopDelay, fileName, gwMacAdress, withAttackId);

            //for the next generations
            genericLinuxServer.get().connect();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to simulate attack: " + fileName + e.getMessage(), Reporter.FAIL);
        }
        return commandToExecute;
    }

    private String buildCommandToExecute(String interFace, String visionIP, String deviceIp, int numOfAttacks, Integer loopDelay, String fileName, String gwMacAdress, boolean withAttackId) {
        StringBuilder buildCommand = new StringBuilder();
        buildCommand.append("sudo perl sendfile.pl ").append("-i ").append(interFace).append(" -d ").append(visionIP)
                .append(" -si ").append(deviceIp).append(" -s ").append(numOfAttacks)
                .append(" -ld ").append(loopDelay)
                .append(withAttackId ? " -ai 1 " : "")
                .append(" -f ").append(fileName).append(".pcap")
                .append(" -dm " + gwMacAdress)
                .append(" &");

        return buildCommand.toString();
    }
}
