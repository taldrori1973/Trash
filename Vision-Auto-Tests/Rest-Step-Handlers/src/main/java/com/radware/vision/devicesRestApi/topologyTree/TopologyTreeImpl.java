package com.radware.vision.devicesRestApi.topologyTree;

import com.fasterxml.jackson.databind.JsonNode;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.RestStepResult;
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
    public String getSiteOrmId(String siteName) {
        GenericVisionRestAPI request = new GenericVisionRestAPI("/Vision/SystemConfigTree.json", "Get Site by Name");

        Map<String, String> pathParams = new HashMap<>();
        pathParams.put("name", siteName);

        request.getRestRequestSpecification().setPathParams(pathParams);

        RestResponse restResponse = request.sendRequest();
        if (!restResponse.getStatusCode().equals(StatusCode.OK))
            BaseTestUtils.report(restResponse.getBody().getBodyAsString(), Reporter.FAIL);

        Optional<JsonNode> responseJsonNodeOpt = restResponse.getBody().getBodyAsJsonNode();

        if (responseJsonNodeOpt.isPresent()) {
            if (responseJsonNodeOpt.get().has("ormID")) responseJsonNodeOpt.get().get("ormID").asText();
        }
        return null;

    }

    @Override
    public RestStepResult deleteSite(String siteName) {
        return null;
    }
}
