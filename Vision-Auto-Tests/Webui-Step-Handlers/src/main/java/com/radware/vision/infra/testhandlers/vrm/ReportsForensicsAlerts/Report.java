package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers.TemplateHandlers;
import com.radware.vision.infra.testresthandlers.ElasticSearchHandler;
import com.radware.vision.vision_project_cli.RootServerCli;
import cucumber.api.java.it.Ma;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;


public class Report extends ReportsForensicsAlertsAbstract {

    @Override
    public void create(String reportName, Map<String, String> map) throws Exception {

        try {
            WebUiTools.check("New Report Tab", "", true);
            createReportParameters(reportName, map);
            selectTemplates(map);
            BasicOperationsHandler.clickButton("save");
        } catch (Exception e) {
            closeReport();
            throw e;
        }
        if (!reportCreated()) {
            closeReport();
            throw new Exception("");
        }
    }

    private boolean reportCreated() {
        return true;
    }

    private void closeReport() {
    }

    private void selectTemplates(Map<String, String> map) throws Exception {
        for (Object templateObject :new JSONArray(map.get("Template")))
            TemplateHandlers.addTemplate(new JSONObject(templateObject.toString()));
    }

    private void editTemplates(Map<String, String> map) {
        for (Object template : (Arrays.asList(map.get("Templates")))) {
            editTemplate(template);
        }
    }
    private void editTemplate(Object template) {

    }

    private void expandReportParameters() throws Exception {
        WebUiTools.check("Report Parameter Menu", "", false);
    }

    private void createReportParameters(String reportName, Map<String, String> map) throws Exception {

        expandReportParameters();
        WebUiTools.check("Name Tab", "", true);
        createName(reportName);
        WebUiTools.check("Logo Tab", "", true);
        addLogo(map);
        WebUiTools.check("Time Tab", "", true);
        selectTime(map);
        WebUiTools.check("Schedule Tab", "", true);
        selectScheduling(map);
        WebUiTools.check("Share Tab", "", true);
        selectShare(map);
        WebUiTools.check("Format Tab", "", true);
        selectFormat(map);

    }

    private void editReportParameters(String reportName, Map<String, String> map) throws Exception {
        expandReportParameters();
        WebUiTools.check("Name Tab", "", true);
        editName(reportName);
        WebUiTools.check("Logo Tab", "", true);
        editLogo(map);
        WebUiTools.check("Time Tab", "", true);
        editTime(map);
        WebUiTools.check("Schedule Tab", "", true);
        editScheduling(map);
        WebUiTools.check("Share Tab", "", true);
        editShare(map);
        WebUiTools.check("Format Tab", "", true);
        editFormat(map);
    }

    private void selectFormat(Map<String, String> map) throws Exception {
        if (map.containsKey("Format")) {
            JSONObject deliveryJsonObject = new JSONObject(map.get("Format"));
            if (deliveryJsonObject.has("Select"))
                BasicOperationsHandler.clickButton( "Format Type", deliveryJsonObject.getString("Select").toUpperCase());
            else BasicOperationsHandler.clickButton("Format Type", "HTML");
        }
    }

    private void editFormat(Map<String, String> map) throws Exception {
        BasicOperationsHandler.clickButton("Format Type", "HTML");
        selectFormat(map);
    }

    private void addLogo(Map<String, String> map) throws Exception {
        if (map.containsKey("Logo"))
            BasicOperationsHandler.uploadFileToVision(map.get("Logo").trim(), null, null);
    }

    private void editLogo(Map<String, String> map) throws Exception {
        addLogo(map);
    }

    @Override
    public void validate(RootServerCli rootServerCli, String reportName, Map<String, String> map) throws Exception{
        JSONObject basicRestResult = waitForESDocument(rootServerCli, "reportName", reportName, "vrm-scheduled-report-definition-vrm", 0);
        StringBuilder errorMessage = new StringBuilder();
        errorMessage.append(validateLogoDefinition(new JSONObject(basicRestResult.get("Logo")), map));
        errorMessage.append(validateTimeDefinition(new JSONObject(basicRestResult.get("Time Definitions.Date")), map));
        errorMessage.append(validateScheduleDefinition(basicRestResult, map, reportName));
        errorMessage.append(validateShareDefinition(new JSONObject(basicRestResult.get("Share")), map));
        errorMessage.append(validateFormatDefinition(new JSONObject(basicRestResult.get("exportFormat")), map));
        errorMessage.append(TemplateHandlers.validateTemplateDefinition(new JSONArray(basicRestResult.get("Template")),map));
        if (errorMessage.length() != 0)
            BaseTestUtils.report(errorMessage.toString(), Reporter.FAIL);
    }

