package com.radware.vision.systemManagement.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.vision.systemManagement.models.ManagementInfo;
import com.radware.vision.tools.rest.CurrentVisionRestAPI;
import models.RestResponse;
import models.StatusCode;

public class VisionConfigurationsController {

    public ManagementInfo getVisionConfigurationsByRest() {
        ManagementInfo managementInfo = new ManagementInfo();
        try {
            CurrentVisionRestAPI currentVisionRestAPI = new CurrentVisionRestAPI("Vision/SystemManagement.json", "Get Management Info");

            RestResponse result = currentVisionRestAPI.sendRequest();

            if (!result.getStatusCode().equals(StatusCode.OK))
                throw new UnsupportedOperationException(result.getBody().getBodyAsString());

            JsonNode body = result.getBody().getBodyAsJsonNode().isPresent() ? result.getBody().getBodyAsJsonNode().get() : null;
            if (body == null) throw new NullPointerException("Request Body returns null");

            managementInfo.setActiveServerMacAddress(body.get("activeServerMacAddress").asText());
            managementInfo.setDefenseFlowId(body.get("defenseFlowId").asText());
            managementInfo.setHardwarePlatform(body.get("hardwarePlatform").asText());
            managementInfo.setHostname(body.get("hostname").asText());
            managementInfo.setMacAddress(body.get("macAddress").asText());

            String[] versionAndBuild = body.get("serverSoftwareVersion").asText().split(" ");
            if (versionAndBuild.length != 2) {
                managementInfo.setVersion("0.00.00");
                managementInfo.setBuild("0");
                throw new IllegalStateException(String.format("\"serverSoftwareVersion\" field returns unexpected value, maybe build or version are missing. "));
            }

            managementInfo.setVersion(versionAndBuild[0]);
            managementInfo.setBuild(versionAndBuild[1]);


        } catch (NoSuchFieldException | UnsupportedOperationException e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }


        return managementInfo;
    }
}
