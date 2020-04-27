package com.radware.vision.infra.testresthandlers;

import basejunit.RestTestBase;
import com.jayway.jsonpath.DocumentContext;
import com.jayway.jsonpath.JsonPath;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.GenericRestClient;
import com.radware.restcore.RestBasicConsts;
import com.radware.restcore.utils.enums.HTTPStatusCodes;
import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.CliOperations;
import com.radware.vision.vision_project_cli.RadwareServerCli;
import com.radware.vision.vision_project_cli.RootServerCli;
import org.json.JSONObject;
import testhandlers.GenericRestApiHandler;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static com.radware.vision.infra.testhandlers.BaseHandler.restTestBase;

public class ElasticSearchHandler {


    public static Object executeESRequest(String ip, HttpMethodEnum httpMethod, String request, String urlField, String bodyFields, String expectedResult) {
        RadwareServerCli radwareUser = restTestBase.getRadwareServerCli();
        radwareUser.disconnect();
        try {
            radwareUser.connect();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to connect", e);
        }

        CliOperations.runCommand(radwareUser, "net firewall open-port set 9200 open");
        GenericRestClient generalRestClient = new GenericRestClient(ip, "1", RestBasicConsts.RestProtocol.CLOUD_ELASTIC_SEARCH);
        generalRestClient.setHttpSessionID(1);
        generalRestClient.setTestHttpReturnCodes(true);
        generalRestClient.setFullUrl(true);
        List<HTTPStatusCodes> expectedStatusCode = Arrays.asList(HTTPStatusCodes.OK, HTTPStatusCodes.NOT_FOUND);
        generalRestClient.setExpectedStatusCode(expectedStatusCode);

        GenericRestApiHandler genericRestHandler = new GenericRestApiHandler();
        return genericRestHandler.handleRequest(generalRestClient, httpMethod, request, urlField, bodyFields, expectedResult);
    }

    public static void deleteESIndex(String ip, String index) {
        try {
            HttpMethodEnum httpMethod = HttpMethodEnum.DELETE;
            executeESRequest(ip, httpMethod, "ESIndex", index, null, null);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to delete index: " + index, e);
        }
    }

    public static void deleteESDocument(String ip, String data, String index) {
        try {
            HttpMethodEnum httpMethod = HttpMethodEnum.POST;
            executeESRequest(ip, httpMethod, "ESIndex->DeleteDocument", index, data, null);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to delete document with data: " + data + ", from index: " + index, e);
        }
    }

    public static JSONObject getDocument(RootServerCli rootServerCli, String documentFieldName, String documentFieldValue, String indexName) {
        CliOperations.runCommand(rootServerCli, "service iptables stop");
        HttpMethodEnum httpMethod = HttpMethodEnum.POST;

        JSONObject restResult = new JSONObject(ElasticSearchHandler.executeESRequest(rootServerCli.getHost(), httpMethod, "ESIndex->GetDocument", indexName, "\"" + documentFieldName + "\":" + "\"" + documentFieldValue + "\"", null).toString());
        restResult = restResult.getJSONObject("hits").getJSONArray("hits").getJSONObject(0).getJSONObject("_source");
        CliOperations.runCommand(rootServerCli, "service iptables start");
        return restResult;
    }


    public static JSONObject getIndex(String ip, String indexName) {
        HttpMethodEnum methodEnum = HttpMethodEnum.GET;
        String result;
        result = executeESRequest(ip, methodEnum, "ESIndex", indexName, null, null).toString();
        return new JSONObject(result);
    }

    public static String getIndex(String ip, String indexName, String sliceToGet, Integer weekSlice) {
        HttpMethodEnum methodEnum = HttpMethodEnum.GET;
        String result;
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


    public static int getNumberOfAttributes(String ip, String indexName, Integer weekSlice) {

        if (getIndex(ip, indexName, "last", weekSlice) == null)
            BaseTestUtils.report(String.format("Can't Find Index \"%s\"", indexName), Reporter.FAIL);
        JSONObject root = getIndex(ip, indexName);
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

    public static void runMigrationTask(MigrationTask migrationTask, int seconds) throws InterruptedException {
        RootServerCli restTestBase = new RestTestBase().getRootServerCli();

        String messageToPrintInLogFile = String.format("\nThe Following Migration Task was Started by the Automation : %s\n" +
                "Server IP : %s\n" +
                "Version : %s\n" +
                "Build: %s\n", migrationTask.name(), restTestBase.getHost(), restTestBase.getVersionNumebr(), restTestBase.getBuildNumber());

        CliOperations.runCommand(restTestBase, "echo \"" + messageToPrintInLogFile + "\" >> /opt/radware/mgt-server/third-party/tomcat/logs/reporter.log", 0);

        String restRequest = "curl -X POST --header 'Content-Type: application/json' --header 'Accept: */*'" +
                " 'http://localhost:10080/reporter/mgmt/monitor/reporter/internal-dashboard/scheduledTasks?jobClassName=com.reporter.dp.task.attack.migration.%s'";


        CliOperations.runCommand(restTestBase, restRequest.replace("%s", migrationTask.name()), 0);

        Thread.sleep(1000 * seconds);


    }

    public static boolean isIndexContainsKeyValue(String deviceIp, String index, String attribute, String value) {
        Object result = executeESRequest(deviceIp, HttpMethodEnum.POST, "ESIndex->IsDocumentContainsKeyValue",
                index, String.format("columnName=%s,value=%s", attribute, value), null);

        if(result.toString().contains("\"hits\":{\"total\":0")) return false;
        return true;
    }


    public enum MigrationTask {
        BDoSBaseLineRatesMigrationTask,
        DFAttackMigrationTask,
        DPAttackDurationMigrationTask,
        DPAttackSamplesMigrationTask
    }
}
