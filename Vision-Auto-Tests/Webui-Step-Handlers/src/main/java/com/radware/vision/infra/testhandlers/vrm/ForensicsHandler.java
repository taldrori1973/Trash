package com.radware.vision.infra.testhandlers.vrm;


import com.google.common.collect.Lists;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.vrm.enums.vrmActions;
import com.radware.vision.vision_project_cli.RootServerCli;
import org.apache.commons.lang3.StringUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.By;
import org.openqa.selenium.NoSuchElementException;
import org.openqa.selenium.WebElement;

import java.util.*;

public class ForensicsHandler extends VRMBaseUtilies {


    public void VRMForensicsOperation(vrmActions operationType, String forensicsName, Map<String, String> forensicsEntry, RootServerCli rootServerCli) throws Exception {
        BaseVRMOperation(operationType, forensicsName, forensicsEntry,rootServerCli);
    }

    protected void AMSValidateBase(RootServerCli rootServerCli, String forensicsName, Map<String, String> map) {
    }

    protected void AMSEditBase(String forensicsName, Map<String, String> map) throws TargetWebElementNotFoundException {
        try {
            enterToEdit(forensicsName);
            editSelectBasicInfo(forensicsName, map);
            expandViews(true);
            selectDevices(map);
            selectTimeDefinitionsNew(map);
            editCriteriaNew(map);//
            selectOutputNew(map);
            editScheduleNew(map);
            editFormat(map);
            editShare(map);
            BasicOperationsHandler.clickButton("Submit", "");
        } catch (Exception e) {
            BasicOperationsHandler.clickButton("Cancel");
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    private void editSelectBasicInfo(String forensicsName, Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Basic Info")) {
            selectBasicInfo(forensicsName, map);
        }
    }

    @Override
    protected void editShare(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Share")) {
            WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorById("ftp").getBy()).click();
            BasicOperationsHandler.setTextField("Send.FTP Location", "");
            BasicOperationsHandler.setTextField("Send.FTP Path", "");
            BasicOperationsHandler.setTextField("Send.FTP Username", "");
            BasicOperationsHandler.setTextField("Send.FTP Password", "");
            super.editShare(map);
        }
    }

    private void editOutput(Map<String, String> map) {
        if (map.containsKey("Output")) {
            selectOutput(map);
        }
    }

    protected void editCriteria(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Criteria")) {
            VisionDebugIdsManager.setLabel("Criteria.delete Row");
            VisionDebugIdsManager.setParams("1");
            ComponentLocator deleteButton = ComponentLocatorFactory.getEqualLocatorByDbgId(VisionDebugIdsManager.getDataDebugId());
            WebElement webElement = WebUIUtils.fluentWaitDisplayedEnabled(deleteButton.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
            while (webElement != null) {
                WebUIUtils.fluentWaitClick(deleteButton.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
                BasicOperationsHandler.delay(1);
                webElement = WebUIUtils.fluentWaitDisplayedEnabled(deleteButton.getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
            }
            try {
                BasicOperationsHandler.setTextField("Criteria.Custom textBox", "");
            } catch (TargetWebElementNotFoundException e) {
                BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
            }

            BasicOperationsHandler.clickButton("Criteria.All", "");
            selectCriteria(map);
        }
    }

    protected void editCriteriaNew(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Criteria")) {
            List<WebElement> closeButtons = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByClass("remove-condition-btn").getBy());
            for (WebElement closeButton : closeButtons) {
                closeButton.click();
            }
            selectCriteria(map);
        }
    }

    protected void editGeneral(String forensicsName, Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Basic Info")) {
            String newForensicsName = forensicsName;
            try {
                newForensicsName = new JSONObject(map.get("Basic Info")).getString("forensics name");
            } catch (Exception e) {
            }
            selectBasicInfo(newForensicsName, map);
        }
    }


    private void validateDevices(JSONArray scopeSelection, Map<String, String> map) {
    }

    protected void selectBasicInfo(String forensicsName, Map<String, String> map) throws TargetWebElementNotFoundException {

        try {
            if (BasicOperationsHandler.getText("Name TextField").equals(""))//Create new
                BasicOperationsHandler.setTextField("Name TextField", forensicsName);
            if (map.containsKey("Basic Info")) {
                JSONObject basicInfoJson = new JSONObject(map.get("Basic Info"));
                if (!basicInfoJson.isNull("forensics name"))
                    BasicOperationsHandler.setTextField("Name TextField", basicInfoJson.getString("forensics name"));
                if (!basicInfoJson.isNull("Description"))
                    BasicOperationsHandler.setTextField("Description TextField", basicInfoJson.getString("Description"));
            }
        } catch (TargetWebElementNotFoundException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }

    }

    private void selectOutput(Map<String, String> map) {
        if (map.containsKey("Output")) {
            List outputsList = Arrays.asList(StringUtils.stripAll(map.get("Output").split(",")));
            List<WebElement> outputElements = WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByXpathDbgId("forensics_output_").getBy());
            for (WebElement checkboxElement : outputElements) {
                if (!checkboxElement.getAttribute("data-debug-id").equals("forensics_output_")) {
//                    String checkboxName = checkboxElement.getAttribute("data-debug-id").split("forensics_output_")[1].replaceAll("_", " ");
                    String checkboxName = checkboxElement.getAttribute("data-debug-id").split("forensics_output_")[1];
                    if (outputsList.contains(checkboxName)) {
                        BasicOperationsHandler.setCheckbox("Output Value", checkboxName, true);
                    } else
                        BasicOperationsHandler.setCheckbox("Output Value", checkboxName, false);
                }
            }
        }
    }

    private void selectOutputNew(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Output")) {
            BasicOperationsHandler.clickButton("output.Select Fields");
            selectOutput(map);
        }
    }

