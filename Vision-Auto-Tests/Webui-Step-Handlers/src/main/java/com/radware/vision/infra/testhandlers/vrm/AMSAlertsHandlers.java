package com.radware.vision.infra.testhandlers.vrm;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.impl.WebUICheckbox;
import com.radware.automation.webui.widgets.impl.WebUIDropdownStandard;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.tools.exceptions.web.DropdownItemNotFoundException;
import com.radware.vision.automation.tools.exceptions.web.DropdownNotOpenedException;
import com.radware.vision.vision_project_cli.RootServerCli;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.vrm.enums.vrmActions;
import org.json.JSONObject;
import org.openqa.selenium.support.How;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class AMSAlertsHandlers extends ForensicsHandler {


    public void VRMAlertsOperation(vrmActions operationType, String alertsName, Map<String, String> alertsEntry, RootServerCli rootServerCli) throws Exception {
        BaseVRMOperation(operationType, alertsName, alertsEntry, rootServerCli);
    }

    protected void editVRMBase(String alertsName, Map<String, String> map) throws Exception {
        enterToEdit(alertsName);
        editGeneral(alertsName, map);
        BasicOperationsHandler.clickButton("Scope Selection Card", "initial");
        editDevices(map);
        BasicOperationsHandler.clickButton("Criteria Card", "initial");
        editCriteria(map);
        BasicOperationsHandler.clickButton("Schedule Card", "initial");
        editSchedule(map);
        BasicOperationsHandler.clickButton("Delivery Card", "initial");
        editDelivery(map);
        BasicOperationsHandler.clickButton("Summary Card", "initial");
        BasicOperationsHandler.clickButton("Submit", "");
    }

    protected void editVRMBaseNew(String alertsName, Map<String, String> map) throws TargetWebElementNotFoundException {
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

    protected void validateVRMBase(RootServerCli rootServerCli, String alertsName, Map<String, String> map) {
    }

    protected void createVRMBase(String alertsName, Map<String, String> map) throws Exception {
        try {
            EnterToCreatingView(alertsName);
            selectBasicInfo(alertsName, map);
            BasicOperationsHandler.clickButton("Next", "");
            selectDevices(map);
            BasicOperationsHandler.clickButton("Next", "");
            selectCriteria(map);
            BasicOperationsHandler.clickButton("Next", "");
            selectSchedule(map);
            BasicOperationsHandler.clickButton("Next", "");
            Delivery(map);
            BasicOperationsHandler.clickButton("Next", "");
            BasicOperationsHandler.clickButton("Submit", "");
        } finally {
            try {
                VisionDebugIdsManager.setLabel("Close");
                ComponentLocator closeLocator = ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
                WebUIUtils.fluentWaitClick(closeLocator.getBy(), 2, false);
                BasicOperationsHandler.clickButton("Close", "");
            } catch (Exception e) {

            }
        }
    }

    protected void createVRMBaseNew(String alertsName, Map<String, String> map) throws TargetWebElementNotFoundException {
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
                String severity = "Basic Info.Severity";
                switch (oldOrNew)
                {
                    case "new":severity = "Severity";
                }
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
        if(checkboxElement==null)
            BaseTestUtils.report("Could not find checkbox with locator: " + labelLocator.toString(), Reporter.FAIL);
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
