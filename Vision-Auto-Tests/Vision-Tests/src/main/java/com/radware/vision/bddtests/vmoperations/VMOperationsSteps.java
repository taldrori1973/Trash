package com.radware.vision.bddtests.vmoperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.utils.AutoDBUtils;
import com.radware.vision.automation.Deploy.NewVmHandler;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.bddtests.clioperation.connections.NewVmSteps;
import com.radware.vision.bddtests.clioperation.system.upgrade.UpgradeSteps;
import com.radware.vision.bddtests.vmoperations.Deploy.FreshInstallKVM;
import com.radware.vision.bddtests.vmoperations.Deploy.FreshInstallOVA;
import com.radware.vision.bddtests.vmoperations.Deploy.Physical;
import com.radware.vision.bddtests.vmoperations.Deploy.Upgrade;
import com.radware.vision.enums.VisionDeployType;
import com.radware.vision.vision_handlers.system.upgrade.visionserver.VisionDeployment;
//import com.radware.vision.vision_project_cli.VisionCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.VisionRadwareFirstTime;
import cucumber.api.DataTable;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import cucumber.runtime.junit.FeatureRunner;
import jsystem.framework.system.SystemManagerImpl;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;

import static com.radware.vision.bddtests.remotessh.RemoteSshCommandsTests.resetPassword;


public class VMOperationsSteps extends VisionUITestBase {

    public static VMOperationsSteps newInstance() throws Exception {
        return new VMOperationsSteps();
    }

    public VMOperationsSteps() throws Exception {
    }

    @When("Upgrade Vision According To SUT Snapshot$")
    public void upgradeAccordingToSnapshot() throws Exception {
        VmSnapShotOperations.newInstance().upgradeAccordingToSnapshot();
    }

    /**
     * @param vmNumber     - from the sut (1 for "vmName1" or 2 for "vmName2")
     * @param snapshotName - VM snapshot
     * @param withMemory   - option take snapshot with memory
     */
    @When("^Take VMWare snapshot from Vision number (\\d+) with name \"(.*)\"( with memory)?$")
    public void takeSnapshot(int vmNumber, String snapshotName, String withMemory) throws Exception {
        VmSnapShotOperations.newInstance().takeSnapshotVMWare(vmNumber, snapshotName, withMemory);
    }

    @When("^Rename VMWare Snapshot \"([^\"]*)\" to \"([^\"]*)\"(?: with description \"([^\"]*)\")?$")
    public void renameSnapshot(String snapshotName, String newSnapshotName, String descriptionOfSnapshot) throws Exception {
        if (descriptionOfSnapshot == null)
            descriptionOfSnapshot = "Automation";
        VmSnapShotOperations.newInstance().renameSnapshotVMWare(snapshotName, newSnapshotName, descriptionOfSnapshot);
    }

    @When("^Delete VMWare Snapshot \"([^\"]*)\"$")
    public void deleteSnapshot(String snapshotName) throws Exception {
        VmSnapShotOperations.newInstance().deleteSnapshotVMWare(snapshotName);
    }

    /**
     * @param vmNumber - from the sut (1 for "vmName1" or 2 for "vmName2")
     */
    @When("^Revert Vision number (\\d+) to snapshot$")
    public void revertSnapshot(int vmNumber) throws Exception {
        VmSnapShotOperations.newInstance().revertVMWareSnapshot(vmNumber, true);
    }

    @When("^Revert DefenseFlow to snapshot$")
    public void DfenseFlowRevertToSnapshot() {
        try {
            //Kvision
//            defenseFlowDevice DF = (defenseFlowDevice) system.getSystemObject("defenseFlowDevice");
//            EsxiInfo esxiInfo = new EsxiInfo(DF.getvCenterURL(), DF.getvCenterUserName(), DF.getvCenterPassword(), DF.getResourcePool());
//            BaseTestUtils.report("Reverting Defense Flow to snapshot " + DF.getSnapshot(), Reporter.PASS_NOR_FAIL);
//            VMSnapshotOperations.newInstance().switchToSnapshot(new VmNameTargetVm(esxiInfo, DF.vmName), DF.snapshot, true);
            Thread.sleep(10 * 60 * 1000);
            BaseTestUtils.report("DefenseFlow Revert done.", Reporter.PASS_NOR_FAIL);
        } catch (Exception e) {
            BaseTestUtils.report("Revert failed:\n" + e.getMessage(), Reporter.FAIL);
        }
    }


