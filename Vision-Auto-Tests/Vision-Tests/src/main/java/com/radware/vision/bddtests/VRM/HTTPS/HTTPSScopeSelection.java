package com.radware.vision.bddtests.VRM.HTTPS;

import com.radware.restcore.utils.enums.HttpMethodEnum;
import com.radware.vision.bddtests.BddUITestBase;
import com.radware.vision.bddtests.GenericSteps;
import com.radware.vision.bddtests.basicoperations.BasicValidationsTests;
import com.radware.vision.bddtests.rest.BasicRestOperationsSteps;
import com.radware.vision.infra.enums.EqualsOrContains;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.baseoperations.clickoperations.ClickOperationsHandler;
import com.radware.vision.infra.testresthandlers.TopologyTreeRestHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import cucumber.api.java.en.Then;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.openqa.selenium.By;
import org.openqa.selenium.WebElement;
import testhandlers.VisionRestApiHandler;

import java.util.*;
import java.util.stream.Collectors;

public class HTTPSScopeSelection extends BddUITestBase {

    //Data Debug ID Labels
    private String serverButtonLabel = "Servers Button";
    private String serverLabel = "Server Selection";
    private String serverNameLabel = "Server Selection.Server Name";
    private String deviceNameLabel = "Server Selection.Device Name";
    private String policyNameLabel = "Server Selection.Policy Name";
    private String loadMoreButton = "Server Selection.Load More";
    private String filter = "Server Selection.Search";
    private String header = "Server Selection.Header";
    private String save = "Server Selection.Save";
    private String contentContainerLabel = "Server Selection.Content Container";

    private static GenericSteps genericSteps;
    private static BasicRestOperationsSteps basicRestOperationsSteps;
    private static VisionRestApiHandler visionRestApiHandler;
    private static BasicValidationsTests basicValidationsTests;

    private static List<Server> allServers;
    private static Map<String, String> deviceIpToDeviceName;

    public HTTPSScopeSelection() throws Exception {
        super();
        genericSteps = new GenericSteps();
        basicRestOperationsSteps = new BasicRestOperationsSteps();
        visionRestApiHandler = new VisionRestApiHandler();
        basicValidationsTests = new BasicValidationsTests();
        if (allServers == null || allServers.isEmpty()) updateAllHTTPSProtectedServers();
        if (deviceIpToDeviceName == null || deviceIpToDeviceName.isEmpty()) updateDeviceIpToDeviceNameMap();

    }


    //Steps
    @Then("^HTTPS Scope Selection Validate Servers List with Page Size (\\d+)$")
    public void httpsScopeSelectionValidateListIncludeUpToNumberServers(int listSize) {

        if (!BasicOperationsHandler.isElementContainsClass(serverButtonLabel, null, "selected-devices-open")) {
            buttonClick(serverButtonLabel, null);
        }


        validateUIServersList(listSize, allServers);

        allServers.forEach(server -> {
            if (!server.isFound)
                ReportsUtils.addErrorMessage("The Following Server is Not Exist:" + server.toString());
        });

        allServers.forEach(server -> server.isFound = false);

        buttonClick(serverButtonLabel, null);
        ReportsUtils.reportErrors();
    }

    @Then("^HTTPS Scope Selection Validate Servers Filtering with Page Size (\\d+)$")
    public void httpsScopeSelectionValidateServersFiltering(int listSize) {
        if (!BasicOperationsHandler.isElementContainsClass(serverButtonLabel, null, "selected-devices-open")) {
            buttonClick(serverButtonLabel, null);
        }


        validateFiltering(allServers, listSize);

        buttonClick(serverButtonLabel, null);
        ReportsUtils.reportErrors();

    }

