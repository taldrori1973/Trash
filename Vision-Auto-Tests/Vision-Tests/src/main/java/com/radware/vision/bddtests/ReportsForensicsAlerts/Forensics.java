package com.radware.vision.bddtests.ReportsForensicsAlerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers.TemplateHandlers;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.tests.BasicOperations.BasicOperations;
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
        WebUiTools.check("New Forensics Tab", "", true);
        createForensicsParam(name, map);
        selectScopeSelection(map);
        BasicOperationsHandler.clickButton("save");
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
                WebUiTools.check("Output Value", outputText, true);
                expectedOutputs.remove(outputText);
            }
            else WebUiTools.check("Output Value", outputText, false);
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
            errorMessage.append(validateTimeDefinition(new JSONObject(basicRestResult.get("timeRangeDefinition").toString()), map));
//            errorMessage.append(validateTimeDefinition(new JSONObject(basicRestResult.get("timeRageDefinition").toString()), map));
//            errorMessage.append(validateCriteriaDefinition(new JSONObject(basicRestResult.get("criteria").toString())));
//            errorMessage.append(validateCriteriaDefinition(new JSONObject(new JSONObject(basicRestResult.get("request").toString()).toString()).get("criteria").toString()));
            errorMessage.append(validateScheduleDefinition(basicRestResult, map, forensicsName));
//            errorMessage.append(validateFormatDefinition(new JSONObject(basicRestResult.get("exportFormat").toString()), map));
            errorMessage.append(validateFormatDefinition(new JSONObject(new JSONArray(basicRestResult.get("exportFormats").toString()).get(0).toString()), map));
            errorMessage.append(validateShareDefinition(new JSONObject(basicRestResult.get("deliveryMethod").toString()), map));
//            errorMessage.append(validateScopeSelection(new JSONArray(map.get("devices"))));
            //new JSONArray(basicRestResult.get("deviceScopes").toString())
        }else errorMessage.append("No Forensics Defined with name ").append(forensicsName).append("/n");
        if (errorMessage.length() != 0)
            BaseTestUtils.report(errorMessage.toString(), Reporter.FAIL);
    }



    private StringBuilder validateScopeSelection(JSONArray devices) {
        return null;
    }

    protected StringBuilder validateCriteriaDefinition(String criteria) {
        return null;
    }

    @Override
    protected StringBuilder validateDefaultFormatDefinition(JSONObject exportFormat, Map<String, String> map ) {
        StringBuilder errorMessage = new StringBuilder();
        if (exportFormat.get("type").toString().trim().toLowerCase().equalsIgnoreCase("html"))
            errorMessage.append("The actual Format is: ").append(exportFormat.get("type").toString()).append("but the Expected format is: ").append("html").append("\n");
        return errorMessage;
    }

    protected void editShareDefinition(Map<String, String> map ) throws Exception {
        if (map.containsKey("Share")) {
            JSONObject deliveryJsonObject = new JSONObject(map.get("Share"));
            if (deliveryJsonObject.has("Email"))
                editShare(map);
            else if (deliveryJsonObject.has("FTP")) {
                WebUiTools.check("Share Tab Label", "ftp", true);
                editFTPShare(map);
            }
        }
    }

    private void editFTPShare(Map<String, String> map) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.setTextField("FTP input", "location", "", true);
        BasicOperationsHandler.setTextField("FTP input", "path", "", true);
        BasicOperationsHandler.setTextField("FTP input", "username", "", true);
        BasicOperationsHandler.setTextField("FTP input", "password", "", true);

      //  selectShare(map);
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
    public void edit(String forensicsName, Map<String, String> map) throws Exception {
        try {
            WebUiTools.getWebElement("Edit Forensics",forensicsName).click();
            editForensicsParameters(forensicsName, map);
            editScopeSelection(map,forensicsName);
            BasicOperationsHandler.clickButton("save");
        } catch (Exception e) {
            cancelView();
            throw e;
        }
//        if (!viewCreated(forensicsName)) {
//            cancelView();
//            throw new Exception("");
//        }
    }

    private void editForensicsParameters(String forensicsName, Map<String, String> map) throws Exception {
        WebUiTools.check("Name Tab", "", true);
        editName(map, forensicsName);
        WebUiTools.check("Time Tab", "", true);
        editTime(map);
        WebUiTools.check("Schedule Tab", "", true);
        editScheduling(map);
        WebUiTools.check("Share Tab", "", true);
        editShareDefinition(map);
        WebUiTools.check("Format Tab", "", true);
        editFormat(map);
        WebUiTools.check("Criteria Tab", "", true);
        editCriteria(map);
        WebUiTools.check("Output Tab", "", true);
        editOutput(map);
    }

    private void editOutput(Map<String, String> map) throws Exception {
        if (map.containsKey("Output"))
            selectOutput(map);
    }



    private void editCriteria(Map<String, String> map) throws Exception {
        if (map.containsKey("Criteria")) {
        }
    }
    private void editFormat(Map<String, String> map) throws Exception {
        if (map.containsKey("Format")) {
            BasicOperationsHandler.clickButton("Format Type", "HTML");
            selectFormat(map);
        }
    }

    private void editScopeSelection(Map<String, String> map,String reportName) throws Exception{
        if (map.containsKey("devices"))
            selectScopeSelection(map);
    }
    
}
