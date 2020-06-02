package com.radware.vision.bddtests.remotessh;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.LinuxFileServer;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.base.TestBase;
import com.radware.vision.bddtests.BddCliTestBase;
import cucumber.api.java.en.Given;

import java.util.Optional;

public class AttacksSteps extends BddCliTestBase {


    /**
     * Run perl script on simulator machine
     *
     * @param numOfAttacks - define the number of execution loops. 0 = infinite
     * @param fileName     - the input PCAP file name
     * @param deviceSetId  - the deviceSetId from the setup
     * @param ld           - OPTIONAL loop delay. delay in mSec between iterations. default 1000loop delay. delay in mSec between iterations. default 1000
     * @param waitTimeout  - OPTIONAL Delay before return default 0
     */
    @Given("^CLI simulate (\\d+) attacks of type \"(.*)\" on SetId \"(.*)\"(?: with loopDelay (\\d+))?(?: and wait (\\d+) seconds)?( with attack ID)?$")
    public void runSimulatorFromDevice(int numOfAttacks, String fileName, String deviceSetId, Integer ld, Integer waitTimeout, String withAttackId) {
        try {
            int loopDelay = 1000;
            int wait = 0;
            if (ld != null) {
                loopDelay = ld;
            }
            if (waitTimeout != null) {
                wait = waitTimeout;
            }
            String commandToExecute = getCommandToexecute(deviceSetId, numOfAttacks, loopDelay, fileName, withAttackId != null);
            Optional<LinuxFileServer> genericLinuxServerOpt = TestBase.serversManagement.getLinuxFileServer();
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
     * Kill all the attacks process from the device to the current vision
     *
     * @param deviceType  - SUTDeviceType enum
     * @param deviceIndex - SUT index
     */

    @Given("^CLI kill simulator attack on \"(.*)\" (\\d+)")
    public void KillAllAttackFromDevice(SUTDeviceType deviceType, int deviceIndex) {
        try {

            String fakeIpPrefix = "50.50";
            String deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            String visionIP = clientConfigurations.getHostIp();
            if (deviceIp.startsWith(fakeIpPrefix)) {
                visionIP = visionIP.replace(visionIP.substring(0, visionIP.indexOf(".", visionIP.indexOf(".") + 1)), fakeIpPrefix);
            }
            String commandToExecute = "/home/radware/run-kill_all_DP_attacks.sh stop " + deviceIp + " " + visionIP;
            Optional<LinuxFileServer> genericLinuxServerOpt = TestBase.serversManagement.getLinuxFileServer();
            if (!genericLinuxServerOpt.isPresent()) {
                throw new Exception("The genericLinuxServer Not found!");
            }
            InvokeUtils.invokeCommand(commandToExecute, genericLinuxServerOpt.get());
        } catch (Exception e) {
            BaseTestUtils.report("Failed to kill attack", Reporter.FAIL);
        }
    }

    /**
     * kills all the attacks process to the current vision
     */

    @Given("^CLI kill all simulator attacks on current vision")
    public void killAllAttacksOnVision() {
        try {
            String visionIP = clientConfigurations.getHostIp();
            Optional<LinuxFileServer> genericLinuxServerOpt = TestBase.serversManagement.getLinuxFileServer();
            if (!genericLinuxServerOpt.isPresent()) {
                throw new Exception("The genericLinuxServer Not found!");
            }
            // fetch the last two octets
            visionIP = visionIP.substring(visionIP.indexOf(".", visionIP.indexOf(".") + 1) + 1, visionIP.length());
            String commandToExecute = "/home/radware/run-kill_all_DP_attacks.sh stop " + visionIP;
            InvokeUtils.invokeCommand(commandToExecute, genericLinuxServerOpt.get());
        } catch (Exception e) {
            BaseTestUtils.report("Failed to kill simulators, " + e.getMessage(), Reporter.FAIL);
        }
    }

    private String getCommandToexecute(String deviceSetId, int numOfAttacks, Integer loopDelay, String fileName, boolean withAttackId) {
        String fakeIpPrefix = "50.50";
        String deviceIp;
        String visionIP = clientConfigurations.getHostIp();
        String interFace;
//        String macAdress = TestBase.getVisionConfigurations().getManagementInfo().getMacAddress();
        String macAdress = "00:14:69:4c:70:42"; //172.17.1.1 GW mac- used only for kvision
        String commandToExecute = "";
        Optional<LinuxFileServer> genericLinuxServer = TestBase.serversManagement.getLinuxFileServer();
        SUTManager sutManager = TestBase.getSutManager();
        Optional<TreeDeviceManagementDto> deviceOpt= sutManager.getTreeDeviceManagement(deviceSetId);
        try {
            if (!genericLinuxServer.isPresent()) {
                throw new Exception("The genericLinuxServer Not found!");
            }
            if (!deviceOpt.isPresent()) {
                throw new Exception(String.format("No Device with \"%s\" Set ID was found in this setup", deviceSetId));
            }

            deviceIp = deviceOpt.get().getManagementIp();
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
            if (withAttackId) {
                commandToExecute = String.format("sudo perl sendfile.pl -i %s -d %s -si %s -s %d -ld %d -ai 1 -f %s.pcap -dm %s &", interFace, visionIP, deviceIp, numOfAttacks, loopDelay, fileName, macAdress);
            } else {
                commandToExecute = String.format("sudo perl sendfile.pl -i %s -d %s -si %s -s %d -ld %d -f %s.pcap -dm %s &", interFace, visionIP, deviceIp, numOfAttacks, loopDelay, fileName, macAdress);
            }
            //for the next generations
            genericLinuxServer.get().connect();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to simulate attack: " + fileName +  e.getMessage(), Reporter.FAIL);
        }
        return commandToExecute;
    }
}
