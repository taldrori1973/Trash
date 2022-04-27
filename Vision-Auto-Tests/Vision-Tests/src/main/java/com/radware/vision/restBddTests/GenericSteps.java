package com.radware.vision.restBddTests;


import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.RestStepResult;
import com.radware.vision.infra.enums.WebElementType;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import com.radware.vision.restTestHandler.GenericStepsHandler;
import com.radware.vision.utils.BodyEntry;
import com.radware.vision.utils.StepsParametersUtils;
import controllers.RestApiManagement;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import models.*;
import net.minidev.json.JSONArray;
import restInterface.RestApi;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import static com.radware.automation.tools.basetest.BaseTestUtils.report;
import static com.radware.automation.tools.basetest.Reporter.FAIL;
import static com.radware.automation.tools.basetest.Reporter.PASS;
import static com.radware.vision.RestStepResult.Status.FAILED;
import static java.lang.String.format;

public class GenericSteps {

    public static RestRequestSpecification restRequestSpecification;
    public static RestResponse response;
    public static Map<String, String> runTimeParameters;
    public static Pattern runTimeValuesPattern = Pattern.compile("\"?\\$\\{(.*)\\}\"?");
    public int passwordPolicyRank;

    public GenericSteps() {
        runTimeParameters = new HashMap<>();

    }


    @Given("^New ([^\"]*) Request Specification with Base Path \"([^\"]*)\"$")
    public void newRequestSpecification(Method method, String basePath) {
        restRequestSpecification = new RestRequestSpecification(method);
        restRequestSpecification.setBasePath(basePath);
    }


    @Given("^New Request Specification from File \"([^\"]*)\" with label \"([^\"]*)\"$")
    public void newRequestSpecificationFromFileWithLabel(String filePath, String requestLabel) {
        if (filePath.startsWith("/")) filePath = filePath.substring(1);
        if (!filePath.endsWith(".json")) filePath = filePath + ".json";

        restRequestSpecification = GenericStepsHandler.createNewRestRequestSpecification(filePath, requestLabel);

    }

    @And("^Create Following RUNTIME Parameters by Sending Request Specification from File \"([^\"]*)\" with label \"([^\"]*)\"$")
    public void createFollowingRUNTIMEParametersBySendingRequestSpecificationFromFileWithLabel(String filePath, String requestLabel, Map<String, String> labelByJsonPath) {
        if (filePath.startsWith("/")) filePath = filePath.substring(1);
        if (!filePath.endsWith(".json")) filePath = filePath + ".json";

        restRequestSpecification = GenericStepsHandler.createNewRestRequestSpecification(filePath, requestLabel);
        this.sendRequest();
        String responseBody = response.getBody().getBodyAsString();
        DocumentContext jsonPath = JsonPath.parse(responseBody);
        for (String label : labelByJsonPath.keySet()) {
            Object object = jsonPath.read(labelByJsonPath.get(label));
            if (object == null)
                runTimeParameters.put(label, null);

            else if (object instanceof JSONArray) {
                Object value;
                List<Object> objects = ((List<Object>) object);
                if (objects.isEmpty()) {
                    runTimeParameters.put(label, null);
                    return;
                }

                value = objects.get(0);
                runTimeParameters.put(label, String.valueOf(value));
            } else {
                runTimeParameters.put(label, String.valueOf(object));
            }

        }
    }

    @And("The Request Path Parameters Are")
    public void requestPathParameters(Map<String, String> pathParams) {
        Map<String, String> pathParamsCopy = StepsParametersUtils.setRunTimeValues(pathParams, runTimeParameters, runTimeValuesPattern);
        restRequestSpecification.setPathParams(pathParamsCopy);
    }

    @And("The Request Query Parameters Are")
    public void requestQueryParams(Map<String, String> queryParams) {
        Map<String, String> queryParamsCopy = StepsParametersUtils.setRunTimeValues(queryParams, runTimeParameters, runTimeValuesPattern);
        restRequestSpecification.setQueryParams(queryParamsCopy);
    }


