package com.radware.vision.infra.testhandlers.DPM;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.vrm.VRMReportsHandler;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.WebElement;

import java.util.List;
import java.util.Map;

public class DPMReportHandler extends VRMReportsHandler {

    protected void selectDevices(Map<String, String> map) {
        try {
        if (map.containsKey("devices")) {
            JSONArray virtsJsonArray = (JSONArray) new JSONObject(map.get("devices")).get("virts");
            for (int i=0; i<virtsJsonArray.length(); i++)
            {
                BasicOperationsHandler.clickButton("Virtual device",virtsJsonArray.getString(i).trim());
            }

        }else{
            VisionDebugIdsManager.setLabel("Virtual device");
            VisionDebugIdsManager.setParams("");
            List<WebElement> virts = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            if (virts.size() >= 1){
                virts.get(0).click();
                Thread.sleep(3);
            }else{
                BaseTestUtils.report("There is NO virst/device to select",Reporter.FAIL);
            }
        }
        }catch (Exception e){
            BaseTestUtils.report("Failed in scope selection",Reporter.FAIL);
        }
    }

//    protected void validateVRMBase(RootServerCli rootServerCli, String reportName, Map<String, String> map) {
//        super.validateGeneratedReport(reportName,map);
//    }
//


    protected void validateGenratedReportDevices(Map<String,String> map) {
    }

    @Override
    protected void selectTemplate(Map<String, String> map) {
        try {
            VisionDebugIdsManager.setLabel("Template");
            VisionDebugIdsManager.setParams("");
            String reportType = map.getOrDefault("reportType", null);
            WebElement selectTemplate = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            if (selectTemplate.getAttribute("class").contains("collapsed"))
                BasicOperationsHandler.clickButton("Template","");
            if (reportType != null && reportType.equalsIgnoreCase("Network Report")) {
                BasicOperationsHandler.clickButton("Template", "Network Report");
            } else {
                BasicOperationsHandler.clickButton("Template", "Application Report");
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to select Template.", Reporter.FAIL);
        }
    }

    @Override
    protected StringBuilder validateDevices(Object devices, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("devices")) {
            JSONArray actualVirtsJsonArray = (JSONArray) devices;
            JSONObject actualVirt = new JSONObject(actualVirtsJsonArray.get(0).toString());

            JSONArray expectedVirtsJsonArray = (JSONArray) new JSONObject(map.get("devices")).get("virts");
            if (actualVirtsJsonArray.length()!=1 || expectedVirtsJsonArray.length()!=1){
//                BaseTestUtils.report("There is more than one virt.",Reporter.FAIL);
                errorMessage.append("There is more than one virt.").append("\n");
            }
            if (!expectedVirtsJsonArray.getString(0).trim().equalsIgnoreCase(actualVirt.get("name").toString())){
//                BaseTestUtils.report("The actual Virts is: "+actualVirt.get("name")+"but the expected Virt is: "+expectedVirtsJsonArray.getString(0).trim(),Reporter.FAIL);
                errorMessage.append("The actual Virts is: "+actualVirt.get("name")+"but the expected Virt is: "+expectedVirtsJsonArray.getString(0).trim()).append("\n");
            }
        }
        return errorMessage;
    }


}
