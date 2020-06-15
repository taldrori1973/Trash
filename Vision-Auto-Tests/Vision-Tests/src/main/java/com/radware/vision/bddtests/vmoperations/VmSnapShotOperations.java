package com.radware.vision.bddtests.vmoperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.EsxiInfo;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.VMSnapshotOperations;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.targetvm.VmNameTargetVm;
import com.radware.vision.automation.tools.sutsystemobjects.VisionVMs;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.bddtests.clioperation.system.upgrade.UpgradeSteps;
import com.radware.vision.infra.testhandlers.cli.CliOperations;
import com.radware.vision.utils.RegexUtils;
import com.radware.vision.vision_handlers.system.VisionServer;
import com.radware.vision.vision_project_cli.VisionRadwareFirstTime;

import java.math.BigDecimal;
import java.util.ArrayList;


public class VmSnapShotOperations extends BddUITestBase {

    private String snapshotName = VMOperationsSteps.getVisionSetupAttributeFromSUT("snapshot");
    private String setupMode = VMOperationsSteps.getVisionSetupAttributeFromSUT("setupMode");

    public enum Snapshot {
        CURRENT("Current"), CURRENT_1("Current-1"), CURRENT_2("Current-2"), CURRENT_3("Current-3");
        String snapshotName;

        Snapshot(String snapshotName) {
            this.snapshotName = snapshotName;
        }

        public String toString() {
            return snapshotName;
        }
    }


    public VmSnapShotOperations() throws Exception {

    }

    public static VmSnapShotOperations newInstance() throws Exception {
        return new VmSnapShotOperations();
    }


    public void takeKVmSnapshot(String snapshotName) throws Exception {
        int DEFAULT_KVM_CLI_TIMEOUT = 3000;
        VisionRadwareFirstTime visionRadwareFirstTime = (VisionRadwareFirstTime) system.getSystemObject("visionRadwareFirstTime");
        String vmName = visionRadwareFirstTime.getVmName() + visionRadwareFirstTime.getIp();
        BaseTestUtils.report("Creating snapshot.", Reporter.PASS_NOR_FAIL);
        CliOperations.runCommand(visionRadwareFirstTime, "virsh snapshot-create-as --domain " + vmName + " --name " + snapshotName, 15 * 60 * 1000);
        CliOperations.runCommand(visionRadwareFirstTime, "virsh snapshot-list " + vmName, DEFAULT_KVM_CLI_TIMEOUT);
        String snapshotIsCreated = ".*" + snapshotName + ".*";
        boolean isContained = RegexUtils.isStringContainsThePattern(snapshotIsCreated, CliOperations.lastOutput);
        if (isContained) {
            String domain = "vision_auto_" + visionRadwareFirstTime.getIp();
            throw new Exception("error: Snapshot: '" + snapshotName + "' of Domain '" + domain + "' is not created");
        }

    }

    public void deleteKvmSnapshot(String snapshotName) throws Exception {
        VisionRadwareFirstTime visionRadwareFirstTime = (VisionRadwareFirstTime) system.getSystemObject("visionRadwareFirstTime");
        String vmName = visionRadwareFirstTime.getVmName() + visionRadwareFirstTime.getIp();
        BaseTestUtils.report("Deleting snapshot.", Reporter.PASS_NOR_FAIL);
        CliOperations.runCommand(visionRadwareFirstTime, "virsh snapshot-delete --domain " + vmName + " --name " + snapshotName, 15 * 60 * 1000);
    }

