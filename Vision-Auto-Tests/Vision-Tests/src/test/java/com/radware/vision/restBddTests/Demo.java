package com.radware.vision.restBddTests;

import com.radware.vision.automation.AutoUtils.SUT.controllers.SUTManager;
import com.radware.vision.automation.AutoUtils.SUT.dtos.VisionConfigurationDto;
import com.radware.vision.base.TestBase;
import com.radware.vision.bddtests.BddRestTestBase;
import com.radware.vision.systemManagement.VisionConfigurations;
import cucumber.api.java.en.Then;

public class Demo extends BddRestTestBase {
    @Then("^Send request$")
    public void sendRequest() throws NoSuchFieldException {
//        CurrentVisionRestAPI genericVisionRestAPI = new CurrentVisionRestAPI("Vision/SystemConfigItemList.json", "Get Local Users");
//
//        RestResponse response = genericVisionRestAPI.sendRequest();
//        System.out.println();
//
//        VisionConfigurations visionConfigurations = new VisionConfigurations();
//        VisionConfigurations.getBuild();

    }

    @Then("^SUT Test$")
    public void sutTest() {
        SUTManager sutManager = TestBase.getSutManager();
        VisionConfigurationDto visionConfigurations = sutManager.getVisionConfigurations();
        VisionConfigurations visionConfigurations1 = TestBase.getVisionConfigurations();
//        SUTDaoImpl sut = VisionConfigurations.getSUT();
//        String setupId = sut.getSetupId();
//        VisionConfiguration visionConfiguration = sut.getVisionConfiguration();
//        List<Site> visionSetupSites = sut.getVisionSetupSites();
//        List<DeviceDto> visionSetupTreeDevices = sut.getVisionSetupTreeDevices();
//
//        assert setupId.equals("fullSetup");
//        assert visionConfiguration.getHostIp().equals("172.17.192.100");
//        assert visionConfiguration.getUserName().equals("radware");
//        assert visionSetupSites.size() == 6;
//        assert visionSetupTreeDevices.size() == 10;

    }
}
