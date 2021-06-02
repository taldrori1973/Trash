package com.radware.vision.bddtests.clioperation.connections;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.automation.tools.sutsystemobjects.VisionVMs;
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
        String vCenterUser = getSutManager().getEnviorement().get().getUser();
        String vCenterPassword = getSutManager().getEnviorement().get().getPassword();
        String hostIp = getSutManager().getEnviorement().get().getHostIp();
        String vCenterURL = getSutManager().getEnviorement().get().getUrl();
        String resourcePool = getSutManager().getEnviorement().get().getResourcePool();

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
        VisionVMs visionVMs = restTestBase.getVisionVMs();
        String userName = visionVMs.getUserName();
        String password = visionVMs.getPassword();
        int deleteMinutes = 24 * 60;
        String vCenterURL = visionVMs.getvCenterURL();
        String hostIp = visionVMs.getvCenterIP();
        String resourcePool = visionVMs.getResourcePool();
        List<Map<String, String>> listOfData = dataTable.asMaps(String.class, String.class);
        for (Map<String, String> data : listOfData) {
            try {
                DeployOva.deleteVmMachines(vCenterURL, hostIp, resourcePool, userName, password, data.get("VmMachinePrefix"), deleteMinutes);
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }
    }
}
