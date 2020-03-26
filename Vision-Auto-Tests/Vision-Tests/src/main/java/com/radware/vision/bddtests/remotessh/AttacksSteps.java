package com.radware.vision.bddtests.remotessh;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import cucumber.api.java.en.Given;

public class AttacksSteps extends BddCliTestBase {


    /**
     * Run perl script on simulator machine
     *
     * @param numOfAttacks - define the number of execution loops. 0 = infinite
     * @param fileName     - the input PCAP file name
     * @param deviceType   - SUTDeviceType ENUM
     * @param deviceIndex  - SUT device index
     * @param ld           - OPTIONAL loop delay. delay in mSec between iterations. default 1000loop delay. delay in mSec between iterations. default 1000
     * @param waitTimeout  - OPTIONAL Delay before return default 0
     */
    @Given("^CLI simulate (\\d+) attacks of type \"(.*)\" on \"(.*)\" (\\d+)(?: with loopDelay (\\d+))?(?: and wait (\\d+) seconds)?( with attack ID)?$")
    public void runSimulatorFromDevice(int numOfAttacks, String fileName, SUTDeviceType deviceType, int deviceIndex, Integer ld, Integer waitTimeout, String withAttackId) {
        try {
            int loopDelay = 1000;
            int wait = 0;
            if (ld != null) {
                loopDelay = ld;
            }
            if (waitTimeout != null) {
                wait = waitTimeout;
            }
            String commandToExecute = getCommandToexecute(deviceType, deviceIndex, numOfAttacks, loopDelay, fileName, withAttackId != null);
            CliOperations.runCommand(getRestTestBase().getGenericLinuxServer(), commandToExecute, 30 * 1000, false, true, false);

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
            String visionIP = restTestBase.getRootServerCli().getHost();
            if (deviceIp.startsWith(fakeIpPrefix)) {
                visionIP = visionIP.replace(visionIP.substring(0, visionIP.indexOf(".", visionIP.indexOf(".") + 1)), fakeIpPrefix);
            }
            String commandToExecute = "/home/radware/run-kill_all_DP_attacks.sh stop " + deviceIp + " " + visionIP;
            InvokeUtils.invokeCommand(commandToExecute, restTestBase.getGenericLinuxServer());
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
            String visionIP = restTestBase.getRootServerCli().getHost();
            // fetch the last two octets
            visionIP = visionIP.substring(visionIP.indexOf(".", visionIP.indexOf(".") + 1) + 1, visionIP.length());
            String commandToExecute = "/home/radware/run-kill_all_DP_attacks.sh stop " + visionIP;
            InvokeUtils.invokeCommand(commandToExecute, restTestBase.getGenericLinuxServer());

        } catch (Exception e) {
            BaseTestUtils.report("Failed to simulate attack:", Reporter.FAIL);
        }
    }

    private String getCommandToexecute(SUTDeviceType deviceType, int deviceIndex, int numOfAttacks, Integer loopDelay, String fileName, boolean withAttackId) {
        String fakeIpPrefix = "50.50";
        String deviceIp;
        String visionIP = restTestBase.getRootServerCli().getHost();
        String interFace;
        String commandToExecute = "";
        try {
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            commandToExecute = "sudo /home/radware/getInterfaceByIP.sh " + deviceIp.substring(0, deviceIp.indexOf(".", deviceIp.indexOf(".") + 1));
            if (deviceIp.startsWith(fakeIpPrefix)) {
                visionIP = visionIP.replace(visionIP.substring(0, visionIP.indexOf(".", visionIP.indexOf(".") + 1)), fakeIpPrefix);
            } else {
                String isDeviceInterfaceExistInVision = "0";
                if (isDeviceInterfaceExistInVision.equals("0"))
                    commandToExecute = "sudo /home/radware/getInterfaceByIP.sh " + visionIP.substring(0, visionIP.indexOf(".", visionIP.indexOf(".") + 1));
                else {
                    commandToExecute = String.format("ifconfig | grep \"inet addr:%s\" | wc -l", deviceIp.substring(0, deviceIp.indexOf(".", deviceIp.indexOf(".") + 1)));
                    CliOperations.runCommand(getRestTestBase().getGenericLinuxServer(), commandToExecute);
                    isDeviceInterfaceExistInVision = CliOperations.lastRow;
                    if (!isDeviceInterfaceExistInVision.equals("0")) {
                        visionIP = visionIP.replace(visionIP.substring(0, visionIP.indexOf(".", visionIP.indexOf(".") + 1)), deviceIp.substring(0, deviceIp.indexOf(".", deviceIp.indexOf(".") + 1)));
                    }
                    commandToExecute = "sudo /home/radware/getInterfaceByIP.sh " + deviceIp.substring(0, deviceIp.indexOf(".", deviceIp.indexOf(".") + 1));
                }
            }

            //Reconnect to avoid disturbing another simulator attack!!!
            restTestBase.getGenericLinuxServer().connect();

            CliOperations.runCommand(getRestTestBase().getGenericLinuxServer(), commandToExecute);
            interFace = CliOperations.lastRow;
            if (withAttackId) {
                commandToExecute = String.format("sudo perl sendfile.pl -i %s -d %s -si %s -s %d -ld %d -ai 1 -f %s.pcap &", interFace, visionIP, deviceIp, numOfAttacks, loopDelay, fileName);
            } else {
                commandToExecute = String.format("sudo perl sendfile.pl -i %s -d %s -si %s -s %d -ld %d -f %s.pcap &", interFace, visionIP, deviceIp, numOfAttacks, loopDelay, fileName);
            }
            //for the next generations
            restTestBase.getGenericLinuxServer().connect();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to simulate attack: " + fileName, Reporter.FAIL);
        }
        return commandToExecute;
    }
}
