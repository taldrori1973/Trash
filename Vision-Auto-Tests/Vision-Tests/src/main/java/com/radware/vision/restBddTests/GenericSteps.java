package com.radware.vision.restBddTests;


import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.RequestBody;
import com.radware.vision.restTestHandler.GenericStepsHandler;
import com.radware.vision.utils.BodyEntry;
import controllers.RestApiManagement;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import models.*;
import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;
import org.junit.internal.runners.statements.Fail;
import restInterface.RestApi;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.radware.automation.tools.basetest.BaseTestUtils.report;
import static com.radware.automation.tools.basetest.Reporter.FAIL;

public class GenericSteps {

    private RestRequestSpecification restRequestSpecification;
    private RestResponse response;
    private Map<String, String> runTimeParameters;
    private Pattern runTimeValuesPattern = Pattern.compile("\\$\\{(.*)\\}");
    private RequestBody requestBody;

    public GenericSteps() {
        this.runTimeParameters = new HashMap<>();

    }


    @Given("^New ([^\"]*) Request Specification with Base Path \"([^\"]*)\"$")
    public void newRequestSpecification(Method method, String basePath) {
        this.restRequestSpecification = new RestRequestSpecification(method);
        this.restRequestSpecification.setBasePath(basePath);
    }

    @And("The Request Path Parameters Are")
    public void requestPathParameters(Map<String, String> pathParams) {
        Map<String, String> pathParamsCopy = new HashMap<>(pathParams);

        for (String key : pathParams.keySet()) {
            Matcher matcher = runTimeValuesPattern.matcher(pathParams.get(key));
            if (matcher.matches()) {
                String variable = matcher.group(1);
                if (!runTimeParameters.containsKey(variable)) report("The Variable " + variable + "is not exist", FAIL);
                pathParamsCopy.put(key, runTimeParameters.get(variable));
            }
        }
        this.restRequestSpecification.setPathParams(pathParamsCopy);
    }

    @And("The Request Query Parameters Are")
    public void requestQueryParams(Map<String, String> queryParams) {
        this.restRequestSpecification.setQueryParams(queryParams);
    }


    @And("The Request Headers Are")
    public void requestHeaders(Map<String, String> headers) {
        this.restRequestSpecification.setHeaders(headers);
    }

    @And("The Request Cookies Are")
    public void requestCookies(Map<String, String> cookies) {
        this.restRequestSpecification.setCookies(cookies);
    }

    @And("The Request Accept ([^\"]*)")
    public void requestAccept(ContentType contentType) {
        this.restRequestSpecification.setAccept(contentType);
    }

    @And("The Request Content Type Is ([^\"]*)")
    public void requestContentType(ContentType contentType) {

        this.restRequestSpecification.setContentType(contentType);

    }

    @And("^The Request Body Is$")
    public void theRequestBodyIs(List<BodyEntry> bodyEntries) {
        GenericStepsHandler.createBody(bodyEntries);
    }

    @When("Send Request with the Given Specification")
    public void sendRequest() {
        RestApi restApi = RestApiManagement.getRestApi();
        this.response = restApi.sendRequest(this.restRequestSpecification);
    }


    @Then("Validate That Response Status Code Is ([^\"]*)")
    public void validateThatResponseCodeOK(StatusCode statusCode) {
        assert response.getStatusCode() == statusCode;
    }


    @Then("^Validate That Response Status Line Is \"([^\"]*)\"$")
    public void validateThatResponseStatusLineIs(String statusLine) {
        assert response.getStatusLine().equals(statusLine);
    }

    @Then("^Validate That Response Headers Are$")
    public void validateThatResponseHeadersIs(Map<String, String> headers) {
        assert response.getHeaders().equals(headers);
    }

    @Then("^Validate That Response Cookies Are$")
    public void validateThatResponseCookiesIs(Map<String, String> cookies) {
        assert response.getCookies().equals(cookies);
    }

    @Then("^Validate That Response Content Type Is ([^\"]*)$")
    public void validateThatResponseAcceptTypeIsJSON(ContentType contentType) {
        assert this.response.getContentType().equals(contentType);
    }


    @Then("^Validate That Response Body Contains$")
    public void validateThatResponseBodyContains(List<JsonPathBodyValidator> validators) {
        String body = this.response.getBody().getBodyAsString();
        DocumentContext dc = JsonPath.parse(body);

        for (JsonPathBodyValidator validator : validators) {
            assert dc.read(validator.getJsonPath()).equals(validator.getExpectedValue());
        }
    }

    @Given("^New Request Specification from File \"([^\"]*)\" with label \"([^\"]*)\"$")
    public void newRequestSpecificationFromFileWithLabel(String filePath, String requestLabel) {
        if (filePath.startsWith("/")) filePath = filePath.substring(1);
        if (!filePath.endsWith(".json")) filePath = filePath + ".json";

        this.restRequestSpecification = GenericStepsHandler.createNewRestRequestSpecification(filePath, requestLabel);
        this.requestBody = new RequestBody(filePath, requestLabel);

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
                if (objects.isEmpty()) report("Empty Array was returned", FAIL);

                value = objects.get(0);
                runTimeParameters.put(label, String.valueOf(value));
            } else {
                runTimeParameters.put(label, String.valueOf(object));
            }

        }
    }
}
