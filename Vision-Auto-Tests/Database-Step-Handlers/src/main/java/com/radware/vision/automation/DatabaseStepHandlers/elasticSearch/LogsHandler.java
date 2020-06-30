package com.radware.vision.automation.DatabaseStepHandlers.elasticSearch;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.EsQuery;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.innerQuery.Match;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.SearchBool;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.search.SearchQuery;

import java.util.HashMap;

public class LogsHandler {
    /**
     * check log with containerName if contains a message
     * @param containerName
     * @param message
     * @return
     */
    public static boolean checkLogContain(String containerName, String message) throws JsonProcessingException {
        HashMap<String, String> hash_map_paramcontainer_name = new HashMap<>();
        hash_map_paramcontainer_name.put("kubernetes.container_name", containerName);
        Match matchConainerName = new Match(hash_map_paramcontainer_name);
        SearchBool searchBool = new SearchBool();
        searchBool.getMust().add(matchConainerName);
        HashMap<String, String> hash_map_message = new HashMap<>();
        hash_map_message.put("message", message);
        Match matchMessage = new Match(hash_map_message);
        searchBool.getMust().add(matchMessage);
        SearchQuery searchQuery = new SearchQuery(searchBool);
        EsQuery esQuery= new EsQuery(searchQuery);
        ObjectMapper mapper = new ObjectMapper();
        String query = mapper.writeValueAsString(esQuery);
        ElasticSearchHandler.searchESIndexByQuery("logstash",query,"Hits:0");
        return true;
    }

}
