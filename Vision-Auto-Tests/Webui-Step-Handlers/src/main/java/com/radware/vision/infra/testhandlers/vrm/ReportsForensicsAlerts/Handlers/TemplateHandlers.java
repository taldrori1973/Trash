package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers;

import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import org.json.JSONArray;
import org.json.JSONObject;



public class TemplateHandlers
{

    public static void addTemplate(JSONObject templateJsonObject) throws TargetWebElementNotFoundException {
        addTemplateType(templateJsonObject.get("reportType").toString());
        addWidgets (new JSONArray(templateJsonObject.get("Widgets").toString()));

    }

    private static void addWidgets(JSONArray widgets) {

    }

    private static void addTemplateType(String reportType) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Add Template", reportType);
    }
}
