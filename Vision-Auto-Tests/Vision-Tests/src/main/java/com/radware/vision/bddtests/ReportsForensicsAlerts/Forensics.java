package com.radware.vision.bddtests.ReportsForensicsAlerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers.TemplateHandlers;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.tools.rest.CurrentVisionRestAPI;
import com.radware.vision.vision_project_cli.RootServerCli;
import models.RestResponse;
import models.StatusCode;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.WebElement;

import java.util.*;

public class Forensics extends ReportsForensicsAlertsAbstract {
    @Override
    protected String getType() {
        return "Forensics";
    }
    protected String getRangeTypeTextKey() {return "type";}
    protected String getRelativeRangeTextKey() {
        return "unit";
    }
    protected String getRelativeRangeValueKey() {
        return "count";
    }
    protected String getSchedulingKey() {
        return "schedule";
    }
    protected String getDeliveryKey() {
        return "Share";
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
        WebUiTools.check("Output Tab", "", true);
        selectOutput(map);
        WebUiTools.check("Schedule Tab", "", true);
        selectScheduling(map);
        WebUiTools.check("Format Tab", "", true);
        selectFormat(map);
        WebUiTools.check("Share Tab", "", true);
        selectShare(map);
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
            errorMessage.append(validateTimeDefinition(new JSONObject(basicRestResult.get("timeRangeDefinition").toString()), map, forensicsName));
            errorMessage.append(validateScheduleDefinition(basicRestResult, map, forensicsName));
            errorMessage.append(validateFormatDefinition(new JSONObject(new JSONArray(basicRestResult.get("exportFormats").toString()).get(0).toString()), map));
            errorMessage.append(validateShareDefinition(new JSONObject(basicRestResult.get("deliveryMethod").toString()), map));
        }else errorMessage.append("No Forensics Defined with name ").append(forensicsName).append("/n");
        if (errorMessage.length() != 0)
            BaseTestUtils.report(errorMessage.toString(), Reporter.FAIL);
    }

    protected StringBuilder validateShareDefinition(JSONObject deliveryJson, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey(getDeliveryKey())) {
            if (!new JSONObject(map.get("Share")).isNull("FTP"))
                validateFTP(deliveryJson, map, errorMessage);
            else
                validateStandardEmail(deliveryJson, map, errorMessage);
        }
        return errorMessage;
    }

    private void validateFTP(JSONObject deliveryJson, Map<String, String> map, StringBuilder errorMessage) {
        if (deliveryJson.isNull("ftp"))
            errorMessage.append("The Expected share type is ftp but Actual no FTP in the definition");
        JSONObject ftpActualJSON = new JSONObject(new JSONArray(deliveryJson.get("ftp").toString()).get(0).toString());
        JSONObject ftpExpectedJSON = new JSONObject(map.get("Share"));
        if (!ftpActualJSON.getString("path").equals(ftpExpectedJSON.get("FTP.Path")))
            errorMessage.append("The Expected ftp path is " + ftpExpectedJSON.get("FTP.Path") + " But the actual is " + ftpActualJSON.get("path") + "/n");
        if (!ftpActualJSON.getString("password").equals(ftpExpectedJSON.get("FTP.Password")))
            errorMessage.append("The Expected ftp password is " + ftpExpectedJSON.get("FTP.Password") + " But the actual is " + ftpActualJSON.get("password") + "/n");
        if (!ftpActualJSON.getString("location").equals(ftpExpectedJSON.get("FTP.Location")))
            errorMessage.append("The Expected ftp location is " + ftpExpectedJSON.get("FTP.Location") + " But the actual is " + ftpActualJSON.get("location") + "/n");
        if (!ftpActualJSON.getString("username").equals(ftpExpectedJSON.get("FTP.Username")))
            errorMessage.append("The Expected ftp username is " + ftpExpectedJSON.get("FTP.Username") + " But the actual is " + ftpActualJSON.get("username") + "/n");
    }


    private StringBuilder validateScopeSelection(JSONArray devices) {
        return null;
    }

    protected StringBuilder validateCriteriaDefinition(String criteria) {
        return null;
    }

    protected String getDefaultFormat() {
        return "html";
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
    protected void validateQuickRangeTime(JSONObject timeDefinitionsJSON, StringBuilder errorMessage, JSONObject expectedTimeDefinitions) throws Exception {
        if (!timeDefinitionsJSON.get("type").toString().equalsIgnoreCase("quickTimeRange"))
            errorMessage.append("The rangeType is ").append(timeDefinitionsJSON.get("type")).append(" and not equal to quick").append("\n");
        if (!timeDefinitionsJSON.get("period").toString().equalsIgnoreCase(getQuickTimeAsText(expectedTimeDefinitions.getString("Quick"))))
            errorMessage.append("The value of the quickRange is ").append(timeDefinitionsJSON.get("period")).append(" and not equal to ").append(expectedTimeDefinitions.getString("Quick")).append("\n");
    }

    @Override
    protected void selectFTP(JSONObject deliveryJsonObject) throws Exception {
        BasicOperationsHandler.setTextField("FTP input", "location", deliveryJsonObject.getString("FTP.Location"), false);
        BasicOperationsHandler.setTextField("FTP input", "path", deliveryJsonObject.getString("FTP.Path"), false);
        BasicOperationsHandler.setTextField("FTP input", "username", deliveryJsonObject.getString("FTP.Username"), false);
        BasicOperationsHandler.setTextField("FTP input", "password", deliveryJsonObject.getString("FTP.Password"), false);
    }

    private String getQuickTimeAsText(String period) throws Exception {
        switch (period)
        {
            case "Today":return "Today";
            case "Yesterday":return "Yesterday";
            case "This Month":return "This Month";
            case "1D":return "oneDay";
            case "1W":return "oneWeek";
            case "1M":return "oneMonth";
            case "3M":return "ThreeMonths";
            case "1Y":return "oneYear";
        }
        throw new Exception("No period with name " + period + " in Forensics");
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

    @Override
    protected void selectEmail(JSONObject deliveryJsonObject) throws Exception {
        WebUiTools.check("Share Tab Label", "email", true);
        super.selectEmail(deliveryJsonObject);
    }

}