    public void takeSnapshotVMWare(int vmNumber, String snapshotName, String withMemory) {
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

    public void renameSnapshotVMWare(String snapshotName, String newSnapshotName, String descriptionOfSnapshot) {
        try {
            VisionVMs visionVMs = restTestBase.getVisionVMs();
            String vmName = visionVMs.getVMNameByIndex(1);
            EsxiInfo esxiInfo = new EsxiInfo(visionVMs.getvCenterURL(), visionVMs.getUserName(), visionVMs.getPassword(), visionVMs.getResourcePool());
            VMSnapshotOperations.newInstance().renameSnapshot(new VmNameTargetVm(esxiInfo, vmName), snapshotName, newSnapshotName, descriptionOfSnapshot);
        } catch (Exception e) {
            BaseTestUtils.report("Error taking snapshot: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public String findVMWareSnapshotIfExist(String snapshotName) throws Exception {
        VisionVMs visionVMs = restTestBase.getVisionVMs();
        String vmName = visionVMs.getVMNameByIndex(1);
        EsxiInfo esxiInfo = new EsxiInfo(visionVMs.getvCenterURL(), visionVMs.getUserName(), visionVMs.getPassword(), visionVMs.getResourcePool());
        return VMSnapshotOperations.newInstance().getNameOfSnapshotInTreeIfExist(new VmNameTargetVm(esxiInfo, vmName), snapshotName);

    }

    public void deleteSnapshotVMWare(String snapshotName) throws Exception {
        VisionVMs visionVMs = restTestBase.getVisionVMs();
        String vmName = visionVMs.getVMNameByIndex(1);
        EsxiInfo esxiInfo = new EsxiInfo(visionVMs.getvCenterURL(), visionVMs.getUserName(), visionVMs.getPassword(), visionVMs.getResourcePool());
        VMSnapshotOperations.newInstance().removeSnapshot(new VmNameTargetVm(esxiInfo, vmName), snapshotName);
    }

    public void revertKvmSnapshot(String snapshotName, VisionRadwareFirstTime visionRadwareFirstTime) throws Exception {
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
        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "/usr/sbin/ntpdate -u $(/bin/grep ^server  /etc/ntp.conf | awk '{print $2}')", 2 * 60 * 1000);
        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "yes|restore_radware_user_password", 60 * 1000);
        if (VisionServer.waitForVisionServerServicesToStartHA(restTestBase.getRadwareServerCli(), 45 * 60 * 1000))
            BaseTestUtils.report("All services up", Reporter.PASS);
        else {
            BaseTestUtils.report("Not all services up.", Reporter.FAIL);
        }

    }

    public String getSnapshotTypeBySetupMode(boolean snapshotFromSut) throws Exception {
        if (snapshotFromSut)
            return snapshotName;
        switch (setupMode.toLowerCase()){
            case "upgrade":
               return getSnapshotNameOfEnumFromListForVMWare();
            case "kvm_upgrade":
                return getSnapshotNameOfEnumFromListForKVM();
            default: return null;
        }
    }

    public void revertVMWareSnapshot(int vmNumber,boolean snapshotFromSut) throws Exception {
        try {
            String snapshot = getSnapshotTypeBySetupMode(snapshotFromSut);

            if (!snapshotFromSut && (snapshot == null || snapshot.equals(""))) {
                BaseTestUtils.report("Could not find snapshot in list ", Reporter.FAIL);
                return;
            }

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
            CliOperations.runCommand(getRestTestBase().getRootServerCli(), "/usr/sbin/ntpdate -u $(/bin/grep ^server  /etc/ntp.conf | awk '{print $2}')", 2 * 60 * 1000);
            CliOperations.runCommand(getRestTestBase().getRootServerCli(), "yes|restore_radware_user_password", 60 * 1000);
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

    public void upgradeAccordingToSnapshot(String upgradeToVersion, String build) throws Exception {
        boolean snapshotFromSut = true;
        if(snapshotName == null || snapshotName.isEmpty() || snapshotName.equals(" "))
            snapshotFromSut = false;
        UpgradeSteps upgradeSteps = new UpgradeSteps();
        if (upgradeToVersion == null || upgradeToVersion.isEmpty() || upgradeToVersion.equals(" "))
            upgradeToVersion = calculateVersionAccordingToSnapshot();
        if (build == null || build.isEmpty() || build.equals(" "))
            build = ""; // latest build
        assert setupMode != null;
        switch (setupMode.toLowerCase()) {
            case "upgrade":
                revertVMWareSnapshot(1,snapshotFromSut);
                upgradeSteps.UpgradeVisionServer(upgradeToVersion, build);
                VmSnapShotOperations.newInstance().renameSnapshotVMWare(snapshotName, "temporarySnapshot", "temporary");
                VmSnapShotOperations.newInstance().takeSnapshotVMWare(1, snapshotName, "withMemory");
                VmSnapShotOperations.newInstance().deleteSnapshotVMWare("temporarySnapshot");
                VmSnapShotOperations.newInstance().renameSnapshotVMWare(snapshotName, snapshotName, "Automation, Version: " + upgradeToVersion);
                break;

            case "kvm_upgrade":
                VisionRadwareFirstTime visionRadwareFirstTime = (VisionRadwareFirstTime) system.getSystemObject("visionRadwareFirstTime");
                VmSnapShotOperations.newInstance().revertKvmSnapshot(snapshotName, visionRadwareFirstTime);
                upgradeSteps.UpgradeVisionServer(upgradeToVersion, build);
                VmSnapShotOperations.newInstance().deleteKvmSnapshot(snapshotName);
                VmSnapShotOperations.newInstance().takeKVmSnapshot(snapshotName);
                break;

        }


    }

    private String calculateVersionAccordingToSnapshot() throws Exception {
        if (setupMode.equalsIgnoreCase("upgrade") && (snapshotName == null || snapshotName.isEmpty() || snapshotName.equals(" ")))
            snapshotName = getSnapshotNameOfEnumFromListForVMWare();
        if (setupMode.equalsIgnoreCase("kvm_upgrade") && (snapshotName == null || snapshotName.isEmpty() || snapshotName.equals(" ")))
            snapshotName = getSnapshotNameOfEnumFromListForKVM();
        String currentVersion = VMOperationsSteps.readVisionVersionFromPomFile().split("\\.")[0] + "." + VMOperationsSteps.readVisionVersionFromPomFile().split("\\.")[1];
        assert snapshotName != null;
        String number = (snapshotName.equalsIgnoreCase("current")) ? "0" : snapshotName.split("-")[1].trim();
        String numberToSubtract = "0." + number;
        return new BigDecimal(currentVersion).subtract(new BigDecimal(numberToSubtract)) + "." + VMOperationsSteps.readVisionVersionFromPomFile().split("\\.")[2];
    }

    public String getSnapshotNameOfEnumFromListForVMWare() throws Exception {
        String snapshotName;
        for (Enum snapshot : Snapshot.values()) {
            snapshotName = findVMWareSnapshotIfExist(snapshot.toString());
            if (snapshotName != null)
                return snapshotName;
        }
        return null;
    }

    public String getSnapshotNameOfEnumFromListForKVM() throws Exception {
        int DEFAULT_KVM_CLI_TIMEOUT = 3000;
        VisionRadwareFirstTime visionRadwareFirstTime = (VisionRadwareFirstTime) system.getSystemObject("visionRadwareFirstTime");
        String vmName = visionRadwareFirstTime.getVmName() + visionRadwareFirstTime.getIp();
        CliOperations.runCommand(visionRadwareFirstTime, "virsh snapshot-list " + vmName + " | awk 'NF!=1 { print $1 }'", DEFAULT_KVM_CLI_TIMEOUT);
        ArrayList cmdOutput = visionRadwareFirstTime.getCmdOutput();
        for (Enum snapshot : VmSnapShotOperations.Snapshot.values())
            for (Object outputLine : cmdOutput) {
                if (outputLine.toString().equalsIgnoreCase(snapshot.toString()))
                    return outputLine.toString().trim();
            }
        return null;
    }
}