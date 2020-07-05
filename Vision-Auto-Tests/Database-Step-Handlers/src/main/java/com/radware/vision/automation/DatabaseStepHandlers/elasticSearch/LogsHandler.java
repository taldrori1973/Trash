package com.radware.vision.automation.DatabaseStepHandlers.elasticSearch;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.EsQuery;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.SearchLog;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.Match;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.SearchBool;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.SearchQuery;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.Range;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.TimeStamp;

import java.time.LocalDateTime;
import java.util.List;

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
//        testTime = testTime.minusMonths(2);            //////////////////////////temproray
        TimeStamp timeStamp = new TimeStamp();
        timeStamp.addFilter("gt", testTime.toString());
        Range range = new Range(timeStamp);
        searchBool.getMust().add(range);
    }

    /**
     * @param selection  the experssion in the log we need to search
     * @param myIgnored  the ignoreLIst
     * @param searchBool the orignal query
     * @return return the query after adding the experssion to it
     * @throws JsonProcessingException JsonProcessingException
     */
    public static String isNotExpectedQuery(SearchLog selection, List<SearchLog> myIgnored, SearchBool searchBool) throws JsonProcessingException {
        Match mustMatch = new Match();
        mustMatch.add("message", selection.getExpression());
        searchBool.getMust().add(mustMatch);
        for (SearchLog ignore : myIgnored) {
            if (ignore.getLogType().serverLogType.equalsIgnoreCase(selection.getLogType().serverLogType)) {
                Match mustNotMatch = new Match();
                mustNotMatch.add("message", ignore.getExpression());
                searchBool.getMust_not().add(mustNotMatch);
            }
        }
        EsQuery esQuery = new EsQuery(new SearchQuery(searchBool));
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(esQuery);
    }

    /**
     * @param selection  the experssion in the log we need to search
     * @param searchBool the orignal query
     * @return return the query after adding the experssion to it
     * @throws JsonProcessingException JsonProcessingException
     */
    public static String ExpectedQuery(SearchLog selection, SearchBool searchBool) throws JsonProcessingException {
        Match mustMatch = new Match();
        mustMatch.add("message", selection.getExpression());
        searchBool.getMust().add(mustMatch);
        EsQuery esQuery = new EsQuery(new SearchQuery(searchBool));
        ObjectMapper mapper = new ObjectMapper();
        return mapper.writeValueAsString(esQuery);
    }


}
