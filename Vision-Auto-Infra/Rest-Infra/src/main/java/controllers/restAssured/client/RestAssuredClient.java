package controllers.restAssured.client;

import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.config.SSLConfig;
import io.restassured.filter.cookie.CookieFilter;
import io.restassured.filter.session.SessionFilter;
import io.restassured.http.ContentType;
import io.restassured.parsing.Parser;
import io.restassured.specification.RequestSpecification;
import restInterface.RestClient;

public abstract class RestAssuredClient implements RestClient {
    public static RestClient currentClient;

    protected final String baseUri;
    protected final int connectionPort;
    protected RequestSpecification requestSpecification;
    protected SessionFilter sessionFilter;
    protected CookieFilter cookieFilter;
    protected String sessionId;

    public RestAssuredClient(String baseUri, int connectionPort) {
        this.baseUri = baseUri;
        this.connectionPort = connectionPort;
        this.sessionFilter = new SessionFilter();
        this.cookieFilter = new CookieFilter();

        this.requestSpecification = new RequestSpecBuilder().
                setContentType(ContentType.JSON).
                setBaseUri(this.baseUri).
                setPort(this.connectionPort).
                build();

        RestAssured.registerParser("application/octet-stream", Parser.JSON);

        RestAssured.config = RestAssured.config.sslConfig(SSLConfig.sslConfig().relaxedHTTPSValidation().allowAllHostnames());
    }

    @Override
    public void switchTo() {
        RestAssured.baseURI = this.baseUri;
        RestAssured.port = this.connectionPort;
        RestAssured.sessionId = this.sessionId;
        RestAssured.requestSpecification = this.requestSpecification;
        currentClient = this;
    }
}
