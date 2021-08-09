package com.radware.vision.bddtests;

import com.radware.vision.thirdPartyAPIs.SaproCommunication.SaproCommunicationHandler;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import java.util.List;


public class SaproClientSteps {
    private final SaproCommunicationHandler sc = new SaproCommunicationHandler();

    @Given("^Start map \"([^\"]*)\"$")
    public void startMap(String mapName) {
        sc.startMap(mapName);
    }

    @Then("^Stop map \"([^\"]*)\"$")
    public void stopMap(String mapName) {
        sc.stopMap(mapName);
    }

    @Given("^Start all devices from map \"([^\"]*)\"$")
    public void startAllDevicesFromMap(String mapName) {
        sc.startAllDevicesFromMap(mapName);
    }

    @Then("^Stop all devices from map \"([^\"]*)\"$")
    public void stopAllDevicesFromMap(String mapName) {
        sc.stopAllDevicesFromMap(mapName);
    }

    @Given("^From map \"([^\"]*)\" start device(?:s)?$")
    public void fromMapStartMultiDevices(String mapName, List<String> devsNames) {
        sc.startDevicesFromMap(mapName, devsNames);
    }

    @Then("^From map \"([^\"]*)\" stop device(?:s)?$")
    public void fromMapStopMultiDevices(String mapName, List<String> devsNames) {
        sc.stopDevicesFromMap(mapName, devsNames);
    }

}