    @Then("^HTTPS Scope Selection Validate Servers Number Header with Page Size (\\d+)$")
    public void httpsScopeSelectionValidateServersNumberHeaderWithPageSize(int listSize) {
        int totalNumberOfServers;
        if (!BasicOperationsHandler.isElementContainsClass(serverButtonLabel, null, "selected-devices-open")) {
            buttonClick(serverButtonLabel, null);
        }


        totalNumberOfServers = allServers.size();

        validateNumberOfServers(totalNumberOfServers, listSize);

        buttonClick(serverButtonLabel, null);

        ReportsUtils.reportErrors();
    }

    @Then("^HTTPS Scope Selection Validate Servers Number Header on Filtering with Page Size (\\d+)$")
    public void httpsScopeSelectionValidateServersNumberHeaderOnFilteringWithPageSize(int listSize) throws Exception {
        if (!BasicOperationsHandler.isElementContainsClass(serverButtonLabel, null, "selected-devices-open")) {
            buttonClick(serverButtonLabel, null);
        }


        validateNumberOfServersWhenFiltering(allServers, listSize);

        buttonClick(serverButtonLabel, null);

        ReportsUtils.reportErrors();

    }

    @Then("^HTTPS Scope Selection Validate Servers are Clickable with Page Size (\\d+)$")
    public void httpsScopeSelectionValidateServersAreClickable(int listSize) {
        if (!BasicOperationsHandler.isElementContainsClass(serverButtonLabel, null, "selected-devices-open")) {
            buttonClick(serverButtonLabel, null);
        }


        validateAnyServerIsClickable(allServers, listSize);

        ReportsUtils.reportErrors();

    }

    @Then("^HTTPS Scope Selection Validate RBAC (?:with Devices IPs \"([^\"]*)\")? and the Following Policies and Page Size (\\d+)$")
    public void httpsScopeSelectionValidateRBACWithPolicyNameAndDevices(String devicesIPs, int pageSize, List<Policy> policies) throws Throwable {
        if (!BasicOperationsHandler.isElementContainsClass(serverButtonLabel, null, "selected-devices-open")) {
            buttonClick(serverButtonLabel, null);
        }

        List<String> scope = null;
        List<Server> expectedServersList = (List<Server>) ((ArrayList<Server>) allServers).clone();

        //if Scope != [ALL] filter by devices ips
        if (devicesIPs != null) { //Scope=Specific Devices
            scope = Arrays.asList(devicesIPs.trim().split(","));
            expectedServersList.clear();
            for (String deviceIP : scope)
                expectedServersList.addAll(allServers.stream().filter(s -> s.deviceIp.equals(deviceIP)).collect(Collectors.toList()));
        }

        if (policies != null && !policies.isEmpty()) {
            List<Server> expectedServersListClone = (List<Server>) ((ArrayList<Server>) expectedServersList).clone();
            expectedServersList.clear();
            for (Policy policy : policies) {
                expectedServersList.addAll(expectedServersListClone.stream()
                        .filter(s ->
                                s.deviceIp.equals(policy.deviceIp) && s.policyName.equals(policy.policyName))
                        .collect(Collectors.toList()));
            }
        }


        validateUIServersList(pageSize, expectedServersList);
        validateNumberOfServers(expectedServersList.size(), pageSize);
        validateUIServersListNegative(pageSize, expectedServersList);


        buttonClick(serverButtonLabel, null);
        ReportsUtils.reportErrors();
    }


    //Report UTILS
    private void buttonClick(String label, String extensions) {
        try {
            WebElement webElement = genericSteps.buttonClick(label, extensions);
            if (webElement == null)
                ReportsUtils.addErrorMessage("\nERROR:Web Element with Label " + label + " and Extension " + extensions + " Not Exist");
        } catch (Exception e) {
            ReportsUtils.addErrorMessage("\nERROR: Clicking " + label + " Button with extension :" + extensions + " Was Failed");
        }
    }

