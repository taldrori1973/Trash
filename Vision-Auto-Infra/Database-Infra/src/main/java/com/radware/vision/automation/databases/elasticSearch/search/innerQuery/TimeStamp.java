package com.radware.vision.automation.databases.elasticSearch.search.innerQuery;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

import java.util.HashMap;
import java.util.Map;

@Data

public class TimeStamp implements RangeFilter {
    @JsonProperty("@timestamp")
    Map<String, String> timestamp;

    public TimeStamp() {
        timestamp = new HashMap<>();
    }

    public TimeStamp(Map<String, String> timestamp) {
        this.timestamp = timestamp;
    }

    public void addFilter(String key, String value) {
        timestamp.put(key, value);
    }

}
