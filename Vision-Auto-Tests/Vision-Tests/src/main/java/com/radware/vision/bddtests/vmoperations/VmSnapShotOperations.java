package com.radware.vision.bddtests.vmoperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.EsxiInfo;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.VMSnapshotOperations;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.targetvm.VmNameTargetVm;
import com.radware.vision.automation.tools.sutsystemobjects.VisionVMs;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.bddtests.clioperation.system.upgrade.UpgradeSteps;
import com.radware.vision.bddtests.visionsettings.VisionInfo;
import com.radware.vision.utils.RegexUtils;
import com.radware.vision.vision_handlers.system.VisionServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.VisionRadwareFirstTime;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import static com.radware.vision.automation.Deploy.VisionServer.waitForServerConnection;
import static com.radware.vision.bddtests.remotessh.RemoteSshCommandsTests.resetPassword;
import static com.radware.vision.vision_handlers.NewVmHandler.waitForServerConnection;


public class VmSnapShotOperations extends VisionUITestBase {

    private String snapshotName = VMOperationsSteps.getVisionSetupAttributeFromSUT("snapshot");
    private final String setupMode = VMOperationsSteps.getVisionSetupAttributeFromSUT("setupMode");
    int DEFAULT_KVM_CLI_TIMEOUT = 3000;
//    TODO kvision
//    VisionRadwareFirstTime visionRadwareFirstTime = (VisionRadwareFirstTime) system.getSystemObject("visionRadwareFirstTime");
//    String kvmMachineName = visionRadwareFirstTime.getVmName() + visionRadwareFirstTime.getIp();
    VisionVMs visionVMs = restTestBase.getVisionVMs();
    int defaultVMWareNumber = 1;
    String vmName = visionVMs.getVMNameByIndex(defaultVMWareNumber);
    EsxiInfo esxiInfo = new EsxiInfo(visionVMs.getvCenterURL(), visionVMs.getUserName(), visionVMs.getPassword(), visionVMs.getResourcePool());
    private static final Map<String, String> NEXT_VERSION = new HashMap<String, String>() {{
        put("4.81.00", "4.82.00");
        put("4.80.00", "4.81.00");
        put("4.70.00", "4.80.00");
        put("4.60.00", "4.70");
        put("4.50.00", "4.60");
    }};

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

    private void validateSnapshotListOfKVMIfExist(String snapshotName, boolean isExist) throws Exception {
//        TODO kvision
//        CliOperations.runCommand(visionRadwareFirstTime, "virsh snapshot-list " + kvmMachineName, DEFAULT_KVM_CLI_TIMEOUT);
//        String snapshotIsCreated = ".*" + snapshotName + ".*";
//        boolean snapshot = RegexUtils.isStringContainsThePattern(snapshotIsCreated, CliOperations.lastOutput);
//        if (!snapshot && isExist) {
//            throw new Exception("error: Snapshot: '" + snapshotName + "' of Domain '" + kvmMachineName + "' is not created");
//        }
//        if (snapshot && !isExist) {
//            throw new Exception("error: Snapshot: '" + snapshotName + "' of Domain '" + kvmMachineName + "' is not deleted");
//        }

    }

    public void takeKVmSnapshot(String snapshotName) throws Exception {
        BaseTestUtils.report("Creating snapshot.", Reporter.PASS_NOR_FAIL);
//        TODO kvision
//        CliOperations.runCommand(visionRadwareFirstTime, "virsh snapshot-create-as --domain " + kvmMachineName + " --name " + snapshotName, 15 * 60 * 1000);
//        String snapshotIsAlreadyExists = ".*" + "snapshot " + snapshotName + " already exists.*";
//        boolean isContained = RegexUtils.isStringContainsThePattern(snapshotIsAlreadyExists, CliOperations.lastOutput);
//        if (isContained) {
//            throw new Exception("error: Snapshot: '" + snapshotName + "' of Domain '" + kvmMachineName + "' is not created already exists");
//        }
//        validateSnapshotListOfKVMIfExist(snapshotName, true);
    }

    public void deleteKvmSnapshot(String snapshotName) throws Exception {
        BaseTestUtils.report("Deleting snapshot.", Reporter.PASS_NOR_FAIL);
//        TODO kvision
//        CliOperations.runCommand(visionRadwareFirstTime, "virsh snapshot-delete --domain " + kvmMachineName + " " + snapshotName, 15 * 60 * 1000);
        validateSnapshotListOfKVMIfExist(snapshotName, false);
    }

