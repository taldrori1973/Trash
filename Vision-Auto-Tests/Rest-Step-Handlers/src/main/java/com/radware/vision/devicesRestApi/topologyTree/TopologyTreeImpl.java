package com.radware.vision.devicesRestApi.topologyTree;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.vision.RestStepResult;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManagerImpl;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import models.RestResponse;
import models.StatusCode;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 5/5/2020
 * Time: 1:33 AM
 */
public class TopologyTreeImpl implements TopologyTree {

    private static SUTManager sutManager = SUTManagerImpl.getInstance();

    private static String REQUESTS_FILE_PATH = "/Vision/SystemConfigTree.json";

    @Override
    public RestStepResult addDevice(String setId) {
        return null;
    }

    @Override
    public RestStepResult getDevice(String setId) {
        return null;
    }

    @Override
    public RestStepResult updateDevice(String setId) {
        return null;
    }

    @Override
    public RestStepResult deleteDevice(String setId) {
        return null;
    }

    @Override
    public RestStepResult addSite(String siteName, String parentSiteName) {
        return null;
    }

    @Override
    public String getSiteOrmId(String siteName) throws Exception {
        GenericVisionRestAPI request = new GenericVisionRestAPI(REQUESTS_FILE_PATH, "Get Site by Name");

        Map<String, String> pathParams = new HashMap<>();
        pathParams.put("name", siteName);

        request.getRestRequestSpecification().setPathParams(pathParams);

        RestResponse restResponse = request.sendRequest();
        if (!restResponse.getStatusCode().equals(StatusCode.OK))
            throw new Exception(restResponse.getBody().getBodyAsString());

        Optional<JsonNode> responseJsonNodeOpt = restResponse.getBody().getBodyAsJsonNode();

        if (responseJsonNodeOpt.isPresent()) {
            if (responseJsonNodeOpt.get().has("ormID")) return responseJsonNodeOpt.get().get("ormID").asText();
        }
        return null;
    }

    @Override
    public RestStepResult deleteSite(String siteName) {
        return null;
    }
}
