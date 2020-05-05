package com.radware.vision.bddtests.vmoperations;

import com.radware.automation.bdd.reporter.BddReporterManager;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.EsxiInfo;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.VMSnapshotOperations;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.targetvm.VmNameTargetVm;
import com.radware.vision.automation.tools.sutsystemobjects.VisionVMs;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.bddtests.clioperation.connections.NewVmSteps;
import com.radware.vision.bddtests.clioperation.system.upgrade.UpgradeSteps;
import com.radware.vision.bddtests.defenseFlow.defenseFlowDevice;
import com.radware.vision.bddtests.rest.BasicRestOperationsSteps;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.utils.RegexUtils;
import com.radware.vision.vision_handlers.NewVmHandler;
import com.radware.vision.vision_handlers.system.VisionServer;
import com.radware.vision.vision_project_cli.RootServerCli;
import com.radware.vision.vision_project_cli.VisionCli;
import com.radware.vision.vision_project_cli.VisionRadwareFirstTime;
import cucumber.api.DataTable;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import cucumber.runtime.junit.FeatureRunner;
import jsystem.framework.system.SystemManagerImpl;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.radware.vision.test_utils.DeployOva.getLastSuccessfulBuildNumberFromArtifactory;

public class VMOperationsSteps extends BddUITestBase {

    public VMOperationsSteps() throws Exception {
    }