    @And("The Request Headers Are")
    public void requestHeaders(Map<String, String> headers) {
        Map<String, String> headersCopy = StepsParametersUtils.setRunTimeValues(headers, runTimeParameters, runTimeValuesPattern);
        restRequestSpecification.setHeaders(headersCopy);
    }

    @And("The Request Cookies Are")
    public void requestCookies(Map<String, String> cookies) {
        Map<String, String> cookiesCopy = StepsParametersUtils.setRunTimeValues(cookies, runTimeParameters, runTimeValuesPattern);
        restRequestSpecification.setCookies(cookiesCopy);
    }

    @And("The Request Accept ([^\"]*)")
    public void requestAccept(ContentType contentType) {
        restRequestSpecification.setAccept(contentType);
    }

    @And("The Request Content Type Is ([^\"]*)")
    public void requestContentType(ContentType contentType) {

        restRequestSpecification.setContentType(contentType);

    }

    @And("^The Request Body is the following (Object|Array)$")
    public void theRequestBodyIs(String type, List<BodyEntry> bodyEntries) {
        List<BodyEntry> bodyEntriesCopy = StepsParametersUtils.setRunTimeValuesOfBodyEntries(bodyEntries, runTimeParameters, runTimeValuesPattern);
        String body = GenericStepsHandler.createBody(bodyEntriesCopy, type);
        restRequestSpecification.setBody(body);
    }

    @When("Send Request with the Given Specification")
    public void sendRequest() {
        RestApi restApi = RestApiManagement.getRestApi();
        response = restApi.sendRequest(restRequestSpecification);
    }

    @Then("Validate That Response Status Code Is ([^\"]*)")
    public void validateThatResponseCodeOK(StatusCode statusCode) {
        if (response.getStatusCode() != statusCode)
            report(format(
                    "The actual %s value \"%s\" is not equal to the expected value \"%s\"",
                    "status code", response.getStatusCode(), statusCode), FAIL);
    }

    @Then("^Validate That Response Status Line Is \"([^\"]*)\"$")
    public void validateThatResponseStatusLineIs(String statusLine) {
        if (!response.getStatusLine().equals(statusLine))
            report(format(
                    "The actual %s value \"%s\" is not equal to the expected value \"%s\"",
                    "status line", response.getStatusLine(), statusLine), FAIL);
    }

    @Then("^Validate That Response Headers Are$")
    public void validateThatResponseHeadersIs(Map<String, String> headers) {
        if (!response.getHeaders().equals(headers))
            report(format(
                    "The actual %s values \"%s\" are not equal to the expected values \"%s\"",
                    "response headers", response.getHeaders(), headers), FAIL);
    }

    @Then("^Validate That Response Cookies Are$")
    public void validateThatResponseCookiesIs(Map<String, String> cookies) {
        if (!response.getCookies().equals(cookies))
            report(format(
                    "The actual %s values \"%s\" are not equal to the expected values \"%s\"",
                    "response cookies", response.getCookies(), cookies), FAIL);
    }

    @Then("^Validate That Response Content Type Is ([^\"]*)$")
    public void validateThatResponseAcceptTypeIsJSON(ContentType contentType) {
        if (!response.getContentType().equals(contentType))
            report(format(
                    "The actual %s value \"%s\" is not equal to the expected value \"%s\"",
                    "response content type", response.getContentType(), contentType), FAIL);
    }

    @Then("^Validate That Response Body Contains$")
    public void validateThatResponseBodyContains(List<BodyEntry> bodyEntries) {
        List<BodyEntry> bodyEntriesCopy = StepsParametersUtils.setRunTimeValuesOfBodyEntries(bodyEntries, runTimeParameters, runTimeValuesPattern);
        String body = response.getBody().getBodyAsString();
        DocumentContext documentContext = JsonPath.parse(body);

        RestStepResult result = GenericStepsHandler.validateBody(bodyEntriesCopy, documentContext);
        if (result.getStatus().equals(FAILED)) report(result.getMessage(), FAIL);

    }

