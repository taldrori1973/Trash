package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.automation.webui.widgets.ComponentLocatorFactory;
import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.WebUiTools;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.interactions.Actions;
import org.openqa.selenium.support.How;


import java.util.*;
import java.util.stream.Collectors;

import static com.radware.vision.infra.testhandlers.BaseHandler.devicesManager;
import static org.apache.commons.lang.math.NumberUtils.isNumber;


public class TemplateHandlers {

    public static void addTemplate(JSONObject templateJsonObject) throws Exception {
        addTemplateType(templateJsonObject.get("reportType").toString());
        addWidgets(new JSONArray(templateJsonObject.get("Widgets").toString()), getCurrentTemplateName(templateJsonObject.get("reportType").toString()));

        getScopeSelection(templateJsonObject).create();
    }

    private static ScopeSelection getScopeSelection(JSONObject templateJsonObject) {
        switch (templateJsonObject.get("reportType").toString()) {
            case "HTTPS Flood":
                return new HTTPSFloodScopeSelection(new JSONArray(templateJsonObject.get("devices").toString()), "");
            case "DefenseFlow Analytics":
                return new DFScopeSelection(new JSONArray(templateJsonObject.get("devices").toString()), "");
            case "AppWall":
                return new AWScopeSelection(new JSONArray(templateJsonObject.get("devices").toString()), "");
            case "EAAF":
                return new EAAFScopeSelection(new JSONArray(templateJsonObject.get("devices").toString()), "");
            case "DefensePro Analytics":
            case "DefensePro Behavioral Protections":
            default:
                return new DPScopeSelection(new JSONArray(templateJsonObject.get("devices").toString()), "");
        }
    }

    private static void addWidgets(JSONArray widgets, String reportType) {
        List<String> widgetsList = getWidgetsList(widgets);
        List<String> widgetsToRemoveDataDataDebugId = new ArrayList<>();
        if (widgetsList.contains("ALL")) {
            widgetsList.removeAll(Collections.singleton("ALL"));
            widgetsToRemoveDataDataDebugId = null;

        } else {
            VisionDebugIdsManager.setLabel("selected widget");
            VisionDebugIdsManager.setParams(reportType);
            List<WebElement> elements = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_RemoveButton')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);

            for (WebElement element : elements) {
                String widgetDataDebugId = element.getAttribute("data-debug-id");
                String debugId = VisionDebugIdsManager.getDataDebugId();
                String widgetName = widgetDataDebugId.split(debugId)[1].split("RemoveButton")[0];
                widgetName = widgetName.substring(1, widgetName.length() - 1);
                if (!widgetsList.contains(widgetName)) {
                    widgetsToRemoveDataDataDebugId.add(widgetDataDebugId);
                } else {
                    widgetsList.remove(widgetName);
                }
            }
        }

        removeunWantedWidgets(widgetsToRemoveDataDataDebugId);
        dragAndDropDesiredWidgets(widgetsList, reportType);
        selectOptions(widgets, getOccurrenceMap(widgets), reportType);
    }

