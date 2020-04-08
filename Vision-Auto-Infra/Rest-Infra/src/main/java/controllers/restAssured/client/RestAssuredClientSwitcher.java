package controllers.restAssured.client;

import controllers.RestClientsManagement;
import io.restassured.RestAssured;
import io.restassured.specification.RequestSpecification;
import restInterface.client.RestClient;

public class RestAssuredClientSwitcher {


    public static void switchTo(String baseUri, int connectionPort, String sessionId, RequestSpecification requestSpecification, RestClient restClient) {
        RestAssured.baseURI = baseUri;
        RestAssured.port = connectionPort;
        RestAssured.sessionId = sessionId;
        RestAssured.requestSpecification = requestSpecification;
        RestClientsManagement.setCurrentConnection(restClient);
    }
}