    protected StringBuilder validateShareDefinition(JSONObject deliveryJson, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Delivery")) {
            JSONObject expectedDeliveryJson = new JSONObject(map.get("Delivery"));
            validateEmailRecipients(deliveryJson, errorMessage, expectedDeliveryJson);
            validateEmailSubject(deliveryJson, errorMessage, expectedDeliveryJson);
            validateEmailBody(deliveryJson, errorMessage, expectedDeliveryJson);
        }
        return errorMessage;
    }

    private void validateEmailBody(JSONObject deliveryJson, StringBuilder errorMessage, JSONObject expectedDeliveryJson) {
        String actualBody = ((JSONObject) deliveryJson.get("email")).get("message").toString();
        String expectedBody = expectedDeliveryJson.get("Body").toString();
        if (!actualBody.equalsIgnoreCase(expectedBody)) {
            errorMessage.append("the Actual Body is " + actualBody + ", but the Expected Body is " + expectedBody).append("\n");
        }
    }

    private void validateEmailSubject(JSONObject deliveryJson, StringBuilder errorMessage, JSONObject expectedDeliveryJson) {
        String actualSubject = ((JSONObject) deliveryJson.get("email")).get("subject").toString();
        String expectedSubject = expectedDeliveryJson.get("Subject").toString();
        if (!actualSubject.equalsIgnoreCase(expectedSubject)) {
            errorMessage.append("the Actual Subject is " + actualSubject + ", but the Expected Subject is " + expectedSubject).append("\n");
        }
    }

    private void validateEmailRecipients(JSONObject deliveryJson, StringBuilder errorMessage, JSONObject expectedDeliveryJson) {
        String actualEmails = ((JSONObject)deliveryJson.get("email")).get("recipients").toString().replace("[", "").replace("]", "").replace(" ", "");
        String[] expectedEmailsArray = expectedDeliveryJson.get("Email").toString().replaceAll("(])|(\\[)", "").split(",");
        for (String email : expectedEmailsArray) {
            if (!actualEmails.toUpperCase().contains(email.toUpperCase().trim())) {
                errorMessage.append("The emails aren't the same, the actual is " + actualEmails + " and the Expected email " + email + " isn't found").append("\n");
            }
        }
    }

    private JSONObject waitForESDocument(RootServerCli rootServerCli, String documentFieldName, String reportName, String indexName, long timeout) {
        if (timeout == 0)
            timeout = WebUIUtils.DEFAULT_WAIT_TIME;
        JSONObject foundObject;
        long startTime = System.currentTimeMillis();
        do {
            try {
                foundObject = ElasticSearchHandler.getDocument(rootServerCli, documentFieldName, reportName, indexName);
                return foundObject;
            } catch (JSONException e) {
            }
        }
        while (System.currentTimeMillis() - startTime < timeout);
        return null;
    }

    private StringBuilder validateFormatDefinition(JSONObject formatJson, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Format")) {
            JSONObject expectedFormatJson = new JSONObject(map.get("Format"));
            if (formatJson.get("type").toString().equalsIgnoreCase(expectedFormatJson.get("Select").toString()))
                errorMessage.append("The actual Format is: " + formatJson.get("type").toString() + "but the Expected format is: " + expectedFormatJson.get("Select").toString()).append("\n");
        }
        else if (formatJson.get("type").toString().equalsIgnoreCase("html"))
            errorMessage.append("The actual Format is: " + formatJson.get("type").toString() + "but the Expected format is: " + "html").append("\n");
        return errorMessage;
    }

    protected StringBuilder validateLogoDefinition( JSONObject  logoDefinitions, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Logo")) {
            JSONObject expectedLogoDefinitions = new JSONObject(map.get("Logo"));
            if (expectedLogoDefinitions.has("addLogo") && !logoDefinitions.get("fileName").toString().equalsIgnoreCase(expectedLogoDefinitions.getString("addLogo"))) {
                    errorMessage.append("The fileName is " + logoDefinitions.get("addLogo") + " and not correct").append("\n");
            }
        }else if (!logoDefinitions.get("fileName").toString().equalsIgnoreCase("null"))
                errorMessage.append("The fileName is " + logoDefinitions.get("addLogo") + " is null").append("\n");
        return errorMessage;
    }


    @Override
    public void edit(String reportName, Map<String, String> map) throws Exception {
        try {
            editReportParameters(reportName, map);
            editTemplates(map);
        } catch (Exception e) {
            closeReport();
            throw e;
        }
        if (!reportCreated()) {
            closeReport();
            throw new Exception("");
        }
    }

    @Override
    public void delete() {

    }

    @Override
    protected String getType(){return "Report";}
}