    public void deleteKvm() throws Exception {
        NewVmHandler handler = new NewVmHandler();
        String vmName = handler.visionRadwareFirstTime.getVmName() + handler.visionRadwareFirstTime.getIp();
        handler.deleteKvm(vmName);
    }

    public static void revertKvmSnapshot(String snapshotName, VisionRadwareFirstTime visionRadwareFirstTime) throws Exception {
        VmSnapShotOperations.newInstance().revertKvmSnapshot(snapshotName, visionRadwareFirstTime);
    }

    @When("^Take KVM Snapshot \"(.*)\"$")
    public void createKVmSnapshot(String snapshotName) throws Exception {
        VmSnapShotOperations.newInstance().takeKVmSnapshot(snapshotName);
    }


    @Then("^Prerequisite for Setup(\\s+force)?$")
    public void prerequisiteForSetup(String force) {
        String setupMode;
        String snapshot;
        VisionRadwareFirstTime visionRadwareFirstTime;
        try {
            setupMode = getVisionSetupAttributeFromSUT("setupMode");
            //kVision
//            visionRadwareFirstTime = (VisionRadwareFirstTime) system.getSystemObject("visionRadwareFirstTime");
            if (setupMode == null) throw new NullPointerException("Can't find \"setupMode\" at SUT File");
            snapshot = getVisionSetupAttributeFromSUT("snapshot");
            if ((snapshot == null || snapshot.equals("")) && setupMode.toLowerCase().contains("upgrade")) {
                BaseTestUtils.report("Could not find snapshot in SUT file performing internal upgrade", Reporter.PASS_NOR_FAIL);
                return;
            }
            /* Fresh section */
            switch (setupMode.toLowerCase()) {
                case "fresh install_inparallel":
                case "fresh install":
                    preFreshInstall();
                    return;

                case "kvm_fresh install":
                    deleteKvm();
                    return;
//
//                case "physical":
//                    return;
//                /* Upgrade section */
                case "kvm_upgrade_inparallel":
                    //Kvision
//                    revert_kvm_upgrade_InParallel(snapshot, visionRadwareFirstTime);
                    afterUpgrade();
                    return;

                case "upgrade_inparallel":
                    revertSnapshot(1);
                    revertSnapshot(2);
                    afterUpgrade();
                    return;

                case "kvm_upgrade":
                    //kVision
//                    revertKvmSnapshot(snapshot, visionRadwareFirstTime);
                    afterUpgrade();
                    return;

                case "upgrade":
                    revertSnapshot(1);
                    afterUpgrade();
                    return;
                default:
                    BaseTestUtils.report("What is wrong with you man? there is no such a mode as: " + setupMode, Reporter.FAIL);
            }

        } catch (Exception e) {
            e.printStackTrace();
            BaseTestUtils.report(e.getMessage() + " ", Reporter.FAIL);
        }
    }

    private void afterUpgrade() {
        resetPassword();
        updateVersionVar();
    }

    private void revert_kvm_upgrade_InParallel(String snapshot, VisionRadwareFirstTime visionRadwareFirstTime) throws Exception {
        KVMSnapShotThread firstMachine = new KVMSnapShotThread(snapshot, visionRadwareFirstTime);
        firstMachine.start();
        //kVision
//        visionRadwareFirstTime = (VisionRadwareFirstTime) system.getSystemObject("visionRadwareFirstTime2");
        KVMSnapShotThread secondMachine = new KVMSnapShotThread(snapshot, visionRadwareFirstTime);
        secondMachine.start();
        while (true) {
            if (!firstMachine.isAlive() && !secondMachine.isAlive())
                break;
        }
    }

