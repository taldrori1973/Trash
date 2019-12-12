package com.radware.vision.infra.testhandlers.alteon.securitymonitoring.dashboardview.sslinspection.enums;

public enum ReportPeriod {

    LAST_DAY("Last 1 Day", "now-id"),
    LAST_WEEK("Last 1 Week", "now-iw"),
    LAST_MONTH("Last 1 Months", "now-im"),
    LAST_THREE_MONTHS("last 3 Months", "now-3m"),
    LAST_SIX_MONTHS("Last 6 Months", "now-6m"),
    LAST_YEAR("Last 1 Year", "now-1y");


    private String reportPeriod;
    private String dataDebugId;

    ReportPeriod(String reportPeriod, String dataDebugId) {
        this.reportPeriod = reportPeriod;
        this.dataDebugId = dataDebugId;

    }

    public static ReportPeriod getReportPeriodEnum(String reportPeriod) {

        switch (reportPeriod) {

            case "Last 1 Day":
                return LAST_DAY;

            case "Last 1 Week":
                return LAST_WEEK;

            case "Last 1 Month":
                return LAST_MONTH;

            case "last 3 Months":
                return LAST_THREE_MONTHS;

            case "Last 6 Months":
                return LAST_SIX_MONTHS;

            case "Last 1 Year":
                return LAST_YEAR;
        }
        return null;
    }

    public String getReportPeriodEnum() {
        return reportPeriod;
    }

    public String getDataDebugId() {
        return dataDebugId;
    }


}
