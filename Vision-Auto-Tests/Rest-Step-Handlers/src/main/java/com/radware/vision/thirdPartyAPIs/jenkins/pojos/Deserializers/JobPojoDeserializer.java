package com.radware.vision.thirdPartyAPIs.jenkins.pojos.Deserializers;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 1:42 PM
 */

public class JobPojoDeserializer extends StdDeserializer<List<Integer>> {

    public JobPojoDeserializer() {
        this(null);
    }

    public JobPojoDeserializer(Class<?> vc) {
        super(vc);
    }

    @Override
    public List<Integer> deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {

        JsonNode node = jsonParser.getCodec().readTree(jsonParser);
        Iterator<JsonNode> buildsObjects = node.get("builds").elements();
        List<Integer> builds = new ArrayList<>();
        buildsObjects.forEachRemaining(jsonNode -> builds.add(jsonNode.get("number").asInt()));
        return builds;
    }
}
