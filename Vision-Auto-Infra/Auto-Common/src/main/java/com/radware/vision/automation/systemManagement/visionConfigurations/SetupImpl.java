package com.radware.vision.automation.systemManagement.visionConfigurations;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.RestStepResult;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.AutoUtils.utils.SystemProperties;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.automation.systemManagement.ReportsUtilsAutoCommon;
import com.radware.vision.automation.thirdPartyAPIs.SaproCommunication.SaproCommunicationHandler;
import com.radware.vision.devicesRestApi.topologyTree.TopologyTree;
import com.radware.vision.devicesRestApi.topologyTree.TopologyTreeImpl;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import lombok.Data;
import models.RestResponse;
import models.StatusCode;

import java.io.IOException;
import java.util.*;

import static models.config.DevicesConstants.*;
import static models.config.DevicesConstants.SIMULATOR_XML_FILE_3;

public class SetupImpl extends TestBase{

    public void buildSetup() throws Exception {
        SystemProperties systemProperties = SystemProperties.get_instance();
        String syncDevices = systemProperties.getValueByKey("SYNC_DEVICES");
        if(syncDevices != null && syncDevices.equalsIgnoreCase("FALSE"))
            return;

        DevicesTree existedDevicesTree;
//        try {
        existedDevicesTree = getDeviceTree();
//        }
//        catch (StatusCodeException e){
//            if(e.getStatusCode().equals(StatusCode.PAYMENT_REQUIRED))
//            {
//                activateVision();
//                existedDevicesTree = getDeviceTree();
//            }
//            else
//                BaseTestUtils.report("Can't get devices tree", Reporter.FAIL);
//        }

        if(existedDevicesTree!=null)
        {
            deleteDevices(existedDevicesTree, existedDevicesTree.getName());
            List<TreeDeviceManagementDto> visionSetupTreeDevices = sutManager.getVisionSetupTreeDevices();
            addDevices(existedDevicesTree , visionSetupTreeDevices);
            //validateSetupIsReady();
        }

        ReportsUtilsAutoCommon.reportErrors();
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
        assert restAPI != null;
        RestResponse restResponse = restAPI.sendRequest();
        if (!restResponse.getBody().getBodyAsString().contains(ip)) {
            BaseTestUtils.report(String.format("The device: %s does not exist in Vision tree", ip), Reporter.FAIL);
        }
    }

    public boolean deleteDevices(DevicesTree existedDevicesTree, String parentSite) throws Exception {
        String name = existedDevicesTree.getName();
        String type = (existedDevicesTree.getType()!=null)?"device":"site";

        boolean containsDevices = false;
        if(existedDevicesTree.getChildren().size() > 0)
        {
            List<DevicesTree> removedDevices = new ArrayList<>();
            for (DevicesTree dt:existedDevicesTree.getChildren()
            ) {
                boolean dtRemoved = deleteDevices(dt, name);
                containsDevices = !dtRemoved || containsDevices;
                if(dtRemoved)
                    removedDevices.add(dt);
            }
            existedDevicesTree.remove(removedDevices);
        }

        if(type.equals("device"))
        {
            String parentSiteSetup = TestBase.getSutManager().getDeviceParentSite(name);

            if(parentSiteSetup != null && parentSiteSetup.equals(parentSite))
            {
                Optional<TreeDeviceManagementDto> d = TestBase.getSutManager().getTreeDeviceManagementFromDevices(name);
                if(d!=null && d.isPresent())
                {
                    GenericVisionRestAPI restAPI = new GenericVisionRestAPI("Vision/SystemConfigTree.json", "Get Device Data");
                    Map<String, String> pathParams = new HashMap<>();
                    pathParams.put("ip", d.get().getManagementIp());
                    restAPI.getRestRequestSpecification().setPathParams(pathParams);
                    RestResponse restResponse = restAPI.sendRequest();
                    if(restResponse.getStatusCode().equals(StatusCode.OK))
                    {
                        return false;
                    }
                }
            }

        }
        else if(containsDevices || name.equals("Default"))
            return false;

        GenericVisionRestAPI restAPI;
        Map<String, String> pathParams = new HashMap<>();
        if(type.equalsIgnoreCase("DEVICE"))
        {
            restAPI = new GenericVisionRestAPI("Vision/SystemConfigTree.json", "Delete Device");
            pathParams.put("ormID" ,existedDevicesTree.getMeIdentifier().getManagedElementID()); // get ormID
        }
        else
        {
            restAPI = new GenericVisionRestAPI("Vision/SystemConfigTree.json", "Delete Site/device by Name");
            pathParams.put("type", type);
            pathParams.put("name", name);
        }
        restAPI.getRestRequestSpecification().setPathParams(pathParams);
        RestResponse restResponse;
        int timeToTry = 5;
        do {
            if(timeToTry != 5)
            {
                Thread.sleep(10 * 1000);
            }
            restResponse = restAPI.sendRequest();
            timeToTry--;
        }
        while (!restResponse.getStatusCode().equals(StatusCode.OK) && type.equals("site"));

        if (!restResponse.getStatusCode().equals(StatusCode.OK)) {
            ReportsUtilsAutoCommon.addErrorMessage(String.format("Failed to delete device/site: %s", name));
            return false;
        }

        return true;
    }

