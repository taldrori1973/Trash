package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers;

import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.WebUiTools;
import org.json.JSONArray;
import org.json.JSONObject;


import static com.radware.vision.infra.testhandlers.BaseHandler.devicesManager;


public class TemplateHandlers {

    public static void addTemplate(JSONObject templateJsonObject) throws Exception {
        addTemplateType(templateJsonObject.get("reportType").toString());
        addWidgets(new JSONArray(templateJsonObject.get("Widgets").toString()));
        getScopeSelection(templateJsonObject.get("devices").toString()).create();
    }

    private static ScopeSelection getScopeSelection(String devicesJSON) {
        return null;
    }

    private static void addWidgets(JSONArray widgets) {

    }

    private static void addTemplateType(String reportType) throws TargetWebElementNotFoundException {
        BasicOperationsHandler.clickButton("Add Template", reportType);
    }


    private static abstract class ScopeSelection {
        protected String templateParam = "";
        JSONArray devicesJSON = new JSONArray();

        abstract public void create() throws Exception;

        abstract public void validate();
    }

    private static class DPScopeSelection extends ScopeSelection {
        DPScopeSelection(JSONArray deviceJSON, String templateParam) {
            this.devicesJSON = deviceJSON;
            this.templateParam = templateParam;
        }

        @Override
        public void create() throws Exception {
            BasicOperationsHandler.clickButton("Open Scope Selection", templateParam);
            for (Object deviceJSONObject : devicesJSON) {
                new DPSingleDPScopeSelection(new JSONObject(deviceJSONObject.toString())).create();
            }
            BasicOperationsHandler.clickButton("SaveScopeSelection");
        }

        @Override
        public void validate() {

        }

        private static class DPSingleDPScopeSelection {
            JSONObject deviceJSON;
            private String deviceIndex;
            private JSONArray devicePorts;
            private JSONArray devicePolicies;

            DPSingleDPScopeSelection(JSONObject deviceJSON) {
                this.deviceJSON = deviceJSON;
                if (!deviceJSON.keySet().contains("empty")) {
                    deviceIndex = deviceJSON.get("deviceIndex").toString();
                    devicePorts = new JSONArray(deviceJSON.toMap().getOrDefault("devicePorts", ""));
                    devicePolicies = new JSONArray(deviceJSON.toMap().getOrDefault("devicePolicies", ""));
                }
            }

            private String getDeviceIp() throws Exception {
                return devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, deviceIndex.matches("\\d+") ? Integer.valueOf(deviceIndex) : -1).getDeviceIp();
            }

            private void selectDevicePolicies() throws Exception {
                if (devicePolicies != null) {
                    WebUITextField policyText = new WebUITextField(WebUiTools.getComponentLocator("DPPortsFilter", getDeviceIp()));
                    for (Object policy : devicePolicies) {
                        policyText.type(policy.toString().trim());
                        WebUiTools.check("DPPortCheck", getDeviceIp() + "," + policy.toString(), true);
                    }
                }

            }

            private void selectDevicePorts() throws Exception {
                if (devicePorts != null) {
                    WebUITextField portText = new WebUITextField(WebUiTools.getComponentLocator("DPPortsFilter", getDeviceIp()));
                    for (Object port : devicePorts) {
                        portText.type(port.toString().trim());
                        WebUiTools.check("DPPortCheck", getDeviceIp() + "," + port.toString(), true);
                    }
                }
            }

            private void selectDeviceIp() throws Exception {
                BasicOperationsHandler.setTextField("DPScopeSelectionFilter", getDeviceIp());
                WebUiTools.check("DPDeviceScopeSelection", getDeviceIp(), true);
            }

            public void create() throws Exception {
                if (this.getDeviceIp().equalsIgnoreCase("-1"))
                    WebUiTools.check("All_DP_Scope_Selection", "", true);
                else {
                    WebUiTools.check("All_DP_Scope_Selection", "", true);
                    WebUiTools.check("All_DP_Scope_Selection", "", false);
                    selectDeviceIp();
                    if (devicePorts != null || devicePolicies != null) {
                        BasicOperationsHandler.clickButton("DPScopeSelectionChange");
                        selectDevicePorts();
                        selectDevicePolicies();
                        BasicOperationsHandler.clickButton("DPScopeSelectionChange");
                    }
                }
            }
        }
    }

    private static class HTTPSFloodScopeSelection extends ScopeSelection {


        HTTPSFloodScopeSelection(JSONArray deviceJSONArray) {
            this.devicesJSON = deviceJSONArray;
        }

        @Override
        public void create() {

        }

        @Override
        public void validate() {

        }
    }

    private static class DFAndAWScopeSelection extends ScopeSelection {

        DFAndAWScopeSelection(JSONArray deviceJSONArray) {
            this.devicesJSON = deviceJSONArray;
        }

        @Override
        public void create() {

        }

        @Override
        public void validate() {

        }
    }

    private static class EAAFScopeSelection extends ScopeSelection {

        EAAFScopeSelection(JSONArray deviceJSONArray) {
            this.devicesJSON = deviceJSONArray;
        }

        @Override
        public void create() {

        }

        @Override
        public void validate() {

        }
    }
}
