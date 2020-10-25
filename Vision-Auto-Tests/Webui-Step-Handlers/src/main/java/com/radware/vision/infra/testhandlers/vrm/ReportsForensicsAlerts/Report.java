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

    private void addTemplate(Object template) {

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

    private void expandReportParameters() throws Exception {
        WebUiTools.check("Report Parameter Menu", "", false);
    }

    private void selectFormat(Map<String, String> map) throws Exception {
        if (map.containsKey("Format")) {
            JSONObject deliveryJsonObject = new JSONObject(map.get("Format"));
            if (deliveryJsonObject.has("Select"))
                BasicOperationsHandler.clickButton( "Format Type", deliveryJsonObject.getString("Select").toUpperCase());
            else BasicOperationsHandler.clickButton("Format Type", "HTML");
        }
    }

    private void addLogo(Map<String, String> map) throws Exception {
        if (map.containsKey("Logo")) {
            getWebElement("Add Logo").click();
            BasicOperationsHandler.uploadFileToVision(map.get("Logo").trim(), null, null);
        }
    }

    @Override
    public void validate(RootServerCli rootServerCli, String reportName, Map<String, String> map) {
        validateScheduleDefinition();
        validateShareDefinition();
        validateFormatDefinition();

    }

    private void validateFormatDefinition() {
    }

    private void validateShareDefinition() {
    }



    @Override
    public void edit() {

    }

    @Override
    public void delete() {

    }
}
