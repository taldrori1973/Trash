package com.radware.vision.setup;

import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.RestStepResult;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.devicesRestApi.topologyTree.TopologyTree;
import com.radware.vision.devicesRestApi.topologyTree.TopologyTreeImpl;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import com.radware.vision.setup.snapshot.Snapshot;
import com.radware.vision.setup.snapshot.SnapshotKVM;
import com.radware.vision.setup.snapshot.SnapshotOVA;
import models.RestResponse;
import org.json.simple.parser.ParseException;

import java.util.HashMap;
import java.util.Map;

public class SetupImpl extends TestBase implements Setup {

//    private static String REQUESTS_FILE_PATH = "/Vision/SystemConfigTree.json";

    public void buildSetup() throws NoSuchFieldException, ParseException {
        GenericVisionRestAPI restAPI = new GenericVisionRestAPI("Vision/SystemConfigTree.json", "GET Device Tree");
        RestResponse restResponse = restAPI.sendRequest();
        DocumentContext jsonContext = JsonPath.parse(restResponse.getBody().getBodyAsString());
        int numberOfChildrens = restResponse.getBody().getBodyAsJsonNode().get().get("children").size();
        while (numberOfChildrens > 0) {

            String jsonPath = String.format("$..children[%s].meIdentifier.managedElementClass", numberOfChildrens - 1);
            String name = jsonContext.read(String.format("$..children[%s].name", numberOfChildrens - 1)).toString();
            name = name.substring(2, name.length() - 2);
            String type = jsonContext.read(jsonPath).toString().contains("Device") ? "device" : "site";
            restAPI = new GenericVisionRestAPI("Vision/SystemConfigTree.json", "Delete Site/device by Name");
            Map<String, String> pathParams = new HashMap<>();
            pathParams.put("type", type);
            pathParams.put("name", name);
            restAPI.getRestRequestSpecification().setPathParams(pathParams);
            restResponse = restAPI.sendRequest();
            numberOfChildrens--;
        }
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
            snapshot = getSnapshot(VMType.KVM, snapshotName);
        else snapshot = getSnapshot(VMType.OVA, snapshotName);
        snapshot.revertToSnapshot();
    }

    public void addDevice(String setId) {
        TopologyTree topologyTree = new TopologyTreeImpl();
        RestStepResult result = topologyTree.addDevice(setId);
        if (result.getStatus() != RestStepResult.Status.SUCCESS)
            BaseTestUtils.report(String.format("Failed to add device with setId: %s", setId), Reporter.FAIL);
    }

    public static Snapshot getSnapshot(VMType type, String snapshotName) {
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
