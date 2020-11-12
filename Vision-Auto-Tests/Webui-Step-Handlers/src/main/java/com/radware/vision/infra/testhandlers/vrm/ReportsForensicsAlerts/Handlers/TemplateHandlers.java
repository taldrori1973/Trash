package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.VisionDebugIdsManager;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
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
        List<String> widgetsToRemove = new ArrayList<>();
        if (widgetsList.contains("ALL")) {
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
//                widgetName = widgetName.substring(1, widgetName.length() - 1);
                if (!widgetsList.contains(widgetName)) {
                    widgetsToRemove.add(widgetName);
                } else {
                    widgetsList.remove(widgetName);
                }
            }
        }

        removeunWantedWidgets(widgetsToRemove, reportType);
        dragAndDropDesiredWidgets(widgetsList, reportType);
        selectOptions(widgets, getOccurrenceMap(widgets), reportType);
    }

    private static void removeunWantedWidgets(List<String> widgetsToRemoveDataDataDebugId, String reportType) {
        VisionDebugIdsManager.setLabel("selected widget");
        for (String widget : widgetsToRemoveDataDataDebugId) {
            try {
                VisionDebugIdsManager.setParams(reportType, widget);
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


    private static void dragAndDropDesiredWidgets(List<String> widgetsList, String reportType) {

        for (String widgetToDrag : widgetsList) {
            VisionDebugIdsManager.setLabel("widget drag");
            VisionDebugIdsManager.setParams(widgetToDrag);
            ComponentLocator sourceLocator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='" + VisionDebugIdsManager.getDataDebugId() + "']");
            VisionDebugIdsManager.setLabel("widgets container");
            VisionDebugIdsManager.setParams(reportType);
            ComponentLocator targetLocator = new ComponentLocator(How.XPATH, "//*[@data-debug-id='" + VisionDebugIdsManager.getDataDebugId() + "' and contains(@class,'TemplateWidgetsContainer')]");
          //TODO target by debugID
//            ComponentLocator targetLocator = new ComponentLocator(How.XPATH, "//*[@class='ReportTemplatestyle__TemplateWidgetsContainer-sc-69xssr-5 iIXqdb widget-container-appear-done widget-container-enter-done']");
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
        VisionDebugIdsManager.setLabel("selected widget");
        for (String widgetName : ocuurenceMap.keySet()) {
            VisionDebugIdsManager.setParams(reportType, widgetName);
            for (int i = 0; i < ocuurenceMap.get(widgetName).size(); i++) {
                List<WebElement> options = null;
                if (widgets.toList().get(ocuurenceMap.get(widgetName).get(i)).getClass().getName().contains("HashMap")) {
                    Map<String, Object> widgetMap = new HashMap<String, Object>(((HashMap) widgets.toList().get(ocuurenceMap.get(widgetName).get(i))));
                    List<String> lst = new ArrayList<>((List) widgetMap.get(widgetName));
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
                                case "all policies":
                                    options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_All Policies')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                                    break;
                                case "All":
                                    options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_All Policies')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                            }
                            options.get(i).click();
                            if (isNumber(option)) {
                                options = WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//*[starts-with(@data-debug-id, '" + VisionDebugIdsManager.getDataDebugId() + "') and contains(@data-debug-id, '_CustomPolicies')]").getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                                options.get(i).sendKeys(option);
                            }
                        } catch (Exception e) {
                            BaseTestUtils.report(String.format("Failed to select option: %s in widget: %s", option, widgetName), Reporter.FAIL);
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

