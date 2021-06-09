package com.radware.vision.setup;

import com.fasterxml.jackson.databind.JsonNode;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.RestStepResult;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.devicesRestApi.topologyTree.TopologyTree;
import com.radware.vision.devicesRestApi.topologyTree.TopologyTreeImpl;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import com.radware.vision.setup.snapshot.Snapshot;
import com.radware.vision.setup.snapshot.SnapshotKVM;
import com.radware.vision.setup.snapshot.SnapshotOVA;
import models.RestResponse;
import models.StatusCode;
import org.json.simple.JSONArray;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SetupImpl extends TestBase implements Setup {

    public void buildSetup() throws Exception {
        GenericVisionRestAPI restAPI = new GenericVisionRestAPI("Vision/SystemConfigTree.json", "GET Device Tree");
        RestResponse restResponse = restAPI.sendRequest();
        deleteDevices(restResponse.getBody().getBodyAsJsonNode().get());
        List<TreeDeviceManagementDto> visionSetupTreeDevices = sutManager.getVisionSetupTreeDevices();
        visionSetupTreeDevices.forEach(device -> addDevice(device.getDeviceSetId()));
    }

    public void validateSetupIsReady() throws Exception {
        List<TreeDeviceManagementDto> visionSetupTreeDevices = sutManager.getVisionSetupTreeDevices();
        long timeout = 6 * 60 * 1000;
        visionSetupTreeDevices.forEach(device -> validateDeviceInTheTree(device.getManagementIp()));
        validateAllDevicesIsUpWithTimeout(timeout, visionSetupTreeDevices);

    }

    private void validateAllDevicesIsUpWithTimeout(Long timeout, List<TreeDeviceManagementDto> visionSetupTreeDevices) throws Exception {
        HashMap<String, Boolean> devicesStatus = new HashMap<>();
        visionSetupTreeDevices.forEach(device -> devicesStatus.put(device.getManagementIp(), false));
        long startTime = System.currentTimeMillis();

        while (System.currentTimeMillis() - startTime < timeout && !allDevicesIsUp(devicesStatus)) {
            for (Map.Entry<String, Boolean> deviceStatus : devicesStatus.entrySet()) {
                if (!deviceStatus.getValue())
                    deviceStatus.setValue(validateDeviceIsUp(deviceStatus.getKey()));
            }
            Thread.sleep(10000L);
        }
        for (Map.Entry<String, Boolean> deviceStatus : devicesStatus.entrySet()) {
            if (!deviceStatus.getValue())
                BaseTestUtils.report(String.format("Failed The device: %s is not UP", deviceStatus.getKey()), Reporter.FAIL);
        }

    }

    private boolean allDevicesIsUp(HashMap<String, Boolean> devicesStatus) {
        for (Map.Entry<String, Boolean> deviceStatus : devicesStatus.entrySet()) {
            if (!deviceStatus.getValue()) return false;
        }
        return true;
    }

    /**
     * return true if device status is ok
     *
     * @param ip : device ip
     * @return :true if device status is ok
     */
    private boolean validateDeviceIsUp(String ip) throws Exception {
        GenericVisionRestAPI restAPI = new GenericVisionRestAPI("Vision/SystemConfigTree.json", "Get Device Data");
        Map<String, String> pathParams = new HashMap<>();
        pathParams.put("ip", ip);
        restAPI.getRestRequestSpecification().setPathParams(pathParams);
        RestResponse restResponse = restAPI.sendRequest();
        if (!restResponse.getStatusCode().equals(StatusCode.OK)) {
            BaseTestUtils.report(String.format("Failed to get data to device: %s", ip), Reporter.FAIL);
        } else {
            DocumentContext jsonContext = JsonPath.parse(restResponse.getBody().getBodyAsString());
            String status = jsonContext.read("$..deviceStatus.status").toString();
            return status.toLowerCase().contains("ok");
        }
        return false;
    }

    private void validateDeviceInTheTree(String ip) {

        GenericVisionRestAPI restAPI = null;
        try {
            restAPI = new GenericVisionRestAPI("Vision/SystemConfigTree.json", "GET Device Tree");
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }
        RestResponse restResponse = restAPI.sendRequest();
        if (!restResponse.getBody().getBodyAsString().contains(ip)) {
            BaseTestUtils.report(String.format("The device: %s does not exist in Vision tree", ip), Reporter.FAIL);
        }
    }

    public void restoreSetup() throws Exception {
        String snapshotName = sutManager.getSnapshotName();
        Snapshot snapshot;
        if (snapshotName == null || snapshotName.equals("")) {
            BaseTestUtils.report("Could not find snapshotName in the SUT file.", Reporter.PASS);
            return;
        }
        if (sutManager.getSetupMode().toLowerCase().contains("kvm"))
            snapshot = getSnapshot(VMType.KVM, snapshotName);
        else snapshot = getSnapshot(VMType.OVA, snapshotName);
        snapshot.revertToSnapshot();
    }

    /**
     * recursive function that delete all the tree elements
     * get tree root
     *
     * @param root:tree root
     */
    private void deleteDevices(JsonNode root) throws Exception {
        DocumentContext jsonContext = JsonPath.parse(root.toString());
        int numberOfChildrens = root.get("children").size();
        while (numberOfChildrens > 0) {
            if (root.get("children").get(numberOfChildrens - 1).get("children").size() > 0) {
                deleteDevices(root.get("children").get(numberOfChildrens - 1));
            }
            String jsonPath = String.format("$..children[%s].meIdentifier.managedElementClass", numberOfChildrens - 1);
            String name = jsonContext.read(String.format("$..children[%s].name", numberOfChildrens - 1), JSONArray.class).get(0).toString();
            String type = jsonContext.read(jsonPath, JSONArray.class).get(0).toString().contains("Device") ? "device" : "site";
            GenericVisionRestAPI restAPI = new GenericVisionRestAPI("Vision/SystemConfigTree.json", "Delete Site/device by Name");
            Map<String, String> pathParams = new HashMap<>();
            pathParams.put("type", type);
            pathParams.put("name", name);
            restAPI.getRestRequestSpecification().setPathParams(pathParams);
            RestResponse restResponse = restAPI.sendRequest();
            if (!restResponse.getStatusCode().equals(StatusCode.OK)) {
                BaseTestUtils.report(String.format("Failed to delete device/site: %s", name), Reporter.FAIL);
            } else {
                Thread.sleep(15 * 1000);
            }

            numberOfChildrens--;
        }
    }

    public void addDevice(String setId) {
        TopologyTree topologyTree = new TopologyTreeImpl();
        RestStepResult result = topologyTree.addDevice(setId);
        if (result.getStatus() != RestStepResult.Status.SUCCESS)
            BaseTestUtils.report(String.format("Failed to add device with setId: %s", setId), Reporter.FAIL);
    }

    private static Snapshot getSnapshot(VMType type, String snapshotName) {
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
