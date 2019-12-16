package controllers.restAssured.client;

import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.config.SSLConfig;
import io.restassured.filter.Filter;
import io.restassured.filter.cookie.CookieFilter;
import io.restassured.http.ContentType;
import io.restassured.http.Cookie;
import io.restassured.http.Cookies;
import io.restassured.specification.FilterableRequestSpecification;
import io.restassured.specification.RequestSpecification;
import restInterface.RestClient;

public abstract class RestAssuredClient implements RestClient {

    protected final String baseUri;
    protected final int connectionPort;
    protected final FilterableRequestSpecification requestSpecification;
    protected  Cookies cookies;

    public RestAssuredClient(String baseUri, int connectionPort) {
        this.baseUri = baseUri;
        this.connectionPort = connectionPort;

        this.requestSpecification = (FilterableRequestSpecification) new RequestSpecBuilder().setContentType(ContentType.JSON).build();
        this.requestSpecification.baseUri(this.baseUri);
        this.requestSpecification.port(this.connectionPort);
        RestAssured.requestSpecification=this.requestSpecification;

        RestAssured.config = RestAssured.config.sslConfig(SSLConfig.sslConfig().relaxedHTTPSValidation().allowAllHostnames());
    }

    @Override
    public void switchTo() {
//        this.requestSpecification.replaceCookies(this.cookies);
        RestAssured.baseURI = this.baseUri;
        RestAssured.port = this.connectionPort;
        RestAssured.requestSpecification=this.requestSpecification;
    }
}