    private void preFreshInstall() {
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
        try {
//            String setupMode = getVisionSetupAttributeFromSUT("setupMode");
            String setupMode = getSutManager().getSetupMode();
            if (setupMode == null) throw new NullPointerException("Can't find \"setupMode\" at SUT File");

            switch (setupMode.toLowerCase()) {
                case "kvm_upgrade":
                case "upgrade":
                    Optional<RadwareServerCli> radwareServerCliOpt = TestBase.getServersManagement().getRadwareServerCli();
                    if (!radwareServerCliOpt.isPresent()) {
                        throw new Exception("Radware Server Not found!");
                    }
                    Optional<RootServerCli> rootServerCliOpt = TestBase.getServersManagement().getRootServerCLI();
                    if (!rootServerCliOpt.isPresent()) {
                        throw new Exception("Root Server Not found!");
                    }
                    Upgrade upgrade = new Upgrade(true, null, radwareServerCliOpt.get(), rootServerCliOpt.get());
                    upgrade.deploy();
                    break;
                case "upgrade_inparallel":
                case "kvm_upgrade_inparallel":
                    UpgradeSteps.UpgradeVisionToLatestBuildTwoMachines();
                    break;
                case "kvm_fresh install":
                    FreshInstallKVM freshInstallKVM = new FreshInstallKVM(true, null);
                    freshInstallKVM.deploy();
                    break;
//                case "fresh install_inparallel":
//                    freshInstallInParallel();
//                    break;
                case "fresh install":
                    FreshInstallOVA freshInstallOVA = new FreshInstallOVA(true, null);
                    freshInstallOVA.deploy();
                    break;
                default: {
                    BaseTestUtils.report("Setup mode:" + setupMode + " is not familiar.", Reporter.FAIL);
                }
            }
            updateVersionVar();
            //kVision
//        CliOperations.runCommand(restTestBase.getRootServerCli(), "chkconfig --level 345 rsyslog on", CliOperations.DEFAULT_TIME_OUT);
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "/usr/sbin/ntpdate -u europe.pool.ntp.org", 2 * 60 * 1000);
        }catch (Exception e){
            e.getMessage();
        }
    }

    public static String getVisionSetupAttributeFromSUT(String attribute) {
//        VisionCli visionCli = null;
//        try {
//            visionCli = (VisionCli) SystemManagerImpl.getInstance().getSystemObject("visionCli");
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        if (visionCli == null) throw new NullPointerException("Can't find \"visionCli\" at SUT File");

        switch (attribute) {
            case "setupMode":
                return getSutManager().getSetupMode();
            case "snapshot":
                return getSutManager().getSnapshotName();
            case "vmPrefix":
                return getSutManager().getServerName();
//            case "FileNamePrefix":
//                return visionCli.visionServer.visionSetup.getFileNamePrefix();
//            case "serverType":
//                return visionCli.visionServer.visionSetup.getServerType();
        }
        return null;
    }

    public static String readVisionVersionFromPomFile() {
        Properties properties = new Properties();
        InputStream inputStream = VMOperationsSteps.class.getClassLoader().getResourceAsStream("vision-tests-pom.properties");
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
        String build = BaseTestUtils.getRuntimeProperty("BUILD", null); //get build from portal
//        restTestBase.getRootServerCli().getVersionNumebr();
        if (build == null || build.equals("") || build.equals("0")) {
            BaseTestUtils.report("No build was supplied. Going for latest", Reporter.PASS);
            build = new VisionDeployment(VisionDeployType.ANY, version, build).getBuild();//Latest Build
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
        //Lock the build
        AutoDBUtils.updateTaskBuild(build);
        return isSetupNeeded;
    }

    /**
     * Update variables for local objects and automation portal regrading the new version and build.
     * Relevant to be used after revert to snapshot and upgrade
     */
    public static void updateVersionVar() {
        //kVision
//        VisionInfo visionInfo = new VisionInfo(getRestTestBase().getGenericRestClient().getDeviceIp());
//        String version = visionInfo.getVisionVersion();
//        String featureBranch = visionInfo.getVisionBranch();
//        String build = visionInfo.getVisionBuild();
        //update runtime variables
//        restTestBase.getRootServerCli().setVersionNumebr(version);
//        restTestBase.getRootServerCli().setBuildNumber(build);
        //Update portal
//        FeatureRunner.update_version_build_mode(version, build, BddReporterManager.getRunMode());
//        FeatureRunner.update_station_sutName(restTestBase.getRootServerCli().getHost(), System.getProperty("SUT"));

    }
}
