package controllers.restAssured.client.SessionBased;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import mappers.restAssured.RestAssuredResponseMapper;
import models.RestResponse;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import static models.config.DevicesConstants.*;

public class VisionRestAssuredClient extends RestAssuredSessionBasedRestClient {

    protected String license;

    private Map<String, String> authenticationRequestBody;


    public VisionRestAssuredClient(String baseUri, String username, String password) {
        this(baseUri, VISION_DEFAULT_PORT, username, password);
    }

    public VisionRestAssuredClient(String baseUri, int connectionPort, String username, String password) {
        this(baseUri, connectionPort, username, password, null);
    }

    public VisionRestAssuredClient(String baseUri, int connectionPort, String username, String password, String license) {
        super(baseUri, connectionPort, username, password);

        this.license = license;

        this.authenticationRequestBody = new HashMap<>();
        this.authenticationRequestBody.put(VISION_USERNAME_FIELD_NAME, username);
        this.authenticationRequestBody.put(VISION_PASSWORD_FIELD_NAME, password);

        if (!Objects.isNull(license)) this.authenticationRequestBody.put(VISION_LICENSE_FIELD_NAME, license);
    }


    @Override
    public RestResponse login() {
        Response response = RestAssured.
                given().filter(this.sessionFilter).contentType(ContentType.JSON).baseUri(this.baseUri).port(VISION_DEFAULT_PORT).body(this.authenticationRequestBody).basePath(VISION_LOGIN_PATH).
                when().post().
                then().extract().response();

        this.requestSpecification.filter(this.sessionFilter);
        this.sessionId = response.sessionId();
        RestResponse restResponse = RestAssuredResponseMapper.map(response);

        if (restResponse.getStatusCode().equals(VISION_ON_SUCCESS_STATUS_CODE)) switchTo();

        return restResponse;
    }

    @Override
    public boolean isLoggedIn() {
        if (Objects.isNull(sessionId)) return false;
        Response response = RestAssured.
                given().sessionId(this.sessionId).baseUri(this.baseUri).port(VISION_DEFAULT_PORT).basePath(VISION_INFO_PATH).
                when().get().
                then().extract().response();

        return response.statusCode() == VISION_ON_SUCCESS_STATUS_CODE.getStatusCode() && response.body().jsonPath().get(VISION_USERNAME_FIELD_NAME).equals(this.username);

    }

    @Override
    public RestResponse logout() {
        Response response = RestAssured.
                given().sessionId(this.sessionId).baseUri(this.baseUri).port(VISION_DEFAULT_PORT).basePath(VISION_LOGOUT_PATH).
                when().post().
                then().extract().response();

        return RestAssuredResponseMapper.map(response);

    }
}
