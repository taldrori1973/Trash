package com.radware.vision.bddtests.vmoperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.EnvironmentDto;
import com.radware.vision.automation.Deploy.UvisionServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RadwareServerCli;
import com.radware.vision.automation.systemManagement.serversManagement.ServersManagement;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.EsxiInfo;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.VMSnapshotOperations;
import com.radware.vision.automation.tools.esxitool.snapshotoperations.targetvm.VmNameTargetVm;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.bddtests.clioperation.system.upgrade.UpgradeSteps;
import com.radware.vision.bddtests.visionsettings.VisionInfo;
import com.radware.vision.utils.RegexUtils;
//import com.radware.vision.vision_handlers.system.VisionServer;
import com.radware.vision.automation.Deploy.VisionServer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.VisionRadwareFirstTime;


import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import static com.radware.vision.automation.Deploy.VisionServer.waitForServerConnection;
import static com.radware.vision.bddtests.remotessh.RemoteSshCommandsTests.resetPassword;
import static com.radware.vision.vision_handlers.NewVmHandler.waitForServerConnection;


public class VmSnapShotOperations extends VisionUITestBase {

    private String snapshotName = sutManager.getDeployConfigurations().getSnapshot();
    private final String setupMode = sutManager.getDeployConfigurations().getSetupMode();
    private final RadwareServerCli radwareServerCli = serversManagement.getRadwareServerCli().get();
    static EnvironmentDto[] environments = new EnvironmentDto[2];
    static String[] vmNames = new String[2];
    int DEFAULT_KVM_CLI_TIMEOUT = 3000;

