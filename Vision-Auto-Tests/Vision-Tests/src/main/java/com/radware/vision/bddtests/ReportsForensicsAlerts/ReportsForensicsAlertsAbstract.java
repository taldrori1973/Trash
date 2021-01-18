package com.radware.vision.bddtests.ReportsForensicsAlerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.base.pages.navigation.WebUIVisionBasePage;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers.SelectTimeHandlers;
import com.radware.vision.infra.testhandlers.vrm.enums.vrmActions;
import com.radware.vision.infra.utils.json.CustomizedJsonManager;
import com.radware.vision.vision_project_cli.RootServerCli;
import org.apache.commons.collections.map.HashedMap;
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
    public static final Map<String, Integer> widgets;
    static {
        Map<String, Integer> templateWidgets= new HashMap<>();
        templateWidgets.put("DefensePro Analytics",18);
        templateWidgets.put("DefensePro Behavioral Protections",20);
        templateWidgets.put("HTTPS Flood",1);
        templateWidgets.put("DefenseFlow Analytics",13);
        templateWidgets.put("AppWall",7);
        templateWidgets.put("EAAF",5);
        templateWidgets.put("System and Network",1);
        templateWidgets.put("Application",6);
        widgets = Collections.unmodifiableMap(templateWidgets);
    }

    protected void createName(String name) throws Exception {
        BasicOperationsHandler.setTextField("Report Name", "", name, true);
        if (!getWebElement("Report Name").getAttribute("value").equals(name))
            throw new Exception("Filling report name doesn't succeed");
        this.name = name;
    }

    protected void editName(Map<String, String> map, String reportName) throws Exception {
        if (map.containsKey("New Report Name")) {
            createName(map.get("New Report Name"));
        }
        else name = reportName;
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
        if (map.containsKey("Time Definitions.Date"))
            selectTime(map);
    }


    protected void selectScheduling(Map<String, String> map) throws Exception {
        if (map.containsKey("Schedule")) {
            JSONObject scheduleJson = new JSONObject(map.getOrDefault("Schedule", null));
            WebUiTools.check("Switch button Scheduled Report", "", true);
            WebUIUtils.sleep(1);
            if (!WebUiTools.isElementChecked(WebUiTools.getWebElement("Switch button Scheduled Report")))
                WebUiTools.check("Switch button Scheduled Report", "", true);
            String runEvery = scheduleJson.getString("Run Every");
            BasicOperationsHandler.clickButton("Schedule Report", runEvery.toLowerCase()); //daily/weekly/monthly/once
            SelectScheduleHandlers.selectScheduling(runEvery, scheduleJson, schedulingDates, getType() + "_" + name);
        }
    }

    protected void editScheduling(Map<String, String> map) throws Exception {
        if (map.containsKey("Schedule")) {
            WebUiTools.check("Switch button Scheduled Report", "", false);
            selectScheduling(map);
        }
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
        if (map.containsKey("Share")) {
            BasicOperationsHandler.setTextField("Email", "");
            BasicOperationsHandler.setTextField("Subject", "");
            BasicOperationsHandler.setTextField("Email message", "");
            selectShare(map);
        }
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


    public void baseOperation(vrmActions operationType, String name,String negative, Map<String, String> entry, RootServerCli rootServerCli) throws Exception {
        Map<String, String> map = null;
        if (operationType != vrmActions.GENERATE) {
            map = CustomizedJsonManager.fixJson(entry);
            if (isOldDesign(map)) {
                fixMapToSupportOldDesign(name, map);
            }
            fixTemplateMap(map);
        }
        switch (operationType.name().toUpperCase()) {
            case "CREATE":
                create(name,negative, map);
                break;
            case "VALIDATE":
                validate(rootServerCli, name, map);
                break;
            case "EDIT":
                edit(name, map);
                break;
            case "GENERATE":
                generate(name, entry);
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

    private void fixMapToSupportOldDesign(String reportName,Map<String, String> map) {
        JSONObject templateJSON = new JSONObject();
        fixOldMapObject(map, templateJSON, "reportType", "reportType", map.containsKey("reportType")?map.get("reportType").contains("DefensePro Ana")?"DefensePro Analytics": map.get("reportType").replaceAll("s Dashboard", "s").trim().replaceAll(" Dashboard", "s"):"DefensePro Analytics");
        fixOldMapObject(map, templateJSON, "Design", "Widgets", map.containsKey("Design")?new JSONObject(map.get("Design")).toMap().getOrDefault("Add",new JSONObject(map.get("Design")).toMap().getOrDefault("Widgets", "").toString()):"");
        String devicesText = "";
        if (map.containsKey("devices"))
            devicesText = map.get("devices").replaceAll("index", "deviceIndex").replaceAll("ports", "devicePorts").replaceAll("policies", "devicePolicies");
        fixOldMapObject(map, templateJSON, "devices", "devices", "[" + devicesText + "]");
        fixOldMapObject(map, templateJSON, "webApplications", "Applications", "[" + map.get("webApplications") + "]");
        fixOldMapObject(map, templateJSON, "projectObjects", "Project Objects", "[" + map.get("projectObjects") + "]");
        if (map.containsKey("policy"))
        {
            JSONObject policy = new JSONObject(map.get("policy"));
            fixOldMapObject(map, templateJSON, "policy", "Servers", "[" + policy.get("serverName") + "-" + policy.get("deviceName") + "-" + policy.get("policyName") + "]");
        }
        if (map.containsKey("Customized Options")){
            if (new JSONObject(map.get("Customized Options")).has("showTable"))
                templateJSON.put("showTable", new JSONObject(map.get("Customized Options")).get("showTable"));
            if(new JSONObject(map.get("Customized Options")).has("addLogo"))
                map.put("Logo", new JSONObject(map.get("Customized Options")).get("addLogo").toString());
            map.remove("Customized Options");
        }
        if(!templateJSON.has("reportType"))
        {
             templateJSON.put("reportType", "DefensePro Analytics");
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

    public void generate(String name, Map<String, String> map) throws Exception {
        BasicOperationsHandler.setTextField("Search Report", name);
        BasicOperationsHandler.clickButton("My Report", name);
        String oldDate = "";
        String[] generateReportParam = {name, "0"};
        if (WebUiTools.getWebElement("Views.reportIndex", generateReportParam) != null)
            oldDate = WebUiTools.getWebElement("Views.reportIndex", generateReportParam).getText();
        BasicOperationsHandler.clickButton("Generate Report Manually", name);

        int remainWaitingInSeconds = Integer.valueOf(map.get("timeOut"));
        while (WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//*[@data-debug-id='list-item_" + name + "']//div[@class='loading-dots--dot-red']").getBy()) != null && remainWaitingInSeconds > 0)
        {
            WebUIUtils.sleep(1);
            remainWaitingInSeconds--;
        }
        remainWaitingInSeconds = 20;
        while (oldDate.equalsIgnoreCase(WebUiTools.getWebElement("Views.reportIndex", generateReportParam).getText()) && remainWaitingInSeconds > 0)
        {
            WebUIUtils.sleep(1);
            remainWaitingInSeconds--;
        }
        if (oldDate.equalsIgnoreCase(WebUiTools.getWebElement("Views.reportIndex", generateReportParam).getText()))
            throw new Exception("Generate " + name + " report has failed");
    }

    @Override
    public void delete(String reportName) throws Exception{

            WebUiTools.check("My Reports Tab", "", true);
            BasicOperationsHandler.clickButton("Delete Report",reportName);
            confirmDeleteReport("confirm Delete Report",reportName);
            clearSavedReportInMap(reportName);
            WebUIUtils.sleep(3);
            if(!BasicOperationsHandler.isElementExists("My Report", false, reportName)){
                BaseTestUtils.report("Failed to delete report name: " + reportName, Reporter.FAIL);
        }

    }

    public void deletionReportInstance(String label, String params) throws Exception{
        VisionDebugIdsManager.setLabel("Show Report Time Generated");
        VisionDebugIdsManager.setParams(params);
        String TimeReport =WebUIUtils.fluentWait(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).getText();
        BasicOperationsHandler.clickButton("Deletion Report Instance",params);
        confirmDeleteReport("confirm Delete Report",params.split("_")[0]);
        WebUIUtils.sleep(3);
        VisionDebugIdsManager.setLabel("Show Report Time Generated");
        VisionDebugIdsManager.setParams(params);
        WebElement element = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (element != null && element.getText().equalsIgnoreCase(TimeReport))
            BaseTestUtils.report("No Report Generate at this time" +TimeReport, Reporter.FAIL);
    }

    public static void confirmDeleteReport(String label, String params) throws TargetWebElementNotFoundException {

        if (WebUiTools.getWebElement(label,params) == null) {
            throw new TargetWebElementNotFoundException("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId());
        }
         WebUIVisionBasePage.getCurrentPage().getContainer().getButton( "//*[@data-debug-id='" + VisionDebugIdsManager.getDataDebugId() +"']//span[@data-debug-id='confirmation-box-delete-button-label']").click();

    }

    private void clearSavedReportInMap(String reportName){

        if(templates.containsValue(getType() + "_" + reportName)){
            templates.remove(getType() + "_" + reportName);
        }

        if(timeAbsoluteDates.containsValue(getType() + "_" + reportName)){
            timeAbsoluteDates.remove(getType() + "_" + reportName);
        }

        if (schedulingDates.containsValue(getType() + "_" + reportName)){
            schedulingDates.remove(getType() + "_" + reportName);
        }
    }

}
