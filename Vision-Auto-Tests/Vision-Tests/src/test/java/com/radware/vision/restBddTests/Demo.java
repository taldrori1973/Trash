package com.radware.vision.restBddTests;

import com.radware.vision.restAPI.GenericVisionRestAPI;
import cucumber.api.java.en.Then;
import models.RestResponse;

public class Demo {
    @Then("^Send request$")
    public void sendRequest() {
        GenericVisionRestAPI genericVisionRestAPI = new GenericVisionRestAPI("172.17.192.100", null,
                "radware", "radware", null,
                "Vision/SystemConfigItemList.json", "Get Local Users"
        );

        RestResponse response = genericVisionRestAPI.sendRequest();
        System.out.println();

    }
}
