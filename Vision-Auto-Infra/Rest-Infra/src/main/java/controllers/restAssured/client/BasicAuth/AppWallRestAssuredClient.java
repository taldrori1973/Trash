package controllers.restAssured.client.BasicAuth;

import static io.restassured.RestAssured.given;
import static models.config.DevicesConstants.*;

public class AppWallRestAssuredClient extends RestAssuredBasicAuthBasedRestClient {

    public AppWallRestAssuredClient(String baseUri, String username, String password) {
        this(baseUri, APPWALL_DEFAULT_PORT, username, password);
    }

    public AppWallRestAssuredClient(String baseUri, int connectionPort, String username, String password) {
        super(baseUri, connectionPort, username, password);

    }

    @Override
    public boolean isConnected() {
        return given().spec(this.requestSpecification).basePath(APPWALL_USER_INFO_PATH).pathParams(APPWALL_USER_INFO_PATH_PARAMETER, this.username).
                when().get().
                then().extract().response().getStatusCode() == APPWALL_ON_SUCCESS_STATUS_CODE.getStatusCode();
    }
}
