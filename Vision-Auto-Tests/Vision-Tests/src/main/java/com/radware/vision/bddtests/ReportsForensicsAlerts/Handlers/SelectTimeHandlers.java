package com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers;

import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.bddtests.ReportsForensicsAlerts.WebUiTools;
import com.radware.vision.infra.utils.TimeUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.GregorianCalendar;
import java.util.Map;

public class SelectTimeHandlers {
    public static void selectRelativeTime(JSONObject timeDefinitionJSONObject) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Time Type" ,"relative");
        ClickRelativeDateNew(timeDefinitionJSONObject.getJSONArray("Relative"));
    }

    public static void selectAbsoluteTime(JSONObject timeDefinitionJSONObject, Map<String, JSONObject> timeAbsoluteDates, String name) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Time Type", "absolute");
        JSONArray absoluteJArray = new JSONArray();
        try {
            absoluteJArray = timeDefinitionJSONObject.getJSONArray("Absolute");
        } catch (Exception e) {
            absoluteJArray.put(timeDefinitionJSONObject.get("Absolute"));
        }
        selectAbsoluteTimeNew(absoluteJArray, timeAbsoluteDates, name);
    }

    public static void selectQuickTime(JSONObject timeDefinitionJSONObject) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Time Type", "quickrange");
        BasicOperationsHandler.clickButton("Quick Range", timeDefinitionJSONObject.getString("Quick"));
    }


    private static void selectAbsoluteTimeNew(JSONArray absoluteJArray, Map<String, JSONObject> timeAbsoluteDates, String name) throws TargetWebElementNotFoundException {
        String toDate, fromDate = WebUiTools.getWebElement("Absolute From").getAttribute("value");
        DateTimeFormatter absoluteFormat = DateTimeFormatter.ofPattern("dd.MM.YYYY HH:mm:ss");
        if (absoluteJArray.length() == 1) {
            toDate = absoluteFormat.format(TimeUtils.getAddedDate(absoluteJArray.get(0).toString().trim()));
            BasicOperationsHandler.setTextField("Absolute To", toDate);
        } else {
            fromDate = absoluteJArray.get(0).toString();
            if (fromDate.equals("Today")) {
                LocalDateTime localDateTime = LocalDateTime.from(Instant.ofEpochMilli(new GregorianCalendar().getTime().getTime()).atZone(ZoneId.systemDefault()));
                fromDate = absoluteFormat.format(localDateTime);
                BasicOperationsHandler.setTextField("Absolute From", fromDate);
            } else {
                BasicOperationsHandler.setTextField("Absolute From", fromDate);
            }
            toDate = absoluteFormat.format(TimeUtils.getAddedDate(absoluteJArray.get(1).toString().trim()));
            BasicOperationsHandler.setTextField("Absolute To", toDate);
        }
        timeAbsoluteDates.put(name, new JSONObject().put("from", fromDate).put("to", toDate));
    }

    private static void ClickRelativeDateNew(JSONArray timeDefinitions) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Relative Time Unit", timeDefinitions.get(0).toString());
        BasicOperationsHandler.setTextField("Relative Time Unit Value", timeDefinitions.get(0).toString(), timeDefinitions.get(1).toString(), false);
    }

    public static String getTypeSelectedTime(JSONObject timeDefinitionJSONObject) {
        return timeDefinitionJSONObject.has("Quick") ? "Quick" :
                timeDefinitionJSONObject.has("Absolute") ? "Absolute" :
                        timeDefinitionJSONObject.has("Relative") ? "Relative" : "";
    }

}
