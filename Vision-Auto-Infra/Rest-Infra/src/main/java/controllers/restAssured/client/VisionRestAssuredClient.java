package controllers.restAssured.client;

import io.restassured.RestAssured;
import io.restassured.filter.Filter;
import io.restassured.filter.cookie.CookieFilter;
import io.restassured.http.Cookie;
import io.restassured.http.Cookies;
import io.restassured.response.Response;
import restInterface.RestClient;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class VisionRestAssuredClient extends RestAssuredClient {
    private static final int DEFAULT_PORT = 443;

    private static final String LOGIN_PATH = "/mgmt/system/user/login";
    private static final String LOGOUT_PATH = "/mgmt/system/user/logout";
    private static final int ON_SUCCESS_STATUS_CODE = 200;


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


    public int login() {
        Response response = RestAssured.
                given().body(this.authenticationRequestBody).baseUri(this.baseUri).port(this.connectionPort).basePath(LOGIN_PATH).
                when().post().
                then().statusCode(ON_SUCCESS_STATUS_CODE).extract().response();

        this.cookies = response.detailedCookies();
        this.requestSpecification.replaceCookies(this.cookies);
        switchTo();
        return response.getStatusCode();
    }

    @Override
    public boolean isConnected() {
        return RestAssured.
                given().cookies(this.cookies).baseUri(this.baseUri).port(this.connectionPort).
                when().get().
                then().statusCode(ON_SUCCESS_STATUS_CODE).extract().statusCode() == ON_SUCCESS_STATUS_CODE;
    }


    @Override
    public int logout() {
        int response = RestAssured.
                given().cookies(this.cookies).baseUri(this.baseUri).port(this.connectionPort).basePath(LOGOUT_PATH).
                when().post().
                then().statusCode(ON_SUCCESS_STATUS_CODE).extract().statusCode();


        return response;
    }

    public static void main(String[] args) {
        RestClient visionClient = new VisionRestAssuredClient("https://172.17.192.100", "radware", "radware");
        visionClient.login();
        Response response = RestAssured.given().basePath("/mgmt/system/config/item/licenseinfo").when().get().then().extract().response();

        RestClient client2 = new VisionRestAssuredClient("https://172.17.192.100", "sys_admin", "radware");
        client2.login();
        response = RestAssured.given().basePath("/mgmt/system/config/item/licenseinfo").when().get().then().extract().response();

        visionClient.switchTo();
        response = RestAssured.given().basePath("/mgmt/system/config/item/licenseinfo").when().get().then().extract().response();

        boolean isConnected = client2.isConnected();

        int isLoggedOut = client2.logout();
        isConnected = client2.isConnected();
        response = RestAssured.given().basePath("/mgmt/system/config/item/licenseinfo").when().get().then().extract().response();
        client2.switchTo();
        response = RestAssured.given().basePath("/mgmt/system/config/item/licenseinfo").when().get().then().extract().response();


    }
}
