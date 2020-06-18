package com.radware.vision.automation.DatabaseStepHandlers.elasticSearch;
import com.google.gson.JsonObject;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import java.util.ArrayList;

public class SearchQuery {

    String index;
    JSONParser parser = new JSONParser();
    String query = "{\\\n" +
            "    \"_source\": [\\\n" +
            "        columnName=%s\\\n" +
            "    ],\\\n" +
            "    \"query\": {\\\n" +
            "        \"bool\": {\\\n" +
            "            \"must\": [],\\\n" +
            "            \"must_not\": [],\\\n" +
            "            \"should\": []\\\n" +
            "        }\\\n" +
            "    },\\\n" +
            "    }\\\n" +
            "}";
    JSONObject QueryObject;
    ArrayList<JsonObject> must;
    ArrayList<JsonObject> mustNot;
    ArrayList<JsonObject> should;


    public SearchQuery(String index) throws ParseException {
        this.index = index;
        startQueryobject();
    }

    private void startQueryobject() throws ParseException {
        QueryObject = (JSONObject) parser.parse(this.query);
    }

     public JSONObject addMustQuery(JSONObject query){

        return QueryObject;
     }

    public JSONObject addMustNotQuery(JSONObject query){

        return QueryObject;
    }
    public JSONObject addShouldQuery(JSONObject query){

        return QueryObject;
    }

    public JSONObject executeQuery(){

        return QueryObject;
    }
    public int getNumberOfHits(){
        JSONObject response = this.executeQuery();

        return 1;
    }
}
