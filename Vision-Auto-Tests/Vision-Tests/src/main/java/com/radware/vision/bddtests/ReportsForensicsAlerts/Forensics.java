package com.radware.vision.bddtests.ReportsForensicsAlerts;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.bddtests.ReportsForensicsAlerts.Handlers.TemplateHandlers;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.tools.rest.CurrentVisionRestAPI;
import com.radware.vision.vision_project_cli.RootServerCli;
import models.RestResponse;
import models.StatusCode;
import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;

import java.util.*;
import java.util.concurrent.atomic.AtomicBoolean;

import static com.radware.vision.infra.testhandlers.BaseHandler.devicesManager;

public class Forensics extends ReportsForensicsAlertsAbstract {
    @Override
    protected String getType() {
        return "Forensics";
    }

    protected String getRangeTypeTextKey() {
        return "type";
    }

    protected String getRelativeRangeTextKey() {
        return "unit";
    }

    protected String getRelativeRangeValueKey() {
        return "count";
    }

    protected String getSchedulingKey() {
        return "schedule";
    }

    protected String getDeliveryKey() {
        return "Share";
    }

    protected JSONObject outputsMatches = new JSONObject();

    protected JSONObject fillOutputMatch(String productName) {
        switch (productName.toLowerCase())
        {
            case "defenseflow":
                return new JSONObject("{\"Application Name\":\"webApp\",\"Device Host Name\":\"appwallHostName\",\"Received Time\":\"receivedTimeStamp\",\"Packets\":\"packetCount\",\"Destination IP\":\"destAddress\",\"Source IP\":\"sourceAddress\",\"Start Time\":\"startTime\",\"Threat Category\":\"category\",\"Attack Name\":\"name\",\"Policy Name\":\"ruleName\",\"Source IP Address\":\"sourceIp\",\"Destination IP Address\":\"destinationIp\",\"Destination Port\":\"destPort\",\"Direction\":\"direction\",\"Protocol\":\"protocol\",\"Device IP\":\"appwallIP\",\"End Time\":\"endTime\",\"Action\":\"actionType\",\"Attack ID\":\"attackIpsId\",\"Source Port\":\"sourcePort\",\"Radware ID\":\"radwareId\",\"Duration\":\"duration\",\"Max pps\":\"maxAttackPacketRatePps\",\"Max bps\":\"maxAttackRateBps\",\"Physical Port\":\"physicalPort\",\"Risk\":\"risk\",\"VLAN Tag\":\"vlanTag\",\"Packet Type\":\"packetType\"}");
            case "appwall":
                return new JSONObject("{\"Application Name\":\"webApp\",\"Device Host Name\":\"appwallHostName\",\"Received Time\":\"receivedTimeStamp\",\"Packets\":\"packetCount\",\"Destination IP\":\"destAddress\",\"Source IP\":\"sourceAddress\",\"Start Time\":\"startTime\",\"Threat Category\":\"category\",\"Attack Name\":\"name\",\"Policy Name\":\"ruleName\",\"Source IP Address\":\"sourceIp\",\"Destination IP Address\":\"destinationIp\",\"Destination Port\":\"destPort\",\"Direction\":\"direction\",\"Protocol\":\"protocol\",\"Device IP\":\"appwallIP\",\"End Time\":\"endTime\",\"Action\":\"action\",\"Attack ID\":\"attackIpsId\",\"Source Port\":\"sourcePort\",\"Radware ID\":\"radwareId\",\"Duration\":\"duration\",\"Max pps\":\"maxAttackPacketRatePps\",\"Max bps\":\"maxAttackRateBps\",\"Physical Port\":\"physicalPort\",\"Risk\":\"risk\",\"VLAN Tag\":\"vlanTag\",\"Packet Type\":\"packetType\"}");
            case "":
            case "defensepro":
                default:
                    return new JSONObject("{\"Application Name\":\"webApp\",\"Device Host Name\":\"appwallHostName\",\"Received Time\":\"receivedTimeStamp\",\"Packets\":\"packetCount\",\"Destination IP\":\"destAddress\",\"Source IP\":\"sourceAddress\",\"Start Time\":\"startTime\",\"Threat Category\":\"category\",\"Attack Name\":\"name\",\"Policy Name\":\"ruleName\",\"Source IP Address\":\"sourceIp\",\"Destination IP Address\":\"destinationIp\",\"Destination Port\":\"destPort\",\"Direction\":\"direction\",\"Protocol\":\"protocol\",\"Device IP\":\"appwallIP\",\"End Time\":\"endTime\",\"Action\":\"actionType\",\"Attack ID\":\"attackIpsId\",\"Source Port\":\"sourcePort\",\"Radware ID\":\"radwareId\",\"Duration\":\"duration\",\"Max pps\":\"maxAttackPacketRatePps\",\"Max bps\":\"maxAttackRateBps\",\"Physical Port\":\"physicalPort\",\"Risk\":\"risk\",\"VLAN Tag\":\"vlanTag\",\"Packet Type\":\"packetType\"}");
        }
    }