    int defaultVMWareNumber = 1;
    String vmName = sutManager.getServerName();
    private static final Map<String, String> NEXT_VERSION = new HashMap<String, String>() {{
        put("4.83.00", "4.84.00");
        put("4.82.00", "4.83.00");
        put("4.81.00", "4.82.00");
        put("4.81.01", "4.82.00");
        put("4.80.00", "4.81.01");
        put("4.80.01", "4.81.01");
        put("4.80.02", "4.81.01");
        put("4.70.00", "4.80.02");
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
        getEnvironmentsFromSut();
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
            if (vmNumber > 1 || vmNumber < 0) throw new Exception("vm number is not coorect");
            String vmName = vmNames[vmNumber - 1];
            EsxiInfo esxiInfo = new EsxiInfo(environments[vmNumber - 1].getUrl(), environments[vmNumber - 1].getUser(), environments[vmNumber - 1].getPassword(), environments[vmNumber - 1].getResourcePool());
            VMSnapshotOperations.newInstance().doSnapshot(new VmNameTargetVm(esxiInfo, vmName), snapshotName, withMem);
        } catch (Exception e) {
            BaseTestUtils.report("Error creating snapshot: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public void renameSnapshotVMWare(String snapshotName, String newSnapshotName, String descriptionOfSnapshot) {
        try {
            EsxiInfo esxiInfo = new EsxiInfo(environments[0].getUrl(), environments[0].getUser(), environments[0].getPassword(), environments[0].getResourcePool());
            VMSnapshotOperations.newInstance().renameSnapshot(new VmNameTargetVm(esxiInfo, vmName), snapshotName, newSnapshotName, descriptionOfSnapshot);
        } catch (Exception e) {
            BaseTestUtils.report("Error rename snapshot: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    public String findVMWareSnapshotIfExist(String snapshotName) throws Exception {
        EsxiInfo esxiInfo = new EsxiInfo(environments[0].getUrl(), environments[0].getUser(), environments[0].getPassword(), environments[0].getResourcePool());
        return VMSnapshotOperations.newInstance().getNameOfSnapshotInTreeIfExist(new VmNameTargetVm(esxiInfo, vmName), snapshotName);
    }

    public void deleteSnapshotVMWare(String snapshotName) throws Exception {
        EsxiInfo esxiInfo = new EsxiInfo(environments[0].getUrl(), environments[0].getUser(), environments[0].getPassword(), environments[0].getResourcePool());
        VMSnapshotOperations.newInstance().removeSnapshot(new VmNameTargetVm(esxiInfo, vmName), snapshotName);
    }

    public void revertKvmSnapshot(String snapshotName, VisionRadwareFirstTime visionRadwareFirstTime) throws Exception {
        visionRadwareFirstTime.init();
        visionRadwareFirstTime.connect();
        CliOperations.runCommand(visionRadwareFirstTime, "virsh list --all");
        String kvmMachineName = visionRadwareFirstTime.getVmName();
        boolean isContained = RegexUtils.isStringContainsThePattern(kvmMachineName, CliOperations.lastOutput);
        if (!isContained) {
            throw new Exception("the " + kvmMachineName + "does not exist");
        }
        CliOperations.runCommand(visionRadwareFirstTime, "virsh start " + kvmMachineName, DEFAULT_KVM_CLI_TIMEOUT);
        waitForDomainState(visionRadwareFirstTime, "running", 120);
        BaseTestUtils.report("Reverting to snapshot: " + snapshotName, Reporter.PASS_NOR_FAIL);
        CliOperations.runCommand(visionRadwareFirstTime, "virsh snapshot-revert --domain " + kvmMachineName + " --snapshotname " + snapshotName + " --force", 15 * 60 * 1000);
        BaseTestUtils.report("Starting server after revert.", Reporter.PASS_NOR_FAIL);
        CliOperations.runCommand(visionRadwareFirstTime, "virsh start " + kvmMachineName, DEFAULT_KVM_CLI_TIMEOUT);
        String error = ".*Domain not found.*";
        isContained = RegexUtils.isStringContainsThePattern(error, CliOperations.lastOutput);
        if (isContained) {
            throw new Exception("error: Domain not found: no domain with matching name '" + kvmMachineName + "' ");
        }
        waitForDomainState(visionRadwareFirstTime, "running", 120);
        setupServerAfterRevert();
    }

    private void setupServerAfterRevert() throws Exception {
        int connectTimeOut = 10 * 60 * 1000;
        waitForServerConnection(connectTimeOut, serversManagement.getRootServerCLI().get());
        CliOperations.runCommand(serversManagement.getRootServerCLI().get(), "chkconfig --level 345 rsyslog on", 2 * 60 * 1000);
        CliOperations.runCommand(serversManagement.getRootServerCLI().get(), "/usr/sbin/ntpdate -u europe.pool.ntp.org", 2 * 60 * 1000);
        resetPassword();
        //if (VisionServer.waitForVisionServerReadinessForUpgrade(radwareServerCli, 45 * 60 * 1000))
        // ToDo kvision replace UvisionServer.UVISON_DEFAULT_SERVICES to what services are needed for upgrade
        if(UvisionServer.isUvisionReady(radwareServerCli, UvisionServer.UVISON_DEFAULT_SERVICES))
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
            String snapshot = sutManager.getDeployConfigurations().getSnapshot();
            if (!snapshotFromSut && (snapshot == null || snapshot.equals(""))) {
                BaseTestUtils.report("Could not find snapshot in list ", Reporter.FAIL);
                return;
            }
            if (snapshot == null || snapshot.equals("")) {
                BaseTestUtils.report("Could not find snapshot in SUT file performing internal upgrade", Reporter.PASS_NOR_FAIL);
                return;
            }
            String vmName = vmNames[vmNumber - 1];
            EsxiInfo esxiInfo = new EsxiInfo(environments[vmNumber - 1].getUrl(), environments[vmNumber - 1].getUser(), environments[vmNumber - 1].getPassword(), environments[vmNumber - 1].getResourcePool());
            BaseTestUtils.report("Reverting to snapshot: " + snapshot, Reporter.PASS_NOR_FAIL);
            VMSnapshotOperations.newInstance().switchToSnapshot(new VmNameTargetVm(esxiInfo, vmName), snapshot, true);
            BaseTestUtils.report("Revert done", Reporter.PASS_NOR_FAIL);
            setupServerAfterRevert();
        } catch (Exception e) {
            BaseTestUtils.report("Error reverting snapshot: " + parseExceptionBody(e), Reporter.FAIL);
        } finally {
            radwareServerCli.setConnectOnInit(true);
            radwareServerCli.init();
            serversManagement.getRootServerCLI().get().setConnectOnInit(true);
            serversManagement.getRootServerCLI().get().init();
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
                String kvmMachineName = visionRadwareFirstTime.getVmName() + visionRadwareFirstTime.getIp();
                CliOperations.runCommand(visionRadwareFirstTime, "virsh domstate " + kvmMachineName, DEFAULT_KVM_CLI_TIMEOUT);
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

    public static void getEnvironmentsFromSut() {
        environments = new EnvironmentDto[2];
        Optional<EnvironmentDto> environmentDto = sutManager.getEnviorement();
        if (!environmentDto.isPresent()) {
            BaseTestUtils.report("Environment Not Found!.", Reporter.FAIL);
        }
        environments[0] = environmentDto.get();

        Optional<EnvironmentDto> pairEnvironmentDto = sutManager.getPairEnviorement();
        if (!pairEnvironmentDto.isPresent()) {
            BaseTestUtils.report("Pair Environment Not Found!, continue without pair.", Reporter.PASS_NOR_FAIL);
            environments[1] = null;
        } else {
            environments[1] = pairEnvironmentDto.get();
        }
        vmNames[0] = sutManager.getServerName();
        if (sutManager.getpair() == null) {
            vmNames[1] = null;
        } else {
            vmNames[1] = sutManager.getpair().getServerName();
        }
    }


}