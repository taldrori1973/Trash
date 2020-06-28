package com.radware.vision.thirdPartyAPIs.jenkins.pojos.Deserializers;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.deser.std.StdDeserializer;
import com.radware.vision.thirdPartyAPIs.jenkins.pojos.JobPojo;
import lombok.Data;

import java.io.IOException;

/**
 * Created by MohamadI - Muhamad Igbaria
 * Date: 6/25/2020
 * Time: 1:42 PM
 */
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class JobPojoDeserializer extends StdDeserializer<JobPojo> {


    @Override
    public JobPojo deserialize(JsonParser jsonParser, DeserializationContext deserializationContext) throws IOException, JsonProcessingException {
        return null;
    }
}
