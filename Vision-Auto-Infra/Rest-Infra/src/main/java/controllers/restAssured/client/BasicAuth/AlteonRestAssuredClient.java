package controllers.restAssured.client.BasicAuth;

import io.restassured.response.Response;
import mappers.restAssured.RestAssuredResponseMapper;
import models.RestResponse;

import static io.restassured.RestAssured.given;
import static models.config.DevicesConstants.ALTEON_DEFAULT_PORT;
import static models.config.DevicesConstants.ALTEON_SESSION_DETAILS_PATH;

public class AlteonRestAssuredClient extends RestAssuredBasicAuthBasedRestClient {

    public AlteonRestAssuredClient(String baseUri, String username, String password) {
        this(baseUri, ALTEON_DEFAULT_PORT, username, password);
    }

    public AlteonRestAssuredClient(String baseUri, int connectionPort, String username, String password) {
        super(baseUri, connectionPort, username, password);
    }

    @Override
    public RestResponse checkConnection() {

        Response response = given().spec(this.requestSpecification).basePath(ALTEON_SESSION_DETAILS_PATH).
                when().get().
                then().extract().response();
        return RestAssuredResponseMapper.map(response);
    }
}