    @Override
    public void create(String name, String negative, Map<String, String> map) throws Exception {
        try
        {
            closeView(false);
            WebUiTools.check("New Forensics Tab", "", true);
            selectScopeSelection(map);
            createForensicsParam(name, map);
            BasicOperationsHandler.clickButton("save");
        }catch (Exception e)
        {
            cancelView();
            BaseTestUtils.report(e.getMessage(), Reporter.FAIL);
        }
    }

    private void selectScopeSelection(Map<String, String> map) throws Exception {
        switch (map.getOrDefault("Product", "").toLowerCase()) {
            case "defensepro":
                WebUiTools.check("Product", map.get("Product"), true);
            case "":
                if (map.containsKey("devices")) {
                    fixSelectionToArray("devices", map);
                    new TemplateHandlers.DPScopeSelection(new JSONArray(map.get("devices")), "", "DEVICES").create();
                }
                break;
            case "defenseflow":
                WebUiTools.check("Product", map.get("Product"), true);
                if (map.containsKey("Protected Objects"))
                    new TemplateHandlers.DFScopeSelection(new JSONArray("[" + map.get("Protected Objects") + "]"), "", "PROTECTED OBJECTS").create();
                break;

            case "appwall":
                WebUiTools.check("Product", map.get("Product"), true);
                if (map.containsKey("Applications"))
                    new TemplateHandlers.AWScopeSelection(new JSONArray("[" + map.get("Applications") + "]"), "", "APPLICATIONS").create();
                break;
        }
    }

    private void fixSelectionToArray(String selectionType, Map<String, String> map) {
        try {
            new JSONArray(map.get(selectionType));
        } catch (Exception e) {
            map.put(selectionType, new JSONArray().put(0, map.get(selectionType)).toString());
        }

    }

    private void createForensicsParam(String name, Map<String, String> map) throws Exception {
        WebUiTools.check("Name Tab", "", true);
        createName(name, map);
        WebUiTools.check("Time Tab", "", true);
        selectTime(map);
        WebUiTools.check("Criteria Tab", "", true);
        selectCriteria(map);
        WebUiTools.check("Output Tab", "", true);
        selectOutput(map);
        WebUiTools.check("Schedule Tab", "", true);
        selectScheduling(map);
        WebUiTools.check("Format Tab", "", true);
        selectFormat(map);
        WebUiTools.check("Share Tab", "", true);
        selectShare(map);
    }

    private void selectCriteria(Map<String, String> map) throws Exception {
        if (map.containsKey("Criteria"))
        {
            JSONArray conditions = new ObjectMapper().readTree(map.get("Criteria")).isArray() ? new JSONArray(map.get("Criteria")) : new JSONArray().put(map.get("Criteria"));
            final Object[] applyValue = {""};
            for (Object condition : conditions)
            {
                (conditions.length() == 1? (new JSONObject(condition)) : ((JSONObject) condition)).keySet().forEach(n -> {if (n.toLowerCase().contains("condition."))
                    applyValue[0] = condition;});
                if (new JSONObject(condition.toString()).has("Event Criteria"))
                {
                    selectAttributeCriteria(new JSONObject(condition.toString()));
                    selectAttributeValuesCriteria(new JSONObject(condition.toString()));
                    BasicOperationsHandler.clickButton("Add Condition","enabled");
                }
            }
            applyToCriteria(applyValue[0].equals("")?new JSONObject("{}"):(JSONObject) applyValue[0]);
        }
    }

