package com.radware.vision.devicesRestApi.topologyTree;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.radware.vision.RestStepResult;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.restAPI.GenericVisionRestAPI;
import models.RestResponse;
import models.StatusCode;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import static com.radware.vision.utils.SutUtils.*;
import static java.lang.String.format;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 5/5/2020
 * Time: 1:33 AM
 */
public class TopologyTreeImpl implements TopologyTree {

//    private static SUTManager sutManager = SUTManagerImpl.getInstance();

    private static String REQUESTS_FILE_PATH = "/Vision/SystemConfigTree.json";
    private static String PARENT_ORM_ID_JSON_KEY = "parentOrmID";

    @Override
    public RestStepResult addDevice(String setId) {
        try {

//            get device from sut
            Optional<TreeDeviceManagementDto> treeDeviceManagementDtoOptional = getDeviceManagement(setId);
            if (!treeDeviceManagementDtoOptional.isPresent()) return new RestStepResult(RestStepResult.Status.FAILED,
                    format("The Device with Set Id \"%s\" wasn't found", setId));

            TreeDeviceManagementDto deviceManagementDto = treeDeviceManagementDtoOptional.get();

//            get device Request Body from SUT
            Optional<JsonNode> requestBodyAsJsonNodeOpt = getDeviceRequestBodyAsJson(deviceManagementDto.getDeviceId());

            if (!requestBodyAsJsonNodeOpt.isPresent())
                return new RestStepResult(RestStepResult.Status.FAILED, "No Json Body was returned from the SUT");

//          get and cast JsonNode to ObjectNode because JsonNode is Immutable.
            ObjectNode body = (ObjectNode) requestBodyAsJsonNodeOpt.get();

//            get device parent ormID

            String siteOrmId = this.getSiteOrmId(sutManager.getDeviceParentSite(deviceManagementDto.getDeviceId()));

            body.put(PARENT_ORM_ID_JSON_KEY, siteOrmId);

//            send request

            GenericVisionRestAPI requestApi = new GenericVisionRestAPI(REQUESTS_FILE_PATH, "Add Device to the Server");

            requestApi.getRestRequestSpecification().setBody(body.toString());

            RestResponse restResponse = requestApi.sendRequest();

            return restResponse.getStatusCode().equals(StatusCode.OK) ?
                    new RestStepResult(RestStepResult.Status.SUCCESS, restResponse.getBody().getBodyAsString()) :
                    new RestStepResult(RestStepResult.Status.FAILED, restResponse.getBody().getBodyAsString());
        } catch (Exception e) {
            return new RestStepResult(RestStepResult.Status.FAILED, e.getMessage());
        }
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
