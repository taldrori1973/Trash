package models;

import controllers.restAssured.client.VisionRestAssuredClient;
import restInterface.RestClient;

public class RestConnectionsFactory {


    public static RestClient getVisionConnection(String baseUri, String username, String password) {
        return new VisionRestAssuredClient(baseUri, username, password);
    }

    public static RestClient getVisionConnection(String baseUri, int connectionPort, String username, String password) {
        return new VisionRestAssuredClient(baseUri, connectionPort, username, password);
    }

    public static RestClient getVisionConnection(String baseUri, int connectionPort, String username, String password, String license) {
        return new VisionRestAssuredClient(baseUri, connectionPort, username, password, license);
    }


}
