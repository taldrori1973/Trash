package com.radware.vision.bddtests.utils;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;

import java.util.HashMap;
import java.util.Map;

import static com.radware.vision.automation.base.TestBase.sutManager;

public class SimulatorUtils {

    public static String convertIpToHexa(String ip) {
        StringBuilder hexa = new StringBuilder();
        String[] ipArray = ip.split("\\.");
        for (String s : ipArray) {
            int temp = Integer.parseInt(s);
            if (temp > 0 && temp <= 255) {
                if (temp < 10) {
                    hexa.append(0).append(temp);
                } else {
                    hexa.append(Integer.toHexString(temp));
                }
            }
        }
        return hexa.toString();
    }


    public static Map<String, String> getNewReportTemplate(Map<String, String> reportsEntry) {
        Map<String, String> newReportEntry = new HashMap<>(reportsEntry);
        String[] application = newReportEntry.get("Application").split(":");
        String template = newReportEntry.get("Template");
        StringBuilder newTemplate = new StringBuilder();
        newTemplate.append(template).append(", Applications:").append(getApplication(application[0], application[1]));
        newReportEntry.remove("Application");
        newReportEntry.put("Template", newTemplate.toString());
        return newReportEntry;
    }

    public static String getApplication(String simSetId, String port) {

        String simIp = sutManager.getTreeDeviceManagement(simSetId).get().getDeviceName();
        if (simIp.isEmpty()) {
            BaseTestUtils.report("Unable to find simulator id", Reporter.FAIL);
            return null;
        }
        return "[Rejith_" + convertIpToHexa(simIp) + ":" + port + "]";
    }
}
