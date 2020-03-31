package com.radware.vision.systemManagement.controllers;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.vision.systemManagement.models.VisionConfigurationsModel;
import com.radware.vision.tools.rest.CurrentVisionRestAPI;
import models.RestResponse;
import models.StatusCode;

public class VisionConfigurationsController {

    public VisionConfigurationsModel getVisionConfigurationsByRest() {
        VisionConfigurationsModel visionConfigurationsModel = new VisionConfigurationsModel();
        try {
            CurrentVisionRestAPI currentVisionRestAPI = new CurrentVisionRestAPI("Vision/SystemManagement.json", "Get Management Info");

            RestResponse result = currentVisionRestAPI.sendRequest();

            if (!result.getStatusCode().equals(StatusCode.OK))
                throw new UnsupportedOperationException(result.getBody().getBodyAsString());

            JsonNode body = result.getBody().getBodyAsJsonNode().isPresent() ? result.getBody().getBodyAsJsonNode().get() : null;
            if (body == null) throw new NullPointerException("Request Body returns null");

            visionConfigurationsModel.setActiveServerMacAddress(body.get("activeServerMacAddress").asText());
            visionConfigurationsModel.setDefenseFlowId(body.get("defenseFlowId").asText());
            visionConfigurationsModel.setHardwarePlatform(body.get("hardwarePlatform").asText());
            visionConfigurationsModel.setHostname(body.get("hostname").asText());
            visionConfigurationsModel.setMacAddress(body.get("macAddress").asText());

            String[] versionAndBuild = body.get("activeServerMacAddress").asText().split(" ");


        } catch (NoSuchFieldException | UnsupportedOperationException e) {
            e.printStackTrace();
        }


        return null;
    }
}
