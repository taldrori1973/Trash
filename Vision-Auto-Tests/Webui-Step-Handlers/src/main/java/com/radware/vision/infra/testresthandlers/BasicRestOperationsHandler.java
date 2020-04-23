package com.radware.vision.infra.testresthandlers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.restcore.GenericRestClient;
import com.radware.restcore.RestBasicConsts;
import com.radware.restcore.VisionRestClient;
import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.vision.infra.utils.ReportsUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import testhandlers.GenericRestApiHandler;
import testhandlers.VisionRestApiHandler;

import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import static com.radware.vision.infra.testhandlers.BaseHandler.restTestBase;
import static com.radware.vision.infra.utils.ReportsUtils.reportErrors;


public class BasicRestOperationsHandler {

    public static void genericRestApiRequest(String ip, Integer httpPort, HttpMethodEnum httpMethod, String fileName, String urlParams, String bodyParams, String expectedResult) {

        if (httpPort == null) {
            visionRestApiRequest(restTestBase.getVisionRestClient(), httpMethod, fileName, urlParams, bodyParams, expectedResult);
            return;
        }
        GenericRestClient generalRestClient = new GenericRestClient(ip, "1", RestBasicConsts.RestProtocol.HTTP);
        generalRestClient.setHttpPort(httpPort);
        generalRestClient.setHttpSessionID(1);
        generalRestClient.setTestHttpReturnCodes(true);
        generalRestClient.setFullUrl(true);

        GenericRestApiHandler genericRestHandler = new GenericRestApiHandler();
        genericRestHandler.handleRequest(generalRestClient, httpMethod, fileName, urlParams, bodyParams, expectedResult);
    }


    static Object visionRestApiRequest(VisionRestClient visionRestClient, HttpMethodEnum httpMethod, String fileName) {
        return visionRestApiRequest(visionRestClient, httpMethod, fileName, null, null, null);
    }

    /**
     * @param visionRestClient - VisionRestClient object
     * @param httpMethod - HttpMethodEnum ENUM
     * @param fileName property file name
     * @param urlParams        %s in the property file will be replaced with this
     * @param bodyParams       same as url params
     * @param expectedResult   in case null will not do the validation
     */
    public static Object visionRestApiRequest(VisionRestClient visionRestClient, HttpMethodEnum httpMethod, String fileName, String urlParams, String bodyParams, String expectedResult) {
        VisionRestApiHandler visionRestApiHandler = new VisionRestApiHandler();
        if (!visionRestClient.isLogged(visionRestClient.getUsername()))
            visionRestClient.login("radware", "radware", "", 1);
        return visionRestApiHandler.handleRequest(visionRestClient, httpMethod, fileName, urlParams, bodyParams, expectedResult);

    }

    /**
     *  @param method - HttpMethodEnum
     * @param request - API property file
     * @param requestEntries - API fields (header, body params, result...)
     * @return
     */
    public static Object visionRestApiBuilder(HttpMethodEnum method, String request, List<RestRequestElements> requestEntries) {
        Object restResult = null;
        List<String> header = new LinkedList<>();
        List<String> bodyList = new LinkedList<>();
        List<String> paramsList = new LinkedList<>();
        List<String> resultsList = new LinkedList<>();
        int expectedReturnedCode = 200;
        String errorMessage = "";
        for (RestRequestElements entry : requestEntries
        ) {
            switch (entry.type.toLowerCase()) {
                case "header":
                    header.add(entry.value);
                    break;
                case "params":
                    paramsList.add(entry.value);
                    break;
                case "body":
                    bodyList.add(entry.value);
                    break;
                case "returned status code":
                    expectedReturnedCode = Integer.parseInt(entry.value);
                    break;
                case "result":
                    resultsList.add(entry.value);
                    break;

            }
        }
        String result = String.join(",", resultsList);
        String body = String.join(",", bodyList);
        String params = String.join(",", paramsList);
        try {
            restResult = BasicRestOperationsHandler.visionRestApiRequest(restTestBase.getVisionRestClient(), method, request, params, body, result);
        } catch (Exception e) {
            errorMessage = e.getMessage();
        }
        finally {
            if (expectedReturnedCode != 0) {
                int actualReturnedCode = restTestBase.getVisionRestClient().getLastHttpStatusCode();
                if(actualReturnedCode != expectedReturnedCode){
                    BaseTestUtils.report("Operation Failed: EXPECT - " + expectedReturnedCode + ", ACTUAL - " + actualReturnedCode +
                            "\n\"Received error message: " + errorMessage, Reporter.FAIL);
                }
            }
        }
        return restResult;

    }

    public static void validateExistenceReports(List<ExistenceReport> expectedReports, Object actualResult) {
        if(actualResult != null) {
            JSONArray actualResultArray = new JSONArray(actualResult.toString());
            List<String> actualReportsName = StreamSupport.stream(actualResultArray.spliterator(), false)
                    .map(s -> String.valueOf(((JSONObject)s).get("name"))).collect (Collectors.toList ());

            for (ExistenceReport expectedReport : expectedReports)
            {
                if (!expectedReport.isExist.equals(actualReportsName.contains(expectedReport.reportName)))
                    ReportsUtils.addErrorMessage("'" + expectedReport.reportName + "' report " + (expectedReport.isExist.equals(true)?"should":"shouldn't") + " be exist, but the Actual is not");
            }
            reportErrors();
        }
    }
    public class ExistenceReport
    {
        String reportName;
        Boolean isExist;
        ExistenceReport(String reportName, Boolean isExist)
        {
            this.reportName = reportName;
            this.isExist = isExist;
        }
    }

    public static class RestRequestElements {
        public String type;
        public String value;
        public RestRequestElements(String type, String value){
            this.type = type;
            this.value = value;
        }
    }

}
