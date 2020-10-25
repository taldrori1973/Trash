package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers;

import com.radware.automation.react.widgets.impl.ReactDateControl;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.WebUiTools;
import org.json.JSONObject;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class selectScheduleHandlers {


    public static void selectSchedulingWithComputingTheDate(String runEvery, LocalDateTime scheduleLocalDateTime) throws Exception {
        String onTimeText = DateTimeFormatter.ofPattern("hh:mm a").format(scheduleLocalDateTime);
        switch (runEvery.toLowerCase()) {
            case "weekly":
                WebUiTools.checkElements("Schedule Day", "", false);
                BasicOperationsHandler.setTextField("Scheduling At Time", onTimeText);
                WebUiTools.check("Schedule Day", getWeekDayAsText(scheduleLocalDateTime), true);
                break;
            case "monthly":
                BasicOperationsHandler.setTextField("Scheduling At Time", onTimeText);
                WebUiTools.checkElements("Schedule Month", "", false);
                WebUiTools.check("Schedule Month", getMonthAsText(scheduleLocalDateTime), true);
                BasicOperationsHandler.setTextField("Scheduling On Day of Month", String.valueOf(scheduleLocalDateTime.getDayOfMonth()));
                break;
            case "once":
                BasicOperationsHandler.setTextField("Scheduling On Day", DateTimeFormatter.ofPattern("yyyy-MM-dd").format(scheduleLocalDateTime));
                break;
            case "daily":
            default:
                BasicOperationsHandler.setTextField("Scheduling At Time", onTimeText);
        }
    }

    public static void selectSchedulingAsTexts(JSONObject scheduleJson, String runEvery) throws Exception {
        switch (runEvery.toLowerCase()) {
            case "monthly":
                BasicOperationsHandler.setTextField("Scheduling At Time", scheduleJson.getString("On Time"));
                for (Object aMonthsArray : scheduleJson.getJSONArray("At Months")) {
                    WebUiTools.check("Schedule Month", aMonthsArray.toString(), true);
                }
                BasicOperationsHandler.setTextField("Scheduling On Day of Month", scheduleJson.getString("ON Day of Month"));
                break;
            case "weekly":
                BasicOperationsHandler.setTextField("Scheduling At Time", scheduleJson.getString("On Time"));
                if (scheduleJson.toMap().containsKey("At Week Day")) {
                    for (Object aWeekArray : scheduleJson.getJSONArray("At Week Day")) {
                        WebUiTools.check("Schedule Day", aWeekArray.toString(), true);
                    }
                }
                break;
            case "once":
                if (scheduleJson.toMap().containsKey("On Day"))
                    BasicOperationsHandler.setTextField("Scheduling On Day", scheduleJson.getString("On Day").trim());
                break;
            case "daily":
            default:
                BasicOperationsHandler.setTextField("Scheduling At Time", scheduleJson.getString("On Time"));
        }
    }


    private static String getMonthAsText(LocalDateTime scheduleLocalDateTime) {
        String month = "JAN";
        switch (scheduleLocalDateTime.getMonth().getValue()) {
            case 1:
                month = "JAN";
                break;
            case 2:
                month = "FEB";
                break;
            case 3:
                month = "MAR";
                break;
            case 4:
                month = "APR";
                break;
            case 5:
                month = "MAY";
                break;
            case 6:
                month = "JUN";
                break;
            case 7:
                month = "JUL";
                break;
            case 8:
                month = "AUG";
                break;
            case 9:
                month = "SEP";
                break;
            case 10:
                month = "OCT";
                break;
            case 11:
                month = "NOV";
                break;
            case 12:
                month = "DEC";
                break;
        }
        return month;
    }

    private static String getWeekDayAsText(LocalDateTime scheduleLocalDateTime) {
        String weekDay = "SUN";
        switch ((scheduleLocalDateTime.getDayOfWeek().getValue() % 7) + 1) {
            case 1:
                weekDay = "SUN";
                break;
            case 2:
                weekDay = "MON";
                break;
            case 3:
                weekDay = "TUE";
                break;
            case 4:
                weekDay = "WED";
                break;
            case 5:
                weekDay = "THU";
                break;
            case 6:
                weekDay = "FRI";
                break;
            case 7:
                weekDay = "SAT";
                break;
        }
        return weekDay;
    }


    private void setDateString(String dateSelector, String date) {
        VisionDebugIdsManager.setLabel(dateSelector);
        ReactDateControl reactDateControl = new ReactDateControl(VisionDebugIdsManager.getDataDebugId());
        reactDateControl.type(date, false);
    }
}
