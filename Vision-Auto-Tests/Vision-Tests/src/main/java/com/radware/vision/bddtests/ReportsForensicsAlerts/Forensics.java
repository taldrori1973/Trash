package com.radware.vision.bddtests.ReportsForensicsAlerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers.TemplateHandlers;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.tools.rest.CurrentVisionRestAPI;
import com.radware.vision.vision_project_cli.RootServerCli;
import models.RestResponse;
import models.StatusCode;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.WebElement;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Map;

public class Forensics extends ReportsForensicsAlertsAbstract {
    @Override
    protected String getType() {
        return "Forensics";
    }

    @Override
    public void create(String name, String negative, Map<String, String> map) throws Exception {
        closeView(false);
        WebUiTools.check("New Forensics", "", true);
        createForensicsParam(name, map);
        selectScopeSelection(map);
    }

    private void selectScopeSelection(Map<String, String> map) throws Exception {
        switch (map.getOrDefault("Product", "").toLowerCase()) {
            case "defensepro":
                WebUiTools.check("Product", map.get("Product"), true);
            case "":
                if (map.containsKey("devices")) {
                    fixSelectionToArray("devices", map);
                    new TemplateHandlers.DPScopeSelection(new JSONArray(map.get("devices")), "", "DEVICES").create();
                }break;
            case "defenseflow":
                WebUiTools.check("Product", map.get("Product"), true);
                if (map.containsKey("Protected Objects"))
                    new TemplateHandlers.DFScopeSelection(new JSONArray("[" + map.get("Protected Objects") + "]"), "", "PROTECTED OBJECTS").create();
                break;

            case "appwall":
                WebUiTools.check("Product", map.get("Product"), true);
                if (map.containsKey("Applications"))
                    new TemplateHandlers.AWScopeSelection(new JSONArray("[" + map.get("Applications") + "]"), "", "APPLICATIONS").create();
                break;
        }
    }

    private void fixSelectionToArray(String selectionType, Map<String, String> map) {
        try {
            new JSONArray(map.get(selectionType));
        } catch (Exception e) {
            map.put(selectionType, new JSONArray().put(0, map.get(selectionType)).toString());
        }

    }

    private void createForensicsParam(String name, Map<String, String> map) throws Exception {
        WebUiTools.check("Name Tab", "", true);
        createName(name, map);
        WebUiTools.check("Time Tab", "", true);
        selectTime(map);
        WebUiTools.check("Schedule Tab", "", true);
        selectScheduling(map);
        WebUiTools.check("Format Tab", "", true);
        selectFormat(map);
        WebUiTools.check("Share Tab", "", true);
        selectShare(map);
//        WebUiTools.check("Output Tab", "", true);
        selectOutput(map);
    }

    public void selectOutput(Map<String, String> map) throws Exception {
        WebUiTools.check("outputExpandOrCollapse", "", true);
        ArrayList expectedOutputs = new ArrayList<>(Arrays.asList(map.get("Output").split(",")));
        if (expectedOutputs.size() == 1 && expectedOutputs.get(0).toString().equalsIgnoreCase(""))
            expectedOutputs.remove(0);

        for(WebElement outputElement : WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId("forensics_output_").getBy()))
        {
            String outputText = outputElement.getText();
            if (expectedOutputs.contains(outputText))
            {
                WebUiTools.check("outputValue", outputText, true);
                expectedOutputs.remove(outputText);
            }
            else WebUiTools.check("outputValue", outputText, false);
        }

        if (expectedOutputs.size()>0)
            throw new Exception("The outputs " + expectedOutputs + " don't exist in the outputs");
    }

    private void createName(String name, Map<String, String> map) throws Exception {
        super.createName(name);
        if (map.containsKey("Description"))
            BasicOperationsHandler.setTextField(getType() + " Description", "", map.get("Description"), true);
    }

    @Override
    public void validate(RootServerCli rootServerCli, String forensicsName, Map<String, String> map) throws Exception {
        StringBuilder errorMessage = new StringBuilder();
        JSONObject basicRestResult = getForensicsDefinition(forensicsName, map);
        if (basicRestResult!=null)
        {
            errorMessage.append(validateTimeDefinition(new JSONObject(basicRestResult.get("timeRageDefinition").toString()), map));
            errorMessage.append(validateCriteriaDefinition(new JSONObject(basicRestResult.get("criteria").toString())));
            errorMessage.append(validateScheduleDefinition(basicRestResult, map, forensicsName));
            errorMessage.append(validateFormatDefinition(new JSONObject(basicRestResult.get("exportFormat").toString()), map));
            errorMessage.append(validateShareDefinition(new JSONObject(basicRestResult.get("deliveryMethod").toString()), map));
            errorMessage.append(validateScopeSelection(new JSONArray(map.get("devices"))));
        }else errorMessage.append("No report Defined with name ").append(forensicsName).append("/n");
        if (errorMessage.length() != 0)
            BaseTestUtils.report(errorMessage.toString(), Reporter.FAIL);
    }

    private StringBuilder validateScopeSelection(JSONArray devices) {
        return null;
    }

    protected StringBuilder validateCriteriaDefinition(JSONObject criteria) {
        return null;
    }

    private StringBuilder validateFormatDefinition(JSONObject exportFormat, Map<String, String> map) {
        return null;
    }

    private JSONObject getForensicsDefinition(String forensicsName, Map<String, String> map) throws Exception {
        RestResponse restResponse = new CurrentVisionRestAPI("Vision/newForensics.json", "Get Created Forensics").sendRequest();
        if (restResponse.getStatusCode()== StatusCode.OK)
        {
            JSONArray forensicsJSONArray = new JSONArray(restResponse.getBody().getBodyAsString());
            for(Object reportJsonObject : forensicsJSONArray)
            {
                if (new JSONObject(reportJsonObject.toString()).getString("name").equalsIgnoreCase(forensicsName))
                {
                    CurrentVisionRestAPI currentVisionRestAPI = new CurrentVisionRestAPI("Vision/newForensics.json", "Get specific Forensics");
                    currentVisionRestAPI.getRestRequestSpecification().setPathParams(Collections.singletonMap("ForensicsID", new JSONObject(reportJsonObject.toString()).getString("id")));
                    restResponse = currentVisionRestAPI.sendRequest();
                    if (restResponse.getStatusCode() == StatusCode.OK)
                        return new JSONObject(restResponse.getBody().getBodyAsString());
                    else throw new Exception("Get specific Forensics request failed, The response is " + restResponse);
                }
            }

            throw new Exception("No Report with Name " + forensicsName);
        }
        else throw new Exception("Get Reports failed request, The response is " + restResponse);
    }

    @Override
    public void edit(String viewBase, Map<String, String> map) throws Exception {

    }
}
