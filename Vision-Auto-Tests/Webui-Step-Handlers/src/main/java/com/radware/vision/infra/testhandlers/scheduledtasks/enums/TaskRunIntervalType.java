package com.radware.vision.infra.testhandlers.scheduledtasks.enums;

public enum TaskRunIntervalType {

    RUN_ONCE("Once"),
    RUN_DAILY("Daily"),
    RUN_MINUTES("Minutes"),
    RUN_WEEKLY("Weekly"),
    ONE_HOUR("1 Hour"),
    THREE_HOURS("3 Hours"),
    SIX_HOURS("6 Hours"),
    TWELVE_HOURS("12 Hours");


    String runType;

    private TaskRunIntervalType(String runType) {
        this.runType = runType;
    }

    public String getRunType() {
        return this.runType;
    }
    public static TaskRunIntervalType getTypeByValue(String runType) {
        for (TaskRunIntervalType e : TaskRunIntervalType.values())  {
            if (e.runType.equals(runType)) return e;
        }
        return null;
    }

}
