package RestClient;


import controllers.RestClientsManagement;
import io.restassured.RestAssured;
import io.restassured.parsing.Parser;
import io.restassured.response.Response;
import models.RestResponse;
import models.StatusCode;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;
import restInterface.client.RestClient;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.is;

public class VisionRestAssuredClient_Test {

    String baseUrl = "https://172.17.192.100";
    RestClient radwareClient;
    RestClient sys_adminClient;
    RestClient vDirect;

    @BeforeClass
    public void setUp() {
        RestAssured.registerParser("application/octet-stream", Parser.JSON);
        radwareClient = RestClientsManagement.getVisionConnection(baseUrl, "radware", "radware");
        sys_adminClient = RestClientsManagement.getVisionConnection(baseUrl, "sys_admin", "radware");
        vDirect = RestClientsManagement.getVDirectConnection(baseUrl, "radware", "radware");
    }

    @Test(priority = 1)
    public void radwareClientLoginReturnsOk() {
        RestResponse result = this.radwareClient.login();
        assert result.getStatusCode() == StatusCode.OK;
    }

    @Test(priority = 2)
    public void restAssuredWorkOnRadwareClient() {
        Response response = given().basePath("/mgmt/system/user/info?showpolicies=true").when().get().then().extract().response();
        response.then().assertThat().body("username", is("radware"));
    }

    @Test(priority = 3)
    public void restAssuredIsRadwareClientLoggedIn() {
        radwareClient.isLoggedIn();
    }


    @Test(priority = 4)
    public void sys_adminClientLoginReturnsOk() {
        RestResponse result = this.sys_adminClient.login();
        assert result.getStatusCode() == StatusCode.OK;
    }


    @Test(priority = 5)
    public void restAssuredWorkOnSys_adminClient() {
        Response response = given().basePath("/mgmt/system/user/info?showpolicies=true").when().get().then().extract().response();
        response.then().assertThat().body("username", is("sys_admin"));
    }

    @Test(priority = 6)
    public void restAssuredIsRadwareClientLoggedInAfterSys_Admin() {
        radwareClient.isLoggedIn();
    }

    @Test(priority = 7)
    public void isRestAssuredStillOnSysAdminAfterIsLogInCheck() {
        Response response = given().basePath("/mgmt/system/user/info?showpolicies=true").when().get().then().extract().response();
        response.then().assertThat().body("username", is("sys_admin"));
    }

    @Test(priority = 8)
    public void vDirectClientLoginReturnsOk() {
        RestResponse result = this.vDirect.login();
        assert result.getStatusCode() == StatusCode.OK;
        RestResponse result2 = vDirect.logout();
        Response response = given().basePath("/api/session").when().get().then().extract().response();
        response.then().assertThat().body("userName", is("radware"));
        assert vDirect.isLoggedIn();

        sys_adminClient.switchTo();
        assert vDirect.isLoggedIn();

    }


//    @Test(priority = 6)
//    public void switchBackToRadwareClient() {
//        this.radwareClient.switchTo();
//        Response response = given().basePath("/mgmt/system/user/info?showpolicies=true").when().get().then().extract().response();
//        response.then().assertThat().body("username", is("radware"));
//    }

//
//    @Test(priority = 7)
//    public void testLogout() {
//        assert this.sys_adminClient.isLoggedIn();
//
//        RestResponse result = this.sys_adminClient.logout();
//
//        assert result.getStatusCode() == StatusCode.OK;
//
//        assert !this.sys_adminClient.isLoggedIn();
//    }


}
