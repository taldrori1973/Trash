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

public class DefenseFlowRestAssuredClient extends RestAssuredSessionBasedRestClient {


    private Map<String, String> authenticationRequestBody;


    public DefenseFlowRestAssuredClient(String baseUri, String username, String password) {
        this(baseUri, DEFENSE_FLOW_DEFAULT_PORT, username, password);
    }


    public DefenseFlowRestAssuredClient(String baseUri, int connectionPort, String username, String password) {
        super(baseUri, connectionPort, username, password);

        this.authenticationRequestBody = new HashMap<>();
        this.authenticationRequestBody.put(DEFENSE_FLOW_USERNAME_FIELD_NAME, username);
        this.authenticationRequestBody.put(DEFENSE_FLOW_PASSWORD_FIELD_NAME, password);
    }


    @Override
    public RestResponse login() {
        Response response = RestAssured.
                given().contentType(ContentType.JSON).baseUri(this.baseUri).port(DEFENSE_FLOW_DEFAULT_PORT).
                body(this.authenticationRequestBody).basePath(DEFENSE_FLOW_LOGIN_PATH).
                when().post().
                then().extract().response();

        this.sessionId = response.getBody().jsonPath().get(DEFENSE_FLOW_LOGIN_RESPONSE_FIELD_NAME);
        this.requestSpecification.headers(DEFENSE_FLOW_HEADER_AUTH_FIELD_NAME, sessionId);
        RestResponse restResponse = RestAssuredResponseMapper.map(response);

        if (restResponse.getStatusCode().equals(DEFENSE_FLOW_ON_SUCCESS_STATUS_CODE)) switchTo();

        return restResponse;
    }

    @Override
    public boolean isLoggedIn() {
        if (Objects.isNull(sessionId)) return false;
        Response response = RestAssured.
                given().sessionId(this.sessionId).baseUri(this.baseUri).port(VISION_DEFAULT_PORT).basePath(VISION_INFO_PATH).
                when().get().
                then().log().all().extract().response();

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


    public static void main(String[] args) {
        DefenseFlowRestAssuredClient defenseFlowRestAssuredClient = new DefenseFlowRestAssuredClient("https://172.17.160.151", "radware", "radware");
        defenseFlowRestAssuredClient.login();
    }
}
