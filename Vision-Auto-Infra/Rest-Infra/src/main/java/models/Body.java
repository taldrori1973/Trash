package models;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jayway.jsonpath.JsonPath;

import java.io.IOException;


public class Body {

    private String bodyAsString;
    private JsonPath bodyAsJsonPath;
    private JsonNode bodyAsJsonNode;


    private ObjectMapper objectMapper;
    private JsonFactory factory;

    public Body(String bodyAsString) throws IOException {
        this.objectMapper = new ObjectMapper();
        this.factory = this.objectMapper.getFactory();
        this.bodyAsString = bodyAsString;
        setBodyAsJsonPath();
        setBodyAsJsonNode();
    }

    private void setBodyAsJsonNode() throws IOException {
        JsonParser parser = this.factory.createParser(this.bodyAsString);
        this.bodyAsJsonNode = this.objectMapper.readTree(parser);
    }

    private void setBodyAsJsonPath() {
        this.bodyAsJsonPath = JsonPath.compile(this.bodyAsString);
    }

    public String getBodyAsString() {
        return bodyAsString;
    }

    public JsonPath getBodyAsJsonPath() {
        return bodyAsJsonPath;
    }

    public JsonNode getBodyAsJsonNode() {
        return bodyAsJsonNode;
    }
}
