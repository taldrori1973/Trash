package controllers.restAssured.client;

import io.restassured.RestAssured;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.config.SSLConfig;
import io.restassured.http.ContentType;
import io.restassured.parsing.Parser;
import io.restassured.specification.RequestSpecification;
import restInterface.client.NoAuthRestClient;

public class RestAssuredNoAuthClient implements NoAuthRestClient {

    protected final String baseUri;
    protected final int connectionPort;
    protected RequestSpecification requestSpecification;


    public RestAssuredNoAuthClient(String baseUri, int connectionPort) {
        this.baseUri = baseUri;
        this.connectionPort = connectionPort;
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
        RestAssuredClientSwitcher.switchTo(this.baseUri, this.connectionPort, null, this.requestSpecification, this);
    }

}
