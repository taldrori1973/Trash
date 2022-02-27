package com.radware.vision.bddtests.ReportsForensicsAlerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.RootServerCli;
import com.radware.vision.automation.base.TestBase;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers.TemplateHandlers;
import com.radware.vision.infra.testhandlers.vrm.VRMReportsChartsHandler;
import com.radware.vision.restAPI.FormatterRestApi;
import com.radware.vision.tools.rest.CurrentVisionRestAPI;
import models.RestResponse;
import models.StatusCode;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class Report extends ReportsForensicsAlertsAbstract {
    private StringBuilder errorMessage = null;
    private static String hostIp = TestBase.getSutManager().getClientConfigurations().getHostIp();

    public void expandReportParameters() throws Exception {
        WebUiTools.check(getType() + " Parameter Menu", "", false);
    }

    @Override
    public void create(String reportName, String negative, Map<String, String> map) throws Exception {


        if (negative == null) {
            try {
                delete(reportName);
            } catch (Exception ignored) {
            }
        }

        try {
            closeView(false);
            WebUiTools.check("New Report Tab", "", true);
            createReportParameters(reportName, map);
            selectTemplates(map, reportName);
            BasicOperationsHandler.clickButton("save");
        } catch (Exception e) {
            cancelView();
            throw e;
        }

        if (negative == null) {
            if (!viewCreated(reportName)) {
                throw new Exception("The report '" + reportName + "' wasn't created!" + errorMessage);
            }
        }

    }

    private boolean reportCreated(String reportName) throws Exception {
        if (WebUiTools.getWebElement("save") != null) {
            WebUIUtils.sleep(10);
        }
        WebUiTools.check("My Report Tab", "", true);
        if (BasicOperationsHandler.isElementExists("My Report", true, reportName))
            return true;
        WebUIUtils.sleep(2);
        closeReport(true);
        return false;
    }

    private void closeReport(boolean withReadTheMessage) throws TargetWebElementNotFoundException {
        boolean isToCancel = false;

        for (WebElement okWebElement : WebUiTools.getWebElements("errorMessageOK", "")) {
            isToCancel = true;
            WebElement errorMessageElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByClass("ant-notification-notice-description").getBy());
            if (withReadTheMessage)
                errorMessage.append(errorMessageElement != null ? "\nbecause:\n" + errorMessageElement.getText() + "\n" : "");
            WebUiTools.clickWebElement(okWebElement);
        }
        if (isToCancel)
            cancelReport();
    }

    private void cancelReport() throws TargetWebElementNotFoundException {
        if (WebUiTools.getWebElement("close scope selection") != null)
            BasicOperationsHandler.clickButton("close scope selection");
        BasicOperationsHandler.clickButton("cancel");
        if (WebUiTools.getWebElement("saveChanges", "no") != null)
            BasicOperationsHandler.clickButton("saveChanges", "no");
    }

    private void selectTemplates(Map<String, String> map, String reportName) throws Exception {
        templates.put(reportName, new HashMap<>());
        for (Object templateObject : new JSONArray(map.get("Template")))
            TemplateHandlers.addTemplate(new JSONObject(templateObject.toString()), reportName);
    }

    private void editTemplates(Map<String, String> map, String reportName) throws Exception {
        for (Object templateObject : new JSONArray(map.get("Template"))) {
            TemplateHandlers.editTemplate(reportName, new JSONObject(templateObject.toString()),
                    getReportTemplateUICurrentName(reportName, new JSONObject(templateObject.toString()).get("templateAutomationID").toString()));
        }
    }

    private void editTemplate(Object template) {
    }

    private void createReportParameters(String reportName, Map<String, String> map) throws Exception {

        expandReportParameters();
        WebUiTools.check("Name Tab", "", true);
        createName(reportName);
        WebUiTools.check("Executive Summary Tab", "", true);
        createExecutiveSummary(map);
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
        editName(map, reportName);
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

    private void editExecutiveSummary(Map<String, String> map) throws Exception {
        if (map.containsKey("ExecutiveSummary")) {
            initExecutiveSummaryParams();
            createExecutiveSummary(map);
        }
    }

    private void initExecutiveSummaryParams() throws Exception {
        BasicOperationsHandler.clickButton("Create Executive Summary Button", "");
        WebUiTools.check("Executive Summary Title Tab", "", false);
        WebUiTools.check("Executive Summary Bold Tab", "", false);
        WebUiTools.check("Executive Summary Underline Tab", "", false);
        WebUiTools.check("Executive Summary Location Tab", "left", true);
        BasicOperationsHandler.setTextField("Executive Summary Body", "", "", true);
        WebUiTools.getWebElement("Save SummaryBody", "").click();
    }

    private void editFormat(Map<String, String> map) throws Exception {
        if (map.containsKey("Format")) {
            BasicOperationsHandler.clickButton("Format Type", "PDF");
            selectFormat(map);
        }
    }

    private void createExecutiveSummary(Map<String, String> map) throws Exception {
        if (map.containsKey("ExecutiveSummary")) {
            BasicOperationsHandler.clickButton("Create Executive Summary Button", "");
            formatandWriteExecutiveSummaryText(map);
            enableExecutiveSummaryText(map);
        }
    }

    private void enableExecutiveSummaryText(Map<String, String> executiveSummary) throws Exception {
        if (executiveSummary.containsKey("Enable") && executiveSummary.containsKey("SummaryBody") && !executiveSummary.get("SummaryBody").equals(""))
            WebUiTools.check("Executive Summary Enable Tab", "", Boolean.parseBoolean(executiveSummary.get("Enable")));
    }

    private void writeExecutiveSummaryText(Map<String, String> executiveSummary) throws TargetWebElementNotFoundException {
        if (executiveSummary.containsKey("ExecutiveSummary")) {
            List<WebElement> elements = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.CLASS_NAME, "notranslate").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            elements.get(0).sendKeys(new JSONObject(executiveSummary.get("ExecutiveSummary")).get("SummaryBody").toString() + "\n");
        }
    }

    private void formatandWriteExecutiveSummaryText(Map<String, String> map) throws Exception {
        titleText(new JSONObject(map.get("ExecutiveSummary")).toMap());
        boldText(new JSONObject(map.get("ExecutiveSummary")).toMap());
        underLineText(new JSONObject(map.get("ExecutiveSummary")).toMap());
        locationText(new JSONObject(map.get("ExecutiveSummary")).toMap());
        writeExecutiveSummaryText(map);
        URLText(new JSONObject(map.get("ExecutiveSummary")).toMap());
    }

    private void titleText(Map<String, Object> executiveSummary) throws Exception {
        if (executiveSummary.containsKey("Title"))
            WebUiTools.check("Executive Summary Title Tab", "", Boolean.parseBoolean(executiveSummary.get("Title").toString()));
    }

    private void boldText(Map<String, Object> executiveSummary) throws Exception {
        if (executiveSummary.containsKey("Bold"))
            WebUiTools.check("Executive Summary Bold Tab", "", Boolean.parseBoolean(executiveSummary.get("Bold").toString()));
    }

    private void underLineText(Map<String, Object> executiveSummary) throws Exception {
        if (executiveSummary.containsKey("Underline"))
            WebUiTools.check("Executive Summary Underline Tab", "", Boolean.parseBoolean(executiveSummary.get("Underline").toString()));
    }

    private void locationText(Map<String, Object> executiveSummary) throws Exception {
        if (executiveSummary.containsKey("Location"))
            WebUiTools.check("Executive Summary Location Tab", executiveSummary.get("Location").toString(), true);
    }

    private void URLText(Map<String, Object> executiveSummary) throws TargetWebElementNotFoundException {
        if (executiveSummary.containsKey("URL")) {
            WebUiTools.getWebElement("Executive Summary URL Tab", "").click();
            BasicOperationsHandler.setTextField("Destination URL", "", new JSONArray(executiveSummary.get("URL").toString()).get(0).toString(), true);
            BasicOperationsHandler.setTextField("Title URL", "", new JSONArray(executiveSummary.get("URL").toString()).get(1).toString(), true);
            WebUiTools.getWebElement("Executive Summary URL Tab Submit", "").click();
        }
        try {
            WebUiTools.getWebElement("Save SummaryBody", "").click();
        } catch (Exception e) {
            WebUiTools.getWebElement("Cancel SummaryBody", "").click();
        }
    }


    private void addLogo(Map<String, String> map) throws Exception {
        if (map.containsKey("Logo"))
            BasicOperationsHandler.uploadFileToVision(map.get("Logo").trim(), null, null);
    }

    private void editLogo(Map<String, String> map) throws Exception {
        if (map.containsKey("Logo"))
            addLogo(map);
    }

    @Override
    public void validate(RootServerCli rootServerCli, String reportName, Map<String, String> map) throws Exception {
        StringBuilder errorMessage = new StringBuilder();
        JSONObject basicRestResult = getReportDefinition(reportName, map);
        if (basicRestResult != null) {
            if (basicRestResult.get("executiveSummary").toString().equals("null"))
                errorMessage.append(validateExecutiveSummaryDefinition(new JSONObject(basicRestResult.get("executiveSummary")), map));
            else
                errorMessage.append(validateExecutiveSummaryDefinition(new JSONObject(basicRestResult.get("executiveSummary").toString()), map));
            errorMessage.append(validateLogoDefinition(new JSONObject(basicRestResult.get("logo").toString()), map));
            errorMessage.append(validateTimeDefinition(new JSONObject(basicRestResult.get("timeFrame").toString().replace("\\", "")), map, reportName));
            errorMessage.append(validateScheduleDefinition(basicRestResult, map, reportName));
            errorMessage.append(validateShareDefinition(new JSONObject(basicRestResult.get("deliveryMethod").toString()), map));
            errorMessage.append(validateFormatDefinition(new JSONObject(basicRestResult.get("exportFormat").toString()), map));
            errorMessage.append(TemplateHandlers.validateTemplateDefinition(basicRestResult.get("templates").toString().equalsIgnoreCase("null") ? new JSONArray() : new JSONArray(basicRestResult.get("templates").toString()), map, templates, widgets, reportName));
        } else errorMessage.append("No report Defined with name ").append(reportName).append("/n");
        if (errorMessage.length() != 0)
            BaseTestUtils.report(errorMessage.toString(), Reporter.FAIL);
    }


    private JSONObject getReportDefinition(String reportName, Map<String, String> map) throws Exception {
        RestResponse restResponse = new CurrentVisionRestAPI("Vision/newReport.json", "Get Created " + isReportAmsOrAdc(map) + " Reports").sendRequest();
        if (restResponse.getStatusCode() == StatusCode.OK) {
            JSONArray reportsJSONArray = new JSONArray(restResponse.getBody().getBodyAsString());
            for (Object reportJsonObject : reportsJSONArray) {
                if (new JSONObject(reportJsonObject.toString()).getString("reportName").equalsIgnoreCase(reportName)) {
                    CurrentVisionRestAPI currentVisionRestAPI = new CurrentVisionRestAPI("Vision/newReport.json", "Get specific Report");
                    currentVisionRestAPI.getRestRequestSpecification().setPathParams(Collections.singletonMap("reportID", new JSONObject(reportJsonObject.toString()).getString("id")));
                    restResponse = currentVisionRestAPI.sendRequest();
                    if (restResponse.getStatusCode() == StatusCode.OK)
                        return new JSONObject(restResponse.getBody().getBodyAsString());
                    else throw new Exception("Get specific Report request failed, The response is " + restResponse);
                }
            }
            throw new Exception("No Report with Name " + reportName);
        } else throw new Exception("Get Reports failed request, The response is " + restResponse);
    }

    private String isReportAmsOrAdc(Map<String, String> map) {
        JSONArray templatesArray = new JSONArray(map.get("Template"));
        for (Object singleTemplate : templatesArray) {
            if (new JSONObject(singleTemplate.toString()).get("reportType") != null
                    && (new JSONObject(singleTemplate.toString()).get("reportType").toString().equalsIgnoreCase("APPLICATION") ||
                    new JSONObject(singleTemplate.toString()).get("reportType").toString().equalsIgnoreCase("SYSTEM AND NETWORK")) ||
                    new JSONObject(singleTemplate.toString()).get("reportType").toString().equalsIgnoreCase("LINKPROOF"))
                return "ADC";
        }
        return "AMS";
    }

    private String getReportID(String reportName) {
        return new JSONObject(new ReportsDefinitions().getJsonDefinition(reportName).toString()).getString("id");
    }

    private StringBuilder validateExecutiveSummaryDefinition(JSONObject executiveSummary, Map<String, String> map) throws TargetWebElementNotFoundException {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("ExecutiveSummary")) {
            validateSummaryBody(executiveSummary, map);
            ValidateStyleExecutiveSummary(executiveSummary, map);
        }
        return errorMessage;
    }

    private void ValidateStyleExecutiveSummary(JSONObject executiveSummary, Map<String, String> map) {
        validateSummaryLocation(executiveSummary, map);
        validateSummaryBOLDStyle(executiveSummary, map);
        validateSummaryTitleStyle(executiveSummary, map);
        validateSummaryUnderlineStyle(executiveSummary, map);
        validateSummaryURL(executiveSummary, map);
    }

    private void validateSummaryURL(JSONObject executiveSummary, Map<String, String> map) {
        boolean flag = false;
        StringBuilder errorMessage = new StringBuilder();
        String ActualURL = new JSONObject(new JSONObject(new JSONObject(new JSONObject(executiveSummary.get("summaryState").toString()).get("entityMap").toString()).get("0").toString()).get("data").toString()).get("url").toString();
        String ExpectedURL = ((JSONArray) new JSONObject(map.get("ExecutiveSummary")).get("URL")).get(0).toString();
        if (!ActualURL.equals(ExpectedURL)) {
            errorMessage.append("The expected URL  " + ExpectedURL + "not equal to " + ActualURL);
        }
        JSONArray blockList = (JSONArray) new JSONObject(new JSONObject(executiveSummary.toString()).get("summaryState").toString()).get("blocks");
        String ExpectedURLTitle = ((JSONArray) new JSONObject(map.get("ExecutiveSummary")).get("URL")).get(1).toString();
        for (int i = 0; i < blockList.length(); i++) {
            if (new JSONObject(blockList.get(i).toString()).get("text").equals(ExpectedURLTitle)) {
                flag = true;
            }
        }
        if (!flag) {
            errorMessage.append("The expected URL title  " + ExpectedURLTitle + "not match to the expected url");
        }

    }

    private void validateSummaryBody(JSONObject executiveSummary, Map<String, String> map) {
        JSONArray blockList;
        StringBuilder errorMessage = new StringBuilder();
        blockList = (JSONArray) new JSONObject(new JSONObject(executiveSummary.toString()).get("summaryState").toString()).get("blocks");
        if (!new JSONObject(blockList.get(0).toString()).get("text").toString().equals(new JSONObject(map.get("ExecutiveSummary")).get("SummaryBody"))) {
            errorMessage.append("The expected result  " + new JSONObject(map.get("ExecutiveSummary")).get("SummaryBody") + "not equal to " + new JSONObject(blockList.get(0).toString()).get("text").toString());
        }
    }

    private void validateSummaryLocation(JSONObject executiveSummary, Map<String, String> map) {
        JSONArray blockList;
        blockList = (JSONArray) new JSONObject(new JSONObject(executiveSummary.toString()).get("summaryState").toString()).get("blocks");
        StringBuilder errorMessage = new StringBuilder();
        if (!new JSONObject(blockList.get(0).toString()).get("type").equals(new JSONObject(map.get("ExecutiveSummary")).get("Location"))) {
            errorMessage.append("The expected Location  " + new JSONObject(map.get("ExecutiveSummary")).get("Location") + "not equal to " + new JSONObject(blockList.get(0).toString()).get("type").toString());
        }
    }

    private void validateSummaryBOLDStyle(JSONObject executiveSummary, Map<String, String> map) {
        boolean flag = false;
        JSONArray blockList, inlineStyleRangesList = null;
        StringBuilder errorMessage = new StringBuilder();
        blockList = (JSONArray) new JSONObject(new JSONObject(executiveSummary.toString()).get("summaryState").toString()).get("blocks");
        inlineStyleRangesList = (JSONArray) new JSONObject(blockList.get(0).toString()).get("inlineStyleRanges");
        for (int i = 0; i < inlineStyleRangesList.length(); i++) {
            if (new JSONObject(inlineStyleRangesList.get(i).toString()).get("style").equals("BOLD")) {
                flag = true;
                break;
            } else
                flag = false;
        }
        if (!(flag == Boolean.parseBoolean(new JSONObject(map.get("ExecutiveSummary")).get("Bold").toString()))) {
            errorMessage.append("The expected Bold style  " + new JSONObject(map.get("ExecutiveSummary")).get("Bold") + "not equal to " + new JSONObject(inlineStyleRangesList.get(0).toString()).get("style").toString());
        }
    }

    private void validateSummaryTitleStyle(JSONObject executiveSummary, Map<String, String> map) {
        boolean flag = false;
        JSONArray blockList, inlineStyleRangesList = null;
        StringBuilder errorMessage = new StringBuilder();
        blockList = (JSONArray) new JSONObject(new JSONObject(executiveSummary.toString()).get("summaryState").toString()).get("blocks");
        inlineStyleRangesList = (JSONArray) new JSONObject(blockList.get(0).toString()).get("inlineStyleRanges");
        for (int i = 0; i < inlineStyleRangesList.length(); i++) {
            if (new JSONObject(inlineStyleRangesList.get(i).toString()).get("style").equals("FONT_SIZE_40")) {
                flag = true;
                break;
            } else
                flag = false;
        }
        if (!(flag == Boolean.parseBoolean(new JSONObject(map.get("ExecutiveSummary")).get("Title").toString()))) {
            errorMessage.append("The expected title style  " + new JSONObject(map.get("ExecutiveSummary")).get("title") + "not equal to " + new JSONObject(inlineStyleRangesList.get(1).toString()).get("style").toString());
        }
    }

    private void validateSummaryUnderlineStyle(JSONObject executiveSummary, Map<String, String> map) {
        boolean flag = false;
        JSONArray blockList, inlineStyleRangesList = null;
        StringBuilder errorMessage = new StringBuilder();
        blockList = (JSONArray) new JSONObject(new JSONObject(executiveSummary.toString()).get("summaryState").toString()).get("blocks");
        inlineStyleRangesList = (JSONArray) new JSONObject(blockList.get(0).toString()).get("inlineStyleRanges");
        for (int i = 0; i < inlineStyleRangesList.length(); i++) {
            if (new JSONObject(inlineStyleRangesList.get(i).toString()).get("style").equals("UNDERLINE")) {
                flag = true;
                break;
            } else
                flag = false;
        }
        if (!(flag == Boolean.parseBoolean(new JSONObject(map.get("ExecutiveSummary")).get("Underline").toString()))) {
            errorMessage.append("The expected Underline style  " + new JSONObject(map.get("ExecutiveSummary")).get("Underline") + "not equal to " + new JSONObject(inlineStyleRangesList.get(2).toString()).get("style").toString());
        }
    }


    private StringBuilder validateLogoDefinition(JSONObject logoDefinitions, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Logo")) {
            if (logoDefinitions.has("empty"))
                errorMessage.append("No Logo Defined");
            else if (!logoDefinitions.get("fileName").toString().equalsIgnoreCase(map.get("Logo")))
                errorMessage.append("The fileName is ").append(logoDefinitions.get("addLogo")).append(" and not correct").append("\n");
        }
        return errorMessage;
    }


    @Override
    public void edit(String reportName, Map<String, String> map) throws Exception {
        try {
            WebUiTools.getWebElement("Edit Report", reportName).click();
            editReportParameters(reportName, map);
            editTemplates(map, reportName);
            BasicOperationsHandler.clickButton("save");
        } catch (Exception e) {
            cancelView();
            throw e;
        }
        if (!viewCreated(reportName)) {
            cancelView();
            throw new Exception("");
        }
    }

    @Override
    protected void selectFTP(JSONObject deliveryJsonObject) {
    }

    @Override
    protected String getType() {
        return "Report";
    }

    public static void updateReportsTemplatesMap(String reportName, String templateAutomationID, String value) {
        templates.get(reportName).put(templateAutomationID, value);
    }

    public static void deleteTemplateReport(String reportName, String templateAutomationID) {
        templates.get(reportName).remove(templateAutomationID);
    }

    public static String getReportTemplateUICurrentName(String reportName, String templateAutomationID) {
        return templates.get(reportName).get(templateAutomationID);
    }


    public VRMReportsChartsHandler getVRMReportsChartsHandler(String reportName, String... args) throws NoSuchFieldException {
        if (generateReportAndGetReportID(reportName, args).equalsIgnoreCase("accepted")) {
            if (generateStatus(getReportID(reportName), 60))
                return new VRMReportsChartsHandler(getReportGenerateResult(getReportID(reportName)));
        }
        BaseTestUtils.report("The generation of report " + reportName + " didn't succeed", Reporter.FAIL);
        return null;
    }


    public static JSONObject getReportGenerateResult(String reportID) {

        FormatterRestApi formatterRestApiResult = new FormatterRestApi("HTTP://" + hostIp, 3002, "Vision/generateReport.json", "Get Result Of Generate Report");
        HashMap map = new HashMap<>();
        map.put("id", reportID);
        formatterRestApiResult.getRestRequestSpecification().setPathParams(map);
        return new JSONObject(new JSONObject(formatterRestApiResult.sendRequest().getBody().getBodyAsString()).get("jsonResult").toString());
    }

    public String generateReportAndGetReportID(String reportName, String... args) {

        FormatterRestApi formatterRestApi = new FormatterRestApi("HTTP://" + hostIp, 3002, "Vision/generateReport.json", "Generate Report");
        formatterRestApi.getRestRequestSpecification().setBody(((args == null || args[0] == null)?new ReportsDefinitions():new ReportsDefinitionsSimulators(args[0])).getJsonDefinition(reportName).toString());
        return formatterRestApi.sendRequest().getStatusCode().getReasonPhrase();
    }

    public boolean generateStatus(String reportID, int secondsTimeOut) {
        FormatterRestApi formatterRestApiStatus = new FormatterRestApi("HTTP://" + hostIp, 3002, "Vision/generateReport.json", "Get Status Report");
        HashMap map = new HashMap<>();
        map.put("id", reportID);
        formatterRestApiStatus.getRestRequestSpecification().setPathParams(map);
        while (!new JSONObject(formatterRestApiStatus.sendRequest().getBody().getBodyAsString()).getString("status").equalsIgnoreCase("S") && secondsTimeOut > 0) {
            WebUIUtils.sleep(1);
            secondsTimeOut--;
        }
        return formatterRestApiStatus.sendRequest().getStatusCode().getReasonPhrase().equalsIgnoreCase("ok");
    }

}
