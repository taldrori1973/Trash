package com.radware.vision.tests.deviceoperations;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.VisionServerInfoPane;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.deviceoperations.DeviceOperationsHandler;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

public class MultipleDevicesOperations extends WebUITestBase {
    public String deviceNameGroup;
    public TopologyTreeTabs parentTree;

    @Test
    @TestProperties(name = "Lock Multiple Devices", paramsInclude = {"deviceNameGroup", "parentTree"})
    public void lockMultipleDevices() throws Exception {

        DeviceOperationsHandler.lockUnlockMultipleDevices(deviceNameGroup, String.valueOf(parentTree), DeviceState.Lock);

    }

    @Test
    @TestProperties(name = "Unlock Multiple Devices", paramsInclude = {"deviceNameGroup", "parentTree"})
    public void unlockMultipleDevices() throws Exception {

        DeviceOperationsHandler.lockUnlockMultipleDevices(deviceNameGroup, String.valueOf(parentTree), DeviceState.UnLock);

    }

    @Test
    @TestProperties(name = "Apply Multiple Devices", paramsInclude = {"deviceNameGroup", "parentTree"})
    public void applyMultipleDevices() throws Exception {
        try {
            setParentTree(TopologyTreeTabs.PhysicalContainers);
            DeviceOperationsHandler.applyMultipleAction(deviceNameGroup, String.valueOf(parentTree));
            VisionServerInfoPane infopane = new VisionServerInfoPane();
            String currentyLockedBy = infopane.getDeviceLockedBy();
            if (!(currentyLockedBy.equals(WebUITestBase.getConnectionUsername()))) {
                report.report("Device: " + deviceNameGroup + " are locked by: " + currentyLockedBy + ", and not by " + WebUITestBase.getConnectionUsername(), Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Topology Element may not have been found :", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Revert Multiple Devices", paramsInclude = {"deviceNameGroup", "parentTree"})
    public void revertMultipleDevices() throws Exception {
        try {
            setParentTree(TopologyTreeTabs.PhysicalContainers);
            DeviceOperationsHandler.revertMultipleAction(deviceNameGroup, String.valueOf(parentTree));
            VisionServerInfoPane infopane = new VisionServerInfoPane();
            String currentyLockedBy = infopane.getDeviceLockedBy();
            if (!(currentyLockedBy.equals(WebUITestBase.getConnectionUsername()))) {
                report.report("Device: " + deviceNameGroup + " are locked by: " + currentyLockedBy + ", and not by " + WebUITestBase.getConnectionUsername(), Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Topology Element may not have been found :", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Save Multiple Devices", paramsInclude = {"deviceNameGroup", "parentTree"})
    public void saveMultipleDevices() throws Exception {
        try {
            setParentTree(TopologyTreeTabs.PhysicalContainers);
            DeviceOperationsHandler.saveMultipleAction(deviceNameGroup, String.valueOf(parentTree));
            VisionServerInfoPane infopane = new VisionServerInfoPane();
            String currentyLockedBy = infopane.getDeviceLockedBy();
            if (!(currentyLockedBy.equals(WebUITestBase.getConnectionUsername()))) {
                report.report("Device: " + deviceNameGroup + " are locked by: " + currentyLockedBy + ", and not by " + WebUITestBase.getConnectionUsername(), Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Topology Element may not have been found :", Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Sync Multiple Devices", paramsInclude = {"deviceNameGroup", "parentTree"})
    public void syncMultipleDevices() throws Exception {
        try {
            setParentTree(TopologyTreeTabs.PhysicalContainers);
            DeviceOperationsHandler.syncMultipleAction(deviceNameGroup, String.valueOf(parentTree));
            VisionServerInfoPane infopane = new VisionServerInfoPane();
            String currentyLockedBy = infopane.getDeviceLockedBy();
            if (!(currentyLockedBy.equals(WebUITestBase.getConnectionUsername()))) {
                report.report("Device: " + deviceNameGroup + " are locked by: " + currentyLockedBy + ", and not by " + WebUITestBase.getConnectionUsername(), Reporter.FAIL);
            }
        } catch (Exception e) {
            report.report("Topology Element may not have been found :", Reporter.FAIL);
        }
    }


    public String getDeviceNameGroup() {
        return deviceNameGroup;
    }

    @ParameterProperties(description = "Specify names of devices to create to make a Multiple selection with. Names must be separated by <,>.")
    public void setDeviceNameGroup(String deviceNameGroup) {
        this.deviceNameGroup = deviceNameGroup;
    }


    public TopologyTreeTabs getParentTree() {
        return parentTree;
    }


    public void setParentTree(TopologyTreeTabs parentTree) {
        this.parentTree = parentTree;
    }
}