    private void applyToCriteria(JSONObject applyValue) throws Exception {
        if (applyValue.has("Criteria.Custom checkBox") || applyValue.has("condition.Custom"))
        {
            WebUiTools.check("Criteria Apply To", "custom", true);
            BasicOperationsHandler.setTextField("customTextField", applyValue.get("Criteria.Custom checkBox").toString());
        }
        else if (applyValue.has("Criteria.Any") || applyValue.has("condition.Any"))
            WebUiTools.check("Criteria Apply To", "any", true);
        else if (applyValue.has("Criteria.All") || applyValue.has("condition.All"))
            WebUiTools.check("Criteria Apply To", "all", true);
    }

    private void selectAttributeValuesCriteria(JSONObject condition) throws Exception {
            switch (condition.get("Event Criteria").toString().toUpperCase()) {
                case "ACTION":
                case "DIRECTION":
                case "DURATION":
                case "PROTOCOL":
                case "RISK":
                case "THREAT CATEGORY": {
                    BasicOperationsHandler.clickButton("Criteria Value Expand");
                    String valuesText = condition.get("Value").toString().charAt(0) == '[' ? condition.get("Value").toString().replaceAll("(\\[)|(])|(\")", "") : condition.get("Value").toString();
                    List<String> values = new ArrayList<>();
                    Collections.addAll(values, valuesText.split(","));
                    for (String value : values)
                        WebUiTools.check("Criteria Value Selected", value, true);
                    break;
                }
                case "ATTACK ID":
                case "ATTACK NAME": {
                    BasicOperationsHandler.setTextField("Criteria Value Input", condition.get("Value").toString());
                    break;
                }
                case "DESTINATION IP":
                case "SOURCE IP": {
                    WebUiTools.check("attributeValueExpand", "", true);
                    WebUiTools.check("attributeValueSelect", condition.get("IPType").toString(), true);
                    BasicOperationsHandler.setTextField("attributeValueIPInput", condition.get("IPValue").toString());
                    break;
                }
                case "DESTINATION PORT":
                case "SOURCE PORT": {
                    WebUiTools.check("attributeValueExpand", "", true);
                    WebUiTools.check("attributeValueSelect", condition.get("portType").toString(), true);
                    if (condition.has("portValue"))
                        BasicOperationsHandler.setTextField("attributeValuePortFrom", condition.get("portValue").toString());
                    else {
                        BasicOperationsHandler.setTextField("attributeValuePortFrom", condition.get("portFrom").toString());
                        BasicOperationsHandler.setTextField("attributeValueIPInput", condition.get("portTo").toString());
                    }
                    break;
                }
                case "ATTACK RATE IN BPS":
                case "ATTACK RATE IN PPS": {
                    BasicOperationsHandler.setTextField("attributeValueRate", condition.get("RateValue").toString());
                    BasicOperationsHandler.clickButton("");
                    WebUiTools.check("attributeValueSelect", condition.get("Unit").toString(), true);
                    break;
                }
            }
    }

    private String getCriteriaOperator(String operator) throws Exception {
        switch (operator.toLowerCase())
        {
            case "not equals": return "≠";
            case "greater than": return ">";
            case "equals": return "=";
        }
        throw new Exception("No operator with name " + operator);
    }

    private void selectAttributeCriteria(JSONObject condition) throws Exception {
        BasicOperationsHandler.clickButton("Criteria Attribute Expand");
        BasicOperationsHandler.clickButton("Criteria Attribute Selected", condition.get("Event Criteria").toString());
        BasicOperationsHandler.clickButton("Criteria Attribute Selected", getCriteriaOperator(condition.get("Operator").toString()));
    }

    public void selectOutput(Map<String, String> map) throws Exception {
        if(map.containsKey("Output")) {
            WebUiTools.check("outputExpandOrCollapse", "", true);
            ArrayList<String> expectedOutputs = new ArrayList<>(Arrays.asList(map.get("Output").split(",")));
            if (expectedOutputs.get(0).equalsIgnoreCase("Add All")) {
                BasicOperationsHandler.clickButton("Add All Output");
                return;
            }
            if (expectedOutputs.size() == 1 && expectedOutputs.get(0).equalsIgnoreCase(""))
                expectedOutputs.remove(0);

            for (WebElement outputElement : WebUIUtils.fluentWaitMultiple(new ComponentLocator(How.XPATH, "//li[contains(@data-debug-id,'forensics_output_') and not(contains(@data-debug-id,'Add All'))]").getBy())) {
                String outputText = outputElement.getText();
                if (expectedOutputs.contains(outputText)) {
                    WebUiTools.check("Output Value", outputText, true);
                    expectedOutputs.remove(outputText);
                } else WebUiTools.check("Output Value", outputText, false);
            }

            if (expectedOutputs.size() > 0)
                throw new Exception("The outputs " + expectedOutputs + " don't exist in the outputs");
        }
    }

