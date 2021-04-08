package com.radware.vision.restBddTests;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.thirdPartyAPIs.jFrog.JFrogAPI;
import com.radware.vision.thirdPartyAPIs.jFrog.models.FileType;
import com.radware.vision.thirdPartyAPIs.jFrog.models.JFrogFileModel;
import cucumber.api.java.en.Then;

public class Demo extends TestBase {
//
    @Then("^Validate pojo Paesing$")
    public void validatePojoPaesing() throws JsonProcessingException {
        try {
            JFrogFileModel build = JFrogAPI.getBuild(FileType.OVA, "kvision-images-snapshot-local", null, null, 0);
            System.out.println(build);
            JFrogFileModel build2 = JFrogAPI.getBuild(FileType.OVA, "kvision-images-release-local", null, null, 0);
            System.out.println(build2);
            JFrogFileModel build3 = JFrogAPI.getBuild(FileType.OVA, "kvision-images-release-local", null, "release", 0);
            System.out.println(build3);
        } catch (Exception e) {
            BaseTestUtils.report(e.getMessage(),Reporter.FAIL);
        }


    }
}
