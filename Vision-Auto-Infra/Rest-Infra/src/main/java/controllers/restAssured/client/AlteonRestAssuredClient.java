package controllers.restAssured.client;

import controllers.restAssured.RestAssuredApi;
import io.restassured.response.Response;
import io.restassured.specification.AuthenticationSpecification;
import mappers.restAssured.RestAssuredResponseMapper;
import models.Method;
import models.RestRequestSpecification;
import models.RestResponse;
import restInterface.RestApi;
import restInterface.RestClient;

import static io.restassured.RestAssured.given;
import static models.config.DevicesConstants.*;

public class AlteonRestAssuredClient extends RestAssuredClient {

    private String username;
    private String password;

    public AlteonRestAssuredClient(String baseUri, String username, String password) {
        this(baseUri, ALTEON_DEFAULT_PORT, username, password);
    }

    public AlteonRestAssuredClient(String baseUri, int connectionPort, String username, String password) {
        super(baseUri, connectionPort);
        this.username = username;
        this.password = password;
    }

    public static void main(String[] args) {
        RestClient restClient = new AlteonRestAssuredClient("https://172.17.164.25", "admin", "shimon1!$4");
        restClient.login();

        RestApi restApi = RestAssuredApi.get_instance();
        RestRequestSpecification specification = new RestRequestSpecification(Method.GET);
        specification.setBasePath(ALTEON_SESSION_DETAILS_PATH);
        RestResponse response = restApi.sendRequest(specification);

    }

    @Override
    public RestResponse login() {

        Response response =
                given().
                        filter(this.sessionFilter).
                        baseUri(this.baseUri).port(ALTEON_DEFAULT_PORT).
                        auth().basic(this.username, this.password).
                        basePath(ALTEON_SESSION_DETAILS_PATH).
                        when().get().
                        then().extract().response();

        this.requestSpecification.auth().basic(this.username, this.password);
        if (response.getStatusCode() == ALTEON_ON_SUCCESS_STATUS_CODE.getStatusCode()) switchTo();
        return RestAssuredResponseMapper.map(response);
    }

    @Override
    public boolean isLoggedIn() {

        AuthenticationSpecification auth = this.requestSpecification.auth();
        return given().
                baseUri(this.baseUri).port(ALTEON_DEFAULT_PORT).
                auth().basic(this.username, this.password).
                basePath(ALTEON_SESSION_DETAILS_PATH).
                when().get().
                then().extract().response().getStatusCode() == ALTEON_ON_SUCCESS_STATUS_CODE.getStatusCode();
    }

    @Override
    public RestResponse logout() {
        Response response = given().
                baseUri(this.baseUri).port(ALTEON_DEFAULT_PORT).
                auth().basic(this.username, this.password).
                basePath(ALTEON_LOGOUT_PATH).
                when().post().
                then().extract().response();
        return RestAssuredResponseMapper.map(response);

    }
}
