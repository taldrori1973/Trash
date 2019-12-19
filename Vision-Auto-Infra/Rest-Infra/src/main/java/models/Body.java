package models;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.EqualsAndHashCode;
import lombok.ToString;

import java.io.IOException;
import java.util.Optional;

@EqualsAndHashCode
@ToString
public class Body {

    private static final ObjectMapper mapper;
    private static final JsonFactory factory;
    private static JsonParser parser;

    static {
        mapper = new ObjectMapper();
        factory = mapper.getFactory();
    }

    private String bodyAsString;
    private Optional<JsonNode> bodyAsJsonNode;

    public Body(String bodyAsString) {
        this.setBodyAsString(bodyAsString);
    }

    public Body(String bodyAsString, Optional<JsonNode> bodyAsJsonNode) {
        this.bodyAsString = bodyAsString;
        this.bodyAsJsonNode = bodyAsJsonNode;
    }

    public String getBodyAsString() {
        return bodyAsString;
    }

    public void setBodyAsString(String bodyAsString) {
        this.bodyAsString = bodyAsString;
        try {
            parser = factory.createParser(this.bodyAsString);
            this.setBodyAsJsonNode(Optional.of(mapper.readTree(parser)));
        } catch (IOException e) {
            this.setBodyAsJsonNode(Optional.empty());
        }
    }

    public Optional<JsonNode> getBodyAsJsonNode() {
        return bodyAsJsonNode;
    }

    public void setBodyAsJsonNode(Optional<JsonNode> bodyAsJsonNode) {
        this.bodyAsJsonNode = bodyAsJsonNode;
    }
}
