package com.radware.vision.infra.testhandlers.vrm;

import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.infra.testhandlers.alteon.securitymonitoring.dashboardview.sslinspection.enums.QuickRange;
import com.radware.vision.infra.utils.TimeUtils;

import java.util.Calendar;
import java.util.GregorianCalendar;

public class VRMReportsDateUtils {
    Long startTimeActual = null;
    Long endTimeActual  = null;
    Long endTimeExpected = null;
    Long startTimeExpected = null;
    String timeFormat = "MMMM d yyyy hh:mm";
    String defaultDate = "July 1 2018 23:59";
    String timeRangeString = "";
    long minute = 1000 * 60;
    GregorianCalendar calendar = new GregorianCalendar();
    public VRMReportsDateUtils() {
    }

    public void setStartEndTime(QuickRange timePeriod){
        try {
            setEndTimeExpected(System.currentTimeMillis());
            initTimeRangeString();
            String startTime = timeRangeString.substring(timeRangeString.indexOf("period") + 7, timeRangeString.indexOf("-") - 1);
            String endTime = timeRangeString.substring(timeRangeString.indexOf("-") + 2, timeRangeString.length());
            startTimeActual = TimeUtils.getEpochTime(startTime, timeFormat);
            endTimeActual = TimeUtils.getEpochTime(endTime, timeFormat);
            startTimeExpected = getExpectedStartTime(timePeriod, System.currentTimeMillis());
        }catch (Exception e){
            throw new IllegalArgumentException(e.getMessage() + "\n" + e.getStackTrace());
        }
    }

    public void initTimeRangeString(){
        ComponentLocator locator = ComponentLocatorFactory.getLocatorById("header-period-title");
        timeRangeString = WebUIUtils.fluentWait(locator.getBy()).getText();
    }

    public Long getExpectedStartTime(QuickRange quickRange, Long endTimeExpected) {
        GregorianCalendar endCalendar = new GregorianCalendar();
        endCalendar.setTimeInMillis(endTimeExpected);
        switch (quickRange) {
            case FIFTEEN_MINUTES:
                endCalendar.add(Calendar.MINUTE, -Integer.parseInt(QuickRange.FIFTEEN_MINUTES.getPeriodIntTimeUnits()));
            case THIRTY_MINUTES:
                endCalendar.add(Calendar.MINUTE, -Integer.parseInt(QuickRange.THIRTY_MINUTES.getPeriodIntTimeUnits()));
            case ONE_HOUR:
                endCalendar.add(Calendar.MINUTE, -Integer.parseInt(QuickRange.ONE_HOUR.getPeriodIntTimeUnits()));
            case ONE_WEEK:
                endCalendar.add(Calendar.MINUTE, -Integer.parseInt(QuickRange.ONE_WEEK.getPeriodIntTimeUnits()));
            case ONE_DAY:
                endCalendar.add(Calendar.MINUTE, -Integer.parseInt(QuickRange.ONE_DAY.getPeriodIntTimeUnits()));
            case ONE_MONTH:
                endCalendar.add(Calendar.MONTH, -Integer.parseInt(QuickRange.ONE_MONTH.getPeriodIntTimeUnits()));
            case THREE_MONTHS:
                endCalendar.add(Calendar.MONTH, -Integer.parseInt(QuickRange.THREE_MONTHS.getPeriodIntTimeUnits()));
        }

        return endCalendar.getTime().getTime();

    }

    public Long getStartTimeActual() {
        return startTimeActual;
    }

    public Long getEndTimeActual() {
        return endTimeActual;
    }

    public Long getStartTimeExpected() {
        return startTimeExpected;
    }

    public Long getEndTimeExpected() {
        return endTimeExpected;
    }

    public void setEndTimeExpected(Long Date) {
        this.endTimeExpected = Date;
    }

    public String getTimeFormat() {
        return timeFormat;
    }

    public GregorianCalendar getCalendar() {
        return calendar;
    }

    public long getMinute() {
        return minute;
    }
}
