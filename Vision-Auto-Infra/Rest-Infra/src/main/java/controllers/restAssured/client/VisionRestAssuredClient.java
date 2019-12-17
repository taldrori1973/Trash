package controllers.restAssured.client;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.response.Response;

import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

public class VisionRestAssuredClient extends RestAssuredClient {
    private static final int DEFAULT_PORT = 443;

    private static final String LOGIN_PATH = "/mgmt/system/user/login";
    private static final String LOGOUT_PATH = "/mgmt/system/user/logout";
    private static final String TEST_PATH = "/mgmt/system/user/info?showpolicies=true";
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
                given().filter(this.sessionFilter).body(this.authenticationRequestBody).basePath(LOGIN_PATH).
                when().post().
                then().statusCode(ON_SUCCESS_STATUS_CODE).extract().response();
       this.requestSpecification.filter(this.sessionFilter);
        switchTo();
        return response.getStatusCode();
    }

    @Override
    public boolean isConnected() {
        return RestAssured.
                given().baseUri(this.baseUri).port(this.connectionPort).basePath(TEST_PATH).
                when().get().
                then().extract().statusCode() == ON_SUCCESS_STATUS_CODE;
    }


    @Override
    public int logout() {
        int response = RestAssured.
                given().baseUri(this.baseUri).port(this.connectionPort).basePath(LOGOUT_PATH).
                when().post().
                then().statusCode(ON_SUCCESS_STATUS_CODE).extract().statusCode();


        return response;
    }

    public static void main(String[] args) {

        Map<String,String> map=new HashMap<>();
        map.put("username","radware");
        map.put("password","radware");

        Response login_response = RestAssured.given().relaxedHTTPSValidation().body(map).contentType(ContentType.JSON).post("https://172.17.192.100/mgmt/system/user/login").then().extract().response();
        Response check_response = RestAssured.given().relaxedHTTPSValidation().get("https://172.17.192.100").then().extract().response();




    }
}
