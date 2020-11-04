package com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.Handlers;

import com.radware.automation.webui.widgets.impl.WebUITextField;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.vrm.ReportsForensicsAlerts.WebUiTools;
import org.json.JSONArray;
import org.json.JSONObject;


import java.util.ArrayList;

import static com.radware.vision.infra.testhandlers.BaseHandler.devicesManager;


public class TemplateHandlers {

    public static void addTemplate(JSONObject templateJsonObject) throws Exception {
        addTemplateType(templateJsonObject.get("reportType").toString());
        addWidgets(new JSONArray(templateJsonObject.get("Widgets").toString()));
        getScopeSelection(new JSONArray(templateJsonObject.get("devices").toString())).create();
    }

    private static ScopeSelection getScopeSelection(JSONArray devicesJSON) {
        return new DPScopeSelection(devicesJSON, "");
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
            if(!isAllAndClearScopeSelection())
            {
                for (Object deviceJSONObject : devicesJSON) {
                    new DPSingleDPScopeSelection(new JSONObject(deviceJSONObject.toString())).create();
                }
            }
            BasicOperationsHandler.clickButton("SaveScopeSelection");
        }

        private boolean isAllAndClearScopeSelection() throws Exception {
            if (devicesJSON.get(0).toString().equalsIgnoreCase("All")) {
                WebUiTools.check("All_DP_Scope_Selection", "", true);
                return true;
            } else {
                WebUiTools.check("All_DP_Scope_Selection", "", true);
                WebUiTools.check("All_DP_Scope_Selection", "", false);
                return false;
            }
        }

        @Override
        public void validate() {

        }

        private static class DPSingleDPScopeSelection {
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

            private void selectDeviceIp() throws Exception {
                BasicOperationsHandler.setTextField("DPScopeSelectionFilter", getDeviceIp());
                WebUiTools.check("DPDeviceScopeSelection", getDeviceIp(), true);
            }

            void create() throws Exception {
                selectDeviceIp();
                if (devicePorts != null || devicePolicies != null) {
                    BasicOperationsHandler.clickButton("DPScopeSelectionChange", getDeviceIp());
                    selectPortsOrPolicies(devicePorts, "DPPortCheck", "DPPortsFilter");
                    selectPortsOrPolicies(devicePolicies, "DPPolicyCheck", "DPPoliciesFilter");
                    BasicOperationsHandler.clickButton("DPScopeSelectionChange", getDeviceIp());
                }
            }
        }
    }

    private static class HTTPSFloodScopeSelection extends ScopeSelection {


        HTTPSFloodScopeSelection(JSONArray deviceJSONArray, String templateParam) {
            this.devicesJSON = deviceJSONArray;
            this.templateParam = templateParam;
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
