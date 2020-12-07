package com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Report;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.bddtests.ReportsForensicsAlerts.WebUiTools;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.Keys;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.How;


import java.util.*;
import java.util.stream.Collectors;

import static com.radware.vision.infra.testhandlers.BaseHandler.devicesManager;
import static org.apache.commons.lang.math.NumberUtils.isNumber;


public class TemplateHandlers {


    public static void addTemplate(JSONObject templateJsonObject, String reportName) throws Exception {
        String reportType = templateJsonObject.get("reportType").toString();
        addTemplateType(reportType);
        String currentTemplateName = getCurrentTemplateName(reportType);
        addWidgets(new JSONArray(templateJsonObject.get("Widgets").toString()), currentTemplateName);
        setSummaryTable(templateJsonObject, currentTemplateName);
        getScopeSelection(templateJsonObject, currentTemplateName.split(reportType).length != 0 ? currentTemplateName.split(reportType)[1] : "").create();
        Report.updateReportsTemplatesMap(reportName, templateJsonObject.get("templateAutomationID").toString(), currentTemplateName);
    }


    private static ScopeSelection getScopeSelection(JSONObject templateJsonObject, String templateParam) {
        switch (templateJsonObject.get("reportType").toString().toUpperCase()) {
            case "HTTPS FLOOD":
                return new HTTPSFloodScopeSelection(new JSONArray(templateJsonObject.get("Servers").toString()), templateParam);
            case "DEFENSEFLOW ANALYTICS":
                return new DFScopeSelection(new JSONArray(templateJsonObject.get("Protected Objects").toString()), templateParam);
            case "APPWALL":
                return new AWScopeSelection(new JSONArray(templateJsonObject.get("Applications").toString()), templateParam);
            case "SYSTEM AND NETWORK":
                return new SystemAndNetworkScopeSelection(new JSONArray(templateJsonObject.get("Applications").toString()), templateParam);
            case "APPLICATION":
                return new ApplicationScopeSelection(new JSONArray(templateJsonObject.get("Applications").toString()), templateParam);
            case "EAAF":
//                return new EAAFScopeSelection(new JSONArray(templateJsonObject.get("devices").toString()), templateParam);
                return new EAAFScopeSelection(new JSONArray(), templateParam);
            case "DEFENSEPRO ANALYTICS":
            case "DEFENSEPRO BEHAVIORAL PROTECTIONS":
            default:
                return new DPScopeSelection(new JSONArray(templateJsonObject.get("devices").toString()), templateParam);
        }
    }

    private static void addWidgets(JSONArray widgets, String reportType) {
        List<String> widgetsList = getWidgetsList(widgets);
        List<String> widgetsToRemove = new ArrayList<>();
        if (widgetsList.contains("ALL") || widgetsList.contains("All")) {
            if (widgets.toList().get(widgetsList.indexOf("ALL")).getClass().getName().contains("HashMap")) { ///// if ALL has widgets with options
                selectAllOptions((HashMap) widgets.toList().get(widgetsList.indexOf("ALL")), reportType);
            }
            widgetsList.removeAll(Collections.singleton("ALL"));
            widgetsToRemove = null;

        } else {
            VisionDebugIdsManager.setLabel("canvas widget");
            VisionDebugIdsManager.setParams(reportType);
            List<WebElement> elements = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_RemoveButton')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

            for (WebElement element : elements) {
                String widgetDataDebugId = element.getAttribute("data-debug-id");
                String debugId = VisionDebugIdsManager.getDataDebugId();
                String widgetName = widgetDataDebugId.split(debugId)[1].split("_")[1];
                if (!widgetsList.contains(widgetName)) {
                    widgetsToRemove.add(widgetName);
                } else {
                    widgetsList.remove(widgetName);
                }
            }
        }
        removeUnWantedWidgetsAll(widgetsToRemove, reportType);
        dragAndDropDesiredWidgets(widgetsList, reportType);
        selectOptions(widgets, getOccurrenceMap(widgets), reportType);
    }

    private static void selectAllOptions(Map<String, Object> allMap, String reportType) {
        List<Map<String, Object>> widgetsLst = new ArrayList<>((List) allMap.get("ALL")); /// get all the widgets with options
        for (Object object : widgetsLst) {
            HashMap<String, List<String>> widgetOptions = new HashMap<>((Map) object);
            String widgetName = (String) widgetOptions.keySet().toArray()[0];
            List<String> optionsLst = new ArrayList<>((List) widgetOptions.get(widgetName));
            selectOptions(optionsLst, widgetName, reportType, 0);
        }
    }

    private static void removeUnWantedWidgetsAll(List<String> widgetsToRemoveDataDataDebugId, String reportType) {
        if (widgetsToRemoveDataDataDebugId == null) return;
        VisionDebugIdsManager.setLabel("selected widget");
        for (String widget : widgetsToRemoveDataDataDebugId) {
            try {
                VisionDebugIdsManager.setParams(reportType, widget.concat("_"));
                List<WebElement> elements = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_RemoveButton')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                while (!elements.isEmpty()) {
                    elements.get(0).click();
                    elements = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_RemoveButton')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                }
            } catch (Exception e) {
                BaseTestUtils.report("Failed to remove widget: " + widget, Reporter.FAIL);
                e.printStackTrace();
            }
        }
    }


    private static Map<String, List<Integer>> getOccurrenceMap(JSONArray widgets) {
        if (widgets == null) return null;
        Map<String, List<Integer>> ocuurenceMap = new HashMap<>();
        for (int i = 0; i < widgets.length(); i++) {
            String widgetName;
            List<Integer> list = new ArrayList<>();
            if (widgets.toList().get(i).getClass().getName().contains("HashMap")) {
                Map<String, Object> widgetMap = new HashMap<String, Object>(((HashMap) widgets.toList().get(i)));
                List<String> aList = widgetMap.keySet().stream().collect(Collectors.toList());
                widgetName = aList.get(0);
//                list.add(it.);
            } else {
                widgetName = widgets.getString(i).trim();
                list.add(null);
            }
            if (!ocuurenceMap.containsKey(widgetName)) {
                List<Integer> indexsList = new ArrayList<>();
                indexsList.add(i);
                ocuurenceMap.put(widgetName, indexsList);
            } else {
                ocuurenceMap.get(widgetName).add(i);
            }

        }
        return ocuurenceMap;

    }

