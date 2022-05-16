package com.radware.vision.bddtests.fnm;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.LinuxFileServer;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.remotessh.AttacksSteps;
import cucumber.api.java.en.Given;

import java.util.Optional;

public class FNMOperationsSteps extends TestBase {

    AttacksSteps attacksSteps = new AttacksSteps();

    /**
     * Run perl script on simulator machine
     *
     * @param numOfAttacks - define the number of execution loops. 0 = infinite
     * @param fileName     - the input PCAP file name
     */
    @Given("^CLI simulate (\\d+) FNM attacks of type \"(.*)\"$")
    public void runFNMSimulation(int numOfAttacks, String fileName) {
        String deviceIp = "";

        try {
            TreeDeviceManagementDto device = sutManager.getFNM().get();
            deviceIp = device.getManagementIp();

            int loopDelay = 1000;
            int wait = numOfAttacks + 1;

            String commandToExecute = getCommandToExecute(deviceIp, numOfAttacks, fileName);
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
    private String getCommandToExecute(String deviceIp, int numOfAttacks, String fileName) {

        String commandToExecute = "";

        Optional<LinuxFileServer> genericLinuxServer = TestBase.serversManagement.getLinuxFileServer();
        try {

            //Reconnect to avoid disturbing another simulator attack!!!
            genericLinuxServer.get().connect();

            String sourceIp = "192.168.30.37";
            // this constant source ip is a limitation must here
            commandToExecute = buildCommandToExecute(sourceIp, deviceIp, numOfAttacks, fileName);

            //for the next generations
            genericLinuxServer.get().connect();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to simulate attack: " + fileName + e.getMessage(), Reporter.FAIL);
        }
        return commandToExecute;
    }

    private String buildCommandToExecute(String sourceIp, String deviceIp, int numOfAttacks, String fileName) {
        StringBuilder buildCommand = new StringBuilder();
        buildCommand.append("sudo perl sendfile.pl ").append("-i ").append("eth0").append(" -d ").append(deviceIp)
                .append(" -si ").append(sourceIp).append(" -s ").append(numOfAttacks)
                .append(" -f ").append(fileName).append(".pcap")
                .append(" &");

        return buildCommand.toString();
    }
}
