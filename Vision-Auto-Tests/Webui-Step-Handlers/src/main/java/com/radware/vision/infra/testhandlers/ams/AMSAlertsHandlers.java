package com.radware.vision.infra.testhandlers.ams;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIDropdownStandard;
import com.radware.vision.automation.DatabaseStepHandlers.elasticSearch.ElasticSearchHandler;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.ams.enums.vrmActions;
import com.radware.vision.vision_project_cli.RootServerCli;
import org.json.JSONException;
import org.json.JSONObject;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class AMSAlertsHandlers extends ForensicsHandler {


    public void AMSAlertsOperation(vrmActions operationType, String alertsName, Map<String, String> alertsEntry) throws Exception {
        BaseAMSOperation(operationType, alertsName, alertsEntry);
    }

    protected void AMSEditBase(String alertsName, Map<String, String> map) throws TargetWebElementNotFoundException {
        try {
            enterToEdit(alertsName);
            expandViews(true);
            selectBasicInfo(alertsName, map);
            selectDevices(map);
            editCriteriaNew(map);
            selectSchedule(map);
            editShare(map);
            BasicOperationsHandler.clickButton("Submit", "");
        } catch (Exception e) {
            BasicOperationsHandler.clickButton("Cancel");
        }


    }

    protected void AMSValidateBase(RootServerCli rootServerCli, String alertsName, Map<String, String> map) {
        ElasticSearchHandler.waitForESDocument("rt-alert-def-vrm-ty-rt-alert-def-vrm", "name",
                alertsName, 0);
        JSONObject basicRestResult = ElasticSearchHandler.getESDocumentByField("rt-alert-def-vrm-ty-rt-alert-def-vrm",
                "name", alertsName);
        if (basicRestResult == null) {
            BaseTestUtils.report("Could not find document: " + alertsName, Reporter.FAIL);
            return;
        }
            try {
                StringBuilder errorMessage = new StringBuilder();
                String ObjectString = basicRestResult.get("content").toString().replace("\\", "");
                JSONObject restResult = new JSONObject(ObjectString);
                errorMessage.append(AMSReportsHandler.validateCustomizedOption(restResult, map, alertsName));
                errorMessage.append(AMSReportsHandler.validateDevices(restResult.getJSONArray("scopeSelection"), map));
                errorMessage.append(AMSReportsHandler.validateTimeDefinitions(restResult.get("timeRange"), map));
                errorMessage.append(AMSReportsHandler.validateSchedule(basicRestResult.get("schedulingDefinition"), map));
                errorMessage.append(AMSReportsHandler.validateDelivery(basicRestResult.get("deliveryMethod"), map));
                errorMessage.append(AMSReportsHandler.validateDesign(restResult.get("currentGridsterContent"), map));
                errorMessage.append(AMSReportsHandler.validateFormat(basicRestResult.get("exportFormat"), map));
                if (errorMessage.length() != 0)
                    BaseTestUtils.report(errorMessage.toString(), Reporter.FAIL);
            } catch (JSONException e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }

    protected void AMSCreateBase(String alertsName, Map<String, String> map) throws TargetWebElementNotFoundException {
        try {
            deleteVRMBase(alertsName);
            BasicOperationsHandler.clickButton("Add New", "");
            expandViews(true);
            selectBasicInfo(alertsName, map);
            selectProductNew(map);
            selectDevices(map);
            selectCriteria(map);
            selectSchedule(map);
            share(map);
            BasicOperationsHandler.clickButton("Submit", "");
        } catch (Exception e) {
            BasicOperationsHandler.clickButton("Cancel");
        }
    }

    protected void editSchedule(Map<String, String> map) throws TargetWebElementNotFoundException {
        selectSchedule(map);
    }

    protected void selectCriteria(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Criteria")) {
            super.selectCriteria(map);
        } else {
            BasicOperationsHandler.newSelectItemFromDropDown("Criteria.Event Criteria", "Action");
            BasicOperationsHandler.newSelectItemFromDropDown("Criteria.Operator", "Equals");
            List<String> valueEntries = new ArrayList<>();
            valueEntries.add("Proxy");
            valueEntries.add("Drop");
            BasicOperationsHandler.multiSelectItemFromDropDown("Criteria.Value", valueEntries, true);
            BasicOperationsHandler.clickButton("Criteria.Add Rule");
        }
    }

    protected void selectSchedule(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Schedule")) {
            Map<String, Object> scheduleMap = new JSONObject(map.get("Schedule")).toMap();
            switch (scheduleMap.getOrDefault("checkBox", "").toString()) {
                case "Trigger":
                    BasicOperationsHandler.clickButton("Schedule.Trigger");
                    break;
                default:
                    BasicOperationsHandler.clickButton("Schedule.Custom");
                    BasicOperationsHandler.setTextField("Schedule.Trigger this rule", scheduleMap.getOrDefault("triggerThisRule", "0").toString());
                    BasicOperationsHandler.setTextField("Schedule.Within", scheduleMap.getOrDefault("Within", "0").toString());
//                    BasicOperationsHandler.selectItemFromDropDown("Schedule.Select time unit", scheduleMap.getOrDefault("selectTimeUnit", "").toString());
                    break;
            }
            BasicOperationsHandler.setTextField("Schedule.Alerts per hour", scheduleMap.getOrDefault("alertsPerHour", "8").toString());
        }
    }

    protected void selectBasicInfo(String alertsName, Map<String, String> map) throws TargetWebElementNotFoundException {
//        super.selectBasicInfo(alertsName, map);
        if (BasicOperationsHandler.getText("Name TextField").equals(""))//Create new
            BasicOperationsHandler.setTextField("Name TextField", alertsName);
        if (map.containsKey("Basic Info")) {
            JSONObject basicInfoJson = new JSONObject(map.get("Basic Info"));

            try{
                if (!basicInfoJson.isNull("Name"))
                    BasicOperationsHandler.setTextField("Name TextField", basicInfoJson.getString("Name"));
                if (!basicInfoJson.isNull("Description"))
                    BasicOperationsHandler.setTextField("Basic Info.Description", basicInfoJson.getString("Description"));
                if (!basicInfoJson.isNull("Impact")){
                    BasicOperationsHandler.setTextField("Basic Info.Impact", basicInfoJson.getString("Impact"));
                }
                if (!basicInfoJson.isNull("Remedy")){
                    BasicOperationsHandler.setTextField("Basic Info.Remedy", basicInfoJson.getString("Remedy"));
                }
                String severity= "Severity";
                if (!basicInfoJson.isNull(severity)){
                    VisionDebugIdsManager.setLabel("Basic Info.Severity");
                    ComponentLocator severityLocator = ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
                    WebUIDropdownStandard severityLocatorWeUI = new WebUIDropdownStandard();
                    severityLocatorWeUI.setLocator(severityLocator);
                    severityLocatorWeUI.selectOptionByText(basicInfoJson.getString("Severity"));
                }

            }catch (TargetWebElementNotFoundException e){
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }
        }
    }

    public void checkORUncheckToggleAlerts(boolean isCheck) {
//        int alertSize = getAlertSize();
//        if (isCheck) {
//            for (int i = 1; i <= alertSize; i++) {
//                ComponentLocator labelLocator = new ComponentLocator(How.XPATH, "(//*[contains(@data-debug-id,'vrm-alerts-toggle-alerts-')])[" + i + "]");
//                WebUICheckbox checkboxElement = new WebUICheckbox(labelLocator);
//                if(checkboxElement.getAttribute("class").contains("closed"))
//                {
//                    checkboxElement.click();
//                }
//            }
//        } else {
//            for (int i = 1; i <= alertSize; i++) {
//                ComponentLocator labelLocator = new ComponentLocator(How.XPATH, "(//*[contains(@data-debug-id,'vrm-alerts-toggle-alerts-')])[" + i + "]");
//                WebUICheckbox checkboxElement = new WebUICheckbox(labelLocator);
//                if(checkboxElement.getAttribute("class").contains("open"))
//                {
//                    checkboxElement.click();
//                }
//            }
//        }

        ComponentLocator labelLocator = new ComponentLocator(How.XPATH, "//*[contains(@class,'toggleAlertsTitle all')]");
        WebUICheckbox checkboxElement = new WebUICheckbox(labelLocator);
        if(isCheck)
        {
            if(checkboxElement.getAttribute("class").contains("Uncheck"))
            {
                checkboxElement.click();
            }
        }
        else
        {
            if(checkboxElement.getAttribute("class").contains("Check"))
            {
                checkboxElement.click();
            }
        }

    }

    private int getAlertSize() {

        int size;
        try
        {
            size = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByDbgId("vrm-alerts-toggle-alerts-").getBy()).size();
        }
        catch (Exception e)
        {
            size = 0;
        }
        return size;
    }

    public void checkORUncheckSpecificToogleAlert(boolean isCheck, String alertName) {

        ComponentLocator labelLocator = new ComponentLocator(How.XPATH, "(//*[contains(@data-debug-id,'vrm-alerts-toggle-alerts-" + alertName + "')])");
        WebUICheckbox checkboxElement = new WebUICheckbox(labelLocator);
        if (isCheck) {

                if(checkboxElement.getAttribute("class").contains("closed"))
                {
                    checkboxElement.click();
                }
        } else {
                if(checkboxElement.getAttribute("class").contains("open"))
                {
                    checkboxElement.click();
                }
        }

    }
}
