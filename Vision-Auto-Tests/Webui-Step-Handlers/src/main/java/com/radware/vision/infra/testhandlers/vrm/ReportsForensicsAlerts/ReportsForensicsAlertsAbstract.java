package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers.SelectTimeHandlers;
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
import static com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.WebUiTools.getWebElement;

import com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers.SelectScheduleHandlers;


abstract class ReportsForensicsAlertsAbstract implements ReportsForensicsAlertsInterface {
    public static LocalDateTime timeDefinitionLocalDateTime;

    StringBuilder errorMessages = new StringBuilder();
    private static Map<String, LocalDateTime> schedulingDates = new HashMap<>();
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
                    SelectTimeHandlers.selectAbsoluteTime(timeDefinitionJSONObject);
                    break;
                case "Relative":
                    SelectTimeHandlers.selectRelativeTime(timeDefinitionJSONObject);
                    break;
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
            errorMessage.append("The rangeType is " + timeDefinitions.get("rangeType") + " and not equal to relative").append("\n");
        if (!timeDefinitions.get("relativeRange").toString().equalsIgnoreCase(new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(0).toString()))
            errorMessage.append("The relative range is " + timeDefinitions.get("relativeRange") + " and not " + new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(0).toString()).append("\n");
        if (!timeDefinitions.get("relativeRangeValue").toString().equalsIgnoreCase(new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(1).toString()))
            errorMessage.append("The relativeRangeValue is " + timeDefinitions.get("relativeRangeValue") + " and not " + new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(1).toString()).append("'n");
    }

    private void validateAbsoluteTime(JSONObject timeDefinitions, StringBuilder errorMessage, JSONObject expectedTimeDefinitions) {
        if (expectedTimeDefinitions.get("Absolute").toString().matches(("[\\+|\\-]\\d+[M|d|y|H|m]"))) {
            if (!timeDefinitions.get("rangeType").toString().equalsIgnoreCase("absolute"))
                errorMessage.append("The rangeType is " + timeDefinitions.get("rangeType") + " and not equal to Absolute").append("\n");

//            Date actualDate = new Date(new Long(timeDefinitions.get("to").toString()));
//            SimpleDateFormat absoluteFormatter = new SimpleDateFormat("dd.MM.YYYY HH:mm:ss");
//            String actualAbsoluteText = absoluteFormatter.format(actualDate);
//            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd.MM.YYYY HH:mm:ss");
//            String expectedAbsoluteText = timeDefinitionLocalDateTime.format(formatter);

            //toDo: check to and from time !!!!!!!!!!!!
            LocalDateTime actualDate = LocalDateTime.ofInstant(Instant.ofEpochMilli(new Long(timeDefinitions.get("to").toString())), ZoneId.systemDefault());
            DateTimeFormatter absoluteFormatter = DateTimeFormatter.ofPattern("MMM dd, yyyy HH:mm");
            if (!actualDate.format(absoluteFormatter).equalsIgnoreCase(timeDefinitionLocalDateTime.format(absoluteFormatter)))
                errorMessage.append("the Actual absolute time is " + actualDate + " but the expected is " + timeDefinitionLocalDateTime).append("\n");
        }
    }

    private void validateQuickRangeTime(JSONObject timeDefinitionsJSON, StringBuilder errorMessage, JSONObject expectedTimeDefinitions) {
        if (!timeDefinitionsJSON.get("rangeType").toString().equalsIgnoreCase("quick"))
            errorMessage.append("The rangeType is " + timeDefinitionsJSON.get("rangeType") + " and not equal to quick").append("\n");
        if (!timeDefinitionsJSON.get("quickRangeSelection").toString().equalsIgnoreCase(expectedTimeDefinitions.getString("Quick")))
            errorMessage.append("The value of the quickRange is " + timeDefinitionsJSON.get("quickRangeSelection") + " and not equal to " + expectedTimeDefinitions.getString("Quick")).append("\n");
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

    protected void selectScopeSelection() {

    }

    protected StringBuilder validateScheduleDefinition(JSONObject schedulingDefinitionJson, Map<String, String> map, String name) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Schedule")) {
            JSONObject expectedScheduleJson = new JSONObject(map.get("Schedule"));
            String actualType = schedulingDefinitionJson.get("type").toString();
            String expectedType = expectedScheduleJson.get("Run Every").toString();
            if (!expectedType.equalsIgnoreCase(actualType))
                errorMessage.append("The Actual schedule type is " + actualType + " but the Expected type is " + expectedType).append("\n");
            else
                SelectScheduleHandlers.validateScheduling(expectedType, schedulingDefinitionJson, expectedScheduleJson, errorMessage, schedulingDates, getType() + "_" + name);
        }
        return errorMessage;
    }

    protected abstract String getType();


    public void baseOperation(vrmActions operationType, String name, Map<String, String> entry, RootServerCli rootServerCli) throws Exception {
        Map<String, String> map = null;
        if (operationType != vrmActions.GENERATE)
            map = CustomizedJsonManager.fixJson(entry);
        fixMapToSupportWithOldDesign(map);

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

    private void fixMapToSupportWithOldDesign(Map<String, String> map) {
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
            newTemplateObject.put(map.get(key));
            map.remove(key);
        }
        map.put("Template", newTemplateObject.toString());
    }

    public void generate(String name){}


}