    private void validateTextFieldElement(String selectorValue, String params, EqualsOrContains equalsOrContains, String expectedText, String cutCharsNumber) {
        try {
            if (BasicOperationsHandler.isItemAvailableById(selectorValue, params) == null)
                ReportsUtils.addErrorMessage("\nERROR:Web Element with Label " + selectorValue + " and Extension " + params + " Not Exist");
            else {
                ClickOperationsHandler.ValidateText validateText = ClickOperationsHandler.validateTextFieldElementByLabelWithoutReporting(selectorValue, params, expectedText, equalsOrContains, cutCharsNumber);
                if (!validateText.isExpected)
                    ReportsUtils.addErrorMessage("\nERROR: Validating Text Field " + selectorValue + " with extension :" + params + " Was Failed,Expected Value: " + expectedText + ", But the Actual value: " + validateText.actualText);
            }
        } catch (Exception e) {
            ReportsUtils.addErrorMessage("\nERROR: Validating Text Field " + selectorValue + " with extension :" + params + " Was Failed");
        }
    }

    private void uiSetTextFieldTo(String label, String params, String value, boolean withEnter) {

        try {
            if (BasicOperationsHandler.isItemAvailableById(label, params) == null)
                ReportsUtils.addErrorMessage("\nERROR:Web Element with Label " + label + " and Extension " + params + " Not Exist");
            genericSteps.uiSetTextFieldTo(label, params, value, withEnter);
        } catch (Exception e) {
            ReportsUtils.addErrorMessage("\nERROR: Setting Value :" + value + " into Text Field " + label + " with extension :" + params + "Was Failed");
        }
    }

    private void validateServerTextFields(String extensions, String serverNameAndIP, String deviceName, String policyName) {
        WebElement serverNameElement = BasicOperationsHandler.isItemAvailableById(serverNameLabel, extensions);
        WebElement deviceNameElement = BasicOperationsHandler.isItemAvailableById(deviceNameLabel, extensions);
        WebElement policyNameElement = BasicOperationsHandler.isItemAvailableById(policyNameLabel, extensions);

        if (serverNameElement == null)
            ReportsUtils.addErrorMessage("\nERROR:Web Element with Label " + serverNameLabel + " and Extension " + extensions + " Not Exist");
        if (deviceNameElement == null)
            ReportsUtils.addErrorMessage("\nERROR:Web Element with Label " + deviceNameLabel + " and Extension " + extensions + " Not Exist");
        if (policyNameElement == null)
            ReportsUtils.addErrorMessage("\nERROR:Web Element with Label " + policyNameLabel + " and Extension " + extensions + " Not Exist");


        if (serverNameElement != null && deviceNameElement != null && policyNameElement != null) {
            if (!getTextNode(serverNameElement).equals(serverNameAndIP))
                ReportsUtils.addErrorMessage("\nERROR: Validating Text Field " + serverNameLabel + " with extension :" + extensions + " Was Failed," +
                        "Expected Value: " + serverNameAndIP + " ,Actual Value: " + getTextNode(serverNameElement));

            if (!getTextNode(deviceNameElement).equals(deviceName))
                ReportsUtils.addErrorMessage("\nERROR: Validating Text Field " + deviceNameLabel + " with extension :" + extensions + " Was Failed," +
                        "Expected Value: " + deviceName + " ,Actual Value: " + getTextNode(deviceNameElement));


            if (!getTextNode(policyNameElement).equals(policyName))
                ReportsUtils.addErrorMessage("\nERROR: Validating Text Field " + policyNameLabel + " with extension :" + extensions + " Was Failed," +
                        "Expected Value: " + policyName + " ,Actual Value: " + getTextNode(policyNameElement));

        }


    }

    private String getTextNode(WebElement e) {
        String text = e.getText().trim();
        List<WebElement> children = e.findElements(By.xpath("./*"));
        for (WebElement child : children) {
            if (child.getAttribute("data-id") != null && child.getAttribute("data-id").equals("tooltip"))
                text = text.replaceFirst(child.getText(), "").trim();
        }
        return text;
    }


