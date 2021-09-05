package com.radware.vision.bddtests;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.thirdPartyAPIs.SaproCommunication.SaproCommunicationHandler;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;

import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

import static models.config.DevicesConstants.*;


public class SaproClientSteps extends TestBase {
    private final SaproCommunicationHandler sc = new SaproCommunicationHandler();

    public SaproClientSteps() throws Exception {
    }

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


    @Given("Play File \"([^\"]*)\" in device \"([^\"]*)\" from map \"([^\"]*)\"(?: and wait (\\d+) seconds)?$")
    public void reloadFile(String newFile, String deviceName, String mapName, Integer secondsToWait) {
        sc.reloadXmlFile(mapName, deviceName, newFile);
        try {
            if (secondsToWait != null) {
                TimeUnit.SECONDS.sleep(secondsToWait);
            }
        } catch (InterruptedException e) {
            BaseTestUtils.report("Interrupted while Sleeping: " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Given("^Init Simulators$")
    public void initSimulators() {
        List<TreeDeviceManagementDto> simulators = sutManager.getVisionSetupTreeDevices().stream().filter(
                dev -> dev.getDeviceId().contains("Fake")).collect(Collectors.toList());
        try {
            simulators.forEach(sim -> {
                String setId = sim.getDeviceSetId();
                String name = sim.getDeviceName();
                switch (setId) {
                    case "Alteon_Sim_Set_0":
                        sc.reloadXmlFile(DEFAULT_MAP, name, SIMULATOR_XML_FILE_1);
                        break;
                    case "Alteon_Sim_Set_1":
                        sc.reloadXmlFile(DEFAULT_MAP, name, SIMULATOR_XML_FILE_2);
                        break;
                    case "Alteon_Sim_Set_2":
                        sc.reloadXmlFile(DEFAULT_MAP, name, SIMULATOR_XML_FILE_3);
                        break;
                }
            });
        } catch (Exception e) {
            BaseTestUtils.report("Failed to initialize Alteon simulators " + e.getMessage(), Reporter.FAIL);
        }
    }
}

