package controllers.restAssured.client;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import mappers.restAssured.RestAssuredResponseMapper;
import models.RestResponse;
import models.StatusCode;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class VisionRestAssuredClient extends RestAssuredClient {
    private final static int VISION_DEFAULT_PORT = 443;

    private final String LOGIN_PATH = "/mgmt/system/user/login";
    private final String LOGOUT_PATH = "/mgmt/system/user/logout";
    private final String INFO_PATH = "/mgmt/system/user/info?showpolicies=true";
    private final StatusCode ON_SUCCESS_STATUS_CODE = StatusCode.OK;


    private final String userName_fieldName = "username";
    private final String password_fieldName = "password";
    private final String license_fieldName = "license";


    private String username;
    private String password;
    private String license;

    private Map<String, String> authenticationRequestBody;


    public VisionRestAssuredClient(String baseUri, String username, String password) {
        this(baseUri, VISION_DEFAULT_PORT, username, password);
    }

    public VisionRestAssuredClient(String baseUri, int connectionPort, String username, String password) {
        this(baseUri, connectionPort, username, password, null);
    }

    public VisionRestAssuredClient(String baseUri, int connectionPort, String username, String password, String license) {
        super(baseUri, connectionPort);

        this.username = username;
        this.password = password;
        this.license = license;

        this.authenticationRequestBody = new HashMap<>();
        this.authenticationRequestBody.put(userName_fieldName, username);
        this.authenticationRequestBody.put(password_fieldName, password);

        if (!Objects.isNull(license)) this.authenticationRequestBody.put(license_fieldName, license);
    }


    @Override
    public RestResponse login() {
        Response response = RestAssured.
                given().filter(this.sessionFilter).contentType(ContentType.JSON).baseUri(this.baseUri).port(this.connectionPort).body(this.authenticationRequestBody).basePath(LOGIN_PATH).
                when().post().
                then().extract().response();

        this.requestSpecification.filter(this.sessionFilter);
        this.sessionId = response.sessionId();
        RestResponse restResponse = RestAssuredResponseMapper.map(response);

        if (restResponse.getStatusCode().equals(ON_SUCCESS_STATUS_CODE)) switchTo();

        return restResponse;
    }

    @Override
    public boolean isLoggedIn() {
        Response response = RestAssured.
                given().sessionId(this.sessionId).baseUri(this.baseUri).port(this.connectionPort).basePath(INFO_PATH).
                when().get().
                then().extract().response();

        return response.statusCode() == ON_SUCCESS_STATUS_CODE.getStatusCode() && response.body().jsonPath().get(userName_fieldName).equals(this.username);

    }

    public static void main(String[] args) {

    }

    @Override
    public RestResponse logout() {
        Response response = RestAssured.
                given().sessionId(this.sessionId).baseUri(this.baseUri).port(this.connectionPort).basePath(LOGOUT_PATH).
                when().post().
                then().extract().response();

        return RestAssuredResponseMapper.map(response);

    }
}
