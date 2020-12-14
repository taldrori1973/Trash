package com.radware.vision.restBddTests;

import com.radware.vision.bddtests.BddRestTestBase;
import com.radware.vision.tools.rest.CurrentVisionRestAPI;
import cucumber.api.java.en.Then;
import models.RestResponse;

public class Demo extends BddRestTestBase {
    @Then("^Send request$")
    public void sendRequest() throws NoSuchFieldException {
        CurrentVisionRestAPI genericVisionRestAPI = new CurrentVisionRestAPI("Vision/SystemConfigItemList.json", "Get Local Users");

        RestResponse response = genericVisionRestAPI.sendRequest();
        System.out.println();

    }
}
