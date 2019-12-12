package com.radware.vision.bddtests.rest.device.byip.config.action;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.VisionRestClient;
import com.radware.utils.DeviceUtils;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.BddRestTestBase;
import cucumber.api.java.en.When;

public class DeviceOperationsSteps extends BddRestTestBase {
    @When("^REST Apply Action on \"(.*)\" (\\d+)$")
    public void applyAction(SUTDeviceType deviceType, int deviceIndex) {
        String deviceIp = "";
        try {
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.applyCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Apply Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Save Action on \"(.*)\" (\\d+)$")
    public void saveAction(SUTDeviceType deviceType, int deviceIndex) {
        String deviceIp = "";
        try {
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.saveCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Save Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Revert Action on \"(.*)\" (\\d+)$")
    public void revertAction(SUTDeviceType deviceType, int deviceIndex) {
        String deviceIp = "";
        try {
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.revertCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Revert Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST RevertApply Action on \"(.*)\" (\\d+)$")
    public void revertApplyAction(SUTDeviceType deviceType, int deviceIndex) {
        String deviceIp = "";
        try {
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.revertApplyCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "RevertApply Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Sync Action on \"(.*)\" (\\d+)$")
    public void syncAction(SUTDeviceType deviceType, int deviceIndex) {
        String deviceIp = "";
        try {
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.syncCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Sync Action may not have been executed properly.:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Synchronize Action on \"(.*)\" (\\d+)$")
    public void synchronizeAction(SUTDeviceType deviceType, int deviceIndex) {
        String deviceIp = "";
        try {
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.treeCommands.synchronizeDeviceWithVision(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Synchronize Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Lock Action on \"(.*)\" (\\d+)$")
    public void lockAction(SUTDeviceType deviceType, int deviceIndex) {
        String deviceIp = "";
        try {
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceUtils.lockCommand(visionRestClient, deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Lock Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Unlock Action on \"(.*)\" (\\d+)$")
    public void unlockAction(SUTDeviceType deviceType, int deviceIndex) {
        String deviceIp = "";
        try {
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            DeviceUtils.unlockCommand(visionRestClient, deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "Unlock Action may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Diff Action on \"(.*)\" (\\d+)$")
    public void getDiff(SUTDeviceType deviceType, int deviceIndex) {
        String deviceIp = "";
        try {
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.getDiffCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "getDiff may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }

    @When("^REST Diff Flash Action on \"(.*)\" (\\d+)$")
    public void getDiffFlash(SUTDeviceType deviceType, int deviceIndex) {
        String deviceIp = "";
        try {
            deviceIp = devicesManager.getDeviceInfo(deviceType, deviceIndex).getDeviceIp();
            VisionRestClient visionRestClient = restTestBase.getVisionRestClient();
            visionRestClient.mgmtCommands.deviceOperationsCommands.getDiffFlashCommand(deviceIp);
        } catch (Exception e) {
            BaseTestUtils.report("Device: " + deviceIp + " " + "getDiffFlash may not have been executed properly:" + e.getMessage(), Reporter.FAIL);
        }
    }


}