    private static void dragAndDropDesiredWidgets(List<String> widgetsList, String reportType) {
        if (widgetsList == null) return;
        try {
            for (String widgetToDrag : widgetsList) {
                VisionDebugIdsManager.setLabel("widget drag");
                VisionDebugIdsManager.setParams(widgetToDrag);
                ComponentLocator sourceLocator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='" + VisionDebugIdsManager.getDataDebugId() + "']");
                VisionDebugIdsManager.setLabel("widgets container");
                VisionDebugIdsManager.setParams(reportType);
                ComponentLocator targetLocator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='" + VisionDebugIdsManager.getDataDebugId() + "' and contains(@class,'TemplateWidgetsContainer')]");
                List<WebElement> widgetElemntsBefore = WebUiTools.getWebElements("selected widget", reportType, widgetToDrag);
                for (int i = 1; i <= 5; i++) {
                    dragAndDrop(sourceLocator, targetLocator);
                    Thread.sleep(3 * 1000);
                    if (WebUiTools.getWebElements("selected widget", reportType, widgetToDrag).size() > widgetElemntsBefore.size())
                        break;
                    if (i == 5) {
                        BaseTestUtils.report("Failed to Drag widget: " + widgetToDrag, Reporter.FAIL);
                    }
                }
            }
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    private static void selectOptions(JSONArray widgets, Map<String, List<Integer>> ocuurenceMap, String reportType) {
        if (widgets == null || ocuurenceMap == null) return;
        for (String widgetName : ocuurenceMap.keySet()) {
            for (int i = 0; i < ocuurenceMap.get(widgetName).size(); i++) {
                if (!widgetName.equalsIgnoreCase("ALL") && widgets.toList().get(ocuurenceMap.get(widgetName).get(i)).getClass().getName().contains("HashMap")) {
                    Map<String, Object> widgetMap = new HashMap<String, Object>(((HashMap) widgets.toList().get(ocuurenceMap.get(widgetName).get(i))));
                    List<String> lst = new ArrayList<>((List) widgetMap.get(widgetName));
                    selectOptions(lst, widgetName, reportType, getWidgetsList(widgets).contains("ALL") ? i + 1 : i);
                }

            }
        }
    }

    private static void selectOptions(List<String> lst, String widgetName, String reportType, int index) {
        VisionDebugIdsManager.setLabel("selected widget");
        VisionDebugIdsManager.setParams(reportType, widgetName);
        List<WebElement> options = null;
        for (String option : lst) {
            try {
                switch (option.toLowerCase()) {
                    case "pps":
                        options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_pps')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                        break;
                    case "bps":
                        options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_bps')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

                        break;
                    case "ipv4":
                        options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_IPv4')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

                        break;
                    case "ipv6":
                        options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_IPv6')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

                        break;
                    case "inbound":
                        options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_Inbound')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

                        break;
                    case "outbound":
                        options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_Outbound')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                        break;
                    case "events":
                        options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_Events')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                        break;
                    case "packets":
                        options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_Packets')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                        break;
                    case "volume":
                        options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_Volume')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                        break;
                    case "all policies":
                        options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_All Policies')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                        break;
                    case "all protected objects":
                        options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_All Protected Objects')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                        break;
                    case "All":
                        options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_All Policies')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                }
                if (options != null) options.get(index).click();
                if (isNumber(option)) {
                    options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_CustomPolicies')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                    options.get(index).click();
                    options.get(index).sendKeys(Keys.chord(Keys.CONTROL, "a", Keys.DELETE));
                    options.get(index).sendKeys(option);
                }
            } catch (Exception e) {
                BaseTestUtils.report(String.format("Failed to select option: %s in widget: %s", option, widgetName), Reporter.FAIL);
            }
        }

    }

    private static String getCurrentTemplateName(String reportType) {
        List<WebElement> elements = WebUiTools.getWebElements("Template Header", reportType);
//        VisionDebugIdsManager.setLabel("Template Header");
//        VisionDebugIdsManager.setParams(reportType);
//        List<WebElement> elements = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[@data-debug-id= '" + VisionDebugIdsManager.getDataDebugId() + "']//input").getBy());
//        return elements.size() != 0 ? elements.get(elements.size() - 1).getText() : reportType;
        return elements.size() != 0 ? elements.get(elements.size() - 1).getAttribute("value") : reportType;
    }

    public static void dragAndDrop(ComponentLocator sourceLocator, ComponentLocator targetLocator) {
        try {
            Actions actions = new Actions(WebUIUtils.getDriver());
            actions.clickAndHold(WebUIUtils.fluentWait(sourceLocator.getBy()))
                    .moveByOffset(-10, 0)
                    .moveToElement(WebUIUtils.fluentWait(targetLocator.getBy()))
                    .release()
                    .perform();
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Drag and Drop.", Reporter.FAIL);
            e.printStackTrace();
        }
    }

    private static List<String> getWidgetsList(JSONArray widgets) {
        List<String> widgetsList = new ArrayList<>();
        for (int i = 0; i < widgets.length(); i++) {
            if (widgets.toList().get(i).getClass().getName().contains("HashMap")) {
                Map<String, Object> widgetMap = new HashMap<String, Object>(((HashMap) widgets.toList().get(i)));
                List<String> aList = widgetMap.keySet().stream().collect(Collectors.toList());
                widgetsList.addAll(aList);
            } else {

                widgetsList.add(widgets.getString(i).trim());

            }
        }
        return widgetsList;
    }


    private static void addTemplateType(String reportType) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Add Template", reportType);
    }

