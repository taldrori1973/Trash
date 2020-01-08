package controllers.restAssured.client.SessionBased;

import io.restassured.RestAssured;
import io.restassured.response.Response;

import static models.config.DevicesConstants.*;

public class OnVisionVDirectRestAssuredClient extends VisionRestAssuredClient {

    public OnVisionVDirectRestAssuredClient(String baseUri, String username, String password) {
        this(baseUri, V_DIRECT_DEFAULT_PORT, username, password);
    }

    public OnVisionVDirectRestAssuredClient(String baseUri, int port, String username, String password) {
        super(baseUri, port, username, password);
    }

    @Override
    public boolean isLoggedIn() {
        if (super.isLoggedIn()) {
            Response response = RestAssured.
                    given().sessionId(this.sessionId).baseUri(this.baseUri).port(V_DIRECT_DEFAULT_PORT).basePath(V_DIRECT_INFO_PATH).
                    when().get().
                    then().extract().response();

            return response.statusCode() == V_DIRECT_ON_SUCCESS_STATUS_CODE.getStatusCode() && response.body().jsonPath().get(V_DIRECT_USERNAME_FIELD_NAME_IN_RESPONSE).equals(this.username);
        }
        return false;
    }
}
