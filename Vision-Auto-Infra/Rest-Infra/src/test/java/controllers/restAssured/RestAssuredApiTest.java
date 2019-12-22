package controllers.restAssured;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import models.*;
import net.minidev.json.JSONArray;
import org.testng.annotations.Test;
import restInterface.RestApi;
import restInterface.RestClient;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.testng.Assert.*;

public class RestAssuredApiTest {

    String baseUri = "https://172.17.192.100";
    String license_info = "/mgmt/system/config/item/licenseinfo";
    String userInfo = "/mgmt/system/user/info";
    String userInfoQuery = "showpolicies";

    String newRulesTable = "mgmt/device/byip/{deviceIp}/config/rsIDSNewRulesTable";
    String newRulesTable_Count = "count";
    String newRulesTable_props = "props";
    String newRulesTable_props_value = "rsIDSNewRulesName";

    String licenseString = "vision-reporting-module-AMS-AkGmi3NA";

    @Test
    public void testGetWithSuccessfulResponse() {
        RestClient restClient = RestConnectionsFactory.getVisionConnection(baseUri, "radware", "radware");
        RestResponse loginResponse = restClient.login();
        assertEquals(loginResponse.getStatusCode(), StatusCode.OK);

        RestRequestSpecification requestSpecification = new RestRequestSpecification(Method.GET);
        requestSpecification.setAccept(ContentType.JSON);
        requestSpecification.setBasePath(license_info);
        requestSpecification.setContentType(ContentType.JSON);
        requestSpecification.addHeaders("Host", "172.17.192.100", "Connection", "keep-alive");
        requestSpecification.addCookies("JSESSIONID", loginResponse.getSessionId());
        RestApi restApi = new RestAssuredApi();
        RestResponse response = restApi.sendRequest(requestSpecification);

        assertEquals(response.getStatusCode(), StatusCode.OK);

        assertEquals(response.getHeaders().get("Content-Type"), ContentType.JSON.toString());

        assertEquals(response.getSessionId(), loginResponse.getSessionId());

        Body body = response.getBody();
        JsonNode root = body.getBodyAsJsonNode().get();
        JsonNode attackCapacityLicense = root.get("attackCapacityLicense");

        assertTrue(attackCapacityLicense.get("message").isNull());
        assertEquals(attackCapacityLicense.get("timeToExpiration").asInt(), 91);


    }

    @Test
    public void testGetWithQueryParameters() {
        RestApi restApi = new RestAssuredApi();
        RestResponse response;
        RestClient restClient = RestConnectionsFactory.getVisionConnection(baseUri, "radware", "radware");
        RestResponse loginResponse = restClient.login();
        assertEquals(loginResponse.getStatusCode(), StatusCode.OK);

        RestRequestSpecification request = new RestRequestSpecification(Method.GET);
        request.setBasePath(userInfo);

        response = restApi.sendRequest(request);
        assertNull(response.getBody().getBodyAsJsonNode().get().get("networkpolicies"));

        request.addQueryParams(this.userInfoQuery, true);
        response = restApi.sendRequest(request);
        assertNotNull(response.getBody().getBodyAsJsonNode().get().get("networkpolicies"));

        request.addQueryParams(this.userInfoQuery, false);
        response = restApi.sendRequest(request);
        assertNull(response.getBody().getBodyAsJsonNode().get().get("networkpolicies"));

    }

    @Test
    public void testGetWithPathParameters() {
        RestApi restApi = new RestAssuredApi();
        RestResponse response;

        RestClient restClient = RestConnectionsFactory.getVisionConnection(baseUri, "radware", "radware");
        RestResponse loginResponse = restClient.login();
        assertEquals(loginResponse.getStatusCode(), StatusCode.OK);

        RestRequestSpecification request = new RestRequestSpecification(Method.GET);
        request.setBasePath(newRulesTable);
        request.addPathParams("deviceIp", "172.16.22.51");

        response = restApi.sendRequest(request);
        assertEquals(response.getStatusCode(), StatusCode.OK);

        request.addQueryParams(newRulesTable_Count, 5);
        response = restApi.sendRequest(request);
        assertEquals(response.getStatusCode(), StatusCode.OK);
        assertEquals(response.getBody().getBodyAsJsonNode().get().get("rsIDSNewRulesTable").size(), 5);


        request.addQueryParams(newRulesTable_props, newRulesTable_props_value);
        response = restApi.sendRequest(request);

        JsonNode body = response.getBody().getBodyAsJsonNode().get();
        JsonNode rules = body.get("rsIDSNewRulesTable");
        assertEquals(rules.size(), 5);
        JsonNode firstRule = rules.get(0);

        List<JsonNode> fields = new ArrayList<>();
        firstRule.elements().forEachRemaining(fields::add);

        assertEquals(response.getStatusCode(), StatusCode.OK);
        assertEquals(fields.size(), 1);


    }