    @Given("^REST Send simple body request from File \"([^\"]*)\" with label \"([^\"]*)\"$")
    public void sendSimpleBodyRestRequest(String filePath, String requestLabel, List<BodyEntry> bodyEntries){
        newRequestSpecificationFromFileWithLabel(filePath, requestLabel);
        theRequestBodyIs("Object", bodyEntries);
        sendRequest();
        validateThatResponseCodeOK(StatusCode.OK);
    }

    @And("^Validate That Response Body has passwordPolicy equals to \"([^\"]*)\"$")
    public void validateThatResponseBodyHasPasswordPolicyEqualsTo(String expectedValue){
        String actualValue = response.getBody().getBodyAsString();
        if(!actualValue.contains(expectedValue)){
            ReportsUtils.reportAndTakeScreenShot("Password Policy for the specified role is not updated", Reporter.FAIL);
        }
    }

    @Then("^Validate That Response Body has passwordRank equals to (\\d+)$")
    public void validateThatResponseBodyHasPasswordRankEqualsTo(int tempRank) {
        this.passwordPolicyRank = tempRank;
        String expectedValue = "\"policyRank\":" + this.passwordPolicyRank;
        String actualValue = response.getBody().getBodyAsString();

        while (actualValue.contains(expectedValue)) {
            this.passwordPolicyRank++;
            expectedValue = "\"policyRank\":" + this.passwordPolicyRank;
        }
    }

    @Then("^UI Set Text for passwordPolicyRank with id \"([^\"]*)\" with rank")
    public void uiSetTextForPasswordPolicyRankWithIdWith(String elementId){
        ClickOperationsHandler.setTextToElement(WebElementType.Id, elementId, String.valueOf(this.passwordPolicyRank), true);
    }

    @And("^Validate That Response Body has (\\d+) minutes resolution data$")
    public void validateThatResponseBodyHasMinutesResolutionData(long retentionTime) {

        long timeStamp1= 0;
        long timeStamp2 = 0;

        if(response.getBody().getBodyAsJsonNode().isPresent()) {
            timeStamp1 = response.getBody().getBodyAsJsonNode().get().get("data").get(0).get("row").get("timeStamp").asLong();
            timeStamp2 = response.getBody().getBodyAsJsonNode().get().get("data").get(1).get("row").get("timeStamp").asLong();
        }

        long actualRetentionTime = timeStamp2 - timeStamp1;

        if(actualRetentionTime > retentionTime * 60000)
            report(format("Retention time is more than %s minutes", retentionTime), FAIL);

        else if(actualRetentionTime < retentionTime * 60000)
            report(format("Retention time is less than %s minutes", retentionTime), FAIL);

        else
            report(format("Retention time is %s minutes", retentionTime), PASS);
    }

    @Given("^The Request Body is the following (Object|Array) with Time (\\d+) hours ago$")
    public void theRequestBodyIsTheFollowingObjectWithTimeHoursAgo(String type,int hoursAgo, List<BodyEntry> bodyEntries) {
        List<BodyEntry> bodyEntriesCopy = StepsParametersUtils.setRunTimeValuesOfBodyEntries(bodyEntries, runTimeParameters, runTimeValuesPattern);
        String epochTime = "";

        try{
            LocalDateTime pastTime = LocalDateTime.now().minusHours(hoursAgo);
            Date date = Date.from(pastTime.atZone(ZoneId.systemDefault()).toInstant());
            epochTime = String.valueOf(date.getTime());
        } catch (Exception e){
            e.printStackTrace();
        }

        bodyEntriesCopy.set(2, new BodyEntry("$.timeInterval.from",epochTime));

        String body = GenericStepsHandler.createBody(bodyEntriesCopy, type);
        restRequestSpecification.setBody(body);
    }
}