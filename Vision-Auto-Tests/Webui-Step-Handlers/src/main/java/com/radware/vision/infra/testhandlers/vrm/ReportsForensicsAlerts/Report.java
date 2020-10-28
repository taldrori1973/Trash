package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts;

import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.vision_project_cli.RootServerCli;
import org.json.JSONObject;

import java.util.Arrays;
import java.util.Map;

import static com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.WebUiTools.getWebElement;

public class Report extends ReportsForensicsAlertsAbstract {

    @Override
    public void create(String reportName, Map<String, String> map) throws Exception {

        try {
            createReportParameters(reportName, map);
            selectTemplates(map);
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

    private void selectTemplates(Map<String, String> map) {
        for (Object template : (Arrays.asList(map.get("templates")))) {
            addTemplate(template);
        }
    }

    private void editTemplates(Map<String, String> map) {
        for (Object template : (Arrays.asList(map.get("templates")))) {
            editTemplate(template);
        }
    }
    private void addTemplate(Object template) {

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
        if (map.containsKey("Logo")) {
//            getWebElement("Add Logo").click();
            BasicOperationsHandler.uploadFileToVision(new JSONObject(map.get("Logo")).get("addLogo").toString().trim(), null, null);
        }
    }

    private void editLogo(Map<String, String> map) throws Exception {
      //  BasicOperationsHandler.uploadFileToVision(null , null, null);
        addLogo(map);
    }

    @Override
    public void validate(RootServerCli rootServerCli, String reportName, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();

        JSONObject logoDefinition = new JSONObject();
        logoDefinition.put("fileName", "reportLogoPNG.png");
        errorMessage.append(validateLogoDefinition(logoDefinition, map));


        JSONObject timeDefinition = new JSONObject();
        timeDefinition.put("rangeType" , "quick");
        timeDefinition.put("quickRangeSelection" , "1H");
        errorMessage.append(validateTimeDefinition(timeDefinition, map));


        validateScheduleDefinition();
        validateShareDefinition();
        validateFormatDefinition();
    }

    private void validateFormatDefinition() {
    }

    private void validateShareDefinition() {
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
}