    private static abstract class ScopeSelection {

        protected String templateParam;
        JSONArray devicesJSON;
        protected String saveButtonText;
        protected String type;

        protected String getType() {
            return type;
        }

        ScopeSelection(JSONArray deviceJSONArray, String templateParam) {
            this.devicesJSON = deviceJSONArray;
            this.templateParam = templateParam;
        }

        protected String getSaveButtonText() {
            return saveButtonText;
        }

        public void create() throws Exception {
            BasicOperationsHandler.clickButton("Open Scope Selection", getType() + templateParam);
            WebUIUtils.sleep(1);
            if (!isAllAndClearScopeSelection()) {
                for (Object deviceJSON : devicesJSON)
                    selectDevice(deviceJSON.toString(), true);
            }
            BasicOperationsHandler.clickButton(getSaveButtonText(), "");
        }

        public void validate(JSONArray actualTemplateDeviceJSON, StringBuilder errorMessage) throws Exception {
            if (devicesJSON.length() == 1 && devicesJSON.get(0).toString().equalsIgnoreCase("All"))
                allDevicesSelected(actualTemplateDeviceJSON, errorMessage);
            else {
                JSONArray actualTemplateArrayJSON = getJSONArraySelected(actualTemplateDeviceJSON);
                if (devicesJSON.length() != actualTemplateArrayJSON.length())
                    errorMessage.append("The actual templateDevice size " + actualTemplateArrayJSON.length() + " is not equal to expected templateDevice size" + devicesJSON.length()).append("\n");
                else {
                    for (Object actualTemplateJSON : actualTemplateArrayJSON) {
                        if (!devicesJSON.toList().contains(new JSONObject(actualTemplateJSON.toString()).get("name")))
                            errorMessage.append("The ActualTemplate deviceName" + new JSONObject(actualTemplateJSON.toString()).get("name").toString() + " is not contains in expected device templates");
                    }
                }
            }
        }

        void selectDevice(String deviceText, boolean isToCheck) throws Exception {
            BasicOperationsHandler.setTextField("ScopeSelectionFilter", deviceText);
            WebUiTools.check(getType() + "_RationScopeSelection", deviceText, isToCheck);
        }

        protected boolean isAllAndClearScopeSelection() throws Exception {
            if (devicesJSON.get(0).toString().equalsIgnoreCase("All")) {
                WebUiTools.check("AllScopeSelection", "", true);
                return true;
            } else {
                WebUiTools.check("AllScopeSelection", "", true);
                WebUiTools.check("AllScopeSelection", "", false);
                return false;
            }
        }

        protected JSONArray getJSONArraySelected(JSONArray jsonArrayToGetSelectedTrue) {
            JSONArray jsonArraySelected = new JSONArray();
            for (Object object : jsonArrayToGetSelectedTrue) {
                if (new JSONObject(object.toString().replace("\\", "")).get("selected").toString().equals("true"))
                    jsonArraySelected.put(new JSONObject(object.toString().replace("\\", "")));
            }
            return jsonArraySelected;
        }

        protected void allDevicesSelected(JSONArray devisesArrayJSON, StringBuilder errorMessage) {
            for (Object object : devisesArrayJSON) {
                if (new JSONObject(object.toString().replace("\\", "")).get("selected").toString().equals("false"))
                    errorMessage.append("The All on Actual is not selected !");
            }
        }
    }

    private static class DPScopeSelection extends ScopeSelection {

        DPScopeSelection(JSONArray deviceJSON, String templateParam) {
            super(deviceJSON, templateParam);
            type = "DefensePro Analytics";
            saveButtonText = "SaveDPScopeSelection";
        }

        @Override
        protected void selectDevice(String deviceText, boolean isToCheck) throws Exception {
            new DPSingleDPScopeSelection(new JSONObject(deviceText)).create();
        }

        @Override
        public void validate(JSONArray actualTemplatesDeviceJSON, StringBuilder errorMessage) throws Exception {
            if (devicesJSON.length() == 1 && devicesJSON.get(0).equals("All"))
                allDevicesSelected(actualTemplatesDeviceJSON, errorMessage);
            else {
                JSONArray actualDevicesTemplateArrayJSON = getActualDevicesJSONArray(actualTemplatesDeviceJSON);
                if (actualDevicesTemplateArrayJSON.length() != devicesJSON.length())
                    errorMessage.append("The actual templateDevice size " + actualTemplatesDeviceJSON.length() + " is not equal to expected templateDevice size " + devicesJSON.length()).append("\n");
                else {
                    for (Object expectedDeviceJSON : devicesJSON)
                        new DPSingleDPScopeSelection(new JSONObject(expectedDeviceJSON.toString())).validate(actualDevicesTemplateArrayJSON, errorMessage);
                }
            }
        }

        private JSONArray getActualDevicesJSONArray(JSONArray actualTemplatesDeviceJSON) {
            JSONArray actualDevicesTemplateArrayJSON = new JSONArray();
            for (Object object : actualTemplatesDeviceJSON) {
                if (new JSONObject(object.toString().replace("\\", "")).get("selected").toString().equals("true"))
                    actualDevicesTemplateArrayJSON.put(new JSONObject(object.toString().replace("\\", "")));
            }
            return actualDevicesTemplateArrayJSON;
        }

        private class DPSingleDPScopeSelection {

            private String deviceIndex;
            private ArrayList devicePorts;
            private ArrayList devicePolicies;

            DPSingleDPScopeSelection(JSONObject deviceJSON) {
                if (deviceJSON.keySet().size() != 0) {
                    deviceIndex = deviceJSON.get("deviceIndex").toString();
                    devicePorts = ((ArrayList) deviceJSON.toMap().getOrDefault("devicePorts", null));
                    devicePolicies = ((ArrayList) deviceJSON.toMap().getOrDefault("devicePolicies", null));
                }
            }

