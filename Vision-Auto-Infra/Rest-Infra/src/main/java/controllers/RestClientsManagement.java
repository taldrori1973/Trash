package controllers;

import controllers.restAssured.client.AlteonRestAssuredClient;
import controllers.restAssured.client.OnVisionVDirectRestAssuredClient;
import controllers.restAssured.client.RestAssuredClient;
import controllers.restAssured.client.VisionRestAssuredClient;
import restInterface.RestClient;

import java.util.Objects;
import java.util.Optional;

public class RestClientsManagement {


    public static RestClient getVisionConnection(String baseUri, String username, String password) {
        return new VisionRestAssuredClient(baseUri, username, password);
    }

    public static RestClient getVDirectConnection(String baseUri, String username, String password) {
        return new OnVisionVDirectRestAssuredClient(baseUri, username, password);
    }

    public static RestClient getAlteonConnection(String baseUri, String username, String password) {
        return new AlteonRestAssuredClient(baseUri, username, password);
    }

    public static Optional<RestClient> getCurrentConnection() {
        if (Objects.isNull(RestAssuredClient.currentClient)) return Optional.empty();
        return Optional.of(RestAssuredClient.currentClient);
    }

}