    public void takeSnapshotVMWare(int vmNumber, String snapshotName, String withMemory) {
        try {
            boolean withMem = withMemory != null;
            String vmName = visionVMs.getVMNameByIndex(vmNumber);
            VMSnapshotOperations.newInstance().doSnapshot(new VmNameTargetVm(esxiInfo, vmName), snapshotName, withMem);
        } catch (Exception e) {
            BaseTestUtils.report("Error creating snapshot: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public void renameSnapshotVMWare(String snapshotName, String newSnapshotName, String descriptionOfSnapshot) {
        try {
            VMSnapshotOperations.newInstance().renameSnapshot(new VmNameTargetVm(esxiInfo, vmName), snapshotName, newSnapshotName, descriptionOfSnapshot);
        } catch (Exception e) {
            BaseTestUtils.report("Error rename snapshot: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public String findVMWareSnapshotIfExist(String snapshotName) throws Exception {
        return VMSnapshotOperations.newInstance().getNameOfSnapshotInTreeIfExist(new VmNameTargetVm(esxiInfo, vmName), snapshotName);
    }

    public void deleteSnapshotVMWare(String snapshotName) throws Exception {
        VMSnapshotOperations.newInstance().removeSnapshot(new VmNameTargetVm(esxiInfo, vmName), snapshotName);
    }

    public void revertKvmSnapshot(String snapshotName, VisionRadwareFirstTime visionRadwareFirstTime) throws Exception {
//        TODO kvision
//        CliOperations.runCommand(visionRadwareFirstTime, "virsh list --all");
//        String kvmMachineName = visionRadwareFirstTime.getVmName() + visionRadwareFirstTime.getIp();
//        boolean isContained = RegexUtils.isStringContainsThePattern(kvmMachineName, CliOperations.lastOutput);
//        if (!isContained) {
//            throw new Exception("the " + kvmMachineName + "does not exist");
//        }
//        CliOperations.runCommand(visionRadwareFirstTime, "virsh start " + kvmMachineName, DEFAULT_KVM_CLI_TIMEOUT);
//        waitForDomainState(visionRadwareFirstTime, "running", 120);
//        BaseTestUtils.report("Reverting to snapshot: " + snapshotName, Reporter.PASS_NOR_FAIL);
//        CliOperations.runCommand(visionRadwareFirstTime, "virsh snapshot-revert --domain " + kvmMachineName + " --snapshotname " + snapshotName + " --force", 15 * 60 * 1000);
//        BaseTestUtils.report("Starting server after revert.", Reporter.PASS_NOR_FAIL);
//        CliOperations.runCommand(visionRadwareFirstTime, "virsh start " + kvmMachineName, DEFAULT_KVM_CLI_TIMEOUT);
//        String error = ".*Domain not found.*";
//        isContained = RegexUtils.isStringContainsThePattern(error, CliOperations.lastOutput);
//        if (isContained) {
//            throw new Exception("error: Domain not found: no domain with matching name '" + kvmMachineName + "' ");
//        }
//        waitForDomainState(visionRadwareFirstTime, "running", 120);
//        setupServerAfterRevert();

    }

    private void setupServerAfterRevert() throws Exception {
        int connectTimeOut = 10 * 60 * 1000;
        waitForServerConnection(connectTimeOut, getRestTestBase().getRootServerCli());
//        TODO kvision
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "chkconfig --level 345 rsyslog on", 2 * 60 * 1000);
//        CliOperations.runCommand(getRestTestBase().getRootServerCli(), "/usr/sbin/ntpdate -u europe.pool.ntp.org", 2 * 60 * 1000);
        resetPassword();
        if (VisionServer.waitForVisionServerReadinessForUpgrade(restTestBase.getRadwareServerCli(), 45 * 60 * 1000))
            BaseTestUtils.report("All services up", Reporter.PASS);
        else {
            BaseTestUtils.report("Not all services up.", Reporter.FAIL);
        }
    }

    public String getSnapshotTypeBySetupMode(boolean snapshotFromSut) throws Exception {
        if (snapshotFromSut)
            return snapshotName;
        switch (setupMode.toLowerCase()) {
            case "upgrade":
                return getSnapshotNameOfEnumFromListForVMWare();
            case "kvm_upgrade":
                return getSnapshotNameOfEnumFromListForKVM();
            default:
                return null;
        }
    }

    public void revertVMWareSnapshot(int vmNumber, boolean snapshotFromSut) throws Exception {
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
            String vmName = visionVMs.getVMNameByIndex(vmNumber);
            BaseTestUtils.report("Reverting to snapshot: " + snapshot, Reporter.PASS_NOR_FAIL);
            VMSnapshotOperations.newInstance().switchToSnapshot(new VmNameTargetVm(esxiInfo, vmName), snapshot, true);
            BaseTestUtils.report("Revert done", Reporter.PASS_NOR_FAIL);
            setupServerAfterRevert();
        } catch (Exception e) {
            BaseTestUtils.report("Error reverting snapshot: " + parseExceptionBody(e), Reporter.FAIL);
        } finally {
            restTestBase.getRadwareServerCli().setConnectOnInit(true);
            restTestBase.getRadwareServerCli().init();
            restTestBase.getRootServerCli().setConnectOnInit(true);
            restTestBase.getRootServerCli().init();
        }
    }

    public void upgradeAccordingToSnapshot() throws Exception {

        boolean snapshotFromSut = true;
        if (snapshotName == null || snapshotName.isEmpty() || snapshotName.equals(" "))
            snapshotFromSut = false;
        UpgradeSteps upgradeSteps = new UpgradeSteps();
        VisionInfo visionInfo;
        assert setupMode != null;
        switch (setupMode.toLowerCase()) {
            case "upgrade":
                revertVMWareSnapshot(defaultVMWareNumber, snapshotFromSut);
                if (!waitForServerConnection(2700000L, restTestBase.getRootServerCli())) {
                    BaseTestUtils.report("Could not connect to device: " + restTestBase.getRootServerCli().getHost(), 1);
                }

                visionInfo = new VisionInfo(getVisionServerIp());
                upgradeSteps.UpgradeVisionServerFromOldVersion(NEXT_VERSION.get(visionInfo.getVisionVersion()));
                VmSnapShotOperations.newInstance().renameSnapshotVMWare(snapshotName, "temporarySnapshot", "temporary");
                VmSnapShotOperations.newInstance().takeSnapshotVMWare(defaultVMWareNumber, snapshotName, "withMemory");
                VmSnapShotOperations.newInstance().deleteSnapshotVMWare("temporarySnapshot");
                VmSnapShotOperations.newInstance().renameSnapshotVMWare(snapshotName, snapshotName, "Automation, Version: " + NEXT_VERSION.get(visionInfo.getVisionVersion()));
                break;

            case "kvm_upgrade":
//                TODO kision
//                VmSnapShotOperations.newInstance().revertKvmSnapshot(snapshotName, visionRadwareFirstTime);
                revertVMWareSnapshot(defaultVMWareNumber, snapshotFromSut);
                if (!waitForServerConnection(2700000L, restTestBase.getRootServerCli())) {
                    BaseTestUtils.report("Could not connect to device: " + restTestBase.getRootServerCli().getHost(), 1);
                }
                visionInfo = new VisionInfo(getVisionServerIp());
                upgradeSteps.UpgradeVisionServerFromOldVersion(NEXT_VERSION.get(visionInfo.getVisionVersion()));
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
        for (Snapshot snapshot : Snapshot.values()) {
            snapshotName = findVMWareSnapshotIfExist(snapshot.toString());
            if (snapshotName != null)
                return snapshotName;
        }
        return null;
    }

    public String getSnapshotNameOfEnumFromListForKVM() {
//        TODO kvision
//        CliOperations.runCommand(visionRadwareFirstTime, "virsh snapshot-list " + kvmMachineName + " | awk 'NF!=1 { print $1 }'", DEFAULT_KVM_CLI_TIMEOUT);
//        ArrayList<String> cmdOutput = visionRadwareFirstTime.getCmdOutput();
//        for (Snapshot snapshot : VmSnapShotOperations.Snapshot.values())
//            for (Object outputLine : cmdOutput) {
//                if (outputLine.toString().equalsIgnoreCase(snapshot.toString()))
//                    return outputLine.toString().trim();
//            }
        return null;
    }


    private void waitForDomainState(VisionRadwareFirstTime visionRadwareFirstTime, String state, int timeout) {
        long startTime = System.currentTimeMillis();
        try {
            boolean isContained;
            do {
//                TODO kvision
//                CliOperations.runCommand(visionRadwareFirstTime, "virsh domstate " + kvmMachineName, DEFAULT_KVM_CLI_TIMEOUT);
                isContained = RegexUtils.isStringContainsThePattern(state, CliOperations.lastRow);
                if (!isContained) {
                    Thread.sleep(5000);
                } else
                    return;
            } while (System.currentTimeMillis() - startTime < timeout);
        } catch (Exception e) {
            BaseTestUtils.report("Server state after timeout is: " + CliOperations.lastOutput, Reporter.FAIL);
        }
    }

}