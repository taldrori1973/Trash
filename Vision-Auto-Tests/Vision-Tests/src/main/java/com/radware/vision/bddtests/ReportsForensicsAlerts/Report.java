package com.radware.vision.bddtests.ReportsForensicsAlerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers.TemplateHandlers;
import com.radware.vision.infra.testhandlers.vrm.VRMReportsChartsHandler;
import com.radware.vision.restAPI.FormatterRestApi;
import com.radware.vision.restBddTests.utils.SutUtils;
import com.radware.vision.tools.rest.CurrentVisionRestAPI;
import com.radware.vision.vision_project_cli.RootServerCli;
import models.RestResponse;
import models.StatusCode;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.WebElement;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;


public class Report extends ReportsForensicsAlertsAbstract {

    public void expandReportParameters() throws Exception {
        WebUiTools.check(getType() + " Parameter Menu", "", false);
    }

    @Override
    public void create(String reportName,String negative, Map<String, String> map) throws Exception {


        if(negative == null){
            try{delete(reportName);}catch (Exception ignored){}
        }

        try {
            closeView(false);
            WebUiTools.check("New Report Tab", "", true);
            createReportParameters(reportName, map);
            selectTemplates(map,reportName);
            BasicOperationsHandler.clickButton("save");
        } catch (Exception e) {
            cancelView();
            throw e;
        }

        if(negative == null){
            if (!viewCreated(reportName)) {
                throw new Exception("The report '" + reportName + "' isn't created!" + errorMessage);
            }
        }

    }

    private boolean reportCreated(String reportName) throws Exception {
        if (WebUiTools.getWebElement("save") != null)
        {
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

        for (WebElement okWebElement : WebUiTools.getWebElements("errorMessageOK", ""))
        {
            isToCancel = true;
            WebElement errorMessageElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByClass("ant-notification-notice-description").getBy());
            if(withReadTheMessage)
                errorMessage+=  errorMessageElement!= null ? "\nbecause:\n" + errorMessageElement.getText() + "\n":"";
            WebUiTools.clickWebElement(okWebElement);
        }
        if (isToCancel)
            cancelReport();
    }

    private void cancelReport() throws TargetWebElementNotFoundException {
        if (WebUiTools.getWebElement("close scope selection") != null)
            BasicOperationsHandler.clickButton("close scope selection");
        BasicOperationsHandler.clickButton("cancel");
        if(WebUiTools.getWebElement("saveChanges","no") != null)
            BasicOperationsHandler.clickButton("saveChanges", "no");
    }

    private void selectTemplates(Map<String, String> map,String reportName) throws Exception {
        templates.put(reportName,new HashMap<>());
        for (Object templateObject :new JSONArray(map.get("Template")))
            TemplateHandlers.addTemplate(new JSONObject(templateObject.toString()),reportName);
    }

