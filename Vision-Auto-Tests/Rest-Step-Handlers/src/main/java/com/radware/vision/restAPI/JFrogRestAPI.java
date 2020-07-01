package com.radware.vision.restAPI;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.RestClientsFactory;
import com.radware.vision.automation.AutoUtils.utils.ApplicationPropertiesUtils;
import com.radware.vision.restTestHandler.GenericStepsHandler;
import controllers.RestApiManagement;
import models.RestRequestSpecification;
import models.RestResponse;
import models.StatusCode;
import restInterface.client.NoAuthRestClient;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/29/2020
 * Time: 3:33 PM
 */
public class JFrogRestAPI {

    private static ApplicationPropertiesUtils applicationPropertiesUtils = new ApplicationPropertiesUtils();
    private String baseUri;
    private Integer connectionPort;
    private String repoName;

    public JFrogRestAPI(String jFrogApiId, String repoName) {
        ObjectMapper objectMapper = new ObjectMapper();
        try (InputStream stream = this.getClass().getClassLoader().getResourceAsStream("restApis/Generic-REST-API/ThirdPartyAPIs/jfrog.json")) {

        } catch (IOException e) {
            e.printStackTrace();
        }
        objectMapper.readTree(this.getClass().getResource("restApis/Generic-REST-API/ThirdPartyAPIs/jfrog.json").getPath(), )
        this.baseUri = String.format(
                "%s://%s",
                applicationPropertiesUtils.getProperty("JFrog.artifactory.protocol"),
                applicationPropertiesUtils.getProperty("JFrog.artifactory.host")
        );

        this.connectionPort = Integer.parseInt(applicationPropertiesUtils.getProperty("JFrog.artifactory.port"));

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
