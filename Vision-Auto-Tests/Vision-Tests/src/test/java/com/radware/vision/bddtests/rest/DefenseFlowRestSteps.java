package com.radware.vision.bddtests.rest;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.utils.enums.HTTPStatusCodes;
import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.vision.automation.Deploy.UvisionServer;
import com.radware.vision.infra.testresthandlers.DefenseFlowRestHandler;
import com.radware.vision.restTestHandler.GenericStepsHandler;
import com.radware.vision.restTestHandler.RestClientsStepsHandler;
import controllers.RestApiManagement;
import cucumber.api.java.en.Then;
import models.*;
import org.json.JSONArray;
import org.json.JSONObject;

import java.util.HashMap;

import static com.radware.vision.automation.base.TestBase.*;

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

    @Then("^Wait For PO's appearance timeout (\\d+) minutes$")
    public void WaitToDisplayProtectedObjects(Integer timeout) {
        StringBuilder errorMessage = new StringBuilder();
        JSONArray poJSONArray = null;
        try {
            BasicRestOperationsSteps bros = new  BasicRestOperationsSteps();
            restTestBase.getVisionRestClient().login(
                    getSutManager().getClientConfigurations().getUserName(),
                    getSutManager().getClientConfigurations().getPassword(),
                    "",
                    0);
            RestClientsStepsHandler.switchToNoAuthClient("https://"+getSutManager().getClientConfigurations().getHostIp(),
                    Integer.parseInt(getSutManager().getClientConfigurations().getRestConnectionDefaultPort()));
            String sessionID = restTestBase.getVisionRestClient().getHttpSession(0).getSessionId();

            RestRequestSpecification requestSpecification = GenericStepsHandler.createNewRestRequestSpecification("Vision/newReport.json", "Get All Protected Objects");

            requestSpecification.setBody("{\"sourceIncludeFilters\":[\"deviceIp\",\"protectedObjectName\"]}");
            requestSpecification.setCookies(new HashMap<String,String>(){{
                put("JSESSIONID", sessionID);
            }});
            RestResponse response = RestApiManagement.getRestApi().sendRequest(requestSpecification);
            if (response.getStatusCode() == StatusCode.OK) {
                JSONObject PoJSONObject = new JSONObject(response.getBody().getBodyAsString());
                poJSONArray = PoJSONObject.getJSONArray("data");
                if (poJSONArray.length() == 0){
                    UvisionServer.doActionForService(getServersManagement().getRootServerCLI().get(),"config_kvision-configuration-service_1", UvisionServer.DockerServiceAction.RESTART);
                    UvisionServer.waitForUvisionServerServicesStatus(getServersManagement().getRadwareServerCli().get(),UvisionServer.UVISON_DEFAULT_SERVICES,8*60);
                    long startTime = System.currentTimeMillis();
                    restTestBase.getVisionRestClient().login(
                            getSutManager().getClientConfigurations().getUserName(),
                            getSutManager().getClientConfigurations().getPassword(),
                            "",
                            0);
                    requestSpecification.setCookies(new HashMap<String,String>(){{
                        put("JSESSIONID", restTestBase.getVisionRestClient().getHttpSession(0).getSessionId());
                    }});
                    timeout *= 60 * 1000;
                    do {
                        response = RestApiManagement.getRestApi().sendRequest(requestSpecification);
                        PoJSONObject = new JSONObject(response.getBody().getBodyAsString());
                        try{
                            poJSONArray = PoJSONObject.getJSONArray("data");
                        }catch (Exception e){
                            poJSONArray = null;
                        }
                        if (poJSONArray == null || poJSONArray.length() == 0){
                            Thread.sleep(10000);
                        }
                    }while ((poJSONArray == null || poJSONArray.length() == 0) && System.currentTimeMillis() - startTime < timeout);
                    if (poJSONArray == null || poJSONArray.length() == 0){
                        errorMessage.append("Po not found!!");
                    }
                }
            }
        } catch (Exception e){
            errorMessage.append(e);
        }
        if (errorMessage.length() == 0){
            BaseTestUtils.report(String.format("%d Po's found",(poJSONArray != null)?poJSONArray.length():0), Reporter.PASS);
        }
        else{
            BaseTestUtils.report(errorMessage.toString(),Reporter.FAIL);
        }
    }

}
