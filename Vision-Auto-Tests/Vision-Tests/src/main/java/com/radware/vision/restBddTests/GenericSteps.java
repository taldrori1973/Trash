package com.radware.vision.restBddTests;


import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.radware.vision.RestStepResult;
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

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import static com.radware.automation.tools.basetest.BaseTestUtils.report;
import static com.radware.automation.tools.basetest.Reporter.FAIL;
import static com.radware.vision.RestStepResult.Status.FAILED;
import static java.lang.String.format;

public class GenericSteps {

    private RestRequestSpecification restRequestSpecification;
    private RestResponse response;
    private Map<String, String> runTimeParameters;
    private static Pattern runTimeValuesPattern = Pattern.compile("\"?\\$\\{(.*)\\}\"?");

    public GenericSteps() {
        this.runTimeParameters = new HashMap<>();

    }


    @Given("^New ([^\"]*) Request Specification with Base Path \"([^\"]*)\"$")
    public void newRequestSpecification(Method method, String basePath) {
        this.restRequestSpecification = new RestRequestSpecification(method);
        this.restRequestSpecification.setBasePath(basePath);
    }


    @Given("^New Request Specification from File \"([^\"]*)\" with label \"([^\"]*)\"$")
    public void newRequestSpecificationFromFileWithLabel(String filePath, String requestLabel) {
        if (filePath.startsWith("/")) filePath = filePath.substring(1);
        if (!filePath.endsWith(".json")) filePath = filePath + ".json";

        this.restRequestSpecification = GenericStepsHandler.createNewRestRequestSpecification(filePath, requestLabel);

    }

    @And("^Create Following RUNTIME Parameters by Sending Request Specification from File \"([^\"]*)\" with label \"([^\"]*)\"$")
    public void createFollowingRUNTIMEParametersBySendingRequestSpecificationFromFileWithLabel(String filePath, String requestLabel, Map<String, String> labelByJsonPath) throws Throwable {
        if (filePath.startsWith("/")) filePath = filePath.substring(1);
        if (!filePath.endsWith(".json")) filePath = filePath + ".json";

        this.restRequestSpecification = GenericStepsHandler.createNewRestRequestSpecification(filePath, requestLabel);
        this.sendRequest();
        String responseBody = this.response.getBody().getBodyAsString();
        DocumentContext jsonPath = JsonPath.parse(responseBody);
        for (String label : labelByJsonPath.keySet()) {
            Object object = jsonPath.read(labelByJsonPath.get(label));
            if (object == null)
                runTimeParameters.put(label, null);

            else if (object instanceof JSONArray) {
                Object value = null;
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
        this.restRequestSpecification.setPathParams(pathParamsCopy);
    }

    @And("The Request Query Parameters Are")
    public void requestQueryParams(Map<String, String> queryParams) {
        Map<String, String> queryParamsCopy = StepsParametersUtils.setRunTimeValues(queryParams, runTimeParameters, runTimeValuesPattern);
        this.restRequestSpecification.setQueryParams(queryParamsCopy);
    }


    @And("The Request Headers Are")
    public void requestHeaders(Map<String, String> headers) {
        Map<String, String> headersCopy = StepsParametersUtils.setRunTimeValues(headers, runTimeParameters, runTimeValuesPattern);
        this.restRequestSpecification.setHeaders(headersCopy);
    }

    @And("The Request Cookies Are")
    public void requestCookies(Map<String, String> cookies) {
        Map<String, String> cookiesCopy = StepsParametersUtils.setRunTimeValues(cookies, runTimeParameters, runTimeValuesPattern);
        this.restRequestSpecification.setCookies(cookiesCopy);
    }

    @And("The Request Accept ([^\"]*)")
    public void requestAccept(ContentType contentType) {
        this.restRequestSpecification.setAccept(contentType);
    }

    @And("The Request Content Type Is ([^\"]*)")
    public void requestContentType(ContentType contentType) {

        this.restRequestSpecification.setContentType(contentType);

    }

    @And("^The Request Body is the following (Object|Array)$")
    public void theRequestBodyIs(String type, List<BodyEntry> bodyEntries) {
        List<BodyEntry> bodyEntriesCopy = StepsParametersUtils.setRunTimeValuesOfBodyEntries(bodyEntries, runTimeParameters, runTimeValuesPattern);
        String body = GenericStepsHandler.createBody(bodyEntriesCopy, type);
        this.restRequestSpecification.setBody(body);
    }

    @When("Send Request with the Given Specification")
    public void sendRequest() {
        RestApi restApi = RestApiManagement.getRestApi();
        this.response = restApi.sendRequest(this.restRequestSpecification);
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
        if (!this.response.getContentType().equals(contentType))
            report(format(
                    "The actual %s value \"%s\" is not equal to the expected value \"%s\"",
                    "response content type", response.getContentType(), contentType), FAIL);
    }


    @Then("^Validate That Response Body Contains$")
    public void validateThatResponseBodyContains(List<BodyEntry> bodyEntries) {
        List<BodyEntry> bodyEntriesCopy = StepsParametersUtils.setRunTimeValuesOfBodyEntries(bodyEntries, runTimeParameters, runTimeValuesPattern);
        String body = this.response.getBody().getBodyAsString();
        DocumentContext documentContext = JsonPath.parse(body);

        RestStepResult result = GenericStepsHandler.validateBody(bodyEntriesCopy, documentContext);
        if (result.getStatus().equals(FAILED)) report(result.getMessage(), FAIL);

    }
}
