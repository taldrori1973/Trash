package com.radware.vision.restBddTests;

import com.radware.vision.automation.AutoUtils.SUT.SUTDaoImpl;
import com.radware.vision.automation.AutoUtils.SUT.dtos.DeviceDto;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.setup.Site;
import com.radware.vision.automation.AutoUtils.SUT.repositories.pojos.sut.VisionConfiguration;
import com.radware.vision.bddtests.BddRestTestBase;
import com.radware.vision.systemManagement.VisionConfigurations;
import cucumber.api.java.en.Then;

import java.util.List;

public class Demo extends BddRestTestBase {
    @Then("^Send request$")
    public void sendRequest() throws NoSuchFieldException {
//        CurrentVisionRestAPI genericVisionRestAPI = new CurrentVisionRestAPI("Vision/SystemConfigItemList.json", "Get Local Users");
//
//        RestResponse response = genericVisionRestAPI.sendRequest();
//        System.out.println();
//
//        VisionConfigurations visionConfigurations = new VisionConfigurations();
        VisionConfigurations.getBuild();

    }

    @Then("^SUT Test$")
    public void sutTest() {
        SUTDaoImpl sut = VisionConfigurations.getSUT();
        String setupId = sut.getSetupId();
        VisionConfiguration visionConfiguration = sut.getVisionConfiguration();
        List<Site> visionSetupSites = sut.getVisionSetupSites();
        List<DeviceDto> visionSetupTreeDevices = sut.getVisionSetupTreeDevices();

        assert setupId.equals("fullSetup");
        assert visionConfiguration.getHostIp().equals("172.17.192.100");
        assert visionConfiguration.getUserName().equals("radware");
        assert visionSetupSites.size() == 6;
        assert visionSetupTreeDevices.size() == 10;

    }
}
