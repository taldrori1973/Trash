package com.radware.vision.rest.bddtests;


import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import cucumber.api.java.en.Given;
import models.RestRequestSpecification;
import models.RestResponse;
import restInterface.RestApi;
import restInterface.client.RestClient;

public class RestClientsSteps {

    private RestClient restClient;
    private RestRequestSpecification restRequestSpecification;
    private RestApi restApi;
    private RestResponse response;

    @Given("^That Current Vision is Logged In(?: With Username \"([^\"]*)\" and Password \"([^\"]*)\")?(?: With (Activation))?$")
    public void thatCurrentVisionIsLoggedIn(String username, String password, String activation) {

    }

    @Given("^That Current Vision HA is Logged In(?: With Username \"([^\"]*)\" and Password \"([^\"]*)\")?$")
    public void thatCurrentVisionHAIsLoggedIn() {

    }

    @Given("^That Vision with IP \"([^\"]*)\" and Port (\\d+) is Logged In With Username \"([^\"]*)\" and Password \"([^\"]*)\"$")
    public void thatVisionWithIPAndPortIsLoggedInWithUsernameAndPassword(String ip, Integer port, String username, String password) throws Throwable {


    }

    @Given("^That Device (Alteon|AppWall) With SUT Number (\\d+) is Logged In$")
    public void thatDeviceAlteonAppWallVDirectWithSUTNumberNumberIsLoggedIn(SUTDeviceType sutDeviceType, Integer deviceNumber) {

    }

    @Given("^That Current On Vision VDirect is Logged In(?: With Username \"([^\"]*)\" and Password \"([^\"]*)\")?$")
    public void thatCurrentOnVisionVDirectIsLoggedInWithUsernameAndPassword(String username, String password) {


    }


//    @Given("^Login to Vision With username \"([^\"]*)\" and password \"([^\"]*)\"$")
//    public void loginToVisionWithUsernameAndPassword(String username, String password) {
//        this.restClient = RestClientsManagement.getVisionConnection("https://172.17.192.100", username, password);
//        assert this.restClient.login().getStatusCode() == StatusCode.OK;
//    }

}
