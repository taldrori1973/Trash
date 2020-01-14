package com.radware.vision.restBddTests;


import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.radware.vision.requestsRepository.controllers.RequestsFilesRepository;
import com.radware.vision.restTestHandler.GenericStepsHandler;
import controllers.RestApiManagement;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import models.*;
import restInterface.RestApi;

import java.util.List;
import java.util.Map;

public class GenericSteps {

    private RestRequestSpecification restRequestSpecification;
    private RestResponse response;
    private GenericStepsHandler genericStepsHandler;


    @Given("^New ([^\"]*) Request Specification with Base Path \"([^\"]*)\"$")
    public void newRequestSpecification(Method method, String basePath) {
        this.restRequestSpecification = new RestRequestSpecification(method);
        this.restRequestSpecification.setBasePath(basePath);
    }

    @And("The Request Path Parameters Are")
    public void requestPathParameters(Map<String, String> pathParams) {
        this.restRequestSpecification.setPathParams(pathParams);
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
    public void theRequestBodyIs() {

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


    }
}
