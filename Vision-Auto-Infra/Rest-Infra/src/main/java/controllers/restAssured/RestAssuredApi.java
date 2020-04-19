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


    private static RestApi _instance = new RestAssuredApi();

    private RestAssuredApi() {

    }

    public static RestApi get_instance() {
        return _instance;
    }

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
            request = request.accept(requestSpecification.getAccept().getAcceptHeader());


        switch (requestSpecification.getMethod()) {
            case POST:
            case PUT:
            case PATCH:
                if (requestSpecification.getBody() != null)
                    request = request.body(requestSpecification.getBody().getBodyAsString());
                break;
            case DELETE:
                if (!Objects.isNull(requestSpecification.getBody()))
                    request = request.body(requestSpecification.getBody().getBodyAsString());
        }
        Response response = request.
                when().log().all().request(Method.valueOf(requestSpecification.getMethod().name())).
                then().log().ifError().extract().response();

        return RestAssuredResponseMapper.map(response);

    }
}
