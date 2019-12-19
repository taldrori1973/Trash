package controllers.restAssured.client;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.path.json.JsonPath;
import io.restassured.response.Response;
import mappers.restAssured.RestAssuredResponseMapper;
import models.RestResponse;
import models.StatusCode;
import models.utils.SessionInfoOptions;
import models.utils.VisionSessionInfoOptions;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
import java.util.Optional;

public class VisionRestAssuredClient extends RestAssuredClient {
    private static final int DEFAULT_PORT = 443;

    private static final String LOGIN_PATH = "/mgmt/system/user/login";
    private static final String LOGOUT_PATH = "/mgmt/system/user/logout";
    private static final String INFO_PATH = "/mgmt/system/user/info?showpolicies=true";
    private static final StatusCode ON_SUCCESS_STATUS_CODE = StatusCode.OK;


    private static final String userName_fieldName = "username";
    private static final String password_fieldName = "password";
    private static final String license_fieldName = "license";


    private String username;
    private String password;
    private String license;

    private Map<String, String> authenticationRequestBody;


    public VisionRestAssuredClient(String baseUri, String username, String password) {
        this(baseUri, DEFAULT_PORT, username, password);
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
                given().filter(this.sessionFilter).body(this.authenticationRequestBody).basePath(LOGIN_PATH).
                when().post().
                then().extract().response();

        this.requestSpecification.filter(this.sessionFilter);

        RestResponse restResponse = RestAssuredResponseMapper.map(response);

        if (restResponse.getStatusCode().equals(ON_SUCCESS_STATUS_CODE)) switchTo();

        return restResponse;
    }

    @Override
    public boolean isConnected() {
        return RestAssured.
                given().baseUri(this.baseUri).port(this.connectionPort).basePath(INFO_PATH).
                when().get().
                then().extract().statusCode() == ON_SUCCESS_STATUS_CODE.getStatusCode();
    }

    @Override
    public Optional<String> getUserName() {

        return getSessionInfoBy(VisionSessionInfoOptions.USERNAME);

    }

    @Override
    public Optional<String> getSessionInfoBy(SessionInfoOptions infoOption) {

        Response response;
        try {
            response = RestAssured.
                    given().basePath(INFO_PATH).
                    when().get().
                    then().assertThat().statusCode(ON_SUCCESS_STATUS_CODE.getStatusCode()).
                    extract().response();
        } catch (AssertionError error) {
            return Optional.empty();
        }

        JsonPath jsonPath = response.jsonPath();

        Object fieldValue = jsonPath.get(infoOption.getFieldName());
        if (Objects.isNull(fieldValue)) return Optional.empty();
        return Optional.of(fieldValue.toString());
    }

    public static void main(String[] args) {


        Response request = RestAssured.
                given().log().all().contentType(ContentType.JSON).relaxedHTTPSValidation().params("username", "radware", "password", "radware").
                when().post("https://172.17.192.100" + LOGIN_PATH);
//        Map<String, String> map = new HashMap<>();
//        map.put("username", "radware");
//        map.put("password", "radware");
//        RestClient restClient = new VisionRestAssuredClient("https://172.17.192.100", "radware", "radware");
//        boolean isConnected = restClient.isConnected();
//        restClient.login();
//        Optional<String> userName = restClient.getUserName();
//        Optional<String> userName2 = restClient.getSessionInfoBy(VisionSessionInfoOptions.USERNAME);
//        Optional<String> GLOBAL_LANDING_PAGE = restClient.getSessionInfoBy(VisionSessionInfoOptions.GLOBAL_LANDING_PAGE);
//        Optional<String> LAST_LOGIN = restClient.getSessionInfoBy(VisionSessionInfoOptions.LAST_LOGIN);
//        Optional<String> LOCALE = restClient.getSessionInfoBy(VisionSessionInfoOptions.LOCALE);
//        Optional<String> LOGICAL_GROUP_ROLES = restClient.getSessionInfoBy(VisionSessionInfoOptions.LOGICAL_GROUP_ROLES);
//        Optional<String> NETWORK_POLICIES = restClient.getSessionInfoBy(VisionSessionInfoOptions.NETWORK_POLICIES);
//        Optional<String> ROLES = restClient.getSessionInfoBy(VisionSessionInfoOptions.ROLES);
//        Optional<String> WARNINGS = restClient.getSessionInfoBy(VisionSessionInfoOptions.WARNINGS);

//        Response login_response = RestAssured.given().relaxedHTTPSValidation().body(map).contentType(ContentType.JSON).post("https://172.17.192.100/mgmt/system/user/login").then().extract().response();
//        Response check_response = RestAssured.given().relaxedHTTPSValidation().get("https://172.17.192.100").then().extract().response();


    }

    @Override
    public RestResponse logout() {
        Response response = RestAssured.
                given().baseUri(this.baseUri).port(this.connectionPort).basePath(LOGOUT_PATH).
                when().post().
                then().extract().response();

        return RestAssuredResponseMapper.map(response);

    }
}