//    private void cleanOutput() {
//        BasicOperationsHandler.setCheckbox("output.Action", false);
//        BasicOperationsHandler.setCheckbox("output.Attack ID", false);
//        BasicOperationsHandler.setCheckbox("output.Start Time", false);
//        BasicOperationsHandler.setCheckbox("output.Source IP Address", false);
//        BasicOperationsHandler.setCheckbox("output.Source Port", false);
//        BasicOperationsHandler.setCheckbox("output.Destination IP Address", false);
//        BasicOperationsHandler.setCheckbox("output.Destination Port", false);
//        BasicOperationsHandler.setCheckbox("output.Direction", false);
//        BasicOperationsHandler.setCheckbox("output.Protocol", false);
//        BasicOperationsHandler.setCheckbox("output.Threat Category", false);
//        BasicOperationsHandler.setCheckbox("output.Radware ID", false);
//        BasicOperationsHandler.setCheckbox("output.Device IP Address", false);
//        BasicOperationsHandler.setCheckbox("output.Attack Name", false);
//        BasicOperationsHandler.setCheckbox("output.End Time", false);
//        BasicOperationsHandler.setCheckbox("output.Duration", false);
//        BasicOperationsHandler.setCheckbox("output.Packets", false);
//        BasicOperationsHandler.setCheckbox("output.Mbits", false);
//        BasicOperationsHandler.setCheckbox("output.Physical Port", false);
//        BasicOperationsHandler.setCheckbox("output.Policy Name", false);
//        BasicOperationsHandler.setCheckbox("output.Risk", false);
//        BasicOperationsHandler.setCheckbox("output.VLAN Tag", false);
//    }

    protected void selectCriteria(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Criteria")) {
            JSONArray criteriaJsonArray = new JSONArray();
            try {
                criteriaJsonArray = new JSONArray(map.get("Criteria"));
            } catch (Exception e) {
                JSONObject criteriaJsonObject = new JSONObject(map.get("Criteria"));
                criteriaJsonArray.put(criteriaJsonObject);
            }
            for (int i = 0; i < criteriaJsonArray.length(); i++) {
                Map<String, Object> criteriaObject = new HashMap<>();
                criteriaObject = ((JSONObject) criteriaJsonArray.get(i)).toMap();
                if (criteriaObject.containsKey("Event Criteria")) {
                    addCriteria(criteriaObject);
                }
                if (criteriaObject.containsKey("Criteria.Custom checkBox") || criteriaObject.containsKey("Criteria.All") || criteriaObject.containsKey("Criteria.Any")) {
                    if (criteriaObject.containsKey("Criteria.Custom checkBox")) {
                        BasicOperationsHandler.clickButton("Criteria.Custom checkBox", "");
                        BasicOperationsHandler.clickButton("Criteria.Custom textBox", "");
                        BasicOperationsHandler.setTextField("Criteria.Custom textBox", criteriaObject.get("Criteria.Custom checkBox").toString());

                    } else if (criteriaObject.containsKey("Criteria.Any")) {
                        BasicOperationsHandler.clickButton("Criteria.Any");
                    } else {
                        BasicOperationsHandler.clickButton("Criteria.All");
                    }
                }
            }

        }
    }

    protected void selectActionSelectItemFromDropDown(String label, String eventCriteria) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams("");
        WebElement dropDownExpand = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (!dropDownExpand.getAttribute("class").contains("expanded-")) {
            dropDownExpand.click();
        }
        dropDownExpand.findElement(By.xpath("..")).findElement(By.xpath("div/div[text()='" + eventCriteria + "']")).click();
    }

    protected void selectMultiActionSelectItemFromDropDown(String label, List<String> eventCriterias) {
        VisionDebugIdsManager.setLabel(label);
        VisionDebugIdsManager.setParams("");
        WebElement dropDownExpand = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy());
        if (!dropDownExpand.getAttribute("class").contains("expanded-")) {
            dropDownExpand.click();
            for (String eventCriteria : eventCriterias) {
                if (!dropDownExpand.findElement(By.xpath("..")).findElement(By.xpath("div/div[text()='" + eventCriteria + "']")).getAttribute("class").contains("selected"))
                    dropDownExpand.findElement(By.xpath("..")).findElement(By.xpath("div/div[text()='" + eventCriteria + "']")).click();
            }
        }
    }

    private void addCriteria(Map<String, Object> criteriaObject) throws TargetWebElementNotFoundException {
        String eventCriteria = criteriaObject.get("Event Criteria").toString();
        selectActionSelectItemFromDropDown("Criteria.Event Criteria", eventCriteria);
        selectActionSelectItemFromDropDown("Criteria.Operator", criteriaObject.get("Operator").toString());
        switch (eventCriteria.toUpperCase()) {
            case "ACTION":
            case "DIRECTION":
            case "DURATION":
            case "PROTOCOL":
            case "RISK":
            case "THREAT CATEGORY": {
                String valuesText = criteriaObject.get("Value").toString();
                if (valuesText.charAt(0) == '[') {
                    valuesText = valuesText.replaceAll("(\\[)|(])", "");
                }
                String[] valuesArray = valuesText.split(",");
                List<String> valueEntries = new ArrayList<>();
                for (String aValuesArray : valuesArray) {
                    valueEntries.add(aValuesArray.trim());
                }
                selectMultiActionSelectItemFromDropDown("Criteria.ValueNew", valueEntries);
            }

            case "RADWARE ID":
            case "ATTACK NAME": {
                BasicOperationsHandler.setTextField("Criteria.ValueTextBoxNew", criteriaObject.get("Value").toString());
                break;
            }

            case "DESTINATION IP":
            case "SOURCE IP": {
                String IPType = criteriaObject.get("IPType").toString();
                String IPValue = criteriaObject.get("IPValue").toString();
                selectActionSelectItemFromDropDown("Criteria.ipType", IPType);
                BasicOperationsHandler.setTextField("Criteria.ipValue", IPValue);
                break;
            }

            case "DESTINATION PORT":
            case "SOURCE PORT": {
                String portType = criteriaObject.get("portType").toString();
                if (portType.equalsIgnoreCase("Port") || portType.equalsIgnoreCase("single")) {
                    String portValue = criteriaObject.get("portValue").toString();
                    portType = "single";
                    selectActionSelectItemFromDropDown("Criteria.portType", portType);
                    BasicOperationsHandler.setTextField("Criteria.portValue", portValue);
                }
                if (portType.equalsIgnoreCase("Port Range") || portType.equalsIgnoreCase("range")) {
                    String from = criteriaObject.get("portFrom").toString();
                    String to = criteriaObject.get("portTo").toString();
                    portType = "range";
                    selectActionSelectItemFromDropDown("Criteria.portType", portType);
                    BasicOperationsHandler.setTextField("Criteria.portFrom", from);
                    BasicOperationsHandler.setTextField("Criteria.portTo", to);
                }
                break;
            }

            case "ATTACK RATE IN BPS":
            case "ATTACK RATE IN PPS": {
                String rateValue = criteriaObject.get("RateValue").toString();
                BasicOperationsHandler.setTextField("Criteria.RateValue", rateValue);
                String unit = criteriaObject.get("Unit").toString();
                selectActionSelectItemFromDropDown("Criteria.Unit", unit);
                break;
            }
        }
        BasicOperationsHandler.clickButton("Criteria.Add Rule", "");
        BasicOperationsHandler.clickButton("Criteria.Add Rule", "");
    }

    @Override
    protected void generateView(String viewName) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Views.Generate Now", viewName);
        BasicOperationsHandler.clickButton("Views.report", viewName);
    }

    @Override
    protected List<String> getViewsList(int maxValue) throws TargetWebElementNotFoundException {
        List<String> snapshotsName = new ArrayList<>();
        snapshotsName.clear();
        for (int i = 0; i < maxValue + 1; i++) {
            generateView("validateMaxViews");
            WebElement iGenerationElement = BasicOperationsHandler.getDisplayedWebElement("Views.reportIndex", "validateMaxViews_0");
            if (iGenerationElement == null) {
                throw new TargetWebElementNotFoundException("No view with name validateMaxViews");
            }
            snapshotsName.add(i, iGenerationElement.getText());
        }
        snapshotsName = Lists.reverse(snapshotsName);
        return snapshotsName;
    }

    //    @Override
    protected List<WebElement> getSnapshotElements() {
        return WebUIUtils.fluentWaitMultiple(ComponentLocatorFactory.getLocatorByDbgId("Vrm_forensic_Snapshot_validateMaxViews_").getBy());
    }

    /**************************************************************************************************************************************************/
    // new forensics UI
    protected void AMSCreateBase(String forensicsName, Map<String, String> map) throws TargetWebElementNotFoundException {
        try {
            deleteVRMBase(forensicsName);
            BasicOperationsHandler.clickButton("Add", "");
            selectBasicInfo(forensicsName, map);
            expandViews(true);
            selectProductNew(map);
            selectDevices(map);
            selectTimeDefinitionsNew(map);
            selectCriteria(map);
            selectOutputNew(map);
            selectScheduleNew(map);
            format(map);
            share(map);
            BasicOperationsHandler.clickButton("Submit", "");
        } catch (Exception e) {
            BasicOperationsHandler.clickButton("Cancel");
            BaseTestUtils.report("cause " + e.getMessage(), Reporter.FAIL);
        }
    }

    @Override
    protected void share(Map<String, String> map) throws TargetWebElementNotFoundException {
        if (map.containsKey("Share")) {
            JSONObject deliveryJsonObject = new JSONObject(map.get("Share"));
            super.share(map);
            if (!deliveryJsonObject.isNull("FTP")) {
                WebUIUtils.scrollIntoView(ComponentLocatorFactory.getLocatorById("ftp"));
                WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorById("ftp").getBy()).click();
                if (!deliveryJsonObject.isNull("FTP.Location"))
                    BasicOperationsHandler.setTextField("Send.FTP Location", deliveryJsonObject.getString("FTP.Location"));
                if (!deliveryJsonObject.isNull("FTP.Path"))
                    BasicOperationsHandler.setTextField("Send.FTP Path", deliveryJsonObject.getString("FTP.Path"));
                if (!deliveryJsonObject.isNull("FTP.Username"))
                    BasicOperationsHandler.setTextField("Send.FTP Username", deliveryJsonObject.getString("FTP.Username"));
                if (!deliveryJsonObject.isNull("FTP.Password"))
                    BasicOperationsHandler.setTextField("Send.FTP Password", deliveryJsonObject.getString("FTP.Password"));
            }
        }
    }

    @Override
    protected void generateVRMBase(String reportName, Map<String, String> map) throws TargetWebElementNotFoundException {
        generate(reportName, map);
    }

    @Override
    protected Map<String, String> getReportLogStatus(WebElement reportContainer) {
        Map<String, String> status = new HashMap<>();
        int listSize = 0;
        String time = "";
        List<WebElement> reportDateCreationElements;
        try {
            reportDateCreationElements = reportContainer.findElements(By.className("time"));
            if (reportDateCreationElements != null && reportDateCreationElements.size() > 0)
                listSize = reportDateCreationElements.size();

            if (listSize > 0) {
                String firstLog = reportDateCreationElements.get(0).getText();
                String[] firstLogTokens = firstLog.trim().split("\n");
                time = firstLogTokens[0];
            }
            status.put("logSize", String.valueOf(listSize));
            status.put("lastLogTime", time);
        } catch (NoSuchElementException e) {
            status.put("logSize", "0");
            status.put("lastLogTime", "None");
            return status;
        }
        return status;
    }

    @Override
    protected WebElement clickableTimeout(WebElement webElemnt, long timeOut) {
        if (webElemnt == null)
            return null;
        boolean noNeedToWait = false;
        long waitingSeconds = 0;
        while (!noNeedToWait && waitingSeconds < timeOut) {
            if (!webElemnt.getAttribute("class").contains("disabled")) {
                noNeedToWait = true;
            }
            WebUIUtils.sleep(1);
            waitingSeconds++;
        }
        if (waitingSeconds == timeOut) return null;
        return webElemnt;
    }
}