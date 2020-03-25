package com.radware.vision.restBddTests;

import com.radware.vision.restAPI.VisionRestAPI;
import cucumber.api.java.en.Then;
import models.RestResponse;

public class Demo {
    @Then("^Send request$")
    public void sendRequest() {
        VisionRestAPI visionRestAPI = new VisionRestAPI("172.17.192.100", null,
                "radware", "radware", null,
                "Vision/SystemConfigItemList.json", "Get Local Users"
        );

        RestResponse response = visionRestAPI.sendRequest();
        System.out.println();

    }
}
