package com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search;
import lombok.Getter;
import lombok.Setter;
import java.util.Map;

@Setter
@Getter
public class Match implements InnerQuery{
    Map<String,String> match;

    public Match(Map<String, String> match) {
        this.match = match;
    }
}