    @Test
    public void testGetWithFailureResponse() {

        RestClient restClient = RestConnectionsFactory.getVisionConnection(baseUri, "radware", "radware");
        RestResponse loginResponse = restClient.login();
        assert loginResponse.getStatusCode().getStatusCode() == 200;

        RestRequestSpecification requestSpecification = new RestRequestSpecification(Method.GET);
        requestSpecification.setAccept(ContentType.JSON);
        requestSpecification.setBasePath(license_info + "a");
        requestSpecification.setContentType(ContentType.JSON);

        RestApi restApi = new RestAssuredApi();
        RestResponse response = restApi.sendRequest(requestSpecification);

        assertEquals(response.getStatusCode(), StatusCode.INTERNAL_SERVER_ERROR);
    }

    @Test
    public void test_Head_With_Successful_Response() {
        RestClient restClient = RestConnectionsFactory.getVisionConnection(baseUri, "radware", "radware");
        RestResponse loginResponse = restClient.login();
        assert loginResponse.getStatusCode().getStatusCode() == 200;

        RestRequestSpecification requestSpecification = new RestRequestSpecification(Method.HEAD);
//        requestSpecification.setAccept(ContentType.JSON);
        requestSpecification.setBasePath(license_info);
//        requestSpecification.setContentType(ContentType.JSON);

        RestApi restApi = new RestAssuredApi();
        RestResponse response = restApi.sendRequest(requestSpecification);

        assertEquals(response.getStatusCode(), StatusCode.OK);

        assertEquals(response.getHeaders().get("Content-Type"), ContentType.JSON.toString());


        Body body = response.getBody();
        assertFalse(body.getBodyAsJsonNode().isPresent());
        assertEquals(body.getBodyAsString(), "");


    }

    @Test
    public void test_Post_Delete() throws JsonProcessingException {
        String taskName = "test";
        String basePath = "/mgmt/system/config/itemlist/scheduledtask/";

//        Connect to Vision
        RestClient restClient = RestConnectionsFactory.getVisionConnection(baseUri, "radware", "radware");
        RestResponse loginResponse = restClient.login();
        assertEquals(loginResponse.getStatusCode(), StatusCode.OK);

//        Check if the task already exist
        RestRequestSpecification request = new RestRequestSpecification(Method.GET);
        request.setBasePath(basePath);

        RestApi restApi = new RestAssuredApi();
        RestResponse response = restApi.sendRequest(request);

        JsonPath jsonPath = JsonPath.compile("$..[?(@.name==\"" + taskName + "\")].ormID");
        DocumentContext root = JsonPath.parse(response.getBody().getBodyAsString());
        JSONArray ormIdArr = root.read(jsonPath);

//        if Exist Delete the task
        String deletePath = basePath + "{ormID}";
        if (ormIdArr.size() > 0) {
            request = new RestRequestSpecification(Method.DELETE);
            request.setBasePath(deletePath);
            request.addPathParams("ormID", ormIdArr.get(0));

            response = restApi.sendRequest(request);

            assertEquals(response.getStatusCode(), StatusCode.OK);
        }


//        add new task with name : test

        Map<String, Object> time = new HashMap<>();
        time.put("runAlways", true);
        time.put("frequency", "DAILY");
        time.put("timeZoneGMT", "Etc/GMT-2");
        time.put("hour", 14);
        time.put("minute", 45);
        time.put("second", 22);

        Map<String, Object> additionalParams = new HashMap<>();
        additionalParams.put("confPassPhrasep", "radware");

        Map<String, Object> parameters = new HashMap<>();

        Map<String, Object> body = new HashMap<>();
        body.put("name", taskName);
        body.put("taskType", "VisionBackupTask");
        body.put("isScheduled", true);
        body.put("backupDestination", "VISION_SERVER");
        body.put("allowDuringAttack", false);
        body.put("requireDeviceLock", true);
        body.put("time", time);
        body.put("additionalParams", additionalParams);
        body.put("parameters", parameters);

        ObjectMapper objectMapper = new ObjectMapper();
        String bodyAsString = objectMapper.writeValueAsString(body);


        request = new RestRequestSpecification(Method.POST);
        request.setBasePath(basePath);
        request.setBody(bodyAsString);

        response = restApi.sendRequest(request);

        assertEquals(response.getStatusCode(), StatusCode.OK);


    }
}