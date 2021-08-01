package com.radware.vision.automation.systemManagement.visionConfigurations;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import models.RestResponse;
import models.StatusCode;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class VisionConfigurationsController {

    public ManagementInfo getVisionManagementInfoByRest() {
        ManagementInfo managementInfo = new ManagementInfo();
        try {
            GenericVisionRestAPI currentVisionRestAPI = new GenericVisionRestAPI("Vision/SystemManagement.json", "Get Management Info");

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

            String serverSoftwareVersion = body.get("serverSoftwareVersion").asText();

            ArrayList<String> versionAndBuild = extractVersionAndBuild(serverSoftwareVersion);
            if (versionAndBuild.size() != 2) {
                managementInfo.setVersion("0.00.00");
                managementInfo.setBuild("0");
                throw new IllegalStateException("\"serverSoftwareVersion\" field returns unexpected value, maybe build or version are missing. ");
            }

            managementInfo.setVersion(versionAndBuild.get(0));
            managementInfo.setBuild(versionAndBuild.get(1));


        } catch (NoSuchFieldException | UnsupportedOperationException e) {
            e.printStackTrace();
            throw new RuntimeException(e.getMessage());
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }
        return managementInfo;
    }
    private ArrayList<String> extractVersionAndBuild(String serverSoftwareVersion) {

        String serverSoftwareVersionPattern = "APSolute Vision\\s(\\d+.\\d+.\\d+)\\s\\(build\\s(\\d+)\\)";
        ArrayList<String> returnArray = new ArrayList<>();
            Matcher matcher = Pattern.compile(serverSoftwareVersionPattern).matcher(serverSoftwareVersion);
            while (matcher.find()) {
                returnArray.add(matcher.group(1));
                returnArray.add(matcher.group(2));
            }
        return returnArray;

    }
}