    private void createName(String name, Map<String, String> map) throws Exception {
        super.createName(name);
        if (WebUiTools.getWebElement("ForensicsNameInvalid") != null)
            throw new Exception("isn't good forensics name because " + WebUiTools.getWebElement("ForensicsNameInvalid").getText());
        if (map.containsKey("Description"))
            BasicOperationsHandler.setTextField(getType() + " Description", "", map.get("Description"), true);
    }

    @Override
    public void validate(RootServerCli rootServerCli, String forensicsName, Map<String, String> map) throws Exception {
        StringBuilder errorMessage = new StringBuilder();
        JSONObject basicRestResult = getForensicsDefinition(forensicsName, map);
        if (basicRestResult != null) {
            errorMessage.append(validateTimeDefinition(new JSONObject(basicRestResult.get("timeRangeDefinition").toString()), map, forensicsName));
            errorMessage.append(validateScheduleDefinition(basicRestResult, map, forensicsName));
            errorMessage.append(validateFormatDefinition(new JSONObject(new JSONArray(basicRestResult.get("exportFormats").toString()).get(0).toString()), map));
            errorMessage.append(validateShareDefinition(new JSONObject(basicRestResult.get("deliveryMethod").toString()), map));
            errorMessage.append(validateScopeSelection(basicRestResult, map));
            errorMessage.append(validateOutput(basicRestResult, map));
            errorMessage.append(validateCriteriaDefinition(basicRestResult, map, errorMessage));
        } else errorMessage.append("No Forensics Defined with name ").append(forensicsName).append("/n");
        if (errorMessage.length() != 0)
            BaseTestUtils.report(errorMessage.toString(), Reporter.FAIL);
    }

