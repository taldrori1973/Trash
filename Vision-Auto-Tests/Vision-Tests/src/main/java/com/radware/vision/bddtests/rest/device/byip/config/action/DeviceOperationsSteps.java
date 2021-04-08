package com.radware.vision.bddtests.rest.device.byip.config.action;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.VisionRestClient;
import com.radware.utils.DeviceUtils;
import com.radware.vision.automation.base.TestBase;
import cucumber.api.java.en.When;

public class DeviceOperationsSteps extends TestBase {
    @When("^REST Apply Action on \"(\\w+)\"$")
    public void applyAction(String deviceSetId) {
        String deviceIp = "";
        try {
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.applyCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Apply Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Save Action on \"(\\w+)\"$")
    public void saveAction(String deviceSetId) {
        String deviceIp = "";
        try {
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.saveCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Save Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Revert Action on \"(\\w+)\"$")
    public void revertAction(String deviceSetId) {
        String deviceIp = "";
        try {
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.revertCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Revert Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST RevertApply Action on \"(\\w+)\"$")
    public void revertApplyAction(String deviceSetId) {
        String deviceIp = "";
        try {
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.revertApplyCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "RevertApply Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Sync Action on \"(\\w+)\"$")
    public void syncAction(String deviceSetId) {
        String deviceIp = "";
        try {
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.syncCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Sync Action may not have been executed properly.:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Synchronize Action on \"(\\w+)\"$")
    public void synchronizeAction(String deviceSetId) {
        String deviceIp = "";
        try {
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.treeCommands.synchronizeDeviceWithVision(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Synchronize Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Lock Action on \"(\\w+)\"$")
    public void lockAction(String deviceSetId) {
        String deviceIp = "";
        try {
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceUtils.lockCommand(visionRestClient, deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Lock Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Unlock Action on \"(\\w+)\"$")
    public void unlockAction(String deviceSetId) {
        String deviceIp = "";
        try {
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceUtils.unlockCommand(visionRestClient, deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Unlock Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Diff Action on \"(\\w+)\"$")
    public void getDiff(String deviceSetId) {
        String deviceIp = "";
        try {
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.getDiffCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "getDiff may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Diff Flash Action on \"(\\w+)\"$")
    public void getDiffFlash(String deviceSetId) {
        String deviceIp = "";
        try {
            deviceIp = sutManager.getTreeDeviceManagement(deviceSetId).get().getManagementIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.getDiffFlashCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "getDiffFlash may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }
}
