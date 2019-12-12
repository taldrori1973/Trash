package com.radware.vision.infra.testhandlers.alteon.securitymonitoring.dashboardview.sslinspection.enums;

public enum QuickRange {

    FIFTEEN_MINUTES("15m","15","1"),
    THIRTY_MINUTES("30m","15","2"),
    ONE_HOUR("1H","60","5"),
    ONE_WEEK("1W","10080","60"),
    ONE_DAY("1D","1440","5"),
    ONE_MONTH("1M","1","60"),
    THREE_MONTHS("3M","3","60"),
    TODAY("Today","1","1"),
    THIS_WEEK("This Week","",""),
    THIS_MONTH("This Month","",""),
    QUARTER("Quarter","3",""),
    YESTERDAY("Yesterday","1440","5"),
    PREVIOUS_MONTH("Previous Month","1","60");




    String quickRange;
    String periodIntTimeUnits;
    String errorThresholdInTimeUnits;

    QuickRange(String quickRange, String periodInTimeUnits, String errorThresholdInTimeUnits) {
        this.quickRange = quickRange;
        this.errorThresholdInTimeUnits = errorThresholdInTimeUnits;
        this.periodIntTimeUnits = periodInTimeUnits;
    }

    public static QuickRange getQuickRangeEnum(String quickRange) {

        switch (quickRange) {


            case "15m":
                return FIFTEEN_MINUTES;
            case "30m":
                return THIRTY_MINUTES;
            case "1H":
                return ONE_HOUR;
            case "1W":
                return ONE_WEEK;
            case "1D":
                return ONE_DAY;
            case "1M":
                return ONE_MONTH;
            case "3M":
                return THREE_MONTHS;
        }

        return null;

    }

    public String getDataDebugId() {
        return "TimeFrameSelector_" + quickRange;
    }

    public String getQuickRange() {
        return quickRange;
    }

    public String getErrorThresholdInTimeUnits() {
        return errorThresholdInTimeUnits;
    }

    public String getPeriodIntTimeUnits() {
        return periodIntTimeUnits;
    }
}
