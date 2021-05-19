package com.radware.vision.setup.snapshot;


import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.VisionRadwareFirstTime;
import com.radware.vision.bddtests.vmoperations.VmSnapShotOperations;

import static com.radware.vision.automation.base.TestBase.sutManager;

public class SnapshotKVM implements Snapshot {
    private VisionRadwareFirstTime visionRadwareFirstTime;
    String snapshotName;

    public SnapshotKVM(String snapshotNam) {
        this.snapshotName = snapshotName;
        String netMask = sutManager.getEnviorement().get().getNetMask();
        String gateway = sutManager.getEnviorement().get().getGateWay();
        String primaryDns = sutManager.getEnviorement().get().getDnsServerIp();
        String physicalManagement = sutManager.getEnviorement().get().getPhysicalManagement();
        String vmName = sutManager.getEnviorement().get().getName();
        String ip = sutManager.getEnviorement().get().getHostIp();
        this.visionRadwareFirstTime = new VisionRadwareFirstTime(netMask, gateway, primaryDns, physicalManagement, vmName, ip);
    }

    @Override
    public void revertToSnapshot() throws Exception {
        VmSnapShotOperations.newInstance().revertKvmSnapshot(snapshotName, visionRadwareFirstTime);
    }
}
