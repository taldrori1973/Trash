package com.radware.vision.bddtests;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.thirdPartyAPIs.SaproCommunication.SaproCommunicationHandler;
import cucumber.api.PendingException;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import java.util.List;
import java.util.concurrent.TimeUnit;


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
        String[] devsNamesArray = devsNames.toArray(new String[0]);
        sc.startDevicesFromMap(mapName, devsNamesArray);
    }

    @Then("^From map \"([^\"]*)\" stop device(?:s)?$")
    public void fromMapStopMultiDevices(String mapName, List<String> devsNames) {
        String[] devsNamesArray = devsNames.toArray(new String[0]);
        sc.stopDevicesFromMap(mapName, devsNamesArray);
    }


    //@Given("Test map \"([^\"]*)\" device \"([^\"]*)\" file \"([^\"]*)\"")
    @Given("Play File \"([^\"]*)\" in device \"([^\"]*)\" from map \"([^\"]*)\"(?: and wait (\\d+) seconds)?$")
    public void reloadFile (String newFile, String deviceName, String mapName, Integer secondsToWait) {
        sc.reloadXmlFile(mapName, deviceName, newFile);
        try {
            if (secondsToWait != null) {
                TimeUnit.SECONDS.sleep(secondsToWait);
            }
        } catch (InterruptedException e) {
            BaseTestUtils.report("Interrupted while Sleeping: " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^Test Test$")
    public void testTest() {
        sc.test();
    }
}

