package com.radware.vision.restAPI;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.RestClientsFactory;
import com.radware.vision.restTestHandler.GenericStepsHandler;
import controllers.RestApiManagement;
import models.RestRequestSpecification;
import models.RestResponse;
import models.StatusCode;
import restInterface.client.NoAuthRestClient;

import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:33 PM
 */
public class JFrogRestAPI {

    private String baseUri;
    private Integer connectionPort;
    private String repoName;

    public JFrogRestAPI(String jFrogApiId, String repoName) throws IOException {
        ObjectMapper objectMapper = new ObjectMapper();
        URL resource = this.getClass().getClassLoader().getResource("restApis/Generic-REST-API/ThirdPartyAPIs/jfrog.json");
        JsonNode jsonNode = objectMapper.readTree(resource).get(jFrogApiId);
        this.baseUri = String.format(
                "%s://%s",
                jsonNode.get("connectionProtocol"),
                jsonNode.get("connectionHost")
        );

        this.connectionPort = jsonNode.get("connectionPort").asInt();

        this.repoName = repoName;


    }

    public RestResponse sendRequest(String path, StatusCode expectedStatusCode) throws Exception {
        if (path == null) path = "";

        NoAuthRestClient connection = RestClientsFactory.getNoAuthConnection(this.baseUri, this.connectionPort);
        connection.switchTo();

        RestRequestSpecification restRequestSpecification = GenericStepsHandler.createNewRestRequestSpecification("/ThirdPartyAPIs/jfrog.json", "Get Artifact API");
        Map<String, String> pathParams = new HashMap<>();
        pathParams.put("repoName", this.repoName);
        pathParams.put("path", path);

        restRequestSpecification.setPathParams(pathParams);

        RestResponse restResponse = RestApiManagement.getRestApi().sendRequest(restRequestSpecification);
        if (!restResponse.getStatusCode().equals(expectedStatusCode))
            throw new Exception(restResponse.getBody().getBodyAsString());
        return restResponse;

    }
}
