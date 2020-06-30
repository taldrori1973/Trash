package com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery;

import lombok.Data;

import java.util.HashMap;
import java.util.Map;
@Data

public class TimeStamp implements RangeFilter {
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
