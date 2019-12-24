package controllers;

import controllers.restAssured.RestAssuredApi;
import restInterface.RestApi;

public class RestApiManagement {

    public static RestApi getRestApi() {
        return RestAssuredApi.get_instance();
    }

}
