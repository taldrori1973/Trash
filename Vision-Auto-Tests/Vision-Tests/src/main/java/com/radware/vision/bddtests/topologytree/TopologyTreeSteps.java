package com.radware.vision.bddtests.topologytree;


import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.webpages.WebUIBasePage;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.DeviceInfo;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.base.VisionUITestBase;
import com.radware.vision.infra.base.pages.topologytree.DeviceProperties;
import com.radware.vision.infra.base.pages.topologytree.StandardDeviceProperties;
import com.radware.vision.infra.enums.ClusterAssociatedMgmtPorts;
import com.radware.vision.infra.enums.TopologyTreeButtons;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.DefencePro.DPClusterManageHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.rbac.RBACHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.infra.testresthandlers.TopologyTreeRestHandler;
import com.radware.vision.infra.utils.ReportsUtils;
import com.radware.vision.pojomodel.helpers.constants.ImConstants$DeviceStatusEnumPojo;
import com.radware.vision.tests.topologytree.TopologyTree;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;
import testhandlers.Device;
import testhandlers.Tree;

import java.util.*;

public class TopologyTreeSteps extends VisionUITestBase {

    TopologyTree topologyTree = new TopologyTree();

    public TopologyTreeSteps() throws Exception {
    }

    @When("^UI Add( physical)?(?: with (DeviceID|SetId))? \"(.*)\" under \"(.*)\" site(?: SNMP Version (V[123]))?( unregister)?(?: expected status \"(.*)\")?$")
    public void addNewDevice(String treeTabType,String idType, String id, String parent, String snmpVersion, String unregister, ImConstants$DeviceStatusEnumPojo expectedStatus) {
        int timeOut = 5 * 60 * 1000;
        try {
            String snmpV = snmpVersion == null? "V2" : snmpVersion;
            boolean register = unregister == null;
            TopologyTreeTabs topologyTreeTab = (treeTabType != null) ? TopologyTreeTabs.PhysicalContainers : TopologyTreeTabs.SitesAndClusters;
            TreeDeviceManagementDto deviceInfo = (idType == null || idType.equals("SetId")) ? sutManager.getTreeDeviceManagement(id).orElse(null) :
                    (idType.equals("DeviceID")) ? sutManager.getTreeDeviceManagementFromDevices(id).orElse(null) : null;
            String port = deviceInfo.getVisionMgtPort();
            String visionServerIP = port.concat(" (").concat(getVisionServerIp()).concat(")");
            HashMap<String, String> deviceProperties = new HashMap<>();
            switch (snmpV){
                case "V1":
                    deviceProperties.put("snmpReadCommunity", deviceInfo.getSnmpV1ReadCommunity());
                    deviceProperties.put("snmpWriteCommunity", deviceInfo.getSnmpV1WriteCommunity());
                    break;
                case "V2":
                    deviceProperties.put("snmpReadCommunity", deviceInfo.getSnmpV2ReadCommunity());
                    deviceProperties.put("snmpWriteCommunity", deviceInfo.getSnmpV2WriteCommunity());
                    break;
                case "V3":
                    //TODO kVision need a device with v3 to implement
                    //TODO kVision should we add SNMP user, authentication password and privacy password?
                    deviceProperties.put("snmpReadCommunity", deviceInfo.getSnmpV3AuthenticationProtocol());
                    deviceProperties.put("snmpWriteCommunity", deviceInfo.getSnmpV3PrivacyProtocol());
                    break;

            }
            deviceProperties.put("httpUserNameDefensePro", deviceInfo.getHttpUsername());
            deviceProperties.put("httpPasswordDefensePro", deviceInfo.getHttpPassword());
            SUTDeviceType deviceType = SUTDeviceType.valueOf(deviceInfo.getDeviceType());
            TopologyTreeHandler.addNewDevice(deviceType, deviceInfo.getDeviceName(), parent, deviceInfo.getManagementIp(), visionServerIP, register, deviceProperties, topologyTreeTab);

            if (expectedStatus == null) {
                expectedStatus = ImConstants$DeviceStatusEnumPojo.OK;
            }
            if(!TopologyTreeHandler.waitForDeviceToShowUp(topologyTreeTab, deviceInfo.getDeviceName(), timeOut))
                BaseTestUtils.report("Device Name :" + getDeviceName() + " Device was not added till timeout", Reporter.FAIL);
            if (!Device.waitForDeviceStatus(restTestBase.getVisionRestClient(), deviceInfo.getDeviceName(), expectedStatus, timeOut)) {
                BaseTestUtils.report("Device Name :" + getDeviceName() + " Device Status is not equal to " + expectedStatus, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
        finally {
            WebUIBasePage.closeAllYellowMessages();
        }
    }

    @When("^UI Add( physical)? \"(.*)\" with index (\\d+) on \"(.*)\" site with params( unregister)?(?: expected status \"(.*)\")?$")
    public void addNewDevice(String treeTabType, String elementType, int index, String parent, String unregister, ImConstants$DeviceStatusEnumPojo expectedStatus, Map<String, String> map) {
        try {
            boolean register = unregister == null;
            TopologyTreeTabs topologyTreeTab = (treeTabType != null) ? TopologyTreeTabs.PhysicalContainers : TopologyTreeTabs.SitesAndClusters;
            SUTDeviceType sutDeviceType = SUTDeviceType.valueOf(elementType);
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(sutDeviceType, index);
            String mgtPort = map.get("mgtPort") != null ? map.get("mgtPort") : "G1";
            String visionServerIP = mgtPort.concat(" (").concat(getVisionServerIp()).concat(")");
            HashMap<String, String> deviceProperties = new HashMap<>();
            String val = map.get("snmpReadCommunity") != null ? deviceProperties.put("snmpReadCommunity", map.get("snmpReadCommunity")) : deviceProperties.put("snmpReadCommunity", deviceInfo.getReadCommunity());
            val = map.get("snmpWriteCommunity") != null ? deviceProperties.put("snmpWriteCommunity", map.get("snmpWriteCommunity")) : deviceProperties.put("snmpWriteCommunity", deviceInfo.getWriteCommunity());
            val = map.get("httpUserNameDefensePro") != null ? deviceProperties.put("httpUserNameDefensePro", map.get("httpUserNameDefensePro")) : deviceProperties.put("httpUserNameDefensePro", deviceInfo.getUsername());
            val = map.get("httpPasswordDefensePro") != null ? deviceProperties.put("httpPasswordDefensePro", map.get("httpPasswordDefensePro")) : deviceProperties.put("httpPasswordDefensePro", deviceInfo.getPassword());

            TopologyTreeHandler.addNewDevice(sutDeviceType, deviceInfo.getDeviceName(), parent, deviceInfo.getDeviceIp(), visionServerIP, register, deviceProperties, topologyTreeTab);

            if (expectedStatus == null) {
                expectedStatus = ImConstants$DeviceStatusEnumPojo.OK;
            }
            if (!Device.waitForDeviceStatus(restTestBase.getVisionRestClient(), deviceInfo.getDeviceName(), expectedStatus, 5 * 60 * 1000)) {
                BaseTestUtils.report("Device Name :" + getDeviceName() + " Device Status is not equal to " + expectedStatus, Reporter.FAIL);
            }
            WebUIBasePage.closeAllYellowMessages();

        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI open AddNew Topology Element Dialog \"$")
    public void openAddNewElementDialog() {
        TopologyTreeHandler.openAddNewTopologyElement();
    }

    @When("^UI open Topology Tree view \"(SitesAndClusters|PhysicalContainers|LOGICAL_GROUPS)\" site$")
    public void openTopologyTreeView(TopologyTreeTabs option) {
        TopologyTreeHandler.openTab(option);
    }

    @When("^UI Add( physical)? \"(.*)\" type \"(.*)\" on \"(.*)\" site nowait$")
    public void addNewDeviceDontWaitForStatus(String treeTabType, String elementType,String type, String parent) {
        try {
            TopologyTreeTabs topologyTreeTab = (treeTabType != null) ? TopologyTreeTabs.PhysicalContainers : TopologyTreeTabs.SitesAndClusters;
            SUTDeviceType sutDeviceType = SUTDeviceType.valueOf(type);
            Optional<TreeDeviceManagementDto> deviceInfo = sutManager.getTreeDeviceManagement(elementType);
           // DeviceInfo deviceInfo = devicesManager.getDeviceInfo(sutDeviceType, index);
            String visionServerIP = ("G1").concat(" (").concat(getVisionServerIp()).concat(")");
            HashMap<String, String> deviceProperties = new HashMap<>();
            deviceProperties.put("snmpReadCommunity", "wrong");
            deviceProperties.put("snmpWriteCommunity", "wrong");
            deviceProperties.put("httpUserNameDefensePro", deviceInfo.get().getHttpUsername());
            deviceProperties.put("httpPasswordDefensePro", deviceInfo.get().getHttpPassword());

            TopologyTreeHandler.addNewDevice(sutDeviceType, sutDeviceType.getDeviceType() + "_" + deviceInfo.get().getManagementIp(), parent, deviceInfo.get().getManagementIp(), visionServerIP, true, deviceProperties, topologyTreeTab);

            WebUIBasePage.closeAllYellowMessages();

            // TODO must remove after solving the issue "DE34464"
            WebUIUtils.getDriver().navigate().refresh();

        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @When("^UI Create DP cluster with Name \"(.*)\" with primary (\\d+) and secondary (\\d+)$")
    public void createDPCluster(String clusterName, int primaryIndex, int secondaryIndex) {
        try {
            ClusterAssociatedMgmtPorts mgmtPort = ClusterAssociatedMgmtPorts.MNG1;
            DeviceInfo primaryDevice = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, primaryIndex);
            DeviceInfo secondaryDevice = devicesManager.getDeviceInfo(SUTDeviceType.DefensePro, secondaryIndex);
            List<DeviceInfo> targetDevices = new ArrayList<>();
            targetDevices.add(primaryDevice);
            targetDevices.add(secondaryDevice);
            DPClusterManageHandler.createDPCluster(targetDevices, clusterName, primaryDevice.getDeviceName(), mgmtPort);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create DP Cluster: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @When("^UI Brake \"(.*)\" DP cluster$")
    public void brakeDPCluster(String clusterName) {
        try {
            DPClusterManageHandler.breakDPCluster(clusterName);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to break DP Cluster: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI Wait for \"(.*)\" device with index (\\d+)$")
    public void waitForDeviceUp(SUTDeviceType deviceType, int deviceIndex) {
        try {
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(deviceType, deviceIndex);
            String deviceName = deviceInfo.getDeviceName();
            if (!Device.waitForDeviceStatus(restTestBase.getVisionRestClient(), deviceName, ImConstants$DeviceStatusEnumPojo.OK, 4 * 60 * 1000)) {
                BaseTestUtils.report("Device Name :" + deviceName + " Device Status is not equal to " + ImConstants$DeviceStatusEnumPojo.OK, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to find device: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @When("^UI Delete( physical)?(?: with (DeviceID|SetId))? \"(.*)\" from topology tree$")
    public void deleteDevice(String treeTabType, String idType, String id) {
        String elementName = "";
        try {
            TopologyTreeTabs topologyTreeTab = (treeTabType != null) ? TopologyTreeTabs.PhysicalContainers : TopologyTreeTabs.SitesAndClusters;
            TreeDeviceManagementDto deviceInfo = (idType == null || idType.equals("SetId")) ? sutManager.getTreeDeviceManagement(id).orElse(null) :
                    (idType.equals("DeviceID")) ? sutManager.getTreeDeviceManagementFromDevices(id).orElse(null) : null;
            elementName = deviceInfo.getDeviceName();
            TopologyTreeHandler.deleteDevice(elementName, topologyTreeTab);
        } catch (NullPointerException e) {
            BaseTestUtils.report(e.getMessage(), Reporter.PASS_NOR_FAIL);
        } catch (Exception e) {
            BaseTestUtils.report("Device with Name: " + elementName + " " + "may not have been properly deleted, " + e.getMessage(), Reporter.FAIL);

        }
    }
    @When("^UI Delete( physical)? device with Name \"(.*)\" from topology tree$")
    public void deleteDeviceByName(String treeTabType,String deviceName) {

        try {
            TopologyTreeTabs topologyTreeTab = (treeTabType != null) ? TopologyTreeTabs.PhysicalContainers : TopologyTreeTabs.SitesAndClusters;

            TopologyTreeHandler.deleteDevice(deviceName, topologyTreeTab);
        } catch (Exception e) {
            BaseTestUtils.report("Device with Name: " + deviceName + " " + "may not have been properly deleted, " + e.getMessage(), Reporter.FAIL);

        }
    }

    @Given("^open topology tree \"([^\"]*)\"$")
    public void openTopologyTree(String treeType) {
        TopologyTreeHandler.openTab(TopologyTreeTabs.getEnum(treeType));
    }

    @When("^physical tab existence \"([^\"]*)\"$")
    public void physicalTabExistence(String existOrNot) {
        RBACHandler.expectedResultRBAC = Boolean.parseBoolean(existOrNot);
        if (!RBACHandler.verifyPhysicalTabExistence()) {
            if (RBACHandler.expectedResultRBAC) {
                ReportsUtils.reportAndTakeScreenShot("physical tab does not exist", Reporter.FAIL);
            } else {
                ReportsUtils.reportAndTakeScreenShot("physical tab exist", Reporter.FAIL);
            }

        }
    }

    @Then("^UI click Topology Tree Operation \"(.*)\"$")
    public void performTopologyTreeOperation(String topologyTreeButtonString) {
        TopologyTreeButtons topologyTreeButton = TopologyTreeButtons.getTopologyTreeButtonsEnum(topologyTreeButtonString);
        try {
            assert topologyTreeButton != null;
            if (!topologyTreeButton.getTreeButton().equals("")) {
                WebUIUtils.isTriggerPopupSearchEvent4FreeTest = false;
                if (topologyTreeButton.equals(TopologyTreeButtons.ADD)) {
                    DeviceProperties deviceProperties = new StandardDeviceProperties();
                    deviceProperties.openAddNewElementDialog();
                } else {
                    ComponentLocator locator = new ComponentLocator(How.ID, topologyTreeButton.getTreeButton());
                    WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
                }
            } else {
                BaseTestUtils.report("Failed to click on the specified button : " + topologyTreeButton, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the specified button : " + topologyTreeButton, Reporter.FAIL);
        } finally {
            WebUIUtils.isTriggerPopupSearchEvent4FreeTest = true;
        }
    }

    @Then("^UI select Topology Element( physical)? \"(.*)\" device with index \"(.*)\" from topology tree$")
    public void performTopologyTreeElement(String treeTabType, SUTDeviceType deviceType, String deviceIndex) {
        String elementName = "";
        try {
            TopologyTreeTabs topologyTreeTab = (treeTabType != null) ? TopologyTreeTabs.PhysicalContainers : TopologyTreeTabs.SitesAndClusters;
            Optional<TreeDeviceManagementDto> deviceInfo = sutManager.getTreeDeviceManagement(deviceIndex);
            elementName = deviceInfo.get().getDeviceName();
            TopologyTreeHandler.selectDevice(elementName, topologyTreeTab);
        } catch (Exception e) {
            BaseTestUtils.report("Device with Name: " + elementName + " " + "may not have been selected, " + e.getMessage(), Reporter.FAIL);

        }
    }

    @Then("^UI Add new Site \"([^\"]*)\" under Parent \"([^\"]*)\"$")
    public void addNewSite(String siteName, String parent) {
        try {
            TopologyTreeHandler.addNewSite(siteName, parent);
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI ExpandAll Physical Containers$")
    public void expandAllPhysicalContainers() {
        try {
            TopologyTreeHandler.expandAllPhysical();
        } catch (Exception e) {
            BaseTestUtils.report("ExpandAll Physical Containers may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI ExpandAll Sites And Clusters$")
    public void expandAllSitesAndClusters() {
        try {
            TopologyTreeHandler.expandAllSitesClusters();
        } catch (Exception e) {
            BaseTestUtils.report("ExpandAll Sites & Clusters may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * @param elementName Label name
     * @param topologyTreeTab In tree location
     */
    @Then("^UI Delete TopologyTree Element \"([^\"]*)\" by topologyTree Tab \"([^\"]*)\"$")
    public void deleteTopologyTreeElement(String elementName, String topologyTreeTab) {
        try {
            TopologyTreeHandler.deleteDevice(elementName, TopologyTreeTabs.getEnum(topologyTreeTab));
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    @Then("^UI Edit Alteon VX device with index (\\d+) from topology tree$")
    public void editDevice(int deviceIndex, Map<String, String> properties) {
        String visionServerIP = (String.valueOf(properties.get("visionMgtPort"))).concat(" (").concat(getVisionServerIp()).concat(")");
        SUTDeviceType deviceType = SUTDeviceType.Alteon;
        HashMap<String, String> deviceProperties = new HashMap<>(properties);
        try {
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(deviceType, deviceIndex);
            deviceProperties.put("visionServerIP", visionServerIP);
            deviceProperties.put("deviceName", deviceInfo.getDeviceName());
            TopologyTreeHandler.editAlteonVX(deviceProperties);
        } catch (Exception e) {
            BaseTestUtils.report(
                    "Topology Element may not have been found: \n" + "\n" + "Error: " + e.getCause() + parseExceptionBody(e),
                    Reporter.FAIL);

        }
    }

    @Then("^UI manage All vADC with index (\\d+) from topology tree$")
    public void manageAllVADC(int deviceIndex, Map<String, String> properties) throws Exception {
        HashMap<String, String> deviceProperties = new HashMap<>(properties);
        String visionServerIP = (String.valueOf(properties.get("visionMgtPort"))).concat(" (").concat(getVisionServerIp()).concat(")");
        DeviceInfo deviceInfo = devicesManager.getDeviceInfo(SUTDeviceType.Alteon, deviceIndex);
        try {
            deviceProperties.put("deviceName", deviceInfo.getDeviceName());
            deviceProperties.put("visionServerIP", visionServerIP);
            List<String> deviceNames = new ArrayList<>(Arrays.asList(properties.get("manageDeviceNames").split(",")));
            List<String> deviceIPs = new ArrayList<>(Arrays.asList(properties.get("deviceIPs").split(",")));
            if (deviceNames.size() == 1) {

                throw new Exception("This test can't work with single device name");
            }
            TopologyTreeHandler.manageAllVADC(deviceProperties, deviceIPs);
            BasicOperationsHandler.delay(15);
            String existingVadcs = topologyTree.checkVadcDevices(new ArrayList<>(deviceNames));

            if (!existingVadcs.equals("")) {
                BaseTestUtils.report("Failed with the following errors: " + existingVadcs, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI manage single vADC with index (\\d+) from topology tree$")
    public void manageVADC(int deviceIndex, Map<String, String> properties) throws Exception {
        HashMap<String, String> deviceProperties = new HashMap<>(properties);
        String visionServerIP = (String.valueOf(properties.get("visionMgtPort"))).concat(" (").concat(getVisionServerIp()).concat(")");
        DeviceInfo deviceInfo = devicesManager.getDeviceInfo(SUTDeviceType.Alteon, deviceIndex);
        try {
            deviceProperties.put("visionServerIP", visionServerIP);
            TopologyTreeHandler.manageVADC(deviceProperties);
            BasicOperationsHandler.delay(15);
            String existingVadcs = topologyTree.checkVadcDevices(new ArrayList<>(Arrays.asList(properties.get("manageDeviceNames"))));
            if (!existingVadcs.equals("")) {
                BaseTestUtils.report("Device: " + getDeviceName() + " was not created correctly. ", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    @When("^UI Wait For Device To Show Up In The Topology Tree( physical)?(?: with (DeviceID|SetId))? \"(.*)\" with timeout (\\d+) seconds$")
    public void waitForDeviceToShowUp(String treeTabType,String idType, String id, Integer timeout) {
        try {
            timeout = timeout * 1000;
            TreeDeviceManagementDto deviceInfo = (idType == null || idType.equals("SetId")) ? sutManager.getTreeDeviceManagement(id).orElse(null) :
                    (idType.equals("DeviceID")) ? sutManager.getTreeDeviceManagementFromDevices(id).orElse(null) : null;
            TopologyTreeTabs topologyTreeTab = (treeTabType != null) ? TopologyTreeTabs.PhysicalContainers : TopologyTreeTabs.SitesAndClusters;
            TopologyTreeHandler.waitForDeviceToShowUp(topologyTreeTab, deviceInfo.getDeviceName(), timeout);
        } catch (Exception e) {
            BaseTestUtils.report(
                    "Device Failed to show up: \n" + "\n" + "Error: " + e.getCause() + parseExceptionBody(e),
                    Reporter.FAIL);

        }
    }

    @Then("^UI Edit AppWall with DeviceType \"([^\"]*)\" with index (\\d+) Mgt port \"([^\"]*)\"$")
    public void uiEditAppWallWithDeviceTypeWithIndex(SUTDeviceType deviceType, int index, String visionMgtPort) {
        // Write code here that turns the phrase above into concrete actions
        try {
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(deviceType, index);
            ///////////////////////////// code for jsystem
            HashMap<String, String> deviceProperties = new HashMap<>(40);
            String visionServerIP = (String.valueOf(visionMgtPort)).concat(" (").concat(getVisionServerIp()).concat(")");
            deviceProperties.put("deviceName", deviceInfo.getDeviceName());
            deviceProperties.put("httpUserName", deviceInfo.getUsername());
            deviceProperties.put("httpPassword", deviceInfo.getPassword());
            deviceProperties.put("httpsPort", String.valueOf(deviceInfo.getHttpsPort()));
            deviceProperties.put("registerVisionServer", "true");
            deviceProperties.put("visionServerIP", visionServerIP);
            deviceProperties.put("removeTargets", "false");

            TopologyTreeHandler.editAppWall(deviceProperties);

        } catch (Exception e) {
            BaseTestUtils.report(
                    "Topology Element may not have been found: \n" + "Error: " + e.getCause() + parseExceptionBody(e),
                    Reporter.FAIL);
        }

        ////////////////////////////////////////
    }

    @Then("^UI Add (\\d+) multiple \"([^\"]*)\" Devices$")
    public void uiAddMultipleDevices(int amountOfDevices, SUTDeviceType elementType, Map<String, String> properties) {
        HashMap<String, String> deviceProperties = new HashMap<>(properties);

        try {
            String managementIP;
            String ip;
            deviceProperties.put("deviceType", elementType.getDeviceType());
            com.radware.vision.pojomodel.helpers.constants.ImConstants$VisionMgtPortEnumPojo visionMGTPort = com.radware.vision.pojomodel.helpers.constants.ImConstants$VisionMgtPortEnumPojo.valueOf(deviceProperties.get("visionMgtPort"));
            setDeviceName(deviceProperties.get("DeviceName"));
            for (int i = 0; i < amountOfDevices; i++) {
                ip = "";
                managementIP = properties.get("BaseIP").concat(".").concat(String.valueOf(i + 1));
                ip = ip.concat(managementIP);
                deviceProperties.put("ip", ip);
                String currentDeviceName = getDeviceName().concat(String.valueOf(i + 1));
                deviceProperties.put("name", currentDeviceName);
                if (elementType.equals(SUTDeviceType.Alteon))
                    Device.addNewAlteonDevice(restTestBase.getVisionRestClient(), currentDeviceName, deviceProperties.get("Parent"), deviceProperties, visionMGTPort);
                else
                    Device.addNewDefenceProDevice(restTestBase.getVisionRestClient(), managementIP, deviceProperties.get("Parent"), deviceProperties, visionMGTPort);
            }

        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }

    }


    @Then("^UI delete (\\d+) \"([^\"]*)\" Devices$")
    public void uiDeleteDevices(int amountOfDevices, String elementName) {
        try {
            for (int i = 1; i <= amountOfDevices; i++) {
                Device.deleteDeviceByName(restTestBase.getVisionRestClient(), elementName + i);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Device with Name: " + elementName + " " + "may not have been properly deleted, " + e.getMessage(), Reporter.FAIL);

        }
    }

    @Then("^UI delete (\\d+) \"([^\"]*)\" Sites$")
    public void uiDeleteSites(int amountOfSites, String elementName) {
        try {
            for (int i = 1; i <= amountOfSites; i++) {
                Tree.deleteSiteByName(restTestBase.getVisionRestClient(), elementName + i);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Device with Name: " + elementName + " " + "may not have been properly deleted, " + e.getMessage(), Reporter.FAIL);

        }

    }

    /**
     * @param ip       Device Ip
     * @param treeName Sites and Devices | Physical Containers | Logical Groups
     */
    @Then("^UI Click Edit device Then Submit to Refresh with IP \"([^\"]*)\" from topology tree \"([^\"]*)\"$")
    public void uiEditAlteonDeviceWithIPFromTopologyTree(String ip, String treeName) {
        DeviceProperties deviceProperties = new StandardDeviceProperties();
        switch (treeName.toLowerCase()) {
            case "sites and devices":
                TopologyTreeHandler.openSitesAndClusters();
                TopologyTreeHandler.expandAllSitesClusters();
                break;
            case "physical containers":
                TopologyTreeHandler.openPhysicalContainers();
                TopologyTreeHandler.expandAllPhysical();
                break;
            case "logical groups":
                TopologyTreeHandler.openGroups();
                TopologyTreeHandler.expandAllLogicalGroups();
                break;
        }

        deviceProperties.selectTreeNode(TopologyTreeRestHandler.getDeviceName(ip));
        deviceProperties.openEditElementDialog();
        TopologyTreeHandler.waitForNonSynchronizedState(deviceProperties);
    }

    @Then("^UI Edit Alteon device with Device Name \"(.*)\" from topology tree$")
    public void uiEditAlteonDeviceWithIpFromTopologyTree(String deviceName, Map<String, String> properties) {
        String visionMgtPort = properties.get("visionMgtPort") != null ? properties.get("visionMgtPort") : "G1";
        String visionMgtIp = getVisionServerIp();
        if (visionMgtPort.equals("G2")) {
            String[] ipTokens = getVisionServerIp().trim().split("\\.");
            visionMgtIp = "50.50.".concat(ipTokens[2]).concat(".").concat(ipTokens[3]);
        }
        String visionServerIP = visionMgtPort.concat(" (").concat(visionMgtIp).concat(")");


        HashMap<String, String> deviceProperties = new HashMap<>(properties);
        try {
            deviceProperties.put("visionServerIP", visionServerIP);
            deviceProperties.put("deviceName", deviceName);
            TopologyTreeHandler.editAlteon(deviceProperties);
        } catch (Exception e) {
            BaseTestUtils.report(
                    "Topology Element may not have been found: \n" + "\n" + "Error: " + e.getCause() + parseExceptionBody(e),
                    Reporter.FAIL);

        }
    }

    @Then("^UI Edit Alteon device with index (\\d+) from topology tree$")
    public void uiEditAlteonDeviceWithIndexFromTopologyTree(int deviceIndex, Map<String, String> properties) {
        String visionServerIP = (String.valueOf(properties.get("visionMgtPort"))).concat(" (").concat(getVisionServerIp()).concat(")");
        SUTDeviceType deviceType = SUTDeviceType.Alteon;
        HashMap<String, String> deviceProperties = new HashMap<>(properties);
        try {
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(deviceType, deviceIndex);
            deviceProperties.put("visionServerIP", visionServerIP);
            deviceProperties.put("deviceName", deviceInfo.getDeviceName());
            TopologyTreeHandler.editAlteon(deviceProperties);
        } catch (Exception e) {
            BaseTestUtils.report(
                    "Topology Element may not have been found: \n" + "\n" + "Error: " + e.getCause() + parseExceptionBody(e),
                    Reporter.FAIL);

        }
    }

    @Then("^UI Edit DP device with index (\\d+) from topology tree ?(?: expected status \\\"(.*)\\\")?$")
    public void uiEditDPDeviceWithIndexFromTopologyTree(int deviceIndex, ImConstants$DeviceStatusEnumPojo expectedStatus, Map<String, String> properties) {
        String visionServerIP = (String.valueOf(properties.get("visionMgtPort"))).concat(" (").concat(getVisionServerIp()).concat(")");
        SUTDeviceType deviceType = SUTDeviceType.DefensePro;
        HashMap<String, String> deviceProperties = new HashMap<>(properties);
        try {
            DeviceInfo deviceInfo = devicesManager.getDeviceInfo(deviceType, deviceIndex);
            deviceProperties.put("visionServerIP", visionServerIP);
            deviceProperties.put("deviceName", deviceInfo.getDeviceName());
            TopologyTreeHandler.editDefencePro(deviceProperties);


            if (expectedStatus == null) {
                expectedStatus = ImConstants$DeviceStatusEnumPojo.OK;
            }
            if (!Device.waitForDeviceStatus(restTestBase.getVisionRestClient(), deviceInfo.getDeviceName(), expectedStatus, 5 * 60 * 1000)) {
                BaseTestUtils.report("Device Name :" + getDeviceName() + " Device Status is not equal to " + expectedStatus, Reporter.FAIL);
            }
            WebUIBasePage.closeAllYellowMessages();
        } catch (Exception e) {
            BaseTestUtils.report(
                    "Topology Element may not have been found: \n" + "\n" + "Error: " + e.getCause() + parseExceptionBody(e),
                    Reporter.FAIL);

        }
    }

    @Then("^UI click Tree Element - By device Names \"(.*)\"$")
    public void clickTreeElement(String deviceName) {
        try {
            setDeviceName(deviceName);
            TopologyTreeHandler.findTreeElement(getDeviceName());
        } catch (Exception e) {
            BaseTestUtils.report("Topology Tree may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Then("^UI is Tree Node Exists - By device Names \"(.*)\"( negative)?$")
    public void isTreeNodeExists(String deviceName, String negative) {
        try {
            WebElement node = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, WebUIStrings.getDeviceTreeNode(deviceName)).getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
            if (node != null) {
                BaseTestUtils.report("Topology Tree was found:\n", Reporter.PASS);
            } else {
                BaseTestUtils.report("Topology Tree was not found:\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Topology Tree may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * @param treeTabType    if the device physical
     * @param type           Alteon|DefensePro|AppWall|Linkproof
     * @param name           Device name
     * @param ip             Device IP address
     * @param site           where to add the device
     * @param optionalValues registerDeviceEvents: [true|false]
     *                       User Name   : support by defensePro Only
     *                       Password    : support by defensePro Only
     *                       SNMP Read Community :default value= public
     *                       SNMP Write Community:default values = public for defensePro and private else
     *                       visionMgtPort: [G1|G2]
     */
    @Then("^UI Add( physical)? \"([^\"]*)\" Device To topology Tree with Name \"([^\"]*)\" and Management IP \"([^\"]*)\" into site \"([^\"]*)\"$")
    public void uiAddDeviceToTopologyTreeWithNameAndManagementIPIntoSite(String treeTabType, String type, String name, String ip, String site, Map<String, String> optionalValues) {
        try {
            boolean register = (optionalValues.get("registerDeviceEvents") != null) ? Boolean.parseBoolean(optionalValues.get("registerDeviceEvents")) : false;

            TopologyTreeTabs topologyTreeTab = (treeTabType != null) ? TopologyTreeTabs.PhysicalContainers : TopologyTreeTabs.SitesAndClusters;

            SUTDeviceType sutDeviceType = SUTDeviceType.valueOf(type);

            DeviceInfo deviceInfo = TopologyTreeHandler.setDeviceInfo(sutDeviceType, name, ip, optionalValues);

            String visionMgtPort = optionalValues.get("visionMgtPort") != null ? optionalValues.get("visionMgtPort") : "G1";
            String visionMgtIp = getVisionServerIp();
            if (visionMgtPort.equals("G2")) {
                String[] ipTokens = getVisionServerIp().trim().split("\\.");
                visionMgtIp = "50.50.".concat(ipTokens[2]).concat(".").concat(ipTokens[3]);
            }
            String visionServerIP = visionMgtPort.concat(" (").concat(visionMgtIp).concat(")");

            HashMap<String, String> deviceProperties = new HashMap<>();
            deviceProperties.put("snmpReadCommunity", deviceInfo.getReadCommunity());
            deviceProperties.put("snmpWriteCommunity", deviceInfo.getWriteCommunity());
            deviceProperties.put("httpUserNameDefensePro", deviceInfo.getUsername());
            deviceProperties.put("httpPasswordDefensePro", deviceInfo.getPassword());

            TopologyTreeHandler.addNewDevice(sutDeviceType, deviceInfo.getDeviceName(), site, deviceInfo.getDeviceIp(), visionServerIP, register, deviceProperties, topologyTreeTab);

            ImConstants$DeviceStatusEnumPojo expectedStatus = ImConstants$DeviceStatusEnumPojo.OK;

            if (!Device.waitForDeviceStatus(restTestBase.getVisionRestClient(), deviceInfo.getDeviceName(), expectedStatus, 5 * 60 * 1000)) {
                BaseTestUtils.report("Device Name :" + getDeviceName() + " Device Status is not equal to " + expectedStatus, Reporter.FAIL);
            }
            WebUIBasePage.closeAllYellowMessages();

        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    /**
     *
     * @param by id or class
     * @param byLabel label name
     * @param deviceName device name
     * @param tab:
     *           Sites and Clusters:  "SitesAndClusters" or "Sites And Devices" or null or "null"
     *           Physical Containers: "Physical Containers" or "PhysicalContainers"
     *           LOGICAL GROUPS : any another value
     */
    @Then("^UI Navigate to iFrame by \"(Id|ClassName)\" Equals to \"([^\"]*)\" of Device \"([^\"]*)\"(?: in Topology Tree Tab \"([^\"]*)\")?$")
    public void uiNavigateToIFrameByOfDeviceInTopologyTreeTab(String by, String byLabel, String deviceName,String tab) {
        TopologyTreeTabs topologyTreeTab=TopologyTreeTabs.getEnum(tab);
        TopologyTreeHandler.navigateToIFrame(by,byLabel,deviceName,topologyTreeTab);
    }

    @Then("^UI Navigate Back to Vision from iFrame$")
    public void uiNavigateBackToVisionFromIFrame(){
        TopologyTreeHandler.navigateBackFromIFrame();

    }
}
