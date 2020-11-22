package controllers;

import controllers.restAssured.client.BasicAuth.AlteonRestAssuredClient;
import controllers.restAssured.client.BasicAuth.AppWallRestAssuredClient;
import controllers.restAssured.client.RestAssuredNoAuthClient;
import controllers.restAssured.client.SessionBased.DefenseFlowRestAssuredClient;
import controllers.restAssured.client.SessionBased.OnVisionVDirectRestAssuredClient;
import controllers.restAssured.client.SessionBased.VisionRestAssuredClient;
import restInterface.client.RestClient;

import java.util.Optional;

import static java.util.Objects.isNull;

public class RestClientsManagement {


    private static RestClient currentConnection;

    public static RestClient getVisionConnection(String baseUri, String username, String password) {
        return new VisionRestAssuredClient(baseUri, username, password);
    }

    public static RestClient getOnVisionVDirectConnection(String baseUri, Integer connectionPort, String username, String password) {
        if (isNull(connectionPort)) return new OnVisionVDirectRestAssuredClient(baseUri, username, password);

        return new OnVisionVDirectRestAssuredClient(baseUri, connectionPort, username, password);
    }


    public static RestClient getVisionConnection(String baseUri, Integer connectionPort, String username, String password) {
        return new VisionRestAssuredClient(baseUri, connectionPort, username, password);
    }

    public static RestClient getVisionConnection(String baseUri, Integer connectionPort, String username, String password, String license) {
        return new VisionRestAssuredClient(baseUri, connectionPort, username, password, license);
    }

    public static RestClient getAlteonConnection(String baseUri, Integer connectionPort, String username, String password) {
        if (isNull(connectionPort))
            return new AlteonRestAssuredClient(baseUri, username, password);
        return new AlteonRestAssuredClient(baseUri, connectionPort, username, password);
    }

    public static RestClient getAppWallConnection(String baseUri, Integer connectionPort, String username, String password) {
        if (isNull(connectionPort))
            return new AppWallRestAssuredClient(baseUri, username, password);
        return new AppWallRestAssuredClient(baseUri, connectionPort, username, password);
    }

    public static RestClient getDefenseFlowConnection(String baseUri, Integer connectionPort, String username, String password) {
        if (isNull(connectionPort))
            return new DefenseFlowRestAssuredClient(baseUri, username, password);
        return new DefenseFlowRestAssuredClient(baseUri, connectionPort, username, password);
    }

    public static RestClient getNoAuthConnection(String baseUri, Integer connectionPort) {
        return new RestAssuredNoAuthClient(baseUri, connectionPort);
    }

    public static Optional<RestClient> getCurrentConnection() {
        if (isNull(currentConnection)) return Optional.empty();
        return Optional.of(currentConnection);
    }

    public static void setCurrentConnection(RestClient currentConnection) {
        RestClientsManagement.currentConnection = currentConnection;
    }
}