    /**
     * @param vmNumber     - from the sut (1 for "vmName1" or 2 for "vmName2")
     * @param snapshotName - VM snapshot
     * @param withMemory   - option take snapshot with memory
     */
    @When("^Take snapshot from Vision number (\\d+) with name \"(.*)\"( with memory)?$")
    public void takeSnapshot(int vmNumber, String snapshotName, String withMemory) {
        try {
            boolean withMem = withMemory != null;
            VisionVMs visionVMs = restTestBase.getVisionVMs();
            String vmName = visionVMs.getVMNameByIndex(vmNumber);
            EsxiInfo esxiInfo = new EsxiInfo(visionVMs.getvCenterURL(), visionVMs.getUserName(), visionVMs.getPassword(), visionVMs.getResourcePool());
            VMSnapshotOperations.newInstance().doSnapshot(new VmNameTargetVm(esxiInfo, vmName), snapshotName, withMem);
        } catch (Exception e) {
            BaseTestUtils.report("Error creating snapshot: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * @param vmNumber - from the sut (1 for "vmName1" or 2 for "vmName2")
     */
    @When("^Revert Vision number (\\d+) to snapshot$")
    public void revertSnapshot(int vmNumber) throws Exception {
        try {
            String snapshot = getVisionSetupAttributeFromSUT("snapshot");
            if (snapshot == null || snapshot.equals("")) {
                BaseTestUtils.report("Could not find snapshot in SUT file performing internal upgrade", Reporter.PASS_NOR_FAIL);
                return;
            }
            VisionVMs visionVMs = restTestBase.getVisionVMs();
            String vmName = visionVMs.getVMNameByIndex(vmNumber);
            EsxiInfo esxiInfo = new EsxiInfo(visionVMs.getvCenterURL(), visionVMs.getUserName(), visionVMs.getPassword(), visionVMs.getResourcePool());
            BaseTestUtils.report("Reverting to snapshot " + snapshot, Reporter.PASS_NOR_FAIL);
            VMSnapshotOperations.newInstance().switchToSnapshot(new VmNameTargetVm(esxiInfo, vmName), snapshot, true);
            BaseTestUtils.report("Revert done", Reporter.PASS_NOR_FAIL);
            Thread.sleep(6 * 60 * 1000);
            CliOperations.runCommand(getRestTestBase().getRootServerCli(), "\"yes|restore_radware_user_password\"", 15 * 1000);
            if (VisionServer.waitForVisionServerServicesToStartHA(restTestBase.getRadwareServerCli(), 45 * 60 * 1000))
                BaseTestUtils.report("All services up", Reporter.PASS);
            else {
                BaseTestUtils.report("Not all services up.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Error reverting snapshot: " + parseExceptionBody(e), Reporter.FAIL);
        } finally {
            restTestBase.getRadwareServerCli().setConnectOnInit(true);
            restTestBase.getRadwareServerCli().init();
            restTestBase.getRootServerCli().setConnectOnInit(true);
            restTestBase.getRootServerCli().init();
        }
    }

    @When("^Revert DefenseFlow to snapshot$")
    public void DfenseFlowRevertToSnapshot() throws Exception {
        try {
            defenseFlowDevice DF = (defenseFlowDevice) system.getSystemObject("defenseFlowDevice");
            EsxiInfo esxiInfo = new EsxiInfo(DF.getvCenterURL(), DF.getvCenterUserName(), DF.getvCenterPassword(), DF.getResourcePool());
            BaseTestUtils.report("Reverting Defense Flow to snapshot " + DF.getSnapshot(), Reporter.PASS_NOR_FAIL);
            VMSnapshotOperations.newInstance().switchToSnapshot(new VmNameTargetVm(esxiInfo, DF.vmName), DF.snapshot, true);
            Thread.sleep(10 * 60 * 1000);
            BaseTestUtils.report("DefenseFlow Revert done.", Reporter.PASS_NOR_FAIL);
        } catch (Exception e) {

        }
    }


    //    private boolean waitForServerConnection(long timeout, CliConnectionImpl connection) throws InterruptedException {
//        long startTime = System.currentTimeMillis();
//        while (System.currentTimeMillis() - startTime < timeout) {
//            try {
//                connection.connect();
//                return true;
//            } catch (Exception e) {
//                Thread.sleep(10000);
//                continue;
//            }
//        }
//        return false;
//    }
    public void deleteKvm() throws Exception {
        NewVmHandler handler = new NewVmHandler();
        String vmName = handler.visionRadwareFirstTime.getVmName() + handler.visionRadwareFirstTime.getIp();
        handler.deleteKvm(vmName);
    }

    public static void revertKvmSnapshot(String snapshotName, VisionRadwareFirstTime visionRadwareFirstTime) throws Exception {
        String vmName = visionRadwareFirstTime.getVmName() + visionRadwareFirstTime.getIp();
        CliOperations.runCommand(visionRadwareFirstTime, "virsh list --all");
        boolean isContained = RegexUtils.isStringContainsThePattern(vmName, CliOperations.lastOutput);
        if (!isContained) {
            throw new Exception("the " + vmName + "does not exist");
        }
        int DEFAULT_KVM_CLI_TIMEOUT = 3000;
        CliOperations.runCommand(visionRadwareFirstTime, "virsh start " + vmName, DEFAULT_KVM_CLI_TIMEOUT);
        Thread.sleep(60 * 1000);
        BaseTestUtils.report("Reverting to snapshot.", Reporter.PASS_NOR_FAIL);
        CliOperations.runCommand(visionRadwareFirstTime, "virsh snapshot-revert --domain " + vmName + " --snapshotname " + snapshotName + " --force", 15 * 60 * 1000);
        BaseTestUtils.report("Starting server after revert.", Reporter.PASS_NOR_FAIL);
        CliOperations.runCommand(visionRadwareFirstTime, "virsh start " + vmName, DEFAULT_KVM_CLI_TIMEOUT);
        String error = ".*Domain not found.*";
        isContained = RegexUtils.isStringContainsThePattern(error, CliOperations.lastOutput);
        if (isContained) {
            String domain = "vision_auto_" + visionRadwareFirstTime.getIp();
            throw new Exception("error: Domain not found: no domain with matching name '" + domain + "' ");
        }
        CliOperations.runCommand(visionRadwareFirstTime, "virsh domstate " + vmName, DEFAULT_KVM_CLI_TIMEOUT);
        isContained = RegexUtils.isStringContainsThePattern("running", CliOperations.lastRow);
        if (!isContained)
            BaseTestUtils.report("Server is not running. status is: " + CliOperations.lastOutput, Reporter.FAIL);

        Thread.sleep(6 * 60 * 1000);
        RootServerCli rootServerCli = new RootServerCli(visionRadwareFirstTime.getIp(),"root","radware");
        rootServerCli.init();
        CliOperations.runCommand(rootServerCli, "\"yes|restore_radware_user_password\"", 15 * 1000);
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "\"yes|restore_radware_user_password\"", 15 * 1000);
        if (VisionServer.waitForVisionServerServicesToStartHA(restTestBase.getRadwareServerCli(), 45 * 60 * 1000))
            BaseTestUtils.report("All services up", Reporter.PASS);
        else {
            BaseTestUtils.report("Not all services up.", Reporter.FAIL);
        }

    }

    @Then("^Prerequisite for Setup(\\s+force)?$")
    public void prerequisiteForSetup(String force) {
        if (force != null || isSetupNeeded()) {
            try {
                String setupMode = getVisionSetupAttributeFromSUT("setupMode");
                VisionRadwareFirstTime visionRadwareFirstTime = (VisionRadwareFirstTime) system.getSystemObject("visionRadwareFirstTime");
                if (setupMode == null) throw new NullPointerException("Can't find \"setupMode\" at SUT File");
                String snapshot = getVisionSetupAttributeFromSUT("snapshot");
                if ((snapshot == null || snapshot.equals("")) && setupMode.toLowerCase().contains("upgrade")) {
                    BaseTestUtils.report("Could not find snapshot in SUT file performing internal upgrade", Reporter.PASS);
                    return;
                }
                switch (setupMode.toLowerCase()) {
                    case "kvm_upgrade_inparallel":
                        revert_kvm_upgrade_InParallel(snapshot, visionRadwareFirstTime);
                        break;

                    case "upgrade_inparallel":
                        revertSnapshot(1);
                        revertSnapshot(2);
                        break;

                    case "kvm_upgrade":
                        revertKvmSnapshot(snapshot, visionRadwareFirstTime);
                        break;

                    case "upgrade":
                        revertSnapshot(1);
                        break;

                    case "fresh install_inparallel":
                    case "fresh install":
                        prefreshInstall();
                        break;

                    case "kvm_fresh install":
                        deleteKvm();
                        break;

                    case "physical":
                        break;
                }
                if (setupMode.toLowerCase().contains("upgrade")) {
                    afterUpgrade();
                }

            } catch (Exception e) {
                e.printStackTrace();
                BaseTestUtils.report(e.getMessage() + " ", Reporter.FAIL);
            }
        }
    }

    private void afterUpgrade() throws Exception {
        InvokeUtils.invokeCommand(null, "yes|restore_radware_user_password", restTestBase.getRootServerCli(), 15 * 1000, true, false, true);
        updateVersionVar();
    }

    private void revert_kvm_upgrade_InParallel(String snapshot, VisionRadwareFirstTime visionRadwareFirstTime) throws Exception {
        KVMSnapShotThread firstMachine = new KVMSnapShotThread(snapshot, visionRadwareFirstTime);
        firstMachine.start();
        visionRadwareFirstTime = (VisionRadwareFirstTime) system.getSystemObject("visionRadwareFirstTime2");
        KVMSnapShotThread secondMachine = new KVMSnapShotThread(snapshot, visionRadwareFirstTime);
        secondMachine.start();
        while (true) {
            if (!firstMachine.isAlive() && !secondMachine.isAlive())
                break;
        }
    }

    private void prefreshInstall() {
        NewVmSteps newVmSteps = new NewVmSteps();
        String vmPrefix = getVisionSetupAttributeFromSUT("vmPrefix");
        if (vmPrefix == null) throw new NullPointerException("Can't find \"vmPrefix\" at SUT File");
        List<String> columnName = Collections.singletonList("VmMachinePrefix");
        List<String> value = Collections.singletonList(vmPrefix);
        List<List<String>> row = Arrays.asList(columnName, value);
        DataTable dataTable = DataTable.create(row, Locale.getDefault(), "VmMachinePrefix");
        newVmSteps.StopMachine(dataTable);
    }

    @Then("^Fresh Install In Parallel$")
    public void freshInstallInParallel() {
        freshInstallThread machine1 = new freshInstallThread("visionRadwareFirstTime", "visionCli", getVisionSetupAttributeFromSUT("vmPrefix"));
        machine1.start();
        freshInstallThread machine2 = new freshInstallThread("visionRadwareFirstTime2", "visionCli2", "freshInstallTest2");
        machine2.start();
        while (true) {
            if (!machine1.isAlive() && !machine2.isAlive())
                break;
        }
    }

    @Then("^Upgrade or Fresh Install Vision$")
    public void upgradeOrFreshInstallVision() {
        UpgradeSteps upgradeSteps = new UpgradeSteps();
        if (!isSetupNeeded()) return;
        String setupMode = getVisionSetupAttributeFromSUT("setupMode");
        if (setupMode == null) throw new NullPointerException("Can't find \"setupMode\" at SUT File");
        String version = readVisionVersionFromPomFile();
        String build = "";
        build = BaseTestUtils.getRuntimeProperty("BUILD", build);//get build from portal
        boolean isAPM = getVisionSetupAttributeFromSUT("isAPM") != null && Boolean.parseBoolean(getVisionSetupAttributeFromSUT("isAPM"));

        switch (setupMode.toLowerCase()) {
            case "kvm_upgrade":
            case "upgrade":
                upgradeSteps.UpgradeVisionServer(version, build);
                break;

            case "upgrade_inparallel":
            case "kvm_upgrade_inparallel":
                upgradeSteps.UpgradeVisionToLatestBuildTwoMachines();
                break;

            case "kvm_fresh install":
                NewVmHandler vmHandler = new NewVmHandler();
                try {
                    vmHandler.firstTimeWizardKVM(isAPM, version, build);
                } catch (Exception e) {
                    BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
                }
                break;

            case "fresh install_inparallel":
                freshInstallInParallel();
                break;

            case "fresh install":
                VisionVMs visionVMs = restTestBase.getVisionVMs();
                NewVmSteps newVmSteps = new NewVmSteps();
                String vmName = getVisionSetupAttributeFromSUT("vmPrefix");
                if (vmName == null) throw new NullPointerException("Can't find \"vmPrefix\" at SUT File");

                List<String> columnNames = Arrays.asList("version", "build", "NewVmName", "isAPM");
                List<String> values;
                values = Arrays.asList(version, build, vmName, String.valueOf(isAPM));
                List<List<String>> row = Arrays.asList(columnNames, values);
                DataTable dataTable = DataTable.create(row, Locale.getDefault(), "version", "build", "NewVmName", "isAPM");
                newVmSteps.firstTimeWizardOva(dataTable, visionVMs);
                break;

            case "physical":
                try {
                    NewVmHandler newVmHandler = new NewVmHandler();
                    newVmHandler.firstTimeWizardIso(version, build);
                    BasicRestOperationsSteps basicRestOperationsSteps = new BasicRestOperationsSteps();
                    basicRestOperationsSteps.loginWithActivation("radware", "radware");
                } catch (Exception e) {
                    BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
                }
                break;

            default: {
                BaseTestUtils.report("Setup mode:" + setupMode + " is not familiar.", Reporter.FAIL);
            }
        }
        updateVersionVar();
    }

    private String getVisionSetupAttributeFromSUT(String attribute) {
        VisionCli visionCli = null;
        try {
            visionCli = (VisionCli) SystemManagerImpl.getInstance().getSystemObject("visionCli");
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (visionCli == null) throw new NullPointerException("Can't find \"visionCli\" at SUT File");

        switch (attribute) {
            case "setupMode":
                return visionCli.visionServer.visionSetup.getSetupMode();
            case "snapshot":
                return visionCli.visionServer.visionSetup.getSnapshot();
            case "vmPrefix":
                return visionCli.visionServer.visionSetup.getVmPrefix();
            case "FileNamePrefix":
                return visionCli.visionServer.visionSetup.getFileNamePrefix();
            case "isAPM":
                return visionCli.visionServer.visionSetup.getIsAPM();
        }
        return null;
    }

    public String readVisionVersionFromPomFile() {
        Properties properties = new Properties();

        InputStream inputStream = getClass().getClassLoader().getResourceAsStream("vision-tests-pom.properties");

        if (inputStream != null) {
            try {
                properties.load(inputStream);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        return properties.getProperty("vision-version");
    }

    public boolean isSetupNeeded() {
        boolean isSetupNeeded;
        String version = readVisionVersionFromPomFile();
//        String versionPrefix = version.substring(0, 4);//example : 4.10.00 --> 4.10
        String build = System.getenv("BUILD");//get build from portal
        restTestBase.getRootServerCli().getVersionNumebr();
        if (build == null || build.equals("") || build.equals("0"))
            try {
                BaseTestUtils.report("No build was supplied. Going for latest", Reporter.PASS);
                build = getLastSuccessfulBuildNumberFromArtifactory(NewVmHandler.jenkinsURL);//Latest Build
            } catch (IOException e) {
                e.printStackTrace();
            }
        String currentBuild = FeatureRunner.getBuild();
        String currentVersion = FeatureRunner.getVersion();

        isSetupNeeded = !currentVersion.equals(version) || !currentBuild.equals(build);
        if (isSetupNeeded) {
            BaseTestUtils.report("Current Build: " + currentBuild, Reporter.PASS);
            BaseTestUtils.report("Current Version: " + currentVersion, Reporter.PASS);
            BaseTestUtils.report("Needed Build: " + build, Reporter.PASS);
            BaseTestUtils.report("Needed Version: " + version, Reporter.PASS);
        }

        return isSetupNeeded;
    }

    /**
     * Update variables for local objects and automation portal regrading the new version and build.
     * Relevant to be used after revert to snapshot and upgrade
     */
    private void updateVersionVar() {
        String version = "";
        String build = "";
        try {
            CliOperations.runCommand(restTestBase.getRootServerCli(), "service vision version");
            String x = CliOperations.lastOutput;
            Pattern pattern = Pattern.compile("APSolute\\s+Vision\\s+(\\d+\\.\\d+\\.\\d+)\\s+\\(build\\s+(\\d+)\\)");
            Matcher matcher = pattern.matcher(x);
            if (matcher.find()) {
                version = matcher.group(1);
                build = matcher.group(2);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to get version and build from server", Reporter.FAIL);
        }
        //update runtime variables
        restTestBase.getRootServerCli().setVersionNumebr(version);
        restTestBase.getRootServerCli().setBuildNumber(build);
        //Update portal
        FeatureRunner.update_version_build_mode(version, build, BddReporterManager.getRunMode());
    }
}
