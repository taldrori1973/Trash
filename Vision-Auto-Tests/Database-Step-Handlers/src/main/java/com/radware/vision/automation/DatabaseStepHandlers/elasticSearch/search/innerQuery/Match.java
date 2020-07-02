package com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.HashMap;
import java.util.Map;

@Data
public class Match implements InnerQuery {
    Map<String, Map<String,String>> match;

    public Match() {
        match = new HashMap<>();
    }

    public Match(Map<String, Map<String,String>> match) {
        this.match = match;
    }

    public void add(String key, String value) {
        HashMap<String,String> map =new HashMap<>();
        map.put("query",value);
        map.put("operator","and");

        match.put(key, map);
    }
}
