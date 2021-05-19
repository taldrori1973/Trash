package com.radware.vision.setup;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.bddtests.vmoperations.KVMSnapShotThread;
import com.radware.vision.setup.snapshot.Snapshot;
import com.radware.vision.setup.snapshot.SnapshotKVM;
import com.radware.vision.setup.snapshot.SnapshotOVA;

public class SetupImpl extends TestBase implements Setup {

    public void buildSetup() {
    }

    public void validateSetupIsReady() {
    }

    public void restoreSetup() throws Exception {
        String snapshotName = sutManager.getSnapshotName();
        Snapshot snapshot;
        if (snapshotName == null || snapshotName.equals("")) {
            BaseTestUtils.report("Could not find snapshotName in the SUT file.", Reporter.PASS);
            return;
        }
        if (sutManager.getSetupMode().toLowerCase().contains("kvm"))
            snapshot = getSnapshot(VMType.KVM,snapshotName);
        else snapshot = getSnapshot(VMType.OVA,snapshotName);
        snapshot.revertToSnapshot();
    }

    public static Snapshot getSnapshot(VMType type,String snapshotName) {
        if (type == VMType.OVA) {
            return new SnapshotOVA();
        } else if (type == VMType.KVM) {
            return new SnapshotKVM(snapshotName);
        }
        return null;

    }

    public enum VMType {
        OVA,
        KVM
    }

}