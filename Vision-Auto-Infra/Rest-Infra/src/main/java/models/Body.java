package models;

import com.fasterxml.jackson.databind.JsonNode;
import com.jayway.jsonpath.JsonPath;
import lombok.AllArgsConstructor;
import lombok.Setter;

import java.util.Optional;

@Setter
@AllArgsConstructor
public class Body {

    private String bodyAsString;
    private Optional<JsonPath> bodyAsJsonPath;
    private Optional<JsonNode> bodyAsJsonNode;


}
