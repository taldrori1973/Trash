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


abstract public class ReportsForensicsAlertsAbstract implements ReportsForensicsAlertsInterface {
    public static LocalDateTime timeDefinitionLocalDateTime;
    protected String errorMessage = "";
    private static Map<String, LocalDateTime> schedulingDates = new HashMap<>();
    private static Map<String, JSONObject> timeAbsoluteDates = new HashMap<>();
    protected static Map<String, Map<String, String>> templates = new HashMap<>();
    public static int maxWANLinks = 6;

    private String name;
    public static final Map<String, Integer> widgets;
    static {
        Map<String, Integer> templateWidgets = new HashMap<>();
        templateWidgets.put("DefensePro Analytics", 18);
        templateWidgets.put("DefensePro Behavioral Protections", 20);
        templateWidgets.put("HTTPS Flood", 1);
        templateWidgets.put("DefenseFlow Analytics", 13);
        templateWidgets.put("AppWall", 7);
        templateWidgets.put("ERT Active Attackers Feed", 5);
        templateWidgets.put("System and Network", 1);
//        templateWidgets.put("System, Network And LinkProof", 5);
        templateWidgets.put("Application", 6);
//        templateWidgets.put("Analytics ADC Application", 6);
        widgets = Collections.unmodifiableMap(templateWidgets);
    }

    protected void createName(String name) throws Exception {
        BasicOperationsHandler.setTextField(getType() + " Name", "", name, true);
        if (!getWebElement(getType() + " Name").getAttribute("value").equals(name))
            throw new Exception("Filling " + getType() + " name doesn't succeed");
        this.name = name;
    }

    protected void editName(Map<String, String> map, String viewName) throws Exception {
        if (map.containsKey("New " + getType() + " Name")) {
            createName(map.get("New " + getType() + " Name"));
        } else this.name = viewName;
    }