    //Validations
    private void validateAnyServerIsClickable(List<Server> allServers, int listSize) {

        Server serverToClick;
        String extensions = null;
        for (Server server : allServers) {
            extensions = server.serverName + "," + deviceIpToDeviceName.get(server.deviceIp) + "," + server.policyName;
            if (BasicOperationsHandler.isItemAvailableById(serverLabel, extensions) != null) break;

        }
        if (extensions != null) {
            buttonClick(serverNameLabel, extensions);
            buttonClick(save, null);
        }
    }

    private void validateUIServersList(int listSize, List<Server> expectedServersList) {

        if (expectedServersList == null) throw new IllegalArgumentException("Expected List is null");
        String extensions;
        int iterations, i = 0;
        iterations = (expectedServersList.size() % listSize == 0) ? expectedServersList.size() / listSize : (expectedServersList.size() / listSize) + 1;

        int serversFound = 0;
        do {
            for (Server server : expectedServersList) {
                extensions = server.serverName + "," + deviceIpToDeviceName.get(server.deviceIp) + "," + server.policyName;
                if (!server.isFound && BasicOperationsHandler.isItemAvailableById(serverLabel, extensions) != null) {
                    server.isFound = true;
                    serversFound++;
                    validateServerTextFields(extensions, server.serverName + "\n" + server.serverIp, deviceIpToDeviceName.get(server.deviceIp), server.policyName);
                }
                if (serversFound == listSize * (i + 1)) break;
            }
            i++;
            if (i < iterations)
                buttonClick(loadMoreButton, null);
        } while (i < iterations);

    }

    private void validateFiltering(List<Server> allServers, int listSize) {

        Set<String> serversNames = getAllValuesOfAttribute("serverName");
        Set<String> serversIPs = getAllValuesOfAttribute("serverIp");

        for (String serverName : serversNames) {
            List<Server> filteredServers =
                    allServers.stream().filter(server -> server.serverName.equalsIgnoreCase(serverName)).collect(Collectors.toList());
            uiSetTextFieldTo(filter, null, serverName, false);

            validateUIServersList(listSize, filteredServers);

            filteredServers.forEach(server -> {
                if (!server.isFound)
                    ReportsUtils.addErrorMessage("The Following Server is Not Exist When Filtering with \"" + serverName + "\" :" + server.toString());
            });

            filteredServers.forEach(server -> server.isFound = false);
        }
        for (String serverIp : serversIPs) {
            List<Server> filteredServers =
                    allServers.stream().filter(server -> server.serverIp.equalsIgnoreCase(serverIp)).collect(Collectors.toList());
            uiSetTextFieldTo(filter, null, serverIp, false);

            validateUIServersList(listSize, filteredServers);

            filteredServers.forEach(server -> {
                if (!server.isFound)
                    ReportsUtils.addErrorMessage("The Following Server is Not Exist When Filtering with \"" + serverIp + "\" :" + server.toString());
            });

            filteredServers.forEach(server -> server.isFound = false);
        }


    }

    private void validateNumberOfServersWhenFiltering(List<Server> allServers, int listSize) throws Exception {
        Set<String> serversNames = getAllValuesOfAttribute("serverName");
        Set<String> serversIPs = getAllValuesOfAttribute("serverIp");


        for (String serverName : serversNames) {
            List<Server> filteredServers =
                    allServers.stream().filter(server -> server.serverName.toLowerCase().contains(serverName.toLowerCase())).collect(Collectors.toList());
            GenericSteps.uiSetTextFieldByCharacterTo(filter, null, serverName, false);
            validateNumberOfServers(filteredServers.size(), listSize);
        }


        for (String serverIp : serversIPs) {
            List<Server> filteredServers =
                    allServers.stream().filter(server -> server.serverIp.toLowerCase().contains(serverIp.toLowerCase())).collect(Collectors.toList());
            GenericSteps.uiSetTextFieldByCharacterTo(filter, null, serverIp, false);
            validateNumberOfServers(filteredServers.size(), listSize);
        }
    }

