package controllers.restAssured;

import com.fasterxml.jackson.databind.JsonNode;
import controllers.restAssured.client.VisionRestAssuredClient;
import models.*;
import org.testng.annotations.Test;
import restInterface.RestApi;
import restInterface.RestClient;

import java.util.ArrayList;
import java.util.List;

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


    @Test
    public void testGetWithSuccessfulResponse() {
        RestClient restClient = new VisionRestAssuredClient(baseUri, "radware", "radware");
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
        RestClient restClient = new VisionRestAssuredClient(baseUri, "radware", "radware");
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

        RestClient restClient = new VisionRestAssuredClient(baseUri, "radware", "radware");
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

        RestClient restClient = new VisionRestAssuredClient(baseUri, "radware", "radware");
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
        RestClient restClient = new VisionRestAssuredClient(baseUri, "radware", "radware");
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
}