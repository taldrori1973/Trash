package RestClient;


import controllers.restAssured.client.VisionRestAssuredClient;

import static io.restassured.RestAssured.*;
import static io.restassured.matcher.RestAssuredMatchers.*;
import static org.hamcrest.Matchers.*;

import io.restassured.RestAssured;
import io.restassured.parsing.Parser;
import io.restassured.response.Response;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;
import restInterface.RestClient;

public class VisionRestAssuredClient_Test {

    String baseUrl = "https://172.17.192.100";
    RestClient radwareClient;
    RestClient sys_adminClient;

    @BeforeClass
    public void setUp() {
        RestAssured.registerParser("application/octet-stream", Parser.JSON);
        radwareClient = new VisionRestAssuredClient(baseUrl, "radware", "radware");
        sys_adminClient = new VisionRestAssuredClient(baseUrl, "sys_admin", "radware");
    }

    @Test(priority = 1)
    public void radwareClientLoginReturnsOk() {
        int result = this.radwareClient.login();
        assert result == 200;
    }

    @Test(priority = 2)
    public void restAssuredWorkOnRadwareClient() {
        Response response = given().basePath("/mgmt/system/user/info?showpolicies=true").when().get().then().extract().response();
        response.then().assertThat().body("username", is("radware"));
    }


    @Test(priority = 3)
    public void sys_adminClientLoginReturnsOk() {
        int result = this.sys_adminClient.login();
        assert result == 200;
    }


    @Test(priority = 4)
    public void restAssuredWorkOnSys_adminClient() {
        Response response = given().basePath("/mgmt/system/user/info?showpolicies=true").when().get().then().extract().response();
        response.then().assertThat().body("username", is("sys_admin"));
    }





}