    private StringBuilder validateOutput(JSONObject basicRestResult, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey("Output"))
        {
            outputsMatches = fillOutputMatch(map.getOrDefault("Product", ""));
            JSONArray actualOutputs = new JSONArray(basicRestResult.get("outputFields").toString());
            List expectedOutputs = new JSONArray("[" + map.get("Output") + "]").toList();
            for (Object expectedOutput : expectedOutputs)
            {
                String matchOutput = outputsMatches.toMap().getOrDefault(expectedOutput, expectedOutput).toString();
                expectedOutputs.set(expectedOutputs.indexOf(expectedOutput), matchOutput);
            }
            for (Object output : expectedOutputs)
            {
                if (!actualOutputs.toList().contains(output))
                    errorMessage.append("The output " + output + " isn't contained in the actual definition /n");
            }

            for (Object output : actualOutputs)
            {
                if (!expectedOutputs.contains(output))
                    errorMessage.append("The output " + output + " in actual output and it isn't contained in the expected definition/n");
            }
        }
        return errorMessage;
    }

    protected StringBuilder validateShareDefinition(JSONObject deliveryJson, Map<String, String> map) {
        StringBuilder errorMessage = new StringBuilder();
        if (map.containsKey(getDeliveryKey())) {
            if (!new JSONObject(map.get("Share")).isNull("FTP"))
                validateFTP(deliveryJson, map, errorMessage);
            else
                validateStandardEmail(deliveryJson, map, errorMessage);
        }
        return errorMessage;
    }

    private void validateFTP(JSONObject deliveryJson, Map<String, String> map, StringBuilder errorMessage) {
        if (deliveryJson.isNull("ftp"))
            errorMessage.append("The Expected share type is ftp but Actual no FTP in the definition");
        JSONObject ftpActualJSON = new JSONObject(new JSONArray(deliveryJson.get("ftp").toString()).get(0).toString());
        JSONObject ftpExpectedJSON = new JSONObject(map.get("Share"));
        if (!ftpActualJSON.getString("path").equals(ftpExpectedJSON.get("FTP.Path")))
            errorMessage.append("The Expected ftp path is " + ftpExpectedJSON.get("FTP.Path") + " But the actual is " + ftpActualJSON.get("path") + "/n");
        if (!ftpActualJSON.getString("password").equals(ftpExpectedJSON.get("FTP.Password")))
            errorMessage.append("The Expected ftp password is " + ftpExpectedJSON.get("FTP.Password") + " But the actual is " + ftpActualJSON.get("password") + "/n");
        if (!ftpActualJSON.getString("location").equals(ftpExpectedJSON.get("FTP.Location")))
            errorMessage.append("The Expected ftp location is " + ftpExpectedJSON.get("FTP.Location") + " But the actual is " + ftpActualJSON.get("location") + "/n");
        if (!ftpActualJSON.getString("username").equals(ftpExpectedJSON.get("FTP.Username")))
            errorMessage.append("The Expected ftp username is " + ftpExpectedJSON.get("FTP.Username") + " But the actual is " + ftpActualJSON.get("username") + "/n");
    }


    private StringBuilder validateScopeSelection(JSONObject forensicsDefinition, Map<String, String> map) throws Exception {
        StringBuilder errorMessage = new StringBuilder();
        switch (map.getOrDefault("Product", "").toLowerCase()) {
            case "defensepro":
            case "":
                if (map.containsKey("devices")) {
                    if (map.get("devices").equalsIgnoreCase("all"))
                        return errorMessage;
                    JsonNode actualDevicesJson = new ObjectMapper().readTree(forensicsDefinition.toString()).get("request").get("criteria").get(0).get("filters");
                    JSONArray expectedDevices = new ObjectMapper().readTree(map.get("devices")).isArray()? new JSONArray(map.get("devices")) : new JSONArray().put(new JSONObject(map.get("devices")));
                    for (Object expectedDevice : expectedDevices)
                    {
                        JsonNode targetActualDevice = validateDPName(actualDevicesJson, expectedDevice, errorMessage);
                        if (targetActualDevice == null)
                            return errorMessage;
                        validateDPPortsOrPolicies(targetActualDevice, ((JSONObject)expectedDevice), errorMessage, "Ports");
                        validateDPPortsOrPolicies(targetActualDevice, ((JSONObject)expectedDevice), errorMessage, "Policies");
                    }

                }
                break;
            case "defenseflow":
                if (map.containsKey("Protected Objects")) {
                    if (map.get("Protected Objects").equalsIgnoreCase("all"))
                        return errorMessage;
                    List<Object> actualPOs = new ArrayList<>();
                    for (Object device : ((JSONArray) ((JSONObject) ((JSONArray) ((JSONObject) forensicsDefinition.get("request")).get("criteria")).get(0)).get("filters")).toList())
                        actualPOs.add(((HashMap)device).get("value"));
                    validatePOsORApps(actualPOs, map, errorMessage, "Protected Objects");
                }
                break;

            case "appwall":
                if (map.containsKey("Applications"))
                {
                    if (map.get("Applications").equalsIgnoreCase("all"))
                        return errorMessage;
                    List applicationsList = ((JSONArray) ((JSONObject) ((JSONArray) ((JSONObject) forensicsDefinition.get("request")).get("criteria")).get(0)).get("filters")).toList();
                    List<Object> actualApplications = new ArrayList<>();
                    for(Object application : applicationsList)
                    {
                        actualApplications.add(((HashMap)(((ArrayList)((HashMap)application).get("filters")).get(1))).get("value"));
                    }
                    validatePOsORApps(actualApplications, map, errorMessage, "Applications");
                }
                break;
        }
        return errorMessage;
    }

    private void validateDPPortsOrPolicies(JsonNode actualDeviceJson, JSONObject expectedDevice, StringBuilder errorMessage, String validateType) throws Exception {
        if (expectedDevice.has(validateType))
        {
            for (Object portOrPolicy : new JSONArray(new JSONObject(expectedDevice.toString()).get(validateType))) {
                AtomicBoolean contained = new AtomicBoolean(false);
                actualDeviceJson.get("filters").get(1).get("filters").get(validateType.equalsIgnoreCase("ports")?0:1).get("filters").forEach(n->
                {
                    if(n.get("value").toString().equalsIgnoreCase(portOrPolicy.toString()))
                        contained.set(true);
                });
                if (!contained.get())
                    errorMessage.append("The " + validateType + " " + portOrPolicy + " isn't exist in device " + getDPDeviceIp(new JSONObject(expectedDevice.toString()).get("index").toString()) + "/n");
            }
        }
    }

    private JsonNode validateDPName(JsonNode actualDevicesDefinition, Object expectedDevice, StringBuilder errorMessage) throws Exception {
        for (JsonNode actualDeviceDefinition : actualDevicesDefinition)
        {
            if (actualDeviceDefinition.get("filters").get(0).get("value").toString().replaceAll("\"", "").equalsIgnoreCase(getDPDeviceIp(new JSONObject(expectedDevice.toString()).get("index").toString())))
                return actualDeviceDefinition;
        }
        errorMessage.append("No device with Ip " + getDPDeviceIp(new JSONObject(expectedDevice.toString()).get("index") + "/n"));
        return null;
    }

    private void validatePOsORApps(List<Object> actualDevices, Map<String, String> map, StringBuilder errorMessage, String devicesKey) {
        List<Object> expectedDevices = new JSONArray("[" + map.get(devicesKey) + "]").toList();
        for (Object device : actualDevices) {
            if (!expectedDevices.contains(device))
                errorMessage.append(devicesKey + " name ").append(new JSONObject(device.toString()).get("value")).append(" is contained in the definition/n");
        }
        if (expectedDevices.size() != actualDevices.size())
            errorMessage.append("The expected " + devicesKey + " number is " + expectedDevices.size() + " But the actual " + devicesKey + " number is " + actualDevices.size() + "/n");
    }

    protected StringBuilder validateCriteriaDefinition(JSONObject basicRestResult, Map<String, String> map, StringBuilder errorMessage) {
        if (map.containsKey("Criteria"))
        {
            JSONObject actualDefinition = new JSONObject(basicRestResult.get("metadata").toString().replace("\\", ""));
            if (map.containsKey("Criteria.Custom checkBox"))
                if (!actualDefinition.get("mode").toString().equalsIgnoreCase(map.get("Criteria.Custom checkBox")))
                    errorMessage.append("The actual mode is " + actualDefinition.get("mode").toString() + " but the expected mode" + map.get("Criteria.Custom checkBox"));
        }
        return errorMessage;
    }

    protected String getDefaultFormat() {
        return "html";
    }

    protected void editShareDefinition(Map<String, String> map) throws Exception {
        if (map.containsKey("Share")) {
            JSONObject deliveryJsonObject = new JSONObject(map.get("Share"));
            if (deliveryJsonObject.has("Email"))
                editShare(map);
            else if (deliveryJsonObject.has("FTP")) {
                WebUiTools.check("Share Tab Label", "ftp", true);
                editFTPShare(map);
            }
        }
    }

    private void editFTPShare(Map<String, String> map) throws Exception {
        BasicOperationsHandler.setTextField("FTP input", "location", "", true);
        BasicOperationsHandler.setTextField("FTP input", "path", "", true);
        BasicOperationsHandler.setTextField("FTP input", "username", "", true);
        BasicOperationsHandler.setTextField("FTP input", "password", "", true);
        selectShare(map);
    }

    private JSONObject getForensicsDefinition(String forensicsName, Map<String, String> map) throws Exception {
        RestResponse restResponse = new CurrentVisionRestAPI("Vision/newForensics.json", "Get Created Forensics").sendRequest();
        if (restResponse.getStatusCode() == StatusCode.OK) {
            JSONArray forensicsJSONArray = new JSONArray(restResponse.getBody().getBodyAsString());
            for (Object reportJsonObject : forensicsJSONArray) {
                if (new JSONObject(reportJsonObject.toString()).getString("name").equalsIgnoreCase(forensicsName)) {
                    CurrentVisionRestAPI currentVisionRestAPI = new CurrentVisionRestAPI("Vision/newForensics.json", "Get specific Forensics");
                    currentVisionRestAPI.getRestRequestSpecification().setPathParams(Collections.singletonMap("ForensicsID", new JSONObject(reportJsonObject.toString()).getString("id")));
                    restResponse = currentVisionRestAPI.sendRequest();
                    if (restResponse.getStatusCode() == StatusCode.OK)
                        return new JSONObject(restResponse.getBody().getBodyAsString());
                    else throw new Exception("Get specific Forensics request failed, The response is " + restResponse);
                }
            }

            throw new Exception("No Report with Name " + forensicsName);
        } else throw new Exception("Get Reports failed request, The response is " + restResponse);
    }


    @Override
    protected void validateQuickRangeTime(JSONObject timeDefinitionsJSON, StringBuilder errorMessage, JSONObject expectedTimeDefinitions) throws Exception {
        if (!timeDefinitionsJSON.get("type").toString().equalsIgnoreCase("quickTimeRange"))
            errorMessage.append("The rangeType is ").append(timeDefinitionsJSON.get("type")).append(" and not equal to quick").append("\n");
        if (!timeDefinitionsJSON.get("period").toString().equalsIgnoreCase(getQuickTimeAsText(expectedTimeDefinitions.getString("Quick"))))
            errorMessage.append("The value of the quickRange is ").append(timeDefinitionsJSON.get("period")).append(" and not equal to ").append(expectedTimeDefinitions.getString("Quick")).append("\n");
    }

    @Override
    protected void selectFTP(JSONObject deliveryJsonObject) throws Exception {
        BasicOperationsHandler.setTextField("FTP input", "location", deliveryJsonObject.getString("FTP.Location"), false);
        BasicOperationsHandler.setTextField("FTP input", "path", deliveryJsonObject.getString("FTP.Path"), false);
        BasicOperationsHandler.setTextField("FTP input", "username", deliveryJsonObject.getString("FTP.Username"), false);
        BasicOperationsHandler.setTextField("FTP input", "password", deliveryJsonObject.getString("FTP.Password"), false);
    }

    private String getQuickTimeAsText(String period) throws Exception {
        switch (period) {
            case "Today":
                return "Today";
            case "Yesterday":
                return "Yesterday";
            case "This Month":
                return "AllDatesInCurrentMonth";
            case "1D":
                return "oneDay";
            case "1W":
                return "oneWeek";
            case "1M":
                return "oneMonth";
            case "3M":
                return "ThreeMonths";
            case "1Y":
                return "oneYear";
        }
        throw new Exception("No period with name " + period + " in Forensics");
    }

    @Override
    public void edit(String forensicsName, Map<String, String> map) throws Exception {
        try {
            WebUiTools.getWebElement("Edit Forensics", forensicsName).click();
            editForensicsParameters(forensicsName, map);
            editScopeSelection(map, forensicsName);
            BasicOperationsHandler.clickButton("save");
        } catch (Exception e) {
            cancelView();
            throw e;
        }
//        if (!viewCreated(forensicsName)) {
//            cancelView();
//            throw new Exception("");
//        }
    }

    private void editForensicsParameters(String forensicsName, Map<String, String> map) throws Exception {
        WebUiTools.check("Name Tab", "", true);
        editName(map, forensicsName);
        WebUiTools.check("Time Tab", "", true);
        editTime(map);
        WebUiTools.check("Schedule Tab", "", true);
        editScheduling(map);
        WebUiTools.check("Share Tab", "", true);
        editShareDefinition(map);
        WebUiTools.check("Format Tab", "", true);
        editFormat(map);
        WebUiTools.check("Criteria Tab", "", true);
        editCriteria(map);
        WebUiTools.check("Output Tab", "", true);
        editOutput(map);
    }

    private void editOutput(Map<String, String> map) throws Exception {
        if (map.containsKey("Output"))
            selectOutput(map);
    }


    private void editCriteria(Map<String, String> map) throws Exception {
        if (map.containsKey("Criteria")) {
            for (WebElement criteriaElement : WebUiTools.getWebElements("Criteria Delete Condition","")) {
                criteriaElement.click();
            }
            selectCriteria(map);
        }
    }

    private void editFormat(Map<String, String> map) throws Exception {
        if (map.containsKey("Format")) {
            BasicOperationsHandler.clickButton("Format Type", "HTML");
            selectFormat(map);
        }
    }

    private void editScopeSelection(Map<String, String> map, String reportName) throws Exception {
        if (map.containsKey("devices"))
            selectScopeSelection(map);
    }

    @Override
    protected void selectEmail(JSONObject deliveryJsonObject) throws Exception {
        WebUiTools.check("Share Tab Label", "email", true);
        super.selectEmail(deliveryJsonObject);
    }

    private String getDPDeviceIp(String deviceIndex) throws Exception {
        return devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, deviceIndex.matches("\\d+") ? Integer.valueOf(deviceIndex) : -1).getDeviceIp();
    }

}
