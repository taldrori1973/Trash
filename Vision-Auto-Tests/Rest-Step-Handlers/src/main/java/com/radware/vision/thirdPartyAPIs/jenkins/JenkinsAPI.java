package com.radware.vision.thirdPartyAPIs.jenkins;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.RestClientsFactory;
import com.radware.vision.restTestHandler.GenericStepsHandler;
import com.radware.vision.thirdPartyAPIs.jenkins.pojos.BuildPojo;
import com.radware.vision.thirdPartyAPIs.jenkins.pojos.JobPojo;
import controllers.RestApiManagement;
import lombok.Data;
import models.RestRequestSpecification;
import models.RestResponse;
import models.StatusCode;
import restInterface.RestApi;
import restInterface.client.NoAuthRestClient;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 1:42 PM
 */
@Data
public class JenkinsAPI {
    private static RestApi restApi = RestApiManagement.getRestApi();

    public static JobPojo getJobInfo(String jobName) throws Exception {
        Map<String, String> pathParamsMap = new HashMap<>();
        pathParamsMap.put("jobName", jobName);

        RestResponse restResponse = sendJenkinsRequest("Get Job Info", pathParamsMap);
        if (!restResponse.getStatusCode().equals(StatusCode.OK))
            throw new Exception(restResponse.getBody().getBodyAsString());

        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(restResponse.getBody().getBodyAsString(), JobPojo.class);
    }

    public static BuildPojo getBuildInfo(String jobName, Integer buildNumber) throws Exception {

        Map<String, String> pathParamsMap = new HashMap<>();
        pathParamsMap.put("jobName", jobName);
        pathParamsMap.put("buildNumber", buildNumber.toString());
        RestResponse restResponse = sendJenkinsRequest("Get Build Info", pathParamsMap);

        if (!restResponse.getStatusCode().equals(StatusCode.OK))
            throw new Exception(restResponse.getBody().getBodyAsString());

        ObjectMapper objectMapper = new ObjectMapper();
        return objectMapper.readValue(restResponse.getBody().getBodyAsString(), BuildPojo.class);
    }

    private static RestResponse sendJenkinsRequest(String requestLabel, Map<String, String> pathParamsMap) throws Exception {
        NoAuthRestClient noAuthConnection = RestClientsFactory.getNoAuthConnection("http://cmjen04.il.corp.radware.com/", 8081);
        noAuthConnection.switchTo();

        RestRequestSpecification request = GenericStepsHandler.createNewRestRequestSpecification("/ThirdPartyAPIs/jenkins.json", requestLabel);

        request.setPathParams(pathParamsMap);

        RestResponse restResponse = RestApiManagement.getRestApi().sendRequest(request);
        if (!restResponse.getStatusCode().equals(StatusCode.OK))
            throw new Exception(restResponse.getBody().getBodyAsString());
        return restResponse;
    }
}
