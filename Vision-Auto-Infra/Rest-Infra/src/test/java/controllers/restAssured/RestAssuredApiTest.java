package controllers.restAssured;

import com.fasterxml.jackson.databind.JsonNode;
import controllers.restAssured.client.VisionRestAssuredClient;
import models.*;
import org.testng.annotations.Test;
import restInterface.RestApi;
import restInterface.RestClient;

import static org.testng.Assert.assertEquals;
import static org.testng.Assert.assertTrue;

public class RestAssuredApiTest {

    String baseUri = "https://172.17.192.100";
    String license_info = "/mgmt/system/config/item/licenseinfo";

    @Test
    public void testGetWithSuccessfulResponse() {
        RestClient restClient = new VisionRestAssuredClient(baseUri, "radware", "radware");
        RestResponse loginResponse = restClient.login();
        assert loginResponse.getStatusCode().getStatusCode() == 200;

        RestRequestSpecification requestSpecification = new RestRequestSpecification(Method.GET);
        requestSpecification.setAccept(ContentType.JSON);
        requestSpecification.setBasePath(license_info);
        requestSpecification.setContentType(ContentType.JSON);

        RestApi restApi = new RestAssuredApi();
        RestResponse response = restApi.sendRequest(requestSpecification);

        assertEquals(response.getStatusCode(), StatusCode.OK);

        assertEquals(response.getHeaders().get("Content-Type"), ContentType.JSON.toString());


        Body body = response.getBody();
        JsonNode root = body.getBodyAsJsonNode().get();
        JsonNode attackCapacityLicense = root.get("attackCapacityLicense");

        assertTrue(attackCapacityLicense.get("message").isNull());
        assertEquals(attackCapacityLicense.get("timeToExpiration").asInt(), 91);


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


    }
}