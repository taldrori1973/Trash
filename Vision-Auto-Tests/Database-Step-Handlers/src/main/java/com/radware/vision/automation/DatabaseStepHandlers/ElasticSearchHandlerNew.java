package com.radware.vision.automation.DatabaseStepHandlers;

import com.jayway.jsonpath.JsonPath;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.restAPI.ElasticsearchRestAPI;
import models.RestResponse;
import models.StatusCode;
import org.json.JSONObject;
import java.util.*;
import com.jayway.jsonpath.DocumentContext;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class ElasticSearchHandlerNew {

    public static void deleteESDocument(String data, String index) {
        try {
            ElasticsearchRestAPI esRestApi = createEsRestConnection("Vision/elasticSearch.json", "Delete doucument by query");
            HashMap<String, String> hash_map_param = new HashMap<String, String>();
            hash_map_param.put("indexName", index);
            esRestApi.getRestRequestSpecification().setPathParams(hash_map_param);
            esRestApi.getRestRequestSpecification().setBody(String.format("{\"query\":{\"match\":{%s}}}", data));
            RestResponse restResponse = esRestApi.sendRequest();
            if (!restResponse.getStatusCode().equals(StatusCode.OK)) {
                BaseTestUtils.report("can't delete index: " + index, Reporter.FAIL);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void deleteESIndex(String index) {
        try {
            ElasticsearchRestAPI esRestApi = createEsRestConnection("Vision/elasticSearch.json", "Delete Index");
            HashMap<String, String> hash_map_param = new HashMap<>();
            hash_map_param.put("indexName", index);
            esRestApi.getRestRequestSpecification().setPathParams(hash_map_param);
            RestResponse restResponse = esRestApi.sendRequest();
            if (!restResponse.getStatusCode().equals(StatusCode.OK)) {
                BaseTestUtils.report("can't delete index: " + index, Reporter.FAIL);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void searchESIndexByQuery(String index, String query, String response) {
        try {
            ElasticsearchRestAPI esRestApi = createEsRestConnection("Vision/elasticSearch.json", "Search index by query");
            HashMap<String, String> hash_map_param = new HashMap<>();
            hash_map_param.put("indexName", index);
            esRestApi.getRestRequestSpecification().setPathParams(hash_map_param);
            esRestApi.getRestRequestSpecification().setBody(query);
            RestResponse restResponse = esRestApi.sendRequest();
            if (!restResponse.getBody().getBodyAsString().contains(response)) {
                BaseTestUtils.reporter.report("The expected response NOT found", Reporter.FAIL);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void updateESIndexByQuery(String index, String query, String response) {
            ElasticsearchRestAPI esRestApi = createEsRestConnection("Vision/elasticSearch.json", "Update index by query");
            HashMap<String, String> hash_map_param = new HashMap<>();
            hash_map_param.put("indexName", index);
            esRestApi.getRestRequestSpecification().setPathParams(hash_map_param);
            esRestApi.getRestRequestSpecification().setBody(query);
            RestResponse restResponse = esRestApi.sendRequest();
            if (response!=null &&!restResponse.getBody().getBodyAsString().contains(response)) {
                BaseTestUtils.reporter.report("The expected response NOT found", Reporter.FAIL);
            }
    }

    public static JSONObject getIndex(String ip, String indexName) throws NoSuchFieldException {
        ElasticsearchRestAPI esRestApi = createEsRestConnection("Vision/elasticSearch.json", "Get Index");
        HashMap<String, String> hash_map_param = new HashMap<>();
        hash_map_param.put("indexName", indexName);
        esRestApi.getRestRequestSpecification().setPathParams(hash_map_param);
        RestResponse restResponse = esRestApi.sendRequest();//
        restResponse.getBody().getBodyAsString();
        return new JSONObject(restResponse.getBody().getBodyAsString());
    }

    public static int getNumberOfAttributes(String ip, String indexName, Integer weekSlice) {

        if (getIndex(ip, indexName, "last", weekSlice) == null)
            BaseTestUtils.report(String.format("Can't Find Index \"%s\"", indexName), Reporter.FAIL);
        JSONObject root = null;
        try {
            root = getIndex(ip, indexName);
        } catch (NoSuchFieldException e) {
            BaseTestUtils.reporter.report("index" + indexName + " Not found", Reporter.FAIL);
            e.printStackTrace();
        }
        String index = getRequiredIndex(root, "last");
        DocumentContext jsonContext = JsonPath.parse(root.toString());

        String enabledPath = "$." + index + ".mappings..[?(@.enabled==false)]";
        if (!((List<String>) jsonContext.read(enabledPath)).isEmpty()) {
            BaseTestUtils.report("The Index contains NOT Enabled Mapping", Reporter.FAIL);
        }
        String typesPath = "$." + index + ".mappings..type";
        List<String> types = jsonContext.read(typesPath);
        return types.size();
    }

    public static boolean isIndexContainsKeyValue(String indexName, String attribute, String value) {
        String body = String.format("{\\\n" +
                "    \"_source\": [\\\n" +
                "        columnName=%s\\\n" +
                "    ],\\\n" +
                "    \"query\": {\\\n" +
                "        \"bool\": {\\\n" +
                "            \"must\": [\\\n" +
                "                {\\\n" +
                "                    \"term\": {\\\n" +
                "                        columnName=%s: value=%s\\\n" +
                "                    }\\\n" +
                "                }\\\n" +
                "            ],\\\n" +
                "            \"must_not\": [],\\\n" +
                "            \"should\": []\\\n" +
                "        }\\\n" +
                "    },\\\n" +
                "    \"size\": 0,\\\n" +
                "    \"aggs\": {\\\n" +
                "        \"unique_field\": {\\\n" +
                "            \"terms\": {\\\n" +
                "                \"field\": columnName=%s\\\n" +
                "            }\\\n" +
                "        }\\\n" +
                "    }\\\n" +
                "}", attribute, attribute, value, attribute);

        ElasticsearchRestAPI esRestApi = createEsRestConnection("Vision/elasticSearch.json", "Search index by query");
        HashMap<String, String> hash_map_param = new HashMap<>();
        hash_map_param.put("indexName", indexName);
        esRestApi.getRestRequestSpecification().setPathParams(hash_map_param);
        esRestApi.getRestRequestSpecification().setBody(body);
        RestResponse restResponse = esRestApi.sendRequest();
        if (restResponse.getBody().getBodyAsString().contains("\"hits\":{\"total\":0")) return false;
        return true;
    }


    public static String getIndex(String ip, String indexName, String sliceToGet, Integer weekSlice) {
        JSONObject jsonObject;
        try {
            jsonObject = getIndex(ip, indexName);
        } catch (Exception e) {
            return null;
        }

        if (!jsonObject.isNull("error") || jsonObject.isEmpty()) return null;
        String requiredIndex = getRequiredIndex(jsonObject, sliceToGet);
        Pattern endsWithNumberPattern = Pattern.compile("^(.*-)(\\d+)$");
        Matcher matcher = endsWithNumberPattern.matcher(requiredIndex);
        int indexWeekSlice = 0;
        if (matcher.matches()) {
            matcher = matcher.reset();
            if (matcher.find()) indexWeekSlice = Integer.parseInt(matcher.group(2));

            if (weekSlice == null)
                BaseTestUtils.report(String.format("For Indices with the pattern : \"{Index Prefix}-{Week number}\" " +
                        "you should provide the week slice value in the step," +
                        " the value you provided is null\nThis value equals every how many weeks the ES will create new index, the value can be different from one index to another"), Reporter.FAIL);

            int currentWeekSlice = (int) ((new Date().getTime() / 1000) / (60 * 60 * 24 * 7 * weekSlice));


            if (sliceToGet.equalsIgnoreCase("last")) {
                if (currentWeekSlice == indexWeekSlice) return requiredIndex;
                else {
                    BaseTestUtils.report(String.format("you required the last index , but according to the weekSlice and the current date the last index which found is not the expected one , " +
                            "please check if the elastic search indices are not up to date, or the week slice you provided is correct for this index\n" +
                            "the last index found is %d , the last index expected is %d according to the week slice you provide.", currentWeekSlice, indexWeekSlice), Reporter.FAIL);
                    return null;
                }
            } else return requiredIndex;
        }

        return requiredIndex;

    }


    private static String getRequiredIndex(JSONObject root, String sliceToGet) {
        Pattern endsWithNumberPattern = Pattern.compile("^(.*-)(\\d+)$");

        Set<String> allPrefixes = new HashSet<>();
        List<String> indices = new ArrayList<>(root.keySet());
        List<Integer> indicesNumbers = new ArrayList<>();
        int indicesNumber = root.keySet().size();

        if (indicesNumber == 1) return indices.get(0);

        //if we have more than one index , so we have to handle two cases:
        //1. there are indices with different prefixes for example : abc-aa-5 , abc-bb-5 -> error
        //2. all the indices with the same prefix but the number value different example : abc-aa-5,abc-aa-6 --> return the latest --> abc-aa-6

//        check if there are different indices prefixes:
        indices.forEach(index -> {
            Matcher matcher = endsWithNumberPattern.matcher(index);
            if (matcher.find())
                allPrefixes.add(matcher.group(1));
            else allPrefixes.add(index);
        });

        if (allPrefixes.size() > 1)
            BaseTestUtils.report(String.format("%d Indices with the given Prefix was Found, Please Enter More Specific Index Prefix", root.keySet().size()), Reporter.FAIL);

//        now all the indices are with same prefix but the number is different
        indices.forEach(index -> {
            Matcher matcher = endsWithNumberPattern.matcher(index);
            if (matcher.find())
                indicesNumbers.add(Integer.parseInt(matcher.group(2)));

        });
        int requiredSlice;
        switch (sliceToGet.toLowerCase()) {
            case "first":
                requiredSlice = indicesNumbers.stream().min(Integer::compareTo).get();
                break;
            case "last":
                requiredSlice = indicesNumbers.stream().max(Integer::compareTo).get();
                break;
            default:
                throw new IllegalArgumentException(String.format("the argument sliceToGet should be or \"LAST\" or \"FIRST\", Actual value is %s", sliceToGet));
        }
        return new ArrayList<>(allPrefixes).get(0) + requiredSlice;
    }

    public static ElasticsearchRestAPI createEsRestConnection(String requestFilePath, String requestLabel) {
        return new ElasticsearchRestAPI("http://172.17.178.117", 9200, requestFilePath, requestLabel);
    }

}
