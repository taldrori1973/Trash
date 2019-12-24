package com.radware.vision.rest.bddtests;


import controllers.RestClientsManagement;
import cucumber.api.java.en.And;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import models.*;
import restInterface.RestApi;
import restInterface.RestClient;

import java.util.List;
import java.util.Map;

public class GenericSteps {

    private RestClient restClient;
    private RestRequestSpecification restRequestSpecification;
    private RestApi restApi;
    private RestResponse response;

    @Given("^Login to Vision With username \"([^\"]*)\" and password \"([^\"]*)\"$")
    public void loginToVisionWithUsernameAndPassword(String username, String password) {
        this.restClient = RestClientsManagement.getVisionConnection("https://172.17.192.100", username, password);
        assert this.restClient.login().getStatusCode() == StatusCode.OK;
    }

    @Given("^New ([^\"]*) Request Specification with Base Path \"([^\"]*)\"$")
    public void newRequestSpecification(Method method, String basePath) {
        this.restRequestSpecification = new RestRequestSpecification(method);
        this.restRequestSpecification.setBasePath(basePath);
    }

    @And("Request Path Parameters")
    public void requestPathParameters(Map<String, String> pathParams) {
        this.restRequestSpecification.setPathParams(pathParams);
    }

    @And("Request Query Params")
    public void requestQueryParams(Map<String, String> queryParams) {
        this.restRequestSpecification.setQueryParams(queryParams);
    }


    @And("Request Headers")
    public void requestHeaders(Map<String, String> headers) {
        this.restRequestSpecification.setHeaders(headers);
    }

    @And("Request Cookies")
    public void requestCookies(Map<String, String> cookies) {
        this.restRequestSpecification.setCookies(cookies);
    }

    @And("Request Accept ([^\"]*)")
    public void requestAccept(ContentType contentType) {
        this.restRequestSpecification.setAccept(contentType);
    }

    @And("Request Content Type ([^\"]*)")
    public void requestContentType(ContentType contentType) {

        this.restRequestSpecification.setContentType(contentType);

    }

    @When("Send Request")
    public void sendRequest() {
        this.restApi = RestClientsManagement.getRestApi();
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

    @Then("^Validate That Response Headers Is$")
    public void validateThatResponseHeadersIs(Map<String, String> headers) {
        assert response.getHeaders().equals(headers);
    }

    @Then("^Validate That Response Cookies Is$")
    public void validateThatResponseCookiesIs(Map<String, String> cookies) {
        assert response.getCookies().equals(cookies);
    }

    @Then("^Validate That Response Content Type Is ([^\"]*)$")
    public void validateThatResponseAcceptTypeIsJSON(ContentType contentType) {
        assert this.response.getContentType().equals(contentType);
    }

    @Then("^Validate That Response Session Id Equals Client Session Id$")
    public void validateThatResponseSessionIdEqualsClientSessionId() {

    }

    @Then("^Validate That Response Body Contains$")
    public void validateThatResponseBodyContains(List<JsonPathBodyValidator> validators) {
        System.out.println(validators);
    }
}
