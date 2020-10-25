package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers;

import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.utils.TimeUtils;
import org.json.JSONArray;
import org.json.JSONObject;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.GregorianCalendar;

public class SelectTimeHandlers {
    public static void selectRelativeTime(JSONObject timeDefinitionJSONObject) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Relative");
        ClickRelativeDateNew(timeDefinitionJSONObject.getJSONArray("Relative"));
    }

    public static void selectAbsoluteTime(JSONObject timeDefinitionJSONObject) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Time Type", "absolute");
        JSONArray absoluteJArray = new JSONArray();
        try {
            absoluteJArray = timeDefinitionJSONObject.getJSONArray("Absolute");
        } catch (Exception e) {
            absoluteJArray.put(timeDefinitionJSONObject.get("Absolute"));
        }
        selectAbsoluteTimeNew(absoluteJArray);
    }

    public static void selectQuickTime(JSONObject timeDefinitionJSONObject) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Time Type", "quickrange");
        BasicOperationsHandler.clickButton("Quick Range", timeDefinitionJSONObject.getString("Quick"));
    }


    private static void selectAbsoluteTimeNew(JSONArray absoluteJArray) throws TargetWebElementNotFoundException {
        DateTimeFormatter absoluteFormat = DateTimeFormatter.ofPattern("dd.MM.YYYY HH:mm:ss");
        if (absoluteJArray.length() == 1) {
            BasicOperationsHandler.setTextField("Absolute To", absoluteFormat.format(TimeUtils.getAddedDate(absoluteJArray.get(0).toString().trim())));
        } else {
            String fromDate = absoluteJArray.get(0).toString();
            if (fromDate.equals("Today")) {
                LocalDateTime localDateTime = LocalDateTime.from(Instant.ofEpochMilli(new GregorianCalendar().getTime().getTime()).atZone(ZoneId.systemDefault()));
                BasicOperationsHandler.setTextField("Absolute From", absoluteFormat.format(localDateTime));
            } else {
                BasicOperationsHandler.setTextField("Absolute From", fromDate);
            }
            BasicOperationsHandler.setTextField("Absolute To", absoluteFormat.format(TimeUtils.getAddedDate(absoluteJArray.get(1).toString().trim())));
        }
    }

    private static void ClickRelativeDateNew(JSONArray timeDefinitions) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Relative Time Unit", timeDefinitions.get(0).toString());
        BasicOperationsHandler.setTextField("Relative Time Unit Value", timeDefinitions.get(0).toString(), timeDefinitions.get(1).toString(), false);
    }

}
