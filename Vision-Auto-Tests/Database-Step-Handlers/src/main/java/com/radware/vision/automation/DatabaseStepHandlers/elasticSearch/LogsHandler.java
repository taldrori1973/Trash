package com.radware.vision.automation.DatabaseStepHandlers.elasticSearch;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.EsQuery;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.Match;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.SearchBool;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.SearchQuery;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.Range;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.TimeStamp;

import java.time.LocalDateTime;

public class LogsHandler {
    /**
     * check log with containerName if contains a message
     *
     * @param containerName
     * @param message
     * @return
     */
    public static boolean checkLogContain(String containerName, String message) throws JsonProcessingException {
        Match matchConainerName = new Match();
        matchConainerName.add("kubernetes.container_name", containerName);
        SearchBool searchBool = new SearchBool();
        searchBool.getMust().add(matchConainerName);
        Match matchMessage = new Match();
        matchMessage.add("message", message);
        searchBool.getMust().add(matchMessage);
        SearchQuery searchQuery = new SearchQuery(searchBool);
        EsQuery esQuery = new EsQuery(searchQuery);
        ObjectMapper mapper = new ObjectMapper();
        String query = mapper.writeValueAsString(esQuery);
        ElasticSearchHandler.searchESIndexByQuery("logstash", query, "Hits:0");
        return true;
    }

    /**
     * update the query with test starting time
     *
     * @param searchBool the orignal query
     */
    public static void updateTimeRange(SearchBool searchBool, LocalDateTime testTime) {
//         = TestBase.getTestStartTime();
        testTime = testTime.minusMonths(2);            //////////////////////////temproray
        TimeStamp timeStamp = new TimeStamp();
        timeStamp.addFilter("gt", testTime.toString());
        Range range = new Range(timeStamp);
        searchBool.getMust().add(range);
    }

}
