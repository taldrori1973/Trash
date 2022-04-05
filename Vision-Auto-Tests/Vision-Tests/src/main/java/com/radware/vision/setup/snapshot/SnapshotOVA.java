package com.radware.vision.setup.snapshot;

import com.radware.vision.bddtests.vmoperations.VmSnapShotOperations;


public class SnapshotOVA implements Snapshot {
    @Override
    public void revertToSnapshot() throws Exception {
        VmSnapShotOperations.newInstance().revertVMWareSnapshot(1, true);
    }
}
