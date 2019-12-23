package mappers;

import controllers.restAssured.RestAssuredApi;
import controllers.restAssured.client.VDirectRestAssuredClient;
import controllers.restAssured.client.VisionRestAssuredClient;
import restInterface.RestApi;
import restInterface.RestClient;

public class RestFrameworkFactory {


    public static RestClient getVisionConnection(String baseUri, String username, String password) {
        return new VisionRestAssuredClient(baseUri, username, password);
    }

    public static RestClient getVDirectConnection(String baseUri, String username, String password) {
        return new VDirectRestAssuredClient(baseUri, username, password);
    }

    public static RestClient getVisionConnection(String baseUri, int connectionPort, String username, String password) {
        return new VisionRestAssuredClient(baseUri, connectionPort, username, password);
    }

    public static RestClient getVDirectConnection(String baseUri, int connectionPort, String username, String password) {
        return new VDirectRestAssuredClient(baseUri, connectionPort, username, password);
    }

    public static RestClient getVisionConnection(String baseUri, int connectionPort, String username, String password, String license) {
        return new VisionRestAssuredClient(baseUri, connectionPort, username, password, license);
    }

    public static RestApi getRestApi() {
        return RestAssuredApi.get_instance();
    }

}
