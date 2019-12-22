package BddTests;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import mappers.RestFrameworkFactory;
import models.*;
import restInterface.RestApi;
import restInterface.RestClient;

import java.util.Map;

public class GenericSteps {

    private RestClient restClient;
    private RestRequestSpecification restRequestSpecification;
    private RestApi restApi;
    private RestResponse response;

    @Given("Login to Vision With username {string} and password {string}")
    public void loginToVisionWithUsernameAndPassword(String username, String password) {
        this.restClient = RestFrameworkFactory.getVisionConnection("https://172.17.192.100", username, password);
        assert this.restClient.login().getStatusCode() == StatusCode.OK;

    }

    @Given("New {} Request Specification")
    public void newRequestSpecification(Method method) {
        this.restRequestSpecification = new RestRequestSpecification(method);
    }

    @And("Request Base Path {string}")
    public void requestBasePath(String basePath) {
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

    @And("Request Accept {}")
    public void requestAccept(ContentType contentType) {
        this.restRequestSpecification.setAccept(contentType);
    }

    @And("Request Content Type {}")
    public void requestContentType(ContentType contentType) {

        this.restRequestSpecification.setContentType(contentType);

    }

    @When("Send Request")
    public void sendRequest() {
        this.restApi = RestFrameworkFactory.getRestApi();
        this.response = restApi.sendRequest(this.restRequestSpecification);
    }


    @Then("Validate That Response Status Code Is {}")
    public void validateThatResponseCodeOK(StatusCode statusCode) {
        assert response.getStatusCode() == statusCode;
    }
}
