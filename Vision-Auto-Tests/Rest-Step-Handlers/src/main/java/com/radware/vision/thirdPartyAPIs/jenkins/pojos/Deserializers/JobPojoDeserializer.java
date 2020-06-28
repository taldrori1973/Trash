package com.radware.vision.thirdPartyAPIs.jenkins.pojos.Deserializers;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;
import com.radware.vision.thirdPartyAPIs.jenkins.pojos.JobPojo;

import java.io.IOException;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 1:42 PM
 */

public class JobPojoDeserializer extends StdDeserializer<JobPojo> {

    protected JobPojoDeserializer() {
        this(null);
    }

    protected JobPojoDeserializer(Class<?> vc) {
        super(vc);
    }

    @Override
    public JobPojo deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
        return null;
    }
}
