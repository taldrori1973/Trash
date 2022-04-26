package com.radware.vision.setup.snapshot;


import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.VisionRadwareFirstTime;
import com.radware.vision.bddtests.vmoperations.VmSnapShotOperations;

import static com.radware.vision.automation.base.TestBase.sutManager;

public class SnapshotKVM implements Snapshot {
    private VisionRadwareFirstTime visionRadwareFirstTime;
    String snapshotName;

    public SnapshotKVM(String snapshotName) {
        this.snapshotName = snapshotName;
        String netMask = sutManager.getEnvironment().get().getNetMask();
        String gateway = sutManager.getEnvironment().get().getGateWay();
        String primaryDns = sutManager.getEnvironment().get().getDnsServerIp();
        String physicalManagement = sutManager.getEnvironment().get().getPhysicalManagement();
        String vmName = sutManager.getServerName();
        String ip = sutManager.getEnvironment().get().getHostIp();
        String user = sutManager.getEnvironment().get().getUser();
        String password = sutManager.getEnvironment().get().getPassword();
        this.visionRadwareFirstTime = new VisionRadwareFirstTime(user,password,netMask, gateway, primaryDns, physicalManagement, vmName, ip);
    }

    @Override
    public void revertToSnapshot() throws Exception {
        VmSnapShotOperations.newInstance().revertKvmSnapshot(snapshotName, visionRadwareFirstTime);
    }
}
