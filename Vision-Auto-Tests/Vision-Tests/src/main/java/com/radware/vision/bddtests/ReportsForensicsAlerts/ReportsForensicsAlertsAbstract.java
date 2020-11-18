package com.radware.vision.bddtests.ReportsForensicsAlerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers.SelectTimeHandlers;
import com.radware.vision.infra.testhandlers.vrm.enums.vrmActions;
import com.radware.vision.infra.utils.json.CustomizedJsonManager;
import com.radware.vision.vision_project_cli.RootServerCli;
import org.json.JSONArray;
import org.json.JSONObject;

import java.time.LocalDateTime;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.*;

import static com.radware.vision.infra.testhandlers.BaseHandler.restTestBase;
import static com.radware.vision.bddtests.ReportsForensicsAlerts.WebUiTools.getWebElement;

import com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers.SelectScheduleHandlers;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;


abstract class ReportsForensicsAlertsAbstract implements ReportsForensicsAlertsInterface {
    public static LocalDateTime timeDefinitionLocalDateTime;

    StringBuilder errorMessages = new StringBuilder();
    private static Map<String, LocalDateTime> schedulingDates = new HashMap<>();
    private static Map<String, JSONObject> timeAbsoluteDates = new HashMap<>();
    protected static Map<String, Map<String,String>> templates = new HashMap<>();
    private String name;


    protected void createName(String name) throws Exception {
        BasicOperationsHandler.setTextField("Report Name", "", name, true);
        if (!getWebElement("Report Name").getAttribute("value").equals(name))
            throw new Exception("Filling report name doesn't succeed");
        this.name = name;
    }

    protected void editName(String name) throws Exception {
        createName(name);
    }

    protected void selectTime(Map<String, String> map) throws Exception {
        if (map.containsKey("Time Definitions.Date")) {
            JSONObject timeDefinitionJSONObject = new JSONObject(map.get("Time Definitions.Date"));

            switch (SelectTimeHandlers.getTypeSelectedTime(timeDefinitionJSONObject)) {
                case "Quick":
                    SelectTimeHandlers.selectQuickTime(timeDefinitionJSONObject);
                    break;
                case "Absolute":
                    SelectTimeHandlers.selectAbsoluteTime(timeDefinitionJSONObject , timeAbsoluteDates, getType() + "_" + name);
                    break;
                case "Relative":
                    SelectTimeHandlers.selectRelativeTime(timeDefinitionJSONObject);
                    break;
                case "":
                default:
                    BaseTestUtils.report("The time definition should be or Quick or Absolute or Relative not " + timeDefinitionJSONObject.toString(), Reporter.FAIL);
            }
        }
    }


    protected void editTime(Map<String, String> map) throws Exception {
        selectTime(map);
    }


    protected void selectScheduling(Map<String, String> map) throws Exception {
        if (map.containsKey("Schedule")) {
            JSONObject scheduleJson = new JSONObject(map.getOrDefault("Schedule", null));
            WebUiTools.check("Switch button Scheduled Report", "", true);
            String runEvery = scheduleJson.getString("Run Every");
            BasicOperationsHandler.clickButton("Schedule Report", runEvery.toLowerCase()); //daily/weekly/monthly/once
            SelectScheduleHandlers.selectScheduling(runEvery, scheduleJson, schedulingDates, getType() + "_" + name);
        }
    }

    protected void editScheduling(Map<String, String> map) throws Exception {
        WebUiTools.check("Switch button Scheduled Report", "", false);
        selectScheduling(map);
    }

