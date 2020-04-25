package com.radware.vision.infra.testhandlers;

import basejunit.RestTestBase;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.restcommands.mgmtcommands.tree.DeviceCommands;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DevicesManager;
import com.radware.vision.infra.base.pages.deviceoperations.DeviceOperations;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;

import java.util.HashMap;

/**
 * Created by AviH on 11-Aug-16.
 */

public class BaseHandler {
    public static RestTestBase restTestBase = null;
    public static DevicesManager devicesManager = null;

    public static void initLockDevice(HashMap<String, String> testProperties) {
        lockUnlockDevice(testProperties.get("deviceName"), testProperties.get("parentTree"), testProperties.get("deviceState"), true, testProperties.get("deviceIp"));
    }

    public static void initLockDevice(String deviceName, String parentTree, String deviceState) {
        lockUnlockDevice(deviceName, parentTree, deviceState, false);
    }


    public static void lockUnlockDevice(String deviceName, String parentTree, String deviceState, boolean useRest) {
        lockUnlockDevice(deviceName, parentTree, deviceState, useRest, null);
    }

    public static void lockUnlockDevice(String deviceName, String parentTree, String deviceState, boolean useRest, String deviceIp) {
        deviceIp = deviceIp != null ? deviceIp : deviceName;
        try {
            if (TopologyTreeTabs.getEnum(parentTree).equals(TopologyTreeTabs.SitesAndClusters)) {
                TopologyTreeHandler.openSitesAndClusters();
            } else if (TopologyTreeTabs.getEnum(parentTree).equals(TopologyTreeTabs.PhysicalContainers)) {
                TopologyTreeHandler.openPhysicalContainers();
            } else {
                throw new IllegalStateException("Incorrect Topology Tree tab name is provided: " + TopologyTreeTabs.getEnum(parentTree));
            }
            if (useRest) {
                DeviceCommands deviceCommands = new DeviceCommands(restTestBase.getVisionRestClient());
                deviceCommands.lockDeviceByManagementIp(deviceIp);
                TopologyTreeHandler.clickTreeNode(deviceName);
                TopologyTreeHandler.openDeviceInfoPane();
            } else {
                TopologyTreeHandler.clickTreeNode(deviceName);
                TopologyTreeHandler.openDeviceInfoPane();
                atomicLockUnlockDevice(deviceState);
            }
        } catch (Exception e) {
            BaseTestUtils.report("LockUnlock device operation failure:\n" + e.toString() + e.getMessage(), Reporter.FAIL);//
        }
    }

    public static void atomicLockUnlockDevice(String deviceState) {
        DeviceOperations deviceOperations = new DeviceOperations();
        boolean deviceLocked = deviceOperations.isLocked();
        if ((!deviceLocked && deviceState.equalsIgnoreCase(DeviceState.Lock.toString())) ||
                deviceLocked && deviceState.equalsIgnoreCase(DeviceState.UnLock.toString())) {
            deviceOperations.lockUnlockDevice();
        }
    }

    public static void clickOnRowIfRequired(WebUITable table, HashMap<String, String> testProperties) {
        if (table != null) {
            if (Boolean.valueOf(testProperties.get("clickOnTableRow"))) {
                table.analyzeTable("div");
            }
            if (table.getRowsNumber() > 0 && Boolean.valueOf(testProperties.get("clickOnTableRow"))) {
                table.clickOnRow(0);
            }
        }
    }
}
