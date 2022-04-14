package com.radware.vision.bddtests.vmoperations;

import com.radware.automation.bdd.reporter.BddReporterManager;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.utils.AutoDBUtils;
import com.radware.vision.automation.AutoUtils.SUT.dtos.EnvironmentDto;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.Deploy.NewVmHandler;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.bddtests.clioperation.connections.NewVmSteps;
import com.radware.vision.bddtests.clioperation.system.upgrade.UpgradeSteps;
import com.radware.vision.bddtests.visionsettings.VisionInfo;
import com.radware.vision.bddtests.vmoperations.Deploy.*;
import com.radware.vision.enums.VisionDeployType;
import com.radware.vision.setup.SetupImpl;
import com.radware.vision.vision_handlers.system.upgrade.visionserver.VisionDeployment;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.VisionRadwareFirstTime;
import cucumber.api.DataTable;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import cucumber.runtime.junit.FeatureRunner;

import com.radware.vision.automation.tools.esxitool.snapshotoperations.EsxiInfo;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.VMSnapshotOperations;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.targetvm.VmNameTargetVm;

import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.concurrent.TimeUnit;

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
            TreeDeviceManagementDto df = sutManager.getDefenseFlow().get();
            EnvironmentDto dfEnv = sutManager.getDefenseFlowEnviorement().get();
            EsxiInfo esxiInfo = new EsxiInfo(dfEnv.getUrl(), dfEnv.getUser(), dfEnv.getPassword(), dfEnv.getResourcePool());
            BaseTestUtils.report("Reverting Defense Flow to snapshot " + df.getSnapshot(), Reporter.PASS_NOR_FAIL);
            VMSnapshotOperations.newInstance().switchToSnapshot(new VmNameTargetVm(esxiInfo, df.getDeviceName()), df.getSnapshot(), true);
            Thread.sleep(10 * 60 * 1000);
            BaseTestUtils.report("DefenseFlow Revert done.", Reporter.PASS_NOR_FAIL);
        } catch (Exception e) {
            BaseTestUtils.report("Revert failed:\n" + e.getMessage(), Reporter.FAIL);
        }
    }


    public void deleteKvm() throws Exception {
        NewVmHandler handler = new NewVmHandler();
        String vmPrefix = getVisionSetupAttributeFromSUT("vmPrefix");
        String vmName = String.format("%s_%s", vmPrefix, handler.visionRadwareFirstTime.getIp());
        // ToDo - check why setConnectOnInit is true
        handler.visionRadwareFirstTime.setConnectOnInit(false);
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

                case "qcow2_fresh install":
                case "kvm_fresh install":
                    deleteKvm();
                    return;
//
//                case "physical":
//                    return;
//                /* Upgrade section */
                case "kvm_upgrade_inparallel":
                case "upgrade_inparallel":
                    RevertSnapshotHandler.revertSnapshot(RevertMachines.MACHINEAndPAIR, 60, TimeUnit.MINUTES);
                    afterUpgrade();
                    return;

                case "kvm_upgrade":
                case "upgrade":
                    RevertSnapshotHandler.revertSnapshot(RevertMachines.MACHINE, 60, TimeUnit.MINUTES);
                    afterUpgrade();
                    return;
                default:
                    BaseTestUtils.report("What is wrong with you man? there is no such a mode as: " + setupMode, Reporter.FAIL);
            }

        } catch (Exception e) {
            e.printStackTrace();
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
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
        NewVmHandler handler = new NewVmHandler();
        String vmPrefix = getVisionSetupAttributeFromSUT("vmPrefix");
        String vmName = String.format("%s_%s", vmPrefix, handler.visionRadwareFirstTime.getIp());
        if (vmPrefix == null) throw new NullPointerException("Can't find \"vmPrefix\" at SUT File");
        List<String> columnName = Collections.singletonList("VmMachinePrefix");
        List<String> value = Collections.singletonList(vmName);
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
            String setupMode = getSutManager().getDeployConfigurations().getSetupMode();
            if (setupMode == null) throw new NullPointerException("Can't find \"setupMode\" at SUT File");

            switch (setupMode.toLowerCase()) {
                case "kvm_upgrade":
                case "upgrade":
                    RadwareServerCli radwareServerCli = null;
                    RootServerCli rootServerCli = null;
                    if (serversManagement.getRadwareServerCli().isPresent())
                        radwareServerCli = serversManagement.getRadwareServerCli().get();
                    if (serversManagement.getRootServerCLI().isPresent())
                        rootServerCli = serversManagement.getRootServerCLI().get();
                    assert rootServerCli != null;
                    assert radwareServerCli != null;
                    //Upgrade upgrade = new Upgrade(true, null, radwareServerCli, rootServerCli);
                    Upgrade upgrade = DeployFactory.getUpgrade(radwareServerCli, rootServerCli);
                    upgrade.deploy();
                    break;

                case "upgrade_inparallel":
                case "kvm_upgrade_inparallel":
                    UpgradeSteps.UpgradeVisionToLatestBuildTwoMachines();
                    break;

                case "qcow2_fresh install":
                case "serial iso_fresh install":
                case "fresh install":
                    String environmentType = getSutManager().getEnviorement().get().getName().split("-")[0];
                    FreshInstall freshInstall = DeployFactory.getFreshInstall(environmentType);
                    assert freshInstall != null;
                    freshInstall.deploy();
                    break;

//                case "fresh install_inparallel":
//                    freshInstallInParallel();
//                    break;
                default: {
                    BaseTestUtils.report("Setup mode:" + setupMode + " is not familiar.", Reporter.FAIL);
                }
            }
            updateVersionVar();
            SetupImpl setup = new SetupImpl();
            setup.buildSetup();
            //kVision
//        CliOperations.runCommand(restTestBase.getRootServerCli(), "chkconfig --level 345 rsyslog on", CliOperations.DEFAULT_TIME_OUT);
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "/usr/sbin/ntpdate -u europe.pool.ntp.org", 2 * 60 * 1000);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
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
                return getSutManager().getDeployConfigurations().getSetupMode();
            case "snapshot":
                return getSutManager().getDeployConfigurations().getSnapshot();
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
        VisionInfo visionInfo = new VisionInfo(sutManager.getClientConfigurations().getHostIp());
        String version = visionInfo.getVisionVersion();
        String featureBranch = visionInfo.getVisionBranch();
        String build = visionInfo.getVisionBuild();
        //update runtime variables
        RootServerCli rootServerCli = null;
        if (serversManagement.getRootServerCLI().isPresent()) {
            rootServerCli = serversManagement.getRootServerCLI().get();
            rootServerCli.setVersionNumebr(version);
            rootServerCli.setBuildNumber(build);
        } else
            BaseTestUtils.report("Optional: RootServerCli is empty", Reporter.FAIL);
        //Update portal
        FeatureRunner.update_version_build_mode(version, build, BddReporterManager.getRunMode());
        FeatureRunner.update_station_sutName(clientConfigurations.getHostIp(), System.getProperty("SUT"));

    }
}
