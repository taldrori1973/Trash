package com.radware.vision.bddtests;

import com.radware.vision.thirdPartyAPIs.SaproCommunication.SaproCommunicationHandler;
import cucumber.api.java.en.Then;

import java.util.List;


public class SaproClientSteps {
    private final SaproCommunicationHandler sc = new SaproCommunicationHandler();

    @Then("^Start map \"([^\"]*)\"$")
    public void startMap(String mapName) {
        sc.startMap(mapName);
    }

    @Then("^Stop map \"([^\"]*)\"$")
    public void stopMap(String mapName) {
        sc.stopMap(mapName);
    }

    @Then("^Start all devices from map \"([^\"]*)\"$")
    public void startAllDevFromMap(String mapName) {
        sc.startAllDevFromMap(mapName);
    }


    @Then("^From map \"([^\"]*)\" start device(s)?$")
    public void fromMapStartMultiDevices(String mapName, String devices, List<String> devsNames) {
        sc.startDevFromMap(mapName, devsNames);
    }

    @Then("^From map \"([^\"]*)\" stop device(s)?$")
    public void fromMapStopMultiDevices(String mapName, String devices, List<String> devsNames) {
        sc.stopDevFromMap(mapName, devsNames);
    }

}