    protected void selectTime(Map<String, String> map) throws Exception {
        if (map.containsKey("Time Definitions.Date")) {
            JSONObject timeDefinitionJSONObject = new JSONObject(map.get("Time Definitions.Date"));

            switch (SelectTimeHandlers.getTypeSelectedTime(timeDefinitionJSONObject)) {
                case "Quick":
                    SelectTimeHandlers.selectQuickTime(timeDefinitionJSONObject);
                    break;
                case "Absolute":
                    SelectTimeHandlers.selectAbsoluteTime(timeDefinitionJSONObject, timeAbsoluteDates, getType() + "_" + name);
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


    public void selectScheduling(Map<String, String> map) throws Exception {
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

    protected StringBuilder validateTimeDefinition(JSONObject timeDefinitionsJSON, Map<String, String> map, String name) throws Exception {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Time Definitions.Date")) {
            JSONObject expectedTimeDefinitions = new JSONObject(map.get("Time Definitions.Date"));

            switch (SelectTimeHandlers.getTypeSelectedTime(expectedTimeDefinitions).toLowerCase()) {
                case "quick":
                    validateQuickRangeTime(timeDefinitionsJSON, errorMessage, expectedTimeDefinitions);
                    break;
                case "absolute":
                    validateAbsoluteTime(timeDefinitionsJSON, errorMessage, expectedTimeDefinitions, name);
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
        if (!timeDefinitions.get(getRangeTypeTextKey()).toString().contains("relative"))
        {
            errorMessage.append("The rangeType is ").append(timeDefinitions.get(getRangeTypeTextKey())).append(" and not equal to relative").append("\n");
            return;
        }
        if (!timeDefinitions.get(getRelativeRangeTextKey()).toString().equalsIgnoreCase(new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(0).toString()))
            errorMessage.append("The relative range is ").append(timeDefinitions.get(getRelativeRangeTextKey())).append(" and not ").append(new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(0).toString()).append("\n");
        if (!timeDefinitions.get(getRelativeRangeValueKey()).toString().equalsIgnoreCase(new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(1).toString()))
            errorMessage.append("The relativeRangeValue is ").append(timeDefinitions.get(getRelativeRangeValueKey())).append(" and not ").append(new JSONArray(expectedTimeDefinitions.get("Relative").toString()).get(1).toString()).append("'n");
    }

    protected String getRelativeRangeValueKey() {
        return "relativeRangeValue";
    }

    protected String getRelativeRangeTextKey() {
        return "relativeRange";
    }

    private void validateAbsoluteTime(JSONObject timeDefinitions, StringBuilder errorMessage, JSONObject expectedTimeDefinitions, String viewName) {
        if (!timeDefinitions.get(getRangeTypeTextKey()).toString().contains("absolute"))
        {
            errorMessage.append("The rangeType is ").append(timeDefinitions.get(getRangeTypeTextKey())).append(" and not equal to Absolute").append("\n");
            return;
        }
        LocalDateTime actualToDate = LocalDateTime.ofInstant(Instant.ofEpochMilli(new Long(timeDefinitions.get("to").toString())), ZoneId.systemDefault());
        LocalDateTime actualFromDate = LocalDateTime.ofInstant(Instant.ofEpochMilli(new Long(timeDefinitions.get("from").toString())), ZoneId.systemDefault());
        DateTimeFormatter absoluteFormatter = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm");
            if (!actualToDate.format(absoluteFormatter).equalsIgnoreCase(LocalDateTime.parse(timeAbsoluteDates.get(getType() + "_" + viewName).get("to").toString(), absoluteFormatter).format(absoluteFormatter)))
                errorMessage.append("the Actual to absolute time is ").append(actualToDate).append(" but the expected is ").append(timeDefinitionLocalDateTime).append("\n");
        if (!actualFromDate.format(absoluteFormatter).equalsIgnoreCase(LocalDateTime.parse(timeAbsoluteDates.get(getType() + "_" + viewName).get("from").toString(), absoluteFormatter).format(absoluteFormatter)))
            errorMessage.append("the Actual from absolute time is ").append(actualFromDate).append(" but the expected is ").append(timeDefinitionLocalDateTime).append("\n");
    }

    protected String getRangeTypeTextKey() {
        return "rangeType";
    }

    protected void validateQuickRangeTime(JSONObject timeDefinitionsJSON, StringBuilder errorMessage, JSONObject expectedTimeDefinitions) throws Exception {
        if (!timeDefinitionsJSON.get(getRangeTypeTextKey()).toString().equalsIgnoreCase("quick"))
        {
            errorMessage.append("The rangeType is ").append(timeDefinitionsJSON.get(getRangeTypeTextKey())).append(" and not equal to quick").append("\n");
            return;
        }
        if (!timeDefinitionsJSON.get("quickRangeSelection").toString().equalsIgnoreCase(expectedTimeDefinitions.getString("Quick")))
            errorMessage.append("The value of the quickRange is ").append(timeDefinitionsJSON.get("quickRangeSelection")).append(" and not equal to ").append(expectedTimeDefinitions.getString("Quick")).append("\n");
    }

    protected void editShare(Map<String, String> map) throws Exception {
        if (map.containsKey("Share")) {
            BasicOperationsHandler.setTextField("Email", "");
            BasicOperationsHandler.setTextField("Subject", "");
            BasicOperationsHandler.setTextField("Email message", "");
            selectShare(map);
        }
    }

    protected void selectShare(Map<String, String> map) throws Exception {
        if (map.containsKey("Share")) {
            JSONObject deliveryJsonObject = new JSONObject(map.get("Share"));
            if (deliveryJsonObject.has("Email"))
            {
                selectEmail(deliveryJsonObject);
            }
            else if (deliveryJsonObject.has("FTP"))
            {
                WebUiTools.check("Share Tab Label", "ftp", true);
                selectFTP(deliveryJsonObject);
            }
        }
    }

    protected abstract void selectFTP(JSONObject deliveryJsonObject) throws Exception;

    protected void selectEmail(JSONObject deliveryJsonObject) throws Exception {
        for (String email : fixEmailsText(deliveryJsonObject))
            BasicOperationsHandler.setTextField("Email", email, true);
        BasicOperationsHandler.setTextField("Subject", deliveryJsonObject.getString("Subject"));
        if (deliveryJsonObject.has("Body")) {
            BasicOperationsHandler.setTextField("Email message", deliveryJsonObject.getString("Body"));
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
            JSONObject actualSchedule = new JSONObject(schedulingDefinitionJson.get(getSchedulingKey()).toString());
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

    protected String getSchedulingKey() {
        return "scheduling";
    }

    protected StringBuilder validateFormatDefinition(JSONObject formatJson, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Format")) {
            JSONObject expectedFormatJson = new JSONObject(map.get("Format"));
            if (!formatJson.get("type").toString().trim().equalsIgnoreCase(expectedFormatJson.get("Select").toString().trim()))
                errorMessage.append("The actual Format is: ").append(formatJson.get("type").toString().toUpperCase()).append("but the Expected format is: ").append(expectedFormatJson.get("Select").toString().toUpperCase()).append("\n");
        } else
            validateDefaultFormatDefinition(formatJson);
        return errorMessage;
    }

    protected abstract String getType();


    public void baseOperation(vrmActions operationType, String name, String negative, Map<String, String> entry, RootServerCli rootServerCli) throws Exception {
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
                create(name, negative, map);
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
            if (getType().equalsIgnoreCase("report") && key.matches("reportType|Design|devices|webApplications|Customized Options|projectObjects"))
                return true;
        return false;
    }

    private void fixMapToSupportOldDesign(String reportName, Map<String, String> map) {
        JSONObject templateJSON = new JSONObject();
        fixOldMapObject(map, templateJSON, "reportType", "reportType", map.containsKey("reportType") ? map.get("reportType").contains("DefensePro Ana") ? "DefensePro Analytics" : map.get("reportType").replaceAll("s Dashboard", "s").trim().replaceAll(" Dashboard", "s") : "DefensePro Analytics");
        fixOldMapObject(map, templateJSON, "Design", "Widgets", map.containsKey("Design") ? new JSONObject(map.get("Design")).toMap().getOrDefault("Add", new JSONObject(map.get("Design")).toMap().getOrDefault("Widgets", "").toString()) : "");
        String devicesText = "";
        if (map.containsKey("devices"))
            devicesText = map.get("devices").replaceAll("index", "deviceIndex").replaceAll("ports", "devicePorts").replaceAll("policies", "devicePolicies");
        fixOldMapObject(map, templateJSON, "devices", "devices", "[" + devicesText + "]");
        fixOldMapObject(map, templateJSON, "webApplications", "Applications", "[" + map.get("webApplications") + "]");
        fixOldMapObject(map, templateJSON, "projectObjects", "Project Objects", "[" + map.get("projectObjects") + "]");
        if (map.containsKey("policy")) {
            JSONObject policy = new JSONObject(map.get("policy"));
            fixOldMapObject(map, templateJSON, "policy", "Servers", "[" + policy.get("serverName") + "-" + policy.get("deviceName") + "-" + policy.get("policyName") + "]");
        }
        if (map.containsKey("Customized Options")) {
            if (new JSONObject(map.get("Customized Options")).has("showTable"))
                templateJSON.put("showTable", new JSONObject(map.get("Customized Options")).get("showTable"));
            if (new JSONObject(map.get("Customized Options")).has("addLogo"))
                map.put("Logo", new JSONObject(map.get("Customized Options")).get("addLogo").toString());
            map.remove("Customized Options");
        }
        if (!templateJSON.has("reportType")) {
            templateJSON.put("reportType", "DefensePro Analytics");
        }
        map.put("Template", templateJSON.toString());
    }


    private void fixOldMapObject(Map<String, String> map, JSONObject templateJSON, String oldMapKey, String newJSONKey, Object newJSONValue) {
        if (map.containsKey(oldMapKey)) {
            templateJSON.put(newJSONKey, newJSONValue);
            map.remove(oldMapKey);
        }
    }

    private void fixTemplateMap(Map<String, String> map) {
        fixNewTemplate(map);
    }

    private void fixNewTemplate(Map<String, String> map) {
        ArrayList templateKeys = new ArrayList();
        map.keySet().forEach(key ->
        {
            if (key.contains("Template"))
                templateKeys.add(key);
        });
        JSONArray newTemplateObject = new JSONArray();
        for (Object key : templateKeys) {
            newTemplateObject.put(new JSONObject(map.get(key)).put("templateAutomationID", key));
            map.remove(key);
        }
        map.put("Template", newTemplateObject.toString());
    }

    public void generate(String name, Map<String, String> map) throws Exception {
        BasicOperationsHandler.setTextField("Search "+getType(), name);
        BasicOperationsHandler.clickButton("My Report", name);
        String oldDate = "";
        String[] generateReportParam = {name, "0"};
        if (WebUiTools.getWebElement("Views.reportIndex", generateReportParam) != null)
            oldDate = WebUiTools.getWebElement("Views.reportIndex", generateReportParam).getText();
        BasicOperationsHandler.clickButton("Generate Report Manually", name);

        int remainWaitingInSeconds = Integer.valueOf(map.get("timeOut"));
        while (WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//*[@data-debug-id='list-item_" + name + "']//div[@class='loading-dots--dot-red']").getBy()) != null && remainWaitingInSeconds > 0) {
            WebUIUtils.sleep(1);
            remainWaitingInSeconds--;
        }
        remainWaitingInSeconds = 20;
        while (oldDate.equalsIgnoreCase(WebUiTools.getWebElement("Views.reportIndex", generateReportParam).getText()) && remainWaitingInSeconds > 0) {
            WebUIUtils.sleep(1);
            remainWaitingInSeconds--;
        }
        if (oldDate.equalsIgnoreCase(WebUiTools.getWebElement("Views.reportIndex", generateReportParam).getText()))
            throw new Exception("Generate " + name + " report has failed");
    }

    @Override
    public void delete(String Name) throws Exception {
        WebUiTools.check("My " + getType() + " Tab", "", true);
        BasicOperationsHandler.setTextField("Search "+getType(), Name);
        BasicOperationsHandler.clickButton("Delete " + getType(), Name);
        confirmDeleteReport("confirm Delete " + getType(), Name);
        clearSavedReportInMap(Name);
        WebUIUtils.sleep(3);
        if (!BasicOperationsHandler.isElementExists("My " + getType(), false, Name)) {
            BaseTestUtils.report("Failed to delete " + getType() + " name: " + Name, Reporter.FAIL);
        }

    }

    public void deletionReportInstance(String label, String params) throws Exception {
        VisionDebugIdsManager.setLabel("Show " + getType() + " Time Generated");
        VisionDebugIdsManager.setParams(params);
        String TimeReport = WebUIUtils.fluentWait(ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).getText();
        BasicOperationsHandler.clickButton("Deletion " + getType() + " Instance", params);
        confirmDeleteReport("confirm Delete " + getType(), params.split("_")[0]);
        WebUIUtils.sleep(3);
        VisionDebugIdsManager.setLabel("Show " + getType() + " Time Generated");
        VisionDebugIdsManager.setParams(params);
        WebElement element = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (element != null && element.getText().equalsIgnoreCase(TimeReport))
            BaseTestUtils.report("No" + getType() + " Generate at this time" + TimeReport, Reporter.FAIL);
    }

    public static void confirmDeleteReport(String label, String params) throws TargetWebElementNotFoundException {

        if (WebUiTools.getWebElement(label, params) == null) {
            throw new TargetWebElementNotFoundException("No Element with data-debug-id " + VisionDebugIdsManager.getDataDebugId());
        }
        WebUIVisionBasePage.getCurrentPage().getContainer().getButton("//*[@data-debug-id='" + VisionDebugIdsManager.getDataDebugId() + "']//span[@data-debug-id='confirmation-box-delete-button-label']").click();

    }

    private void clearSavedReportInMap(String reportName) {

        if (templates.containsValue(getType() + "_" + reportName)) {
            templates.remove(getType() + "_" + reportName);
        }

        if (timeAbsoluteDates.containsValue(getType() + "_" + reportName)) {
            timeAbsoluteDates.remove(getType() + "_" + reportName);
        }

        if (schedulingDates.containsValue(getType() + "_" + reportName)) {
            schedulingDates.remove(getType() + "_" + reportName);
        }
    }

    protected boolean viewCreated(String reportName) throws Exception {
        if (WebUiTools.getWebElement("save") != null) {
            WebUIUtils.sleep(10);
        }
        WebUiTools.check("My " + getType() + " Tab", "", true);
        if (BasicOperationsHandler.isElementExists("My " + getType(), true, reportName))
            return true;
        WebUIUtils.sleep(2);
        closeView(true);
        return false;
    }

    protected void closeView(boolean withReadTheMessage) throws TargetWebElementNotFoundException {
        boolean isToCancel = false;

        for (WebElement okWebElement : WebUiTools.getWebElements("errorMessageOK", "")) {
            isToCancel = true;
            WebElement errorMessageElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByClass("ant-notification-notice-description").getBy());
            if (withReadTheMessage)
                errorMessage += errorMessageElement != null ? "\nbecause:\n" + errorMessageElement.getText() + "\n" : "";
            WebUiTools.clickWebElement(okWebElement);
        }
        if (isToCancel)
            cancelView();
    }

    protected void cancelView() throws TargetWebElementNotFoundException {
        if (WebUiTools.getWebElement("close scope selection") != null)
            BasicOperationsHandler.clickButton("close scope selection");
        if (WebUiTools.getWebElement("cancel") != null)
            BasicOperationsHandler.clickButton("cancel");
        if (WebUiTools.getWebElement("saveChanges", "no") != null)
            BasicOperationsHandler.clickButton("saveChanges", "no");
    }

    protected void selectFormat(Map<String, String> map) throws Exception {
        if (map.containsKey("Format")) {
            JSONObject deliveryJsonObject = new JSONObject(map.get("Format"));
            if (deliveryJsonObject.has("Select"))
                BasicOperationsHandler.clickButton("Format Type", deliveryJsonObject.getString("Select").equalsIgnoreCase("CSV With Attack Details")?"CSVWithDetails":deliveryJsonObject.getString("Select"));
            else BasicOperationsHandler.clickButton("Format Type", "HTML");
        }
    }

    protected StringBuilder validateShareDefinition(JSONObject deliveryJson, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey(getDeliveryKey())) {
            validateStandardEmail(deliveryJson, map, errorMessage);
        }
        return errorMessage;
    }

    protected void validateStandardEmail(JSONObject deliveryJson, Map<String, String> map, StringBuilder errorMessage) {
        JSONObject expectedDeliveryJson = new JSONObject(map.get(getDeliveryKey()));
        validateEmailRecipients(deliveryJson, errorMessage, expectedDeliveryJson);
        validateEmailSubject(deliveryJson, errorMessage, expectedDeliveryJson);
        validateEmailBody(deliveryJson, errorMessage, expectedDeliveryJson);
    }

    protected String getDeliveryKey() {
        return "Delivery";
    }

    private void validateEmailBody(JSONObject deliveryJson, StringBuilder errorMessage, JSONObject expectedDeliveryJson) {
        String actualBody = ((JSONObject) deliveryJson.get("email")).get("message").toString();
        String expectedBody = expectedDeliveryJson.get("Body").toString();
        if (!actualBody.equalsIgnoreCase(expectedBody)) {
            errorMessage.append("the Actual Body is ").append(actualBody).append(", but the Expected Body is ").append(expectedBody).append("\n");
        }
    }

    private void validateEmailSubject(JSONObject deliveryJson, StringBuilder errorMessage, JSONObject expectedDeliveryJson) {
        String actualSubject = ((JSONObject) deliveryJson.get("email")).get("subject").toString();
        String expectedSubject = expectedDeliveryJson.get("Subject").toString();
        if (!actualSubject.equalsIgnoreCase(expectedSubject)) {
            errorMessage.append("the Actual Subject is ").append(actualSubject).append(", but the Expected Subject is ").append(expectedSubject).append("\n");
        }
    }

    private void validateEmailRecipients(JSONObject deliveryJson, StringBuilder errorMessage, JSONObject expectedDeliveryJson) {
        String actualEmails = ((JSONObject) deliveryJson.get("email")).get("recipients").toString().replace("[", "").replace("]", "").replace(" ", "");
        String[] expectedEmailsArray = expectedDeliveryJson.get("Email").toString().replaceAll("(])|(\\[)", "").split(",");
        for (String email : expectedEmailsArray) {
            if (!actualEmails.toUpperCase().contains(email.toUpperCase().trim())) {
                errorMessage.append("The emails aren't the same, the actual is ").append(actualEmails).append(" and the Expected email ").append(email).append(" isn't found").append("\n");
            }
        }
    }

protected StringBuilder validateDefaultFormatDefinition(JSONObject exportFormat) {
    StringBuilder errorMessage = new StringBuilder();
    if (!exportFormat.get("type").toString().trim().toLowerCase().equalsIgnoreCase(getDefaultFormat()))
        errorMessage.append("The actual Format is: ").append(exportFormat.get("type").toString()).append("but the Expected format is: ").append(getDefaultFormat()).append("\n");
    return errorMessage;
}

    protected String getDefaultFormat() {
        return "pdf";
    }
}
