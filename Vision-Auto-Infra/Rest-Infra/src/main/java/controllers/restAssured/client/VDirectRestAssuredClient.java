package controllers.restAssured.client;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.response.Response;
import mappers.restAssured.RestAssuredResponseMapper;
import models.RestResponse;
import models.StatusCode;
import restInterface.RestClient;

import java.util.HashMap;
import java.util.Map;

public class VDirectRestAssuredClient extends RestAssuredClient {
    private static final int VDIRECT_DEFAULT_PORT = 2189;
    private final String SESSION_COOKIE_NAME = "vdirectsession";

    private final String LOGIN_PATH = "/api/session";
    private final String LOGOUT_PATH = "/api/session";
    private final String INFO_PATH = "/api/session";
    private final StatusCode ON_SUCCESS_STATUS_CODE = StatusCode.OK;


    private final String userName_fieldName = "user";
    private final String userName_fieldName_in_response = "userName";
    private final String password_fieldName = "password";


    private String username;
    private String password;

    private Map<String, String> authenticationRequestBody;


    public VDirectRestAssuredClient(String baseUri, String username, String password) {
        this(baseUri, VDIRECT_DEFAULT_PORT, username, password);
    }

    public VDirectRestAssuredClient(String baseUri, int connectionPort, String username, String password) {
        super(baseUri, connectionPort);

        this.username = username;
        this.password = password;


        this.authenticationRequestBody = new HashMap<>();
        this.authenticationRequestBody.put(userName_fieldName, username);
        this.authenticationRequestBody.put(password_fieldName, password);

    }

    public static void main(String[] args) {
        RestClient vDirect = new VDirectRestAssuredClient("https://172.17.192.100", "radware", "radware");
        RestResponse response = vDirect.login();


    }

    @Override
    public RestResponse login() {

        Response response = RestAssured.
                given().contentType(ContentType.URLENC).filter(this.cookieFilter).baseUri(this.baseUri).port(this.connectionPort).formParams(this.authenticationRequestBody).basePath(LOGIN_PATH).
                when().post().
                then().extract().response();

        this.requestSpecification.filter(this.cookieFilter);
        this.sessionId = response.getCookie(SESSION_COOKIE_NAME);
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

        return response.statusCode() == ON_SUCCESS_STATUS_CODE.getStatusCode() && response.body().jsonPath().get(userName_fieldName_in_response).equals(this.username);

    }

    @Override
    public RestResponse logout() {
        Response response = RestAssured.
                given().sessionId(this.sessionId).baseUri(this.baseUri).port(this.connectionPort).basePath(LOGOUT_PATH).
                when().delete().
                then().extract().response();

        return RestAssuredResponseMapper.map(response);

    }
}