    public void addDevices(DevicesTree existedDevicesTree, List<TreeDeviceManagementDto> setupDevicesTree)
    {
        HashMap<String, String> existedDevicesHash = existedDevicesTree.getDevicesHash();

        for (TreeDeviceManagementDto device:setupDevicesTree
        ) {
            startupIfSimulator(device);
            if(!existedDevicesHash.containsKey(device.getDeviceName()))
            {
                addDevice(device.getDeviceSetId());
            }
        }
    }

    public void addDevice(String setId) {
        TopologyTree topologyTree = new TopologyTreeImpl();
        RestStepResult result = topologyTree.addDevice(setId);
        if (result.getStatus() != RestStepResult.Status.SUCCESS)
            ReportsUtilsAutoCommon.addErrorMessage(String.format("Failed to add device with setId: %s", setId));
    }

    private void startupIfSimulator(TreeDeviceManagementDto tDMDto)
    {
        if(!tDMDto.getDeviceSetId().startsWith("Alteon_Sim"))
            return;

        SaproCommunicationHandler.getInstance().reloadXmlFile(DEFAULT_MAP, tDMDto.getDeviceName(), getSimulatorXMLFile(tDMDto.getDeviceSetId()));
    }

    private String getSimulatorXMLFile(String name)
    {
        switch (name) {
            case "Alteon_Sim_Set_2": return SIMULATOR_XML_FILE_3;
            case "Alteon_Sim_Set_1": return SIMULATOR_XML_FILE_2;
            case "Alteon_Sim_Set_0":
            default: return SIMULATOR_XML_FILE_1;
        }
    }

    protected static DevicesTree getDeviceTree() throws Exception
    {
        GenericVisionRestAPI restAPI = new GenericVisionRestAPI("Vision/SystemConfigTree.json", "GET Device Tree");
        RestResponse restResponse = restAPI.sendRequest();

        if(!restResponse.getStatusCode().equals(StatusCode.OK))
            throw new StatusCodeException(restResponse.getStatusCode());

        String jsonTree = restResponse.getBody().getBodyAsJsonNode().get().toString();

        ObjectMapper objectMapper = new ObjectMapper();
        DevicesTree devicesTree = null;

        try {
            devicesTree = objectMapper.readValue(jsonTree, DevicesTree.class);
        } catch (IOException e) {
            System.err.println(e.getMessage());
            e.printStackTrace();
        }

        return devicesTree;
    }
}

class StatusCodeException extends Exception
{
    private final StatusCode statusCode;

    public StatusCodeException(StatusCode statusCode)
    {
        super(statusCode.toString());
        this.statusCode = statusCode;
    }

    public StatusCode getStatusCode()
    {
        return this.statusCode;
    }
}

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
class Identifier {
    private String managedElementID;
}

@Data
@JsonIgnoreProperties(ignoreUnknown = true)
class DevicesTree {
    private List<DevicesTree> children;
    private String name;
    private String type;
    private Identifier meIdentifier;

    public HashMap<String,String> getDevicesHash()
    {
        HashMap<String,String> devicesHash = new HashMap<>();

        if(children.size() > 0)
        {
            for (DevicesTree dt:children
            ) {
                devicesHash.putAll(dt.getDevicesHash());
            }
        }
        else if(type!=null)
        {
            devicesHash.put(name, type);
        }

        return devicesHash;
    }

    public void remove(List<DevicesTree> children)
    {
        this.children.removeAll(children);
    }
}