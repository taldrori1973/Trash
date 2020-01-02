package controllers.restAssured.client.BasicAuth;

import controllers.restAssured.client.RestAssuredClientSwitcher;
import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.config.SSLConfig;
import io.restassured.http.ContentType;
import io.restassured.parsing.Parser;
import io.restassured.specification.RequestSpecification;
import restInterface.client.BasicAuthBasedRestClient;

public abstract class RestAssuredBasicAuthBasedRestClient implements BasicAuthBasedRestClient {


    protected final String baseUri;
    protected final int connectionPort;
    protected final String username;
    protected final String password;

    protected RequestSpecification requestSpecification;


    public RestAssuredBasicAuthBasedRestClient(String baseUri, int connectionPort, String username, String password) {
        this.baseUri = baseUri;
        this.connectionPort = connectionPort;
        this.username = username;
        this.password = password;

        this.requestSpecification = new RequestSpecBuilder().
                setContentType(ContentType.JSON).
                setBaseUri(this.baseUri).
                setPort(this.connectionPort).
                build();

        this.requestSpecification.auth().basic(this.username, this.password);

        RestAssured.registerParser("application/octet-stream", Parser.JSON);

        RestAssured.config = RestAssured.config.sslConfig(SSLConfig.sslConfig().relaxedHTTPSValidation().allowAllHostnames());
    }

    @Override
    public void switchTo() {
        RestAssuredClientSwitcher.switchTo(this.baseUri, this.connectionPort, null, this.requestSpecification, this);
    }
}
