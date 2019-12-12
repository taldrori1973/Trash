package com.radware.vision.bddtests.rest;



import com.radware.restcore.VisionRestClient;
import com.radware.vision.infra.testresthandlers.RestSettingHandler;
import cucumber.api.java.en.When;
import basejunit.RestTestBase;

public class RestSettingSteps {

    RestSettingHandler restSettingHandler = new RestSettingHandler();
    VisionRestClient visionRestClient = RestTestBase.visionRestClient;

    @When("^Change email configurations to \"(enable|disable)\"$")
    public void changeEmailConfigurationToEnableOrDisable(String isEnable){
        restSettingHandler.changeEmailConfigurationToEnableOrDisable(isEnable);
    }
}