    private void validateNumberOfServers(int totalNumberOfServers, int listSize) {

        if (totalNumberOfServers <= listSize)
            validateTextFieldElement(header, null, EqualsOrContains.EQUALS, "Servers\n" + totalNumberOfServers + "/" + totalNumberOfServers, null);

        else {

            int index = 0;
            int numOfSlots = totalNumberOfServers / listSize;//number of full slot (with size equals listSize)
            int remainder = totalNumberOfServers % listSize;
            do {

                index++;
                validateTextFieldElement(header, null, EqualsOrContains.EQUALS, "Servers\n" + listSize * index + "/" + totalNumberOfServers, null);

                if (index < numOfSlots || remainder > 0)
                    buttonClick(loadMoreButton, null);
            } while (index < numOfSlots);

            if (remainder > 0) {
                validateTextFieldElement(header, null, EqualsOrContains.EQUALS, "Servers\n" + (listSize * index + remainder) + "/" + totalNumberOfServers, null);

            }
        }
    }


    private void validateUIServersListNegative(int pageSize, List<Server> expectedServersList) {

        List<UIServer> serversAtUI = getAllServersFromUI();
        List<UIServer> expectedServers = new ArrayList<>();
        for (Server server : expectedServersList) {
            expectedServers.add(new UIServer(server.serverName + "\n" + server.serverIp,
                    deviceIpToDeviceName.get(server.deviceIp),
                    server.policyName));
        }

        serversAtUI.removeAll(expectedServers);
        if (!serversAtUI.isEmpty()) {
            ReportsUtils.addErrorMessage("[ERROR : The Following Server should not be available at the list :]" + serversAtUI.toString()
                    + "\nThe Expected List : " + expectedServers.toString());

        }

    }

    private List<UIServer> getAllServersFromUI() {
        List<UIServer> foundServers = new ArrayList<>();
        while (BasicOperationsHandler.isItemAvailableById(loadMoreButton, null) != null) {
            buttonClick(loadMoreButton, null);
        }

        WebElement container = BasicOperationsHandler.isItemAvailableById(contentContainerLabel, null);
        List<WebElement> allLI = container.findElements(By.xpath("div/div/ul/li"));
        for (WebElement li : allLI) {
            UIServer server = new UIServer(
                    getTextNode(li.findElement(By.xpath("div/label[contains(@data-debug-id,\"server_name\")]"))),
                    getTextNode(li.findElement(By.xpath("div/label[contains(@data-debug-id,\"device_name\")]"))),
                    getTextNode(li.findElement(By.xpath("div/label[contains(@data-debug-id,\"policy_name\")]"))));
            foundServers.add(server);
        }
        return foundServers;
    }
    //Tools

    private Set<String> getAllValuesOfAttribute(String attribute) {
        Set<String> result = new HashSet<>();
        if (allServers == null) {
            return result;
        }

        switch (attribute) {
            case "serverName":
                allServers.forEach(server -> result.add(server.serverName));
                break;
            case "serverIp":
                allServers.forEach(server -> result.add(server.serverIp));
                break;
            case "deviceIp":
                allServers.forEach(server -> result.add(server.deviceIp));
                break;
            case "policyName":
                allServers.forEach(server -> result.add(server.policyName));
                break;
        }

        return result;


    }

    private void updateDeviceIpToDeviceNameMap() {
        deviceIpToDeviceName = new HashMap<>();
        if (allServers == null) return;
        for (Server server : allServers) {
            if (deviceIpToDeviceName.get(server.deviceIp) == null) {
                deviceIpToDeviceName.put(server.deviceIp, TopologyTreeRestHandler.getDeviceName(server.deviceIp));
            }
        }
    }

