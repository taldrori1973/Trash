package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers.SelectTimeHandlers;
import com.radware.vision.infra.utils.TimeUtils;
import org.json.JSONObject;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import static com.radware.vision.infra.testhandlers.BaseHandler.restTestBase;
import static com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.WebUiTools.getWebElement;
import com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers.selectScheduleHandlers;

abstract class ReportsForensicsAlertsAbstract implements ReportsForensicsAlertsInterface {
    StringBuilder errorMessages = new StringBuilder();


    protected void createName(String name) throws Exception {
        BasicOperationsHandler.setTextField("Report Name", "", name, true);
        if (!getWebElement("Report Name").getAttribute("value").equals(name))
            throw new Exception("Filling report name doesn't succeed");
    }

    protected void selectTime(Map<String, String> map) throws Exception {
        if (map.containsKey("Time Definitions.Date")) {
            JSONObject timeDefinitionJSONObject = new JSONObject(map.get("Time Definitions.Date"));
            String typeSelectedTime = timeDefinitionJSONObject.has("Quick") ? "Quick" :
                    timeDefinitionJSONObject.has("Absolute") ? "Absolute" :
                            timeDefinitionJSONObject.has("Relative") ? "Relative" : "";

            switch (typeSelectedTime) {
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




    protected void selectScheduling(Map<String, String> map) throws Exception {
        if (map.containsKey("Schedule")) {
            JSONObject scheduleJson = new JSONObject(map.getOrDefault("Schedule", null));
            WebUiTools.check("Switch button Scheduled Report", "", true);
            String runEvery = scheduleJson.getString("Run Every");
            BasicOperationsHandler.clickButton("Schedule Report", runEvery.toLowerCase()); //daily/weekly/monthly/once

            if (scheduleJson.toMap().get("On Time").toString().matches(("[\\+|\\-]\\d+[M|d|y|H|m]")))
                selectScheduleHandlers.selectSchedulingWithComputingTheDate(runEvery, TimeUtils.getAddedDate(scheduleJson.toMap().get("On Time").toString().trim()));
            else
                selectScheduleHandlers.selectSchedulingAsTexts(scheduleJson, runEvery);
        }
    }



    protected void selectShare(Map<String, String> map) throws Exception {
        if (map.containsKey("Share")) {
            JSONObject deliveryJsonObject = new JSONObject(map.get("Share"));
            if (deliveryJsonObject.has("Email")) {
                for(String email : fixEmailsText(deliveryJsonObject))
                    BasicOperationsHandler.setTextField("Email", email, true);
                BasicOperationsHandler.setTextField("Subject", deliveryJsonObject.getString("Subject"));
                if (deliveryJsonObject.has("Body")) {
                    BasicOperationsHandler.setTextField("Email message", deliveryJsonObject.getString("Body"));
                }
            }
        }
    }

    private List<String> fixEmailsText(JSONObject deliveryJsonObject) {
        String eMailsText = deliveryJsonObject.getJSONArray("Email").toString().replaceAll("(])|(\\[)|(\")", "").replaceAll("\\s","");
        List<String> emailList = Arrays.asList(eMailsText.split(","));
        emailList.forEach(mail->{
            if(!mail.contains("@"))
                emailList.set(emailList.indexOf(mail),String.format("%s@%s.local",mail,restTestBase.getRootServerCli().getHost()));
        });
        return emailList;
    }

    protected void selectScopeSelection() {

    }

    protected void validateScheduleDefinition() {
    }





}
