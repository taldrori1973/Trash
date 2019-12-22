package RestClient;


import io.restassured.RestAssured;
import io.restassured.parsing.Parser;
import io.restassured.response.Response;
import mappers.RestFactory;
import models.RestResponse;
import models.StatusCode;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;
import restInterface.RestClient;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.is;

public class VisionRestAssuredClient_Test {

    String baseUrl = "https://172.17.192.100";
    RestClient radwareClient;
    RestClient sys_adminClient;

    @BeforeClass
    public void setUp() {
        RestAssured.registerParser("application/octet-stream", Parser.JSON);
        radwareClient = RestFactory.getVisionConnection(baseUrl, "radware", "radware");
        sys_adminClient = RestFactory.getVisionConnection(baseUrl, "sys_admin", "radware");
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
    public void sys_adminClientLoginReturnsOk() {
        RestResponse result = this.sys_adminClient.login();
        assert result.getStatusCode() == StatusCode.OK;
    }


    @Test(priority = 4)
    public void restAssuredWorkOnSys_adminClient() {
        Response response = given().basePath("/mgmt/system/user/info?showpolicies=true").when().get().then().extract().response();
        response.then().assertThat().body("username", is("sys_admin"));
    }

//    @Test(priority = 5)
//    public void switchBackToRadwareClient() {
//        this.radwareClient.switchTo();
//        Response response = given().basePath("/mgmt/system/user/info?showpolicies=true").when().get().then().extract().response();
//        response.then().assertThat().body("username", is("radware"));
//    }


    @Test(priority = 6)
    public void testLogout() {
        assert this.sys_adminClient.isConnected();

        RestResponse result = this.sys_adminClient.logout();

        assert result.getStatusCode() == StatusCode.OK;

        assert !this.sys_adminClient.isConnected();
    }


}
