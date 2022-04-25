package com.radware.vision.bddtests.clioperation.connections;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.EnvironmentDto;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.test_utils.DeployOva;
import cucumber.api.DataTable;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

public class NewVmSteps extends TestBase {

    /**
     * Power of all machines in a dataTable.
     *
     * @param dataTable - table of VmMachinePrefix.
     */
    @Then("^Stop VM Machine$")
    public void StopMachine(DataTable dataTable) {
        List<Map<String, String>> listOfData = dataTable.asMaps(String.class, String.class);
        String vCenterUser = getSutManager().getEnvironment().get().getUser();
        String vCenterPassword = getSutManager().getEnvironment().get().getPassword();
        String hostIp = getSutManager().getEnvironment().get().getHostIp();
        String vCenterURL = getSutManager().getEnvironment().get().getUrl();
        String resourcePool = getSutManager().getEnvironment().get().getResourcePool();

        for (Map<String, String> data : listOfData) {
            try {
                DeployOva.stopStartVmMachines(restTestBase.getRadwareServerCli(), vCenterURL,
                        hostIp, resourcePool,
                        data.getOrDefault("userName", vCenterUser),
                        data.getOrDefault("password", vCenterPassword), data.get("VmMachinePrefix"), true);
            } catch (Exception e) {
                BaseTestUtils.report("Stopping VM with prefix: " + data.get("VmMachinePrefix") + " failed with the following error: \n" +
                        "Message: " + e.getMessage() + "\n" +
                        "Cause: " + e.getCause() + "\n" +
                        "Stack Trace: " + Arrays.asList(e.getStackTrace()), Reporter.FAIL);
            }
        }

    }

    @Given("^Remove old VMs$")
    public void removeOldVms(DataTable dataTable) {
        EnvironmentDto environmentDto = getSutManager().getEnvironment().get();
        String userName = environmentDto.getUser();
        String password = environmentDto.getPassword();
        int deleteMinutes = 24 * 60;
        String vCenterURL = environmentDto.getUrl();
        String hostIp = environmentDto.getHostIp();
        String resourcePool = environmentDto.getResourcePool();
        List<Map<String, String>> listOfData = dataTable.asMaps(String.class, String.class);
        for (Map<String, String> data : listOfData) {
            try {
                BaseTestUtils.report("removing server: " + data.get("VmMachinePrefix"), Reporter.PASS_NOR_FAIL);
                DeployOva.deleteVmMachines(vCenterURL, hostIp, resourcePool, userName, password,
                        data.get("VmMachinePrefix"), deleteMinutes);
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }
    }
}