            private String getDeviceIp() throws Exception {
                return devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, deviceIndex.matches("\\d+") ? Integer.valueOf(deviceIndex) : -1).getDeviceIp();
            }

            private void selectPortsOrPolicies(ArrayList devicePoliciesOrPorts, String dpPolicyCheck, String portOrPolicyFileter) throws Exception {
                if (devicePoliciesOrPorts != null) {
                    WebUITextField policyOrPortText = new WebUITextField(WebUiTools.getComponentLocator(portOrPolicyFileter, getDeviceIp()));
                    for (Object policyOrPort : devicePoliciesOrPorts) {
                        policyOrPortText.type(policyOrPort.toString().trim());
                        checkSpecificPortOrPolicy(dpPolicyCheck, policyOrPort);
                    }
                }
            }

            private void checkSpecificPortOrPolicy(String dpPolicyCheck, Object policyOrPort) throws Exception {
                try {
                    WebUiTools.check(dpPolicyCheck, new String[]{getDeviceIp(), policyOrPort.toString()}, true);
                } catch (Exception e) {
                    if (e.getMessage().startsWith("No Element with"))
                        throw new Exception("No Element with label" + dpPolicyCheck + " and params " + getDeviceIp() + " and " + policyOrPort.toString());
                    throw e;
                }
            }

            void selectDevice(String deviceText, boolean isToCheck) throws Exception {
                BasicOperationsHandler.setTextField("ScopeSelectionFilter", deviceText);
                WebUiTools.check(getType() + "_RationScopeSelection", deviceText, isToCheck);
            }

            void create() throws Exception {
                selectDevice(getDeviceIp(), true);
                if (devicePorts != null || devicePolicies != null) {
                    BasicOperationsHandler.clickButton("DPScopeSelectionChange", getDeviceIp());
                    selectPortsOrPolicies(devicePorts, "DPPortCheck", "DPPortsFilter");
                    selectPortsOrPolicies(devicePolicies, "DPPolicyCheck", "DPPoliciesFilter");
                    BasicOperationsHandler.clickButton("DPScopeSelectionChange", getDeviceIp());
                }
            }

            private void validate(JSONArray actualTemplatesDeviceJSON, StringBuilder errorMessage) throws Exception {
                JSONObject actualTemplateDevice = getActualDeviceIndex(actualTemplatesDeviceJSON);
                if (actualTemplateDevice != null) {
                    compareDevice(actualTemplateDevice, errorMessage);
                } else
                    errorMessage.append("Actual Device " + actualTemplateDevice + "is not equal to expectedDevice" + toString());
            }

            private JSONObject getActualDeviceIndex(JSONArray actualTemplatesDeviceJSON) throws Exception {
                for (Object actualTemplateDevice : actualTemplatesDeviceJSON) {
                    if (new JSONObject(actualTemplateDevice.toString()).get("deviceIP").toString().equals(getDeviceIp()))
                        return new JSONObject(actualTemplateDevice.toString());
                }
                return null;
            }

            private void compareDevice(JSONObject actualTemplateDevice, StringBuilder errorMessage) throws Exception {
                validateComparePoliciesOrPorts(errorMessage, new JSONArray(actualTemplateDevice.get("policies").toString()), devicePolicies);
                validateComparePoliciesOrPorts(errorMessage, new JSONArray(actualTemplateDevice.get("ports").toString()), devicePorts);
            }

