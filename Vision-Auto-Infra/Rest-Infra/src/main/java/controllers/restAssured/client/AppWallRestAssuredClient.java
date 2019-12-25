package controllers.restAssured.client;

import io.restassured.response.Response;
import mappers.restAssured.RestAssuredResponseMapper;
import models.RestResponse;

import java.util.HashMap;
import java.util.Map;

import static io.restassured.RestAssured.given;
import static models.config.DevicesConstants.*;

public class AppWallRestAssuredClient extends RestAssuredClient {
    protected String username;
    protected String password;


    private Map<String, String> authenticationRequestBody;


    public AppWallRestAssuredClient(String baseUri, String username, String password) {
        this(baseUri, APPWALL_DEFAULT_PORT, username, password);
    }

    public AppWallRestAssuredClient(String baseUri, int connectionPort, String username, String password) {
        super(baseUri, connectionPort);

        this.username = username;
        this.password = password;

        this.authenticationRequestBody = new HashMap<>();
        this.authenticationRequestBody.put(APPWALL_USERNAME_FIELD_NAME, username);
        this.authenticationRequestBody.put(APPWALL_PASSWORD_FIELD_NAME, password);

    }

    public static void main(String[] args) {

    }

    @Override
    public RestResponse login() {
        Response response =
                given().
                        baseUri(this.baseUri).port(APPWALL_DEFAULT_PORT).
                        auth().basic(this.username, this.password).
                        basePath(APPWALL_USER_INFO_PATH).pathParam(APPWALL_USER_INFO_PATH_PARAMETER, this.username).
                        when().get().
                        thenReturn();

        this.requestSpecification.auth().basic(this.username, this.password);
        this.sessionId = response.getCookie(APPWALL_JWT_COOKIE_NAME);
        RestResponse restResponse = RestAssuredResponseMapper.map(response);

        if (restResponse.getStatusCode().equals(APPWALL_ON_SUCCESS_STATUS_CODE)) switchTo();

        return restResponse;
    }

    @Override
    public boolean isLoggedIn() {
        Response response =
                given().
                        baseUri(this.baseUri).port(APPWALL_DEFAULT_PORT).
                        auth().basic(this.username, this.password).
                        basePath(APPWALL_USER_INFO_PATH).pathParam(APPWALL_USER_INFO_PATH_PARAMETER, this.username).
                        when().get().
                        thenReturn();

        return response.statusCode() == APPWALL_ON_SUCCESS_STATUS_CODE.getStatusCode();
    }

    @Override
    public RestResponse logout() {
        Response response = given().auth().basic(this.username, this.password).
                baseUri(this.baseUri).port(APPWALL_DEFAULT_PORT).basePath(APPWALL_LOGOUT_PATH).
                when().put().
                then().extract().response();

        return RestAssuredResponseMapper.map(response);

    }
}
