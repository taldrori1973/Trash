package controllers.restAssured.client;

import controllers.RestClientsManagement;
import controllers.restAssured.client.BasicAuth.RestAssuredBasicAuthBasedRestClient;
import controllers.restAssured.client.SessionBased.RestAssuredSessionBasedRestClient;
import io.restassured.RestAssured;
import io.restassured.specification.RequestSpecification;
import restInterface.client.RestClient;

public class RestAssuredClientSwitcher {
    public static void switchTo(RestClient restClient, Class<RestClient> restClientClass) {

        if (restClientClass.equals(RestAssuredSessionBasedRestClient.class)) {

        } else if (restClientClass.equals(RestAssuredBasicAuthBasedRestClient.class)) {

        }
    }

    public static void switchTo(String baseUri, int connectionPort, String sessionId, RequestSpecification requestSpecification, RestClient restClient) {
        RestAssured.baseURI = baseUri;
        RestAssured.port = connectionPort;
        RestAssured.sessionId = sessionId;
        RestAssured.requestSpecification = requestSpecification;
        RestClientsManagement.setCurrentConnection(restClient);
    }
}
