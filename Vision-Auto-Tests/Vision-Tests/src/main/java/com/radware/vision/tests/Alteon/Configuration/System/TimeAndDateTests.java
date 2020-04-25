package com.radware.vision.tests.Alteon.Configuration.System;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.TimeAndDateHandler;
import com.radware.vision.tests.Alteon.AlteonTestBase;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by konstantinr on 6/7/2015.
 */
public class TimeAndDateTests extends AlteonTestBase {
    GeneralEnums.State ntp = GeneralEnums.State.DISABLE;
    String time;
    String date;
    GeneralEnums.IpVersion primaryIPVersion;
    GeneralEnums.IpVersion secondaryIPVersion;
    String primaryIPAddress;
    String secondaryIPAddress;
    String SynchInterval;
    String TimeZoneOffset;
    String timezone;

    @Test
    @TestProperties(name = "Set Time and Date Settings" , paramsInclude = {"qcTestId", "deviceState", "deviceIp",
            "deviceName", "parentTree", "date", "time" , "timezone", "ntp", "primaryIPVersion", "primaryIPAddress",
            "secondaryIPVersion", "secondaryIPAddress", "SynchInterval", "TimeZoneOffset"} )
    public void setTimeAndDateSettings()throws IOException {
        try{
            testProperties.put("ntp", ntp.toString());
            testProperties.put("time", time);
            testProperties.put("date", date);
            testProperties.put("timezone", timezone);
            testProperties.put("primaryIPVersion", primaryIPVersion.toString());
            testProperties.put("secondaryIPVersion", primaryIPVersion.toString());
            testProperties.put("primaryIPAddress", primaryIPAddress);
            testProperties.put("secondaryIPAddress", secondaryIPAddress);
            testProperties.put("SynchInterval", SynchInterval);
            testProperties.put("TimeZoneOffset", TimeZoneOffset);
            TimeAndDateHandler.setTimeAndDateSettings(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
        }
    }


    public HashMap<String, String> getTestProperties() {
        return testProperties;
    }

    public void setTestProperties(HashMap<String, String> testProperties) {
        this.testProperties = testProperties;
    }

    public String getTime() {
        return time;
    }

    @ParameterProperties(description = "HH:mm:ss")
    public void setTime(String time) {
        this.time = time;
    }

    public String getDate() {
        return date;
    }

    @ParameterProperties(description = "MM/dd/yyyy")
    public void setDate(String date) {
        this.date = date;
    }

    public GeneralEnums.IpVersion getPrimaryIPVersion() {
        return primaryIPVersion;
    }

    public void setPrimaryIPVersion(GeneralEnums.IpVersion primaryIPVersion) {
        this.primaryIPVersion = primaryIPVersion;
    }

    public GeneralEnums.IpVersion getSecondaryIPVersion() {
        return secondaryIPVersion;
    }

    public void setSecondaryIPVersion(GeneralEnums.IpVersion secondaryIPVersion) {
        this.secondaryIPVersion = secondaryIPVersion;
    }

    public String getPrimaryIPAddress() {
        return primaryIPAddress;
    }

    public void setPrimaryIPAddress(String primaryIPAddress) {
        this.primaryIPAddress = primaryIPAddress;
    }

    public String getSecondaryIPAddress() {
        return secondaryIPAddress;
    }

    public void setSecondaryIPAddress(String secondaryIPAddress) {
        this.secondaryIPAddress = secondaryIPAddress;
    }

    public String getSynchInterval() {
        return SynchInterval;
    }

    @ParameterProperties(description = "Min")
    public void setSynchInterval(String synchInterval) {
        SynchInterval = synchInterval;
    }

    public String getTimeZoneOffset() {
        return TimeZoneOffset;
    }

    @ParameterProperties(description = "-HH:mm")
    public void setTimeZoneOffset(String timeZoneOffset) {
        TimeZoneOffset = timeZoneOffset;
    }

    public GeneralEnums.State getNtp() {
        return ntp;
    }

    public void setNtp(GeneralEnums.State ntp) {
        this.ntp = ntp;
    }

    public String getTimezone() {
        return timezone;
    }

    public void setTimezone(String timezone) {
        this.timezone = timezone;
    }


}