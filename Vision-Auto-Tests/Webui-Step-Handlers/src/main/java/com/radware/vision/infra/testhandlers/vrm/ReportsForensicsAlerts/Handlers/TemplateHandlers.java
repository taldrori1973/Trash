package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers;

import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.WebUiTools;
import org.json.JSONArray;
import org.json.JSONObject;


import java.util.ArrayList;
import java.util.Map;

import static com.radware.vision.infra.testhandlers.BaseHandler.devicesManager;


public class TemplateHandlers {

    public static void addTemplate(JSONObject templateJsonObject) throws Exception {
        addTemplateType(templateJsonObject.get("reportType").toString());
        addWidgets(new JSONArray(templateJsonObject.get("Widgets").toString()));
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

    private static void addWidgets(JSONArray widgets) {

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