    protected StringBuilder validateTimeDefinition(JSONObject timeDefinitionsJSON, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Time Definitions.Date")) {
            JSONObject expectedTimeDefinitions = new JSONObject(map.get("Time Definitions.Date"));

            switch (SelectTimeHandlers.getTypeSelectedTime(expectedTimeDefinitions).toLowerCase()) {
                case "quick":
                    validateQuickRangeTime(timeDefinitionsJSON, errorMessage, expectedTimeDefinitions);
                    break;
                case "absolute":
                    validateAbsoluteTime(timeDefinitionsJSON, errorMessage, expectedTimeDefinitions);
                    break;
                case "relative":
                    validateRelativeTime(timeDefinitionsJSON, errorMessage, expectedTimeDefinitions);
                    break;
                default:
                    BaseTestUtils.report("The time definition should be or Quick or Absolute or Relative not " + timeDefinitionsJSON.toString(), Reporter.FAIL);
            }
        }
        return errorMessage;
    }

    private void validateRelativeTime(JSONObject timeDefinitions, StringBuilder errorMessage, JSONObject expectedTimeDefinitions) {
        if (!timeDefinitions.get("rangeType").toString().equalsIgnoreCase("relative"))
            errorMessage.append("The rangeType is ").append(timeDefinitions.get("rangeType")).append(" and not equal to relative").append("\n");
        if (!timeDefinitions.get("relativeRange").toString().equalsIgnoreCase(new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(0).toString()))
            errorMessage.append("The relative range is ").append(timeDefinitions.get("relativeRange")).append(" and not ").append(new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(0).toString()).append("\n");
        if (!timeDefinitions.get("relativeRangeValue").toString().equalsIgnoreCase(new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(1).toString()))
            errorMessage.append("The relativeRangeValue is ").append(timeDefinitions.get("relativeRangeValue")).append(" and not ").append(new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(1).toString()).append("'n");
    }

    private void validateAbsoluteTime(JSONObject timeDefinitions, StringBuilder errorMessage, JSONObject expectedTimeDefinitions) {
        if (expectedTimeDefinitions.get("Absolute").toString().matches(("[\\+|\\-]\\d+[M|d|y|H|m]"))) {
            if (!timeDefinitions.get("rangeType").toString().equalsIgnoreCase("absolute"))
                errorMessage.append("The rangeType is ").append(timeDefinitions.get("rangeType")).append(" and not equal to Absolute").append("\n");
            //toDo: check to and from time !!!!!!!!!!!!
            LocalDateTime actualDate = LocalDateTime.ofInstant(Instant.ofEpochMilli(new Long(timeDefinitions.get("to").toString())), ZoneId.systemDefault());
            DateTimeFormatter absoluteFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
            if (!actualDate.format(absoluteFormatter).equalsIgnoreCase(timeDefinitionLocalDateTime.format(absoluteFormatter)))
                errorMessage.append("the Actual absolute time is ").append(actualDate).append(" but the expected is ").append(timeDefinitionLocalDateTime).append("\n");
        }
    }

    private void validateQuickRangeTime(JSONObject timeDefinitionsJSON, StringBuilder errorMessage, JSONObject expectedTimeDefinitions) {
        if (!timeDefinitionsJSON.get("rangeType").toString().equalsIgnoreCase("quick"))
            errorMessage.append("The rangeType is ").append(timeDefinitionsJSON.get("rangeType")).append(" and not equal to quick").append("\n");
        if (!timeDefinitionsJSON.get("quickRangeSelection").toString().equalsIgnoreCase(expectedTimeDefinitions.getString("Quick")))
            errorMessage.append("The value of the quickRange is ").append(timeDefinitionsJSON.get("quickRangeSelection")).append(" and not equal to ").append(expectedTimeDefinitions.getString("Quick")).append("\n");
    }

    protected void selectShare(Map<String, String> map) throws Exception {
        if (map.containsKey("Share")) {
            JSONObject deliveryJsonObject = new JSONObject(map.get("Share"));
            if (deliveryJsonObject.has("Email")) {
                for (String email : fixEmailsText(deliveryJsonObject))
                    BasicOperationsHandler.setTextField("Email", email, true);
                BasicOperationsHandler.setTextField("Subject", deliveryJsonObject.getString("Subject"));
                if (deliveryJsonObject.has("Body")) {
                    BasicOperationsHandler.setTextField("Email message", deliveryJsonObject.getString("Body"));
                }
            }
        }
    }

    protected void editShare(Map<String, String> map) throws Exception {
        BasicOperationsHandler.setTextField("Email", "");
        BasicOperationsHandler.setTextField("Subject", "");
        BasicOperationsHandler.setTextField("Email message", "");
        selectShare(map);
    }

    private List<String> fixEmailsText(JSONObject deliveryJsonObject) {
        String eMailsText = deliveryJsonObject.getJSONArray("Email").toString().replaceAll("(])|(\\[)|(\")", "").replaceAll("\\s", "");
        List<String> emailList = Arrays.asList(eMailsText.split(","));
        emailList.forEach(mail -> {
            if (!mail.contains("@"))
                emailList.set(emailList.indexOf(mail), String.format("%s@%s.local", mail, restTestBase.getRootServerCli().getHost()));
        });
        return emailList;
    }

    protected StringBuilder validateScheduleDefinition(JSONObject schedulingDefinitionJson, Map<String, String> map, String name) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Schedule")) {
            JSONObject actualSchedule = new JSONObject(schedulingDefinitionJson.get("scheduling").toString());
            JSONObject expectedScheduleJson = new JSONObject(map.get("Schedule"));
            String actualType = actualSchedule.get("type").toString();
            String expectedType = expectedScheduleJson.get("Run Every").toString();
            if (!expectedType.equalsIgnoreCase(actualType))
                errorMessage.append("The Actual schedule type is ").append(actualType).append(" but the Expected type is ").append(expectedType).append("\n");
            else
                SelectScheduleHandlers.validateScheduling(expectedType, actualSchedule, expectedScheduleJson, errorMessage, schedulingDates, getType() + "_" + name);
        }
        return errorMessage;
    }

    protected abstract String getType();


    public void baseOperation(vrmActions operationType, String name, Map<String, String> entry, RootServerCli rootServerCli) throws Exception {
        Map<String, String> map = null;
        if (operationType != vrmActions.GENERATE)
            map = CustomizedJsonManager.fixJson(entry);
        if (isOldDesign(map))
            fixMapToSupportOldDesign(map);
        fixTemplateMap(map);

        switch (operationType.name().toUpperCase()) {
            case "CREATE":
                create(name, map);
                break;
            case "VALIDATE":
                validate(rootServerCli, name, map);
                break;
            case "EDIT":
                edit(name, map);
                break;
            case "GENERATE":
                generate(name);
                break;
            case "ISEXIST":
                break;
        }
    }

    private boolean isOldDesign(Map<String, String> map) {
        for (String key : map.keySet())
            if (key.matches("reportType|Design|devices|webApplications|Customized Options|projectObjects")) return true;
        return false;
    }

    private void fixMapToSupportOldDesign(Map<String, String> map) {
        JSONObject templateJSON = new JSONObject();
        fixOldMapObject(map, templateJSON, "reportType", "reportType", map.get("reportType"));
        fixOldMapObject(map, templateJSON, "Design", "Widgets", map.containsKey("Design")?new JSONObject(map.get("Design")).toMap().getOrDefault("Add",new JSONObject(map.get("Design")).toMap().getOrDefault("Widgets", "").toString()):"");
        fixOldMapObject(map, templateJSON, "devices", "devices", map.get("devices"));
        fixOldMapObject(map, templateJSON, "webApplications", "Applications", "[" + map.get("webApplications") + "]");
        fixOldMapObject(map, templateJSON, "projectObjects", "Project Objects", "[" + map.get("projectObjects") + "]");
        if (map.containsKey("Customized Options")){
            if (new JSONObject(map.get("Customized Options")).has("showTable"))
                templateJSON.put("showTable", new JSONObject(map.get("Customized Options")).get("showTable"));
            if(new JSONObject(map.get("Customized Options")).has("addLogo"))
                map.put("Logo", new JSONObject(map.get("Customized Options")).get("addLogo").toString());
            map.remove("Customized Options");
        }
        map.put("Template", templateJSON.toString());
    }


    private void fixOldMapObject(Map<String, String> map, JSONObject templateJSON, String oldMapKey, String newJSONKey, Object newJSONValue)
    {
        if (map.containsKey(oldMapKey))
        {
            templateJSON.put(newJSONKey, newJSONValue);
            map.remove(oldMapKey);
        }
    }

    private void fixTemplateMap(Map<String, String> map) {
        fixNewTemplate(map);
    }

    private void fixNewTemplate(Map<String, String> map) {
        ArrayList templateKeys = new ArrayList();
        map.keySet().forEach(key->
        {
            if (key.contains("Template"))
                templateKeys.add(key);
        });
        JSONArray newTemplateObject = new JSONArray();
        for(Object key : templateKeys){
            newTemplateObject.put(new JSONObject(map.get(key)).put("templateAutomationID", key));
            map.remove(key);
        }
        map.put("Template", newTemplateObject.toString());
    }

    public void generate(String name){}

    @Override
    public void delete(String reportName) throws Exception{

        try{
            WebUiTools.check("My Reports Tab", "", true);
            //click on delete icon
            deleteReport("Delete Report",reportName);
            //click on validate delete report
            confirmDeleteReport("confirm Delete Report",reportName);

            if(templates.containsValue(getType() + "_" + reportName)){
                templates.remove(getType() + "_" + reportName);
            }

            if(timeAbsoluteDates.containsValue(getType() + "_" + reportName)){
                timeAbsoluteDates.remove(getType() + "_" + reportName);
            }

            if (schedulingDates.containsValue(getType() + "_" + reportName)){
                schedulingDates.remove(getType() + "_" + reportName);
            }

            // validate that report not exist in list
        }catch (Exception e){

        }
    }


    private static WebElement deleteReport(String label, String params) throws TargetWebElementNotFoundException {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()) == null) {
            throw new TargetWebElementNotFoundException("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId());
        }
        return WebUIVisionBasePage.getCurrentPage().getContainer().getButton(label).click();
    }

    private static WebElement confirmDeleteReport(String label, String params) throws TargetWebElementNotFoundException {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams(params);
        if (WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()) == null) {
            throw new TargetWebElementNotFoundException("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId());
        }
        // return WebUIVisionBasePage.getCurrentPage().getContainer().getButton(label).click();
        return WebUIVisionBasePage.getCurrentPage().getContainer().getButton( "//*[@data-debug-id='" + VisionDebugIdsManager.getDataDebugId() +"']//span[@data-debug-id='confirmation-box-delete-button-label']").click();

    }

}
