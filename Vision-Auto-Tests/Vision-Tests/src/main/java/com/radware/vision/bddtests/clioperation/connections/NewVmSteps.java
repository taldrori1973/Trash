package com.radware.vision.bddtests.clioperation.connections;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.sutsystemobjects.VisionVMs;
import com.radware.vision.bddtests.BddCliTestBase;
import com.radware.vision.bddtests.vmoperations.Deploy.FreshInstallKVM;
import com.radware.vision.bddtests.vmoperations.Deploy.FreshInstallOVA;
import com.radware.vision.test_utils.DeployOva;
import com.radware.vision.vision_handlers.NewVmHandler;
import cucumber.api.DataTable;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

public class NewVmSteps extends BddCliTestBase {

    private String vCenterURL;
    private String hostip;
    private String resourcePool;

    private String destFolder = null;

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

    /**
     * Create a new VM
     * Deploy a VM and add license.
     *
     * @param newServer - data of the machine
     */
    @Then("^first Time wizard$")
    public void firstTimeWizardOva(DataTable newServer, VisionVMs vCenter) {
        List<Map<String, String>> listOfData = newServer.asMaps(String.class, String.class);

        for (Map<String, String> data : listOfData) {
            String newVmName = data.get("NewVmName");
            String version = data.get("version");
            String build = data.get("build");
            boolean isAPM = Boolean.parseBoolean(data.getOrDefault("isAPM", String.valueOf(false)));

            String vCenterUser = vCenter.getUserName();
            String vCenterPassword = vCenter.getPassword();
            hostip = vCenter.getvCenterIP();
            vCenterURL = vCenter.getvCenterURL();
            String networkName = vCenter.getNetworkName();
            resourcePool = vCenter.getResourcePool();
            String dataStores = vCenter.getDataStores();

            NewVmHandler handler = new NewVmHandler();
            try {
                FreshInstallOVA freshInstallOVA = new FreshInstallOVA(true, isAPM, null, null, "dev", "vision-snapshot-local");
                handler.firstTimeWizardOva(freshInstallOVA.getBuildFileInfo().getDownloadUri().getPath(),isAPM, vCenterURL, vCenterUser, vCenterPassword, hostip,
                        version, build, newVmName, null, networkName, resourcePool, destFolder, dataStores);
            } catch (Exception e) {
                BaseTestUtils.report("Setup Failed changing server to OFFLINE", Reporter.FAIL);
                BaseTestUtils.report("Failed to Create NewVm: " + data.get("NewVmName") + " failed with the following error: \n" +
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
        vCenterURL = visionVMs.getvCenterURL();
        hostip = visionVMs.getvCenterIP();
        resourcePool = visionVMs.getResourcePool();
        List<Map<String, String>> listOfData = dataTable.asMaps(String.class, String.class);
        for (Map<String, String> data : listOfData) {
            try {
                DeployOva.deleteVmMachines(vCenterURL, hostip, resourcePool, userName, password, data.get("VmMachinePrefix"), deleteMinutes);
            } catch (Exception e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }
    }
}
