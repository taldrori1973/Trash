package com.radware.vision.bddtests.rest;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.utils.enums.HTTPStatusCodes;
import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.vision.infra.testresthandlers.DefenseFlowRestHandler;
import com.radware.vision.vision_handlers.NewVmHandler;
import cucumber.api.java.en.Then;

import static com.radware.vision.infra.testhandlers.BaseHandler.restTestBase;

public class DefenseFlowRestSteps {

    @Then("^REST Add Or Get DefenseFlow PO Request \"([^\"]*)\" for \"([^\"]*)\"(?: url params \"([^\"]*)\")?(?: Body params \"([^\"]*)\")?(?: Expected result \"([^\"]*)\")?$")
    public void restPoDF(HttpMethodEnum method, String urlField, String bodyField, String expectedResult) {
        DefenseFlowRestHandler.addOrGetPo(method, urlField, bodyField, expectedResult);
        if (restTestBase.getVisionRestClient().getLastHttpStatusCode() != HTTPStatusCodes.OK.getCode())
            BaseTestUtils.report("", Reporter.FAIL);
    }

    @Then("^REST Add (\\d+) Of DefenseFlow PO url params \"([^\"]*)\"$")
    public void addPo(int number, String poPrefix) {
        String bodyField;
        String name = "name=";
        String peak = "peak=";
        for (int i = 1; i <= number; i++) {
            String nameofPo = poPrefix + "_" + i;
            bodyField = name + nameofPo + "," + peak + (2000 + i);
            restPoDF(HttpMethodEnum.POST, nameofPo, bodyField, null);
        }
    }

    @Then("^REST DELETE (\\d+) DefenseFlow PO url params \"([^\"]*)\"$")
    public void deletePo(int number, String poPrefix) {
        for (int i = 1; i <= number; i++) {
            String nameofPo = poPrefix + "_" + i;
            DefenseFlowRestHandler.deletePo(HttpMethodEnum.DELETE, nameofPo, null, null);
        }
    }

    @Then("^REST DELETE DefenseFlow PO url params \"([^\"]*)\"$")
    public void deletePo(String nameOfPo) {
        DefenseFlowRestHandler.deletePo(HttpMethodEnum.DELETE, nameOfPo, null, null);

    }


}