    private void updateAllHTTPSProtectedServers() {
        allServers = new ArrayList<>();
        int page = 0, size = 50, topHits = 50;
        int totalHits;
        List<JSONArray> allData = new ArrayList<>();
        JSONArray currentData;


        Object result = requestHTTPSProtectedServersByPagination(page, size, topHits);
        totalHits = getTotalHits(result);
        currentData = getData(result);
        allData.add(currentData);

        while ((totalHits -= currentData.size()) > 0) {
            page++;
            result = requestHTTPSProtectedServersByPagination(page, size, topHits);
            currentData = getData(result);
            allData.add(currentData);
        }
        allServers.clear();
        allServers.addAll(parseData(allData));


    }

    private List<Server> parseData(List<JSONArray> allData) {
        List<Server> servers = new ArrayList<>();
        JSONParser jsonParser = new JSONParser();
        JSONObject row;
        for (JSONArray dataArray : allData) {

            for (Object server : dataArray) {
                row = (JSONObject) ((JSONObject) server).get("row");
                servers.add(
                        new Server((String) row.get("deviceIp"),
                                (String) row.get("policyName"),
                                (String) row.get("serverName"),
                                (String) row.get("serverIp")
                        ));
            }
        }

        return servers;
    }

    private JSONArray getData(Object result) {
        JSONArray data = null;
        JSONParser jsonParser = new JSONParser();
        try {
            JSONObject resultAsJSON = (JSONObject) jsonParser.parse(result.toString());
            data = (JSONArray) resultAsJSON.get("data");
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return data;
    }

    private int getTotalHits(Object result) {
        int hits = 0;
        JSONParser jsonParser = new JSONParser();
        try {
            JSONObject resultAsJSON = (JSONObject) jsonParser.parse(result.toString());
            JSONObject metaData = (JSONObject) resultAsJSON.get("metaData");
            String totalHits = (String) metaData.get("totalHits");
            hits = Integer.parseInt(totalHits.toString());
        } catch (ParseException e) {
            e.printStackTrace();
        }

        return hits;
    }

    private Object requestHTTPSProtectedServersByPagination(int page, Integer size, Integer topHits) {
        basicRestOperationsSteps.restLoginWithUserAndPassword("radware", "radware");
        String bodyFields = "page=" + page;
        if (size != null) bodyFields = bodyFields + ",size=" + size;
        if (topHits != null) bodyFields = bodyFields + ",topHits=" + topHits;

        Object result = visionRestApiHandler.handleRequest(BaseHandler.restTestBase.getVisionRestClient(), HttpMethodEnum.POST,
                "HTTPS Scope Selection->DP_HTTPS_PROTECTED_SERVER_LIST", null, bodyFields, null);

        return result;
    }

    //Inner Class
    class Server {

        String deviceIp;
        String policyName;
        String serverName;
        String serverIp;
        boolean isFound;

        public Server(String deviceIp, String policyName, String serverName, String serverIp) {
            this.deviceIp = deviceIp;
            this.policyName = policyName;
            this.serverIp = serverIp;
            this.serverName = serverName;
        }

        @Override
        public String toString() {

            return "serverName :" + serverName + " , Device Ip :" + deviceIp + " , Policy Name : " + policyName;
        }
    }

    class UIServer {

        String serverName;
        String deviceName;
        String policyName;

        public UIServer(String serverName, String deviceName, String policyName) {
            this.serverName = serverName;
            this.deviceName = deviceName;
            this.policyName = policyName;
        }

        @Override
        public boolean equals(Object obj) {
            if (this == obj) return true;
            UIServer server = (UIServer) obj;
            return (this.serverName.equals(server.serverName) &&
                    this.deviceName.equals(server.deviceName) &&
                    this.policyName.equals(server.policyName));
        }

        @Override
        public String toString() {

            return "\nServer Name :" + serverName + " , Device Name :" + deviceName + " , Policy Name : " + policyName;
        }
    }

    class Policy {

        String deviceIp;
        String policyName;

    }

}