            private void validateComparePoliciesOrPorts(StringBuilder errorMessage, JSONArray actualDevicePoliciesOrPorts, ArrayList devicePoliciesOrPorts) {
                JSONArray policiesOrPortsJSONArray = getJSONArraySelected(actualDevicePoliciesOrPorts);
                if (devicePoliciesOrPorts != null) {
                    if (policiesOrPortsJSONArray.length() != devicePoliciesOrPorts.size())
                        errorMessage.append("The actual templateDevice size " + policiesOrPortsJSONArray.length() + " is not equal to expected templateDevice size" + devicePoliciesOrPorts.size()).append("\n");
                    else {
                        for (Object actualDevicePolicyOrPorts : policiesOrPortsJSONArray) {
                            if (!devicePoliciesOrPorts.contains(new JSONObject(((JSONObject) actualDevicePolicyOrPorts).toString()).get("name")))
                                errorMessage.append("The Actual PolicyDevice" + actualDevicePolicyOrPorts + "is not exist in expected policyDevice ");
                        }
                    }
                } else if (policiesOrPortsJSONArray.length() > 0)
                    errorMessage.append("The actual templateDevice size " + policiesOrPortsJSONArray.length() + " is not equal to expected templateDevice size 0").append("\n");
            }
        }
    }

    private static class HTTPSFloodScopeSelection extends ScopeSelection {

        HTTPSFloodScopeSelection(JSONArray deviceJSONArray, String templateParam) {
            super(deviceJSONArray, templateParam);
            type = "HTTPS Flood";
            saveButtonText = "SaveHTTPSScopeSelection";
        }

        protected boolean isAllAndClearScopeSelection() {
            return false;
        }

        @Override
        protected void selectDevice(String deviceText, boolean isToCheck) throws Exception {
            BasicOperationsHandler.setTextField("HTTPSScopeSelectionFilter", deviceText.split("-")[0]);
            WebUiTools.check("httpsScopeRadio", deviceText, isToCheck);
        }

        @Override
        public void validate(JSONArray actualTemplateDeviceJSON, StringBuilder errorMessage) throws Exception {
            if (devicesJSON.length() == 1 && devicesJSON.get(0).equals("All"))
                allDevicesSelected(actualTemplateDeviceJSON, errorMessage);
            else {
                JSONArray actualObjectsDevicesSelected = getJSONArraySelected(actualTemplateDeviceJSON);
                if (devicesJSON.length() != actualObjectsDevicesSelected.length())
                    errorMessage.append("The actual templateDevice size " + actualObjectsDevicesSelected.length() + " is not equal to expected templateDevice size" + devicesJSON.length()).append("\n");
                else if (actualObjectsDevicesSelected != null) {
                    String[] expectedDeviceStringArray = devicesJSON.get(0).toString().split("-");
                    if (!new JSONObject(actualObjectsDevicesSelected.get(0).toString()).get("serverName").toString().equals(expectedDeviceStringArray[0]))
                        errorMessage.append("The ActualTemplate ServerName" + new JSONObject(actualObjectsDevicesSelected.get(0).toString()).get("serverName").toString() + " is not equal to the expected: " + expectedDeviceStringArray[0]);
                    if (!new JSONObject(actualObjectsDevicesSelected.get(0).toString()).get("deviceName").toString().equals(expectedDeviceStringArray[1]))
                        errorMessage.append("The ActualTemplate deviceName" + new JSONObject(actualObjectsDevicesSelected.get(0).toString()).get("deviceName").toString() + " is not equal to the expected: " + expectedDeviceStringArray[1]);
                    if (!new JSONObject(actualObjectsDevicesSelected.get(0).toString()).get("policyName").toString().equals(expectedDeviceStringArray[2]))
                        errorMessage.append("The ActualTemplate policyName" + new JSONObject(actualObjectsDevicesSelected.get(0).toString()).get("policyName").toString() + " is not equal to the expected: " + expectedDeviceStringArray[2]);
                }
            }
        }
    }

    public static class AWScopeSelection extends ScopeSelection {

        AWScopeSelection(JSONArray deviceJSONArray, String templateParam) {
            super(deviceJSONArray, templateParam);
            this.type = "AppWall";
            this.saveButtonText = "AWSaveButton";
        }
    }

    public static class DFScopeSelection extends ScopeSelection {

        DFScopeSelection(JSONArray deviceJSONArray, String templateParam) {
            super(deviceJSONArray, templateParam);
            this.type = "DefenseFlow Analytics";
            this.saveButtonText = "DFSaveButton";
        }
    }

    public static class ApplicationScopeSelection extends ScopeSelection {

        ApplicationScopeSelection(JSONArray deviceJSONArray, String templateParam) {
            super(deviceJSONArray, templateParam);
            this.type = "Application";
            this.saveButtonText = "ApplicationSaveButton";
        }
    }

    public static class SystemAndNetworkScopeSelection extends ScopeSelection {

        SystemAndNetworkScopeSelection(JSONArray deviceJSONArray, String templateParam) {
            super(deviceJSONArray, templateParam);
            this.type = "System And Network";
            this.saveButtonText = "SystemAndNetworkSaveButton";
        }
    }


    private static class EAAFScopeSelection extends ScopeSelection {

        EAAFScopeSelection(JSONArray deviceJSONArray, String templateParam) {
            super(deviceJSONArray, templateParam);
            type = "EAAF";
            saveButtonText = null;
        }


        @Override
        public void create() {

        }

        @Override
        public void validate(JSONArray actualTemplateDeviceJSON, StringBuilder errorMessage) throws Exception {

        }

    }

    public static StringBuilder validateTemplateDefinition(JSONArray actualTemplateJSONArray, Map<String, String> map, Map<String, Map<String, String>> templates, Map<String, Integer> widgets, String reportName) throws Exception {
        StringBuilder errorMessage = new StringBuilder();
        JSONArray expectedTemplates = new JSONArray(map.get("Template").toString());
        for (Object expectedTemplate : expectedTemplates) {
            validateSingleTemplateDefinition(actualTemplateJSONArray, new JSONObject(expectedTemplate.toString()), templates.get(reportName).get(new JSONObject(expectedTemplate.toString()).get("templateAutomationID")), widgets, errorMessage);
        }
        return errorMessage;
    }

    public static void validateSingleTemplateDefinition(JSONArray actualTemplateJSON, JSONObject expectedSingleTemplate, String expectedTemplateTitle, Map<String, Integer> widgets, StringBuilder errorMessage) throws Exception, TargetWebElementNotFoundException {
        JSONObject singleActualTemplate = validateTemplateTypeDefinition(actualTemplateJSON, expectedSingleTemplate, expectedTemplateTitle, errorMessage);
        if (singleActualTemplate != null) {
            validateTemplateDevicesDefinition(singleActualTemplate, expectedSingleTemplate, errorMessage);
            validateTemplateWidgetsDefinition(singleActualTemplate, expectedSingleTemplate, expectedSingleTemplate.get("reportType").toString(), widgets, errorMessage);
            validateTemplateSummaryTableDefinition(singleActualTemplate, expectedSingleTemplate, expectedSingleTemplate.get("reportType").toString(), widgets, expectedTemplateTitle, errorMessage);
        } else
            errorMessage.append("There is no equal template on actual templates that equal to " + expectedSingleTemplate);
    }

    private static void validateTemplateSummaryTableDefinition(JSONObject singleActualTemplate, JSONObject expectedSingleTemplate, String reportType, Map<String, Integer> widgets, String expectedTemplateTitle, StringBuilder errorMessage) {
        switch (expectedTemplateTitle) {
            case "DefensePro Analytics":
            case "DefenseFlow Analytics":
            case "AppWall":
                validateTemplateContainsSummaryTable(singleActualTemplate, expectedSingleTemplate, errorMessage);
            default:
                break;
        }
    }

    private static void validateTemplateContainsSummaryTable(JSONObject singleActualTemplate, JSONObject expectedSingleTemplate, StringBuilder errorMessage) {
        if (expectedSingleTemplate.toMap().containsKey("showTable")) {
            if (!singleActualTemplate.get("summaryTable").toString().equals(expectedSingleTemplate.get("showTable").toString()))
                errorMessage.append("summaryTable on actual template = " + singleActualTemplate.get("summaryTable").toString() + " and not equal to " + expectedSingleTemplate.get("showTable").toString());
        } else if (!singleActualTemplate.get("summaryTable").toString().equals("false"))
            errorMessage.append("summaryTable on actual template = " + singleActualTemplate.get("summaryTable").toString() + " and not equal to false");
    }

    private static JSONObject validateTemplateTypeDefinition(JSONArray actualTemplateJSON, JSONObject expectedSingleTemplate, String expectedTemplateTitle, StringBuilder errorMessage) throws TargetWebElementNotFoundException {
        String[] expectedTemplateName = expectedTemplateTitle.split("_");
        for (Object singleTemplate : actualTemplateJSON) {
            String[] actualTemplateName = new JSONObject(singleTemplate.toString()).get("templateTitle").toString().split("_");
            switch (expectedTemplateName.length) {
                case 1:
                    if (expectedTemplateName[0].equals(actualTemplateName[0]))
                        return new JSONObject(singleTemplate.toString());
                    break;
                case 2:
                    if (expectedTemplateName[0].equals(actualTemplateName[0]) && expectedTemplateName[1].equals(actualTemplateName[0]))
                        return new JSONObject(singleTemplate.toString());
                    break;
            }
        }
        errorMessage.append("This expected template name " + expectedSingleTemplate + " is not exist");
        return null;
    }

    private static void validateTemplateDevicesDefinition(JSONObject singleTemplate, JSONObject expectedSingleTemplate, StringBuilder errorMessage) throws Exception {
        getScopeSelection(expectedSingleTemplate, "").validate(new JSONArray(singleTemplate.get("scope").toString()), errorMessage);
    }

    private static void validateTemplateWidgetsDefinition(JSONObject singleActualTemplate, JSONObject expectedSingleTemplate, String expectedTemplateTitle, Map<String, Integer> widgets, StringBuilder errorMessage) {
        JSONArray expectedWidgetsJSONArray = new JSONArray(expectedSingleTemplate.get("Widgets").toString());
        for (Object expectedWidgetObject : expectedWidgetsJSONArray) {
            if (expectedSingleTemplate.get("Widgets").toString().contains("ALL"))
                validateAllWidgetsSelected(new JSONArray(singleActualTemplate.get("widgets").toString()), expectedSingleTemplate, expectedTemplateTitle, widgets, errorMessage);
            else if (expectedWidgetObject.getClass().getName().contains("String")) {
                if (!singleActualTemplate.toMap().get("widgets").toString().contains(expectedWidgetObject.toString()))
                    errorMessage.append("The Actual TemplateWidget title = " + ((HashMap) singleActualTemplate.toMap().get("metaData")).get("title").toString() + "is not equal to  " + expectedWidgetObject.toString());
            } else
                validateHashMapObjectWidgets(new JSONArray(singleActualTemplate.get("widgets").toString()), new JSONObject(expectedWidgetObject.toString()), expectedTemplateTitle, errorMessage);
        }
    }

    private static void validateAllWidgetsSelected(JSONArray singleActualTemplate, JSONObject expectedSingleTemplate, String expectedTemplateTitle, Map<String, Integer> widgets, StringBuilder errorMessage) {
        if (singleActualTemplate.length() != widgets.get(expectedTemplateTitle.split("_")[0]))
            errorMessage.append("The all widget is not selected on the actual selected" + singleActualTemplate.length() + " and not " + widgets.get(expectedTemplateTitle.split("_")[0]));
        else {
            JSONArray expectedWidgetOptions = new JSONArray(new JSONObject(new JSONArray(expectedSingleTemplate.get("Widgets").toString()).get(0).toString()).get("ALL").toString());
            for (Object expectedWidgetOption : expectedWidgetOptions) {
                validateAllTheWidgetsOptions(singleActualTemplate, new JSONObject(expectedWidgetOption.toString()), expectedTemplateTitle, errorMessage);
            }
        }
    }

    private static void validateAllTheWidgetsOptions(JSONArray singleActualTemplate, JSONObject expectedWidgetOption, String expectedTemplateTitle, StringBuilder errorMessage) {
        for (Object actualWidgetOption : singleActualTemplate) {
            if (new JSONObject(actualWidgetOption.toString()).get("metaData").toString().replace("\\", "").contains(expectedWidgetOption.keys().next()))
                validateOptionsWidgets(expectedWidgetOption.keys().next(), expectedWidgetOption, new JSONObject(new JSONObject(actualWidgetOption.toString()).get("metaData").toString().replace("\\", "")), expectedTemplateTitle, errorMessage);
        }
    }

    private static void validateHashMapObjectWidgets(JSONArray actualWidgetsJSONArray, JSONObject expectedWidgetJSONObject, String expectedTemplateTitle, StringBuilder errorMessage) {
        for (Object actualWidgetObject : actualWidgetsJSONArray) {
            if (expectedWidgetJSONObject.keys().next().equals(new JSONObject(new JSONObject((HashMap) new JSONObject(actualWidgetObject.toString()).toMap()).get("metaData").toString().replace("\\", "")).get("title").toString())) {
                validateOptionsWidgets(expectedWidgetJSONObject.keys().next(), expectedWidgetJSONObject, new JSONObject(new JSONObject((HashMap) new JSONObject(actualWidgetObject.toString()).toMap()).get("metaData").toString().replace("\\", "")), expectedTemplateTitle, errorMessage);
                return;
            }
        }
        errorMessage.append("The expected TemplateWidget title = :" + expectedWidgetJSONObject.keys().next() + " does not exist");
    }

    private static void validateOptionsWidgets(String widgetTitle, JSONObject expectedWidgetJSONObject, JSONObject actualWidgetJSONObject, String expectedTemplateTitle, StringBuilder errorMessage) {
        switch (expectedTemplateTitle) {
            case "DefensePro Analytics":
                validateOptionsWidgetOnDefenseProAnalytics(widgetTitle, expectedWidgetJSONObject, actualWidgetJSONObject, errorMessage);
                break;
            case "DefensePro Behavioral Protections":
                validateOptionsWidgetOnDefenseProBehavioralProtections(widgetTitle, expectedWidgetJSONObject, actualWidgetJSONObject, errorMessage);
                break;
            case "DefenseFlow Analytics":
                validateOptionsWidgetOnDefenseFlowAnalytics(widgetTitle, expectedWidgetJSONObject, actualWidgetJSONObject, errorMessage);
                break;
            case "EAAF":
                validateOptionsWidgetOnEAAF(widgetTitle, expectedWidgetJSONObject, actualWidgetJSONObject, errorMessage);
                break;
            default:
                errorMessage.append("The template title is wrong : " + widgetTitle);
        }
    }

    private static void validateOptionsWidgetOnDefenseProAnalytics(String templateTitle, JSONObject expectedWidgetJSONObject, JSONObject actualWidgetJSONObject, StringBuilder errorMessage) {
        JSONArray togglesData = new JSONArray(actualWidgetJSONObject.get("togglesData").toString());
        JSONArray expectedWidgetOptions = new JSONArray(expectedWidgetJSONObject.get(templateTitle).toString());
        for (Object toggleData : togglesData) {
            if (new JSONObject(toggleData.toString()).get("field").equals("unit") && !new JSONObject(toggleData.toString()).get("value").equals(expectedWidgetOptions.get(0).toString()))
                errorMessage.append("The Actual TemplateWidget OptionValue unit is " + new JSONObject(toggleData.toString()).get("value") + " is not equal to the expected " + expectedWidgetOptions.get(0).toString());
            if (new JSONObject(toggleData.toString()).get("field").equals("direction") && !new JSONObject(toggleData.toString()).get("value").equals(expectedWidgetOptions.get(1).toString()))
                errorMessage.append("The Actual TemplateWidget OptionValue direction is " + new JSONObject(toggleData.toString()).get("value") + " is not equal to the expected " + expectedWidgetOptions.get(1).toString());
            if (new JSONObject(toggleData.toString()).get("field").equals("policies") && !new JSONObject(toggleData.toString()).get("value").equals(expectedWidgetOptions.get(2).toString()))
                errorMessage.append("The Actual TemplateWidget OptionValue policies is " + new JSONObject(toggleData.toString()).get("value") + " is not equal to the expected " + expectedWidgetOptions.get(2).toString());
        }
    }

    private static void validateOptionsWidgetOnDefenseProBehavioralProtections(String templateTitle, JSONObject expectedWidgetJSONObject, JSONObject actualWidgetJSONObject, StringBuilder errorMessage) {
        JSONArray togglesData = new JSONArray(actualWidgetJSONObject.get("togglesData").toString());
        JSONArray expectedWidgetOptions = new JSONArray(expectedWidgetJSONObject.get(templateTitle).toString());
        switch (expectedWidgetOptions.length()) {
            case 1:
                validateOptionWidgetOnDFWhenThereOneOption(errorMessage, togglesData, expectedWidgetOptions);
                break;
            case 2:
                validateOptionWidgetOnDFWhenThereTwoOptions(errorMessage, togglesData, expectedWidgetOptions);
                break;
            case 3:
                validateOptionWidgetOnDFWhenThereThreeOptions(errorMessage, togglesData, expectedWidgetOptions);
                break;
        }

    }

    private static void validateOptionWidgetOnDFWhenThereOneOption(StringBuilder errorMessage, JSONArray togglesData, JSONArray expectedWidgetOptions) {
        for (Object toggleData : togglesData) {
            if (new JSONObject(toggleData.toString()).get("field").equals("protocol") && !new JSONObject(toggleData.toString()).get("value").equals(expectedWidgetOptions.get(0).toString()))
                errorMessage.append("The Actual TemplateWidget OptionValue protocolis " + new JSONObject(toggleData.toString()).get("value") + " is not equal to the expected " + expectedWidgetOptions.get(0).toString());
        }
    }

    private static void validateOptionWidgetOnDFWhenThereTwoOptions(StringBuilder errorMessage, JSONArray togglesData, JSONArray expectedWidgetOptions) {
        for (Object toggleData : togglesData) {
            if (new JSONObject(toggleData.toString()).get("field").equals("ipVersion") && !new JSONObject(toggleData.toString()).get("value").equals(expectedWidgetOptions.get(0).toString()))
                errorMessage.append("The Actual TemplateWidget OptionValue ipVersion is " + new JSONObject(toggleData.toString()).get("value") + " is not equal to the expected " + expectedWidgetOptions.get(0).toString());
            if (new JSONObject(toggleData.toString()).get("field").equals("direction") && !new JSONObject(toggleData.toString()).get("value").equals(expectedWidgetOptions.get(1).toString()))
                errorMessage.append("The Actual TemplateWidget OptionValue direction is " + new JSONObject(toggleData.toString()).get("value") + " is not equal to the expected " + expectedWidgetOptions.get(1).toString());
        }
    }

    private static void validateOptionWidgetOnDFWhenThereThreeOptions(StringBuilder errorMessage, JSONArray togglesData, JSONArray expectedWidgetOptions) {
        for (Object toggleData : togglesData) {
            if (new JSONObject(toggleData.toString()).get("field").equals("protocol") && !new JSONObject(toggleData.toString()).get("value").equals(expectedWidgetOptions.get(0).toString()))
                errorMessage.append("The Actual TemplateWidget OptionValue protocol is " + new JSONObject(toggleData.toString()).get("value") + " is not equal to the expected " + expectedWidgetOptions.get(0).toString());
            if (new JSONObject(toggleData.toString()).get("field").equals("units") && !new JSONObject(toggleData.toString()).get("value").equals(expectedWidgetOptions.get(1).toString()))
                errorMessage.append("The Actual TemplateWidget OptionValue units is " + new JSONObject(toggleData.toString()).get("value") + " is not equal to the expected " + expectedWidgetOptions.get(1).toString());
            if (new JSONObject(toggleData.toString()).get("field").equals("direction") && !new JSONObject(toggleData.toString()).get("value").equals(expectedWidgetOptions.get(2).toString()))
                errorMessage.append("The Actual TemplateWidget OptionValue direction is " + new JSONObject(toggleData.toString()).get("value") + " is not equal to the expected " + expectedWidgetOptions.get(2).toString());
        }
    }

    private static void validateOptionsWidgetOnDefenseFlowAnalytics(String templateTitle, JSONObject expectedWidgetJSONObject, JSONObject actualWidgetJSONObject, StringBuilder errorMessage) {
        JSONArray togglesData = new JSONArray(actualWidgetJSONObject.get("togglesData").toString());
        JSONArray expectedWidgetOptions = new JSONArray(expectedWidgetJSONObject.get(templateTitle).toString());
        for (Object toggleData : togglesData) {
            if (new JSONObject(toggleData.toString()).get("field").equals("protectedObjects") && !new JSONObject(toggleData.toString()).get("value").equals(expectedWidgetOptions.get(0).toString()))
                errorMessage.append("The Actual TemplateWidget OptionValue protectedObjects is " + new JSONObject(toggleData.toString()).get("value") + " is not equal to the expected " + expectedWidgetOptions.get(0).toString());
        }
    }

    private static void validateOptionsWidgetOnEAAF(String templateTitle, JSONObject expectedWidgetJSONObject, JSONObject actualWidgetJSONObject, StringBuilder errorMessage) {
        JSONArray togglesData = new JSONArray(actualWidgetJSONObject.get("togglesData").toString());
        JSONArray expectedWidgetOptions = new JSONArray(expectedWidgetJSONObject.get(templateTitle).toString());
        for (Object toggleData : togglesData) {
            if (new JSONObject(toggleData.toString()).get("field").equals("tab") && !new JSONObject(toggleData.toString()).get("value").equals(expectedWidgetOptions.get(0).toString()))
                errorMessage.append("The Actual TemplateWidget OptionValue tab is " + new JSONObject(toggleData.toString()).get("value") + " is not equal to the expected " + expectedWidgetOptions.get(0).toString());
        }
    }


    private static void setSummaryTable(JSONObject templateJsonObject, String templateName) {
        if (!templateJsonObject.has("showTable")) return;
        WebElement checkbox = WebUiTools.getWebElement("check summary table", templateName);
        boolean isChecked = Boolean.parseBoolean(checkbox.getAttribute("data-debug-checked"));
        switch (templateJsonObject.get("showTable").toString().toLowerCase()) {
            case "true":
                if (!isChecked) {
                    checkbox.click();
                }
                break;
            case "false":
                if (isChecked) {
                    checkbox.click();
                }
                break;
        }
    }

    public static void editTemplate(String reportName, JSONObject templateJsonObject, String currentTemplateName) throws Exception {
        if (templateJsonObject.has("Widgets")) {
            addTemplate(templateJsonObject, reportName);
            return;
        }
        if (templateJsonObject.has("DeleteTemplate") && Boolean.parseBoolean(templateJsonObject.get("DeleteTemplate").toString())) {
            deleteTemplate(currentTemplateName);
            return;
        }
        String reportType = templateJsonObject.get("reportType").toString();
        editTemplateWidgets(templateJsonObject, currentTemplateName);
        if (templateJsonObject.has("devices")) {
            getScopeSelection(templateJsonObject, currentTemplateName.split(reportType).length != 0 ? currentTemplateName.split(reportType)[1] : "").create();
        }
    }

    public static void editTemplateWidgets(JSONObject templateJsonObject, String currentTemplateName) throws Exception {
        List<String> widgetsListToRemove = templateJsonObject.has("DeleteWidgets") ?
                getWidgetsList(new JSONArray(templateJsonObject.get("DeleteWidgets").toString())) : null;
        List<String> widgetsList = templateJsonObject.has("AddWidgets") ?
                getWidgetsList(new JSONArray(templateJsonObject.get("AddWidgets").toString())) : null;
        JSONArray editWidgets = templateJsonObject.has("EditWidgets") ?
                new JSONArray(templateJsonObject.get("EditWidgets").toString()) : null;
        editTemplate(templateJsonObject.get("reportType").toString());
        removeUnWantedWidgets(widgetsListToRemove, currentTemplateName);
        dragAndDropDesiredWidgets(widgetsList, currentTemplateName);
        selectOptions(new JSONArray(templateJsonObject.get("AddWidgets").toString()), getOccurrenceMap(new JSONArray(templateJsonObject.get("AddWidgets").toString())), currentTemplateName);
        selectOptions(editWidgets, getOccurrenceMap(editWidgets), currentTemplateName);
    }

    private static void removeUnWantedWidgets(List<String> widgetsToRemoveDataDataDebugId, String reportType) {
        if (widgetsToRemoveDataDataDebugId == null) return;
        VisionDebugIdsManager.setLabel("selected widget");
        for (String widget : widgetsToRemoveDataDataDebugId) {
            try {
                VisionDebugIdsManager.setParams(reportType, widget.concat("_"));
                WebUIUtils.fluentWait(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_RemoveButton')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false).click();
            } catch (Exception e) {
                BaseTestUtils.report("Failed to remove widget: " + widget, Reporter.FAIL);
                e.printStackTrace();
            }
        }
    }

    public static void deleteTemplate(String currentTemplateName) {
        WebUiTools.getWebElement("Delete Template", currentTemplateName);
    }

    private static void editTemplate(String reportType) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Edit Template", reportType);
    }
}