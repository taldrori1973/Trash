package com.radware.vision.bddtests.clioperation.connections;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.sutsystemobjects.VisionVMs;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.test_utils.DeployOva;
import cucumber.api.DataTable;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

public class NewVmSteps extends BddCliTestBase {

    /**
     * Power of all machines in a dataTable.
     *
     * @param dataTable - table of VmMachinePrefix.
     */
    @Then("^Stop VM Machine$")
    public void StopMachine(DataTable dataTable) {
        List<Map<String, String>> listOfData = dataTable.asMaps(String.class, String.class);
        VisionVMs visionVMs = restTestBase.getVisionVMs();
        for (Map<String, String> data : listOfData) {
            try {
                DeployOva.stopStartVmMachines(restTestBase.getRadwareServerCli(), visionVMs.getvCenterURL(),
                        visionVMs.getvCenterIP(), visionVMs.getResourcePool(),
                        data.getOrDefault("userName", restTestBase.getRootServerCli().getUser()),
                        data.getOrDefault("password", restTestBase.getRootServerCli().getPassword()), data.get("VmMachinePrefix"), true);
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
