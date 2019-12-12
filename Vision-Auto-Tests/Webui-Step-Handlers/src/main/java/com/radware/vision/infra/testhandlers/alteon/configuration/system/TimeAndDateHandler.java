package com.radware.vision.infra.testhandlers.alteon.configuration.system;

import com.radware.automation.webui.webpages.configuration.system.TimeAndDate.TimeAndDate;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by konstantinr on 6/7/2015.
 */
public class TimeAndDateHandler extends BaseHandler {

    public static void setTimeAndDateSettings(HashMap<String, String> testProperties) throws TargetWebElementNotFoundException {
        TimeAndDate timeAndDate = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mTimeAndDate();
        initLockDevice(testProperties);
        timeAndDate.openPage();

        if (testProperties.get("date")!=null){
        timeAndDate.setDate(testProperties.get("date"));}

        if (testProperties.get("time")!=null){
        timeAndDate.setTime(testProperties.get("time"));}

        if (testProperties.get("timezone")!=null){
        timeAndDate.setTimeZone(testProperties.get("timezone"));}

        if (testProperties.get("ntp").equals("Enable")){
            timeAndDate.enableNTP();
        }
        if (testProperties.get("ntp").equals("Disable")){
            timeAndDate.disableNTP();
        }

        timeAndDate.setPrimaVer(testProperties.get("primaryIPVersion"));
        timeAndDate.setSeconVer(testProperties.get("secondaryIPVersion"));

        if (testProperties.get("primaryIPVersion").equals("IPv4")) {
            timeAndDate.setPrimaAddr(testProperties.get("primaryIPAddress"));
        }
        if (testProperties.get("primaryIPVersion").equals("IPv6")) {
            timeAndDate.setPrimaIpv6Addr(testProperties.get("primaryIPAddress"));
        }
        if (testProperties.get("secondaryIPVersion").equals("IPv4")) {
            timeAndDate.setSeconAddr(testProperties.get("secondaryIPAddress"));
        }
        if (testProperties.get("secondaryIPVersion").equals("IPv6")) {
            timeAndDate.setsecondryIpv6Addr(testProperties.get("secondaryIPAddress"));
        }

        if (testProperties.get("SynchInterval")!=null){
        timeAndDate.setSynchInterval(testProperties.get("SynchInterval"));}

        if (testProperties.get("TimeZoneOffset")!=null){
        timeAndDate.setTimeZoneOffset(testProperties.get("TimeZoneOffset"));}
        timeAndDate.submit();
    }
}