    private void editTemplates(Map<String, String> map,String reportName) throws Exception{
        for (Object templateObject : new JSONArray(map.get("Template"))) {
            TemplateHandlers.editTemplate(reportName,new JSONObject(templateObject.toString()),
                    getReportTemplateUICurrentName(reportName,new JSONObject(templateObject.toString()).get("templateAutomationID").toString()));
        }
    }
    private void editTemplate(Object template) {

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

    private void editFormat(Map<String, String> map) throws Exception {
        if (map.containsKey("Format")) {
            BasicOperationsHandler.clickButton("Format Type", "PDF");
            selectFormat(map);
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
    public void validate(RootServerCli rootServerCli, String reportName, Map<String, String> map) throws Exception{
        StringBuilder errorMessage = new StringBuilder();
        JSONObject basicRestResult = getReportDefinition(reportName, map);
        if (basicRestResult!=null)
        {
            errorMessage.append(validateLogoDefinition(new JSONObject(basicRestResult.get("logo").toString()), map));
            errorMessage.append(validateTimeDefinition(new JSONObject(basicRestResult.get("timeFrame").toString().replace("\\", "")), map, reportName));
            errorMessage.append(validateScheduleDefinition(basicRestResult, map, reportName));
            errorMessage.append(validateShareDefinition(new JSONObject(basicRestResult.get("deliveryMethod").toString()), map));
            errorMessage.append(validateFormatDefinition(new JSONObject(basicRestResult.get("exportFormat").toString()), map));
            errorMessage.append(TemplateHandlers.validateTemplateDefinition(basicRestResult.get("templates").toString().equalsIgnoreCase("null")?new JSONArray():new JSONArray(basicRestResult.get("templates").toString()),map,templates,widgets,reportName));
        }else errorMessage.append("No report Defined with name ").append(reportName).append("/n");
        if (errorMessage.length() != 0)
            BaseTestUtils.report(errorMessage.toString(), Reporter.FAIL);
    }

    private JSONObject getReportDefinition(String reportName, Map<String, String> map) throws Exception {
        RestResponse restResponse = new CurrentVisionRestAPI("Vision/newReport.json", "Get Created " + isReportAmsOrAdc(map) + " Reports").sendRequest();
        if (restResponse.getStatusCode()== StatusCode.OK)
        {
            JSONArray reportsJSONArray = new JSONArray(restResponse.getBody().getBodyAsString());
            for(Object reportJsonObject : reportsJSONArray){
                if (new JSONObject(reportJsonObject.toString()).getString("reportName").equalsIgnoreCase(reportName))
                {
                    CurrentVisionRestAPI currentVisionRestAPI = new CurrentVisionRestAPI("Vision/newReport.json", "Get specific Report");
                    currentVisionRestAPI.getRestRequestSpecification().setPathParams(Collections.singletonMap("reportID", new JSONObject(reportJsonObject.toString()).getString("id")));
                    restResponse = currentVisionRestAPI.sendRequest();
                    if (restResponse.getStatusCode() == StatusCode.OK)
                        return new JSONObject(restResponse.getBody().getBodyAsString());
                    else throw new Exception("Get specific Report request failed, The response is " + restResponse);
                }
            }
            throw new Exception("No Report with Name " + reportName);
        }
        else throw new Exception("Get Reports failed request, The response is " + restResponse);
    }

    private String isReportAmsOrAdc(Map<String, String> map) {
        JSONArray templatesArray = new JSONArray(map.get("Template"));
        for (Object singleTemplate: templatesArray)
        {
            if (new JSONObject(singleTemplate.toString()).get("reportType")!=null
                    && (new JSONObject(singleTemplate.toString()).get("reportType").toString().equalsIgnoreCase("APPLICATION")||
                    new JSONObject(singleTemplate.toString()).get("reportType").toString().equalsIgnoreCase("SYSTEM AND NETWORK")))
                return "ADC";
        }
        return "AMS";
    }

    private String getReportID(String reportName) {
        return new JSONObject(new ReportsDefinitions().getJsonDefinition(reportName).toString()).getString("id");
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
            WebUiTools.getWebElement("Edit Report",reportName).click();
            editReportParameters(reportName, map);
            editTemplates(map,reportName);
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
    protected void selectFTP(JSONObject deliveryJsonObject) {}

    @Override
    protected String getType(){return "Report";}

    public static void updateReportsTemplatesMap(String reportName,String templateAutomationID, String value){
        templates.get(reportName).put(templateAutomationID,value);
    }

    public static void deleteTemplateReport(String reportName,String templateAutomationID){
        templates.get(reportName).remove(templateAutomationID);
    }

    public static String getReportTemplateUICurrentName(String reportName,String templateAutomationID){
        return templates.get(reportName).get(templateAutomationID);
    }


    public VRMReportsChartsHandler getVRMReportsChartsHandler(String reportName) throws NoSuchFieldException {
        if (generateReportAndGetReportID(reportName).equalsIgnoreCase("accepted"))
        {
            if (generateStatus(getReportID(reportName), 60))
                return new VRMReportsChartsHandler(getReportGenerateResult(getReportID(reportName)));
        }
        BaseTestUtils.report("The generation of report " + reportName + " doesn't succeed", Reporter.FAIL);
        return null;
    }


    public static JSONObject getReportGenerateResult(String reportID) throws NoSuchFieldException {
        FormatterRestApi formatterRestApiResult = new FormatterRestApi("HTTP://" + SutUtils.getCurrentVisionIp(), 3002,"Vision/generateReport.json", "Get Result Of Generate Report");
        HashMap map = new HashMap<>();
        map.put("id", reportID);
        formatterRestApiResult.getRestRequestSpecification().setPathParams(map);
        return new JSONObject(new JSONObject(formatterRestApiResult.sendRequest().getBody().getBodyAsString()).get("jsonResult").toString());
    }

    public String generateReportAndGetReportID(String reportName) throws NoSuchFieldException {

        FormatterRestApi formatterRestApi = new FormatterRestApi("HTTP://" + SutUtils.getCurrentVisionIp(), 3002,"Vision/generateReport.json", "Generate Report");
        formatterRestApi.getRestRequestSpecification().setBody(new ReportsDefinitions().getJsonDefinition(reportName).toString());
            return formatterRestApi.sendRequest().getStatusCode().getReasonPhrase();
    }

    public boolean generateStatus(String reportID, int secondsTimeOut) throws NoSuchFieldException {
        FormatterRestApi formatterRestApiStatus = new FormatterRestApi("HTTP://" + SutUtils.getCurrentVisionIp(), 3002,"Vision/generateReport.json", "Get Status Report");
        HashMap map = new HashMap<>();
        map.put("id", reportID);
        formatterRestApiStatus.getRestRequestSpecification().setPathParams(map);
        while (!new JSONObject(formatterRestApiStatus.sendRequest().getBody().getBodyAsString()).getString("status").equalsIgnoreCase("S") && secondsTimeOut>0)
        {
            WebUIUtils.sleep(1);
            secondsTimeOut--;
        }
        return formatterRestApiStatus.sendRequest().getStatusCode().getReasonPhrase().equalsIgnoreCase("ok");
    }

}
