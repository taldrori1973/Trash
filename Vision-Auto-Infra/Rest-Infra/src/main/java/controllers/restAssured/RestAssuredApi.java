package controllers.restAssured;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import io.restassured.http.Method;
import io.restassured.response.Response;
import io.restassured.specification.RequestSpecification;
import mappers.restAssured.RestAssuredResponseMapper;
import models.RestRequestSpecification;
import models.RestResponse;
import restInterface.RestApi;

import java.util.Objects;

public class RestAssuredApi implements RestApi {

    @Override
    public RestResponse sendRequest(RestRequestSpecification requestSpecification) {


        RequestSpecification request = RestAssured.given().
                basePath(requestSpecification.getBasePath()).
                pathParams(requestSpecification.getPathParams()).
                queryParams(requestSpecification.getQueryParams()).
                headers(requestSpecification.getHeaders()).
                cookies(requestSpecification.getCookies());

        if (!Objects.isNull(requestSpecification.getContentType()))
            request = request.contentType(ContentType.fromContentType(requestSpecification.getContentType().toString()));
        if (!Objects.isNull(requestSpecification.getAccept()))
            request = request.accept(ContentType.fromContentType(requestSpecification.getAccept().getAcceptHeader()));


        switch (requestSpecification.getMethod()) {
            case POST:
            case PUT:
            case PATCH:
                request = request.body(requestSpecification.getBody().getBodyAsString());
            case DELETE:
                if (!Objects.isNull(requestSpecification.getBody()))
                    request = request.body(requestSpecification.getBody().getBodyAsString());
        }
        Response response = request.when().request(Method.valueOf(requestSpecification.getMethod().name())).then().extract().response();

        return RestAssuredResponseMapper.map(response);

    }
}
