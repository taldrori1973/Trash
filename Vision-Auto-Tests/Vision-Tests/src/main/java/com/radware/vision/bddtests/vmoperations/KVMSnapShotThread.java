package com.radware.vision.bddtests.vmoperations;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.VisionRadwareFirstTime;

public class KVMSnapShotThread extends Thread {
    private String snapshotName;
    private VisionRadwareFirstTime visionRadwareFirstTime;

    KVMSnapShotThread(String snapshotName, VisionRadwareFirstTime visionRadwareFirstTime) {
        this.snapshotName = snapshotName;
        this.visionRadwareFirstTime = visionRadwareFirstTime;
    }

    @Override
    public void run() {
        try {
            VMOperationsSteps.revertKvmSnapshot(snapshotName, visionRadwareFirstTime);
        } catch (
                Exception e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }
}
