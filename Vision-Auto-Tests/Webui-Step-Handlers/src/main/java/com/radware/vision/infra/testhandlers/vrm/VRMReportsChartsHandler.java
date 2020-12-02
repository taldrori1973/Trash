package com.radware.vision.infra.testhandlers.vrm;

import com.radware.jsonparsers.impl.JsonUtils;
import com.radware.vision.automation.tools.exceptions.web.SessionStorageException;
import org.json.JSONObject;

import java.util.List;
import java.util.Map;

public class VRMReportsChartsHandler extends VRMHandler {
    public Map getSessionStorage(String chart) throws SessionStorageException {
        String result  = "{}";
        JSONObject jsonResult = new JSONObject(new JSONObject(result).get(chart).toString());
        return JsonUtils.getJsonMap(jsonResult.toString());
    }
    public String generateReportAndGetReportID(String reportName) {
        return null;
    }

    public boolean generateStatus(String reportID, int secondsTimeOut) {
        return true;
    }

    public void validateReportResult(String chart, String label, String reportID, List<Data> entries) {
        JSONObject generateResult = getReportGenerateResult(reportID);
//        if (generateResult.has(chart))
//            foundObject = new JSONObject(generateResult.get(chart).toString());
        validateChartDataOfDataSets(chart, label, null, entries);
    }

    protected JSONObject getReportGenerateResult(String reportID) {
        JSONObject generatedReportJSON = new JSONObject();
        return generatedReportJSON;
    }

}
