package controllers.restAssured.client.BasicAuth;

import static io.restassured.RestAssured.given;
import static models.config.DevicesConstants.*;

public class AlteonRestAssuredClient extends RestAssuredBasicAuthBasedRestClient {

    public AlteonRestAssuredClient(String baseUri, String username, String password) {
        this(baseUri, ALTEON_DEFAULT_PORT, username, password);
    }

    public AlteonRestAssuredClient(String baseUri, int connectionPort, String username, String password) {
        super(baseUri, connectionPort, username, password);
    }

    @Override
    public boolean isConnected() {

        return given().spec(this.requestSpecification).basePath(ALTEON_SESSION_DETAILS_PATH).
                when().get().
                then().extract().response().getStatusCode() == ALTEON_ON_SUCCESS_STATUS_CODE.getStatusCode();
    }
}