    private static void removeunWantedWidgets(List<String> widgetsToRemoveDataDataDebugId) {
        for (String widget : widgetsToRemoveDataDataDebugId) {
            WebElement widgetElement = WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(widget).getBy());
            widgetElement.click();
        }
    }


    private static void dragAndDropDesiredWidgets(List<String> widgetsList, String reportType) {

        for (String widgetToDrag : widgetsList) {
            VisionDebugIdsManager.setLabel("widget drag");
            VisionDebugIdsManager.setParams(widgetToDrag.replaceAll("\\s+", "_"));
            ComponentLocator sourceLocator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='" + VisionDebugIdsManager.getDataDebugId() + "']");
            VisionDebugIdsManager.setLabel("Template Header");
            VisionDebugIdsManager.setParams(reportType);
//            ComponentLocator targetLocator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='" + VisionDebugIdsManager.getDataDebugId() + "']/..");
            ComponentLocator targetLocator = new ComponentLocator(How.XPATH, "//*[@class='ReportTemplatestyle__TemplateWidgetsContainer-sc-69xssr-5 iIXqdb']");
            dragAndDrop(sourceLocator, targetLocator);
        }


    }

    private static Map<String, List<Integer>> getOccurrenceMap(JSONArray widgets) {

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

    private static void selectOptions(JSONArray widgets, Map<String, List<Integer>> ocuurenceMap, String reportType) {
        for (String widgetName : ocuurenceMap.keySet()) {
            for (int i = 0; i < ocuurenceMap.get(widgetName).size(); i++) {
                if (widgets.toList().get(ocuurenceMap.get(widgetName).get(i)).getClass().getName().contains("HashMap")) {
                    Map<String, Object> widgetMap = new HashMap<String, Object>(((HashMap) widgets.toList().get(ocuurenceMap.get(widgetName).get(i))));
                    List<String> lst = new ArrayList<>((List) widgetMap.get(widgetName));
                    for (String option : lst) {
                        switch (option.toLowerCase()) {
                            case "pps":
                                VisionDebugIdsManager.setLabel("widget option pps");
                                VisionDebugIdsManager.setParams(reportType, widgetName);
                                break;
                            case "bps":
                                VisionDebugIdsManager.setLabel("widget option bps");
                                VisionDebugIdsManager.setParams(reportType, widgetName);
                                break;
                            case "ipv4":
                                VisionDebugIdsManager.setLabel("widget option ipv4");
                                VisionDebugIdsManager.setParams(reportType, widgetName);
                                break;
                            case "ipv6":
                                VisionDebugIdsManager.setLabel("widget option ipv6");
                                VisionDebugIdsManager.setParams(reportType, widgetName);
                                break;
                            case "inbound":
                                VisionDebugIdsManager.setLabel("widget option Inbpund");
                                VisionDebugIdsManager.setParams(reportType, widgetName);
                                break;
                            case "outbound":
                                VisionDebugIdsManager.setLabel("widget option Outbound");
                                VisionDebugIdsManager.setParams(reportType, widgetName);
                                break;
                            case "all policies":
                                VisionDebugIdsManager.setLabel("widget option All Polices");
                                VisionDebugIdsManager.setParams(reportType, widgetName);
                                break;
                        }
                        WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).click();
                        if (isNumber(option)) {
                            VisionDebugIdsManager.setLabel("widget option CustomPolicies");
                            VisionDebugIdsManager.setParams(reportType, widgetName);
//                            int policy= Integer.parseInt(option);
                            WebUIUtils.fluentWait(ComponentLocatorFactory.getLocatorByXpathDbgId(VisionDebugIdsManager.getDataDebugId()).getBy()).sendKeys(option);
                        }
                    }
                }

            }
        }

    }

    private static String getCurrentTemplateName(String reportType) {
        VisionDebugIdsManager.setLabel("Template Header");
        VisionDebugIdsManager.setParams(reportType);
        List<WebElement> elements = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[@data-debug-id='" + VisionDebugIdsManager.getDataDebugId() + "']").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
        return elements.get(elements.size() - 1).getText();

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

        protected String templateParam = "";
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
            if (!isAllAndClearScopeSelection()) {
                for (Object deviceJSON : devicesJSON)
                    selectDevice(deviceJSON.toString(), true);
            }
            BasicOperationsHandler.clickButton(getSaveButtonText(), "");
        }

        abstract public void validate(JSONArray actualTemplateDeviceJSON, StringBuilder errorMessage) throws Exception;

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
            if (actualTemplatesDeviceJSON.length() != devicesJSON.length())
                errorMessage.append("The actual templateDevice size " + actualTemplatesDeviceJSON.length() + " is not equal to expected templateDevice size" + devicesJSON.length()).append("\n");
            else {
                for (Object expectedDeviceJSON : devicesJSON) {
                    new DPSingleDPScopeSelection(new JSONObject(expectedDeviceJSON)).validate(actualTemplatesDeviceJSON, errorMessage);
                }
            }
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
                Object actualTemplateDevice = getActualDeviceIndex(actualTemplatesDeviceJSON);
                if (actualTemplateDevice != null) {
                    compareDevice(new JSONObject(actualTemplateDevice), errorMessage);
                } else
                    errorMessage.append("Actual Device " + actualTemplateDevice + "is not equal to expectedDevice" + toString());
            }

            private Object getActualDeviceIndex(JSONArray actualTemplatesDeviceJSON) throws Exception {
                for (Object actualTemplateDevice : actualTemplatesDeviceJSON) {
                    if (new JSONObject(actualTemplateDevice).get("deviceIP").toString().equals(getDeviceIp()))
                        return actualTemplateDevice;
                }
                return null;
            }


            private void compareDevice(JSONObject actualTemplateDevice, StringBuilder errorMessage) throws Exception {
                JSONArray actualDevicePorts = new JSONArray(actualTemplateDevice.get("ports"));
                JSONArray actualDevicePolicies = new JSONArray(actualTemplateDevice.get("policies"));
                if (actualDevicePolicies.length() != devicePolicies.size()) {
                    errorMessage.append("The actual templateDevice size " + actualDevicePolicies.length() + " is not equal to expected templateDevice size" + devicePolicies.size()).append("\n");
                    for (Object actualDevicePolicy : actualDevicePolicies) {
                        if (!devicePolicies.contains(actualDevicePolicy))
                            errorMessage.append("The Actual PolicyDevice" + actualDevicePolicy + "is not exist in expected policyDevice ");
                    }
                }
                if (actualDevicePorts.length() != devicePorts.size()) {
                    errorMessage.append("The actual templateDevice size " + actualDevicePorts.length() + " is not equal to expected templateDevice size" + devicePorts.size()).append("\n");
                    for (Object actualDevicePort : actualDevicePorts) {
                        if (!devicePorts.contains(actualDevicePort))
                            errorMessage.append("The Actual PolicyDevice" + actualDevicePort + "is not exist in expected policyDevice ");

                    }
                }
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

        }
    }

    public static class AWScopeSelection extends ScopeSelection {

        AWScopeSelection(JSONArray deviceJSONArray, String templateParam) {
            super(deviceJSONArray, templateParam);
            this.type = "AppWall";
            this.saveButtonText = "AWSaveButton";
        }

        @Override
        public void validate(JSONArray actualTemplateDeviceJSON, StringBuilder errorMessage) throws Exception {

        }

    }

    public static class DFScopeSelection extends ScopeSelection {

        DFScopeSelection(JSONArray deviceJSONArray, String templateParam) {
            super(deviceJSONArray, templateParam);
            this.type = "DefenseFlow Analytics";
            this.saveButtonText = "DFSaveButton";
        }

        @Override
        public void validate(JSONArray actualTemplateDeviceJSON, StringBuilder errorMessage) throws Exception {

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

    public static StringBuilder validateTemplateDefinition(JSONArray actualTemplateJSONArray, Map<String, String> map) throws Exception {
        StringBuilder errorMessage = new StringBuilder();
        JSONArray expectedTemplates = new JSONArray(map.get("Template"));
        for (Object expectedTemplate : expectedTemplates)
            validateSingleTemplateDefinition(actualTemplateJSONArray, new JSONObject(expectedTemplate), errorMessage);
        return errorMessage;
    }

    public static void validateSingleTemplateDefinition(JSONArray actualTemplateJSON, JSONObject expectedSingleTemplate, StringBuilder errorMessage) throws Exception, TargetWebElementNotFoundException {
        JSONObject singleTemplate = validateTemplateTypeDefinition(actualTemplateJSON, expectedSingleTemplate);
        if (singleTemplate != null) {
            validateTemplateDevicesDefinition(singleTemplate, expectedSingleTemplate, errorMessage);
            validateTemplateWidgetsDefinition(actualTemplateJSON, expectedSingleTemplate, errorMessage);
        } else
            errorMessage.append("There is no equal template on actual templates that equal to " + expectedSingleTemplate);
    }

    private static JSONObject validateTemplateTypeDefinition(JSONArray actualTemplateJSON, JSONObject expectedSingleTemplate) throws TargetWebElementNotFoundException {
        for (Object singleTemplate : actualTemplateJSON) {
            if (expectedSingleTemplate.get("reportType").toString().equalsIgnoreCase(new JSONObject(singleTemplate).get("templateTitle").toString())) {
                return new JSONObject(singleTemplate);
            }
        }
        return null;
    }

    private static void validateTemplateDevicesDefinition(JSONObject singleTemplate, JSONObject expectedSingleTemplate, StringBuilder errorMessage) throws Exception {
        getScopeSelection(expectedSingleTemplate).validate(new JSONArray(singleTemplate.get("devices")), errorMessage);
    }

    private static void validateTemplateWidgetsDefinition(JSONArray actualTemplateJSON, JSONObject expectedSingleTemplate, StringBuilder errorMessage) {
    }
}

