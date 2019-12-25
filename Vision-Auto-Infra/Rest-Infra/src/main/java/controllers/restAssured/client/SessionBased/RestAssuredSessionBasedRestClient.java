package controllers.restAssured.client.SessionBased;

import controllers.RestClientsManagement;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.config.SSLConfig;
import io.restassured.filter.cookie.CookieFilter;
import io.restassured.filter.session.SessionFilter;
import io.restassured.http.ContentType;
import io.restassured.parsing.Parser;
import io.restassured.specification.RequestSpecification;
import restInterface.client.SessionBasedRestClient;

public abstract class RestAssuredSessionBasedRestClient implements SessionBasedRestClient {

    protected final String baseUri;
    protected final int connectionPort;
    protected final String username;
    protected final String password;

    protected RequestSpecification requestSpecification;
    protected SessionFilter sessionFilter;
    protected CookieFilter cookieFilter;
    protected String sessionId;

    public RestAssuredSessionBasedRestClient(String baseUri, int connectionPort, String username, String password) {
        this.baseUri = baseUri;
        this.connectionPort = connectionPort;
        this.username = username;
        this.password = password;

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
        RestClientsManagement.setCurrentConnection(this);
    }
}
