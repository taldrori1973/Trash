package com.radware.vision.tests.topologytree;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.InvokeUtils;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.utils.WebUIStrings;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.insite.model.helpers.constants.ImConstants.SnmpV3AuthenticationProtocolEnum;
import com.radware.vision.automation.tools.sutsystemobjects.devicesinfo.enums.SUTDeviceType;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.base.pages.topologytree.DeviceProperties;
import com.radware.vision.infra.base.pages.topologytree.StandardDeviceProperties;
import com.radware.vision.infra.enums.ClusterAssociatedMgmtPorts;
import com.radware.vision.infra.enums.DeviceStatusEnum;
import com.radware.vision.infra.enums.DeviceType4Group;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.DefencePro.DPClusterManageHandler;
import com.radware.vision.infra.testhandlers.baseoperations.BasicOperationsHandler;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import com.radware.vision.pojomodel.device.DevicePojo;
import com.radware.vision.vision_project_cli.RootServerCli;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.After;
import org.junit.Test;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.How;
import testhandlers.Device;
import testhandlers.Tree;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

public class TopologyTree extends WebUITestBase {
    String userName = "radware";
    String password = "radware";
    String elementName;
    String siteName;
    String manageAllDeviceNames;
    String managementIP;
    SUTDeviceType elementType;
    String location;
    DeviceStatusEnum expectedDeviceStatus;
    String addMultiDeviceDelay = "1500";
    String deletiondeviceNames;
    String deletionSiteNames;

    // DP Cluster Attributes
    String containedDPDevices;
    String clusterName;
    String primaryDevice;
    ClusterAssociatedMgmtPorts associatedMgmtPort = ClusterAssociatedMgmtPorts.MNG1;

    //	Manage vADC
    String manageVadcLocation = "Default";

    String managedDeviceName = "";

    com.radware.vision.pojomodel.helpers.constants.ImConstants$SnmpVersionEnumPojo snmpVersion = com.radware.vision.pojomodel.helpers.constants.ImConstants$SnmpVersionEnumPojo.SNMP_V2;

    String readCommunity = "public";
    String writeCommunityAlteon = "private";
    String writeCommunityDefencePro = "public";

    String snmpReadCommunity = "public";
    String snmpWriteCommunity;

    String snmpV3Username;
    boolean useSnmpV3Authentication = false;
    SnmpV3AuthenticationProtocolEnum snmpV3AuthenticationProtocol = SnmpV3AuthenticationProtocolEnum.MD5;
    String snmpV3AuthenticationPassword = "admin";
    boolean useSnmpV3Privacy = false;
    String snmpV3PrivacyPassword = "admin";

    String httpUserNameAlteon = "admin";
    String httpPasswordAlteon = "admin";
    String httpUserNameDefensePro = "radware";
    String httpPasswordDefensePro = "radware";
    int httpPort = 80;
    int httpsPort = 443;
    boolean verifyHttpAccess = true;
    boolean verifyHttpsAccess = true;

    String sshUserName = "admin";
    String sshPassword = "admin";
    int sshPort = 22;

    boolean registerVisionServer = true;
    com.radware.vision.pojomodel.helpers.constants.ImConstants$VisionMgtPortEnumPojo visionMgtPort = com.radware.vision.pojomodel.helpers.constants.ImConstants$VisionMgtPortEnumPojo.G1;
    boolean removeTargets = false;

    String multiSelectionItems;
    String parent;
    String baseIP;
    int amountOfSites = 1;
    int amountOfDevices = 1;
    int startIndex = 1;
    String ip = "";
    DeviceType4Group deviceType4Group;
    String groupName;

    TopologyTreeTabs treeNode = TopologyTreeTabs.SitesAndClusters;


    int timeout;


    /*
     * @Before public void beforeTree() throws Exception { try {
     * VisionServerInfoPane topoTree = new VisionServerInfoPane();
     * topoTree.openTopologyTree(); DeviceProperties newSiteProperties = new
     * DeviceProperties(); newSiteProperties.pinDevicesTree(); }catch(Exception
     * e){
     *
     * } }
     */
    @Test
    @TestProperties(name = "add new Site", paramsInclude = {"qcTestId", "siteName", "parent"})
    public void addNewSite() throws Exception {
        try {
            TopologyTreeHandler.addNewSite(siteName, parent);
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "add new Device", paramsInclude = {"qcTestId", "deviceName", "parent", "managementIP", "elementType", "visionMgtPort", "registerVisionServer", "snmpReadCommunity", "snmpWriteCommunity", "httpUserNameDefensePro", "httpPasswordDefensePro"})
    public void addNewDevice() throws Exception {
        try {
            String visionServerIP = (String.valueOf(visionMgtPort)).concat(" (").concat(getVisionServerIp()).concat(")");
            HashMap<String, String> deviceProperties = new HashMap<String, String>();
            deviceProperties.put("snmpReadCommunity", snmpReadCommunity);
            deviceProperties.put("httpUserNameDefensePro", httpUserNameDefensePro);
            deviceProperties.put("httpPasswordDefensePro", httpPasswordDefensePro);
            if (org.apache.commons.lang.StringUtils.isEmpty(snmpWriteCommunity)) {
                snmpWriteCommunity = elementType.equals(SUTDeviceType.DefensePro) ? writeCommunityDefencePro : writeCommunityAlteon;
            }
            deviceProperties.put("snmpWriteCommunity", snmpWriteCommunity);

            TopologyTreeHandler.addNewDevice(elementType, getDeviceName(), parent, managementIP, visionServerIP, registerVisionServer, deviceProperties);

            // TODO must remove after solving the issue "DE34463"
            WebUIUtils.getDriver().navigate().refresh();
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "add Multiple Device WebUI", paramsInclude = {"qcTestId", "deviceName", "amountOfDevices", "parent", "baseIP", "elementType", "visionMgtPort", "registerVisionServer", "startIndex"})
    public void addMultipleDevicesWebUI() throws Exception {
        try {

            String visionServerIP = (String.valueOf(visionMgtPort)).concat(" (").concat(getVisionServerIp()).concat(")");
            for (int i = startIndex; i < (startIndex + amountOfDevices); i++) {
                try {
                    TopologyTreeHandler.addNewDevice(elementType,
                            getDeviceName().concat(String.valueOf(i)), parent,
                            baseIP.concat(String.valueOf(i)), visionServerIP, registerVisionServer);
                } catch (Exception e) {
                    BaseTestUtils.report("Topology Element failed to be created:" + getDeviceName() + "\n" + parseExceptionBody(e), Reporter.PASS);
                }
                DeviceProperties.cancelDialog();
            }

//			DevicePojo deviceFromGet = new DevicePojo();
//			deviceFromGet = DeviceUtils.getDeviceByID(getVisionRestClient(), DeviceUtils.getDeviceOrmid(getVisionRestClient(), deviceName));
//			String compareResult = compareDeviceValues(deviceFromGet);
//			if (!compareResult.equals("")) {
//				BaseTestUtils.report("Device: " + getDeviceNameWithOutType() + " was not updated correctly. " + "Non matching properties: " + compareResult, Reporter.FAIL);
//			}
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Add New AlteonVX Device", paramsInclude = {"qcTestId", "deviceName", "parent", "managementIP", "visionMgtPort", "registerVisionServer", "snmpReadCommunity", "snmpWriteCommunity"})
    public void addNewAlteonVXDevice() throws Exception {
        try {
            String visionServerIP = (String.valueOf(visionMgtPort)).concat(" (").concat(getVisionServerIp()).concat(")");
            setElementType(SUTDeviceType.Alteon);
            setSshUserName("");
            setSshPassword("");
            HashMap<String, String> deviceProperties = new HashMap<String, String>();
            deviceProperties.put("snmpReadCommunity", snmpReadCommunity);
            deviceProperties.put("snmpWriteCommunity", snmpWriteCommunity);
            TopologyTreeHandler.addNewAlteonVXDevice(getDeviceName(), parent, managementIP, visionServerIP, registerVisionServer, deviceProperties);
//            BasicOperationsHandler.delay(2);
//			DevicePojo deviceFromGet = new DevicePojo();
//			deviceFromGet = DeviceUtils.getDeviceByID(getVisionRestClient(), DeviceUtils.getDeviceOrmid(getVisionRestClient(), getDeviceNameWithOutType()));
//			String compareResult = compareDeviceValues(deviceFromGet);
//			if (!compareResult.equals("")) {
//				BaseTestUtils.report("Device: " + getDeviceNameWithOutType() + " was not updated correctly. " + "Non matching properties: " + compareResult, Reporter.FAIL);
//			}
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "add multiple Devices", paramsInclude = {"qcTestId", "deviceName", "parent", "baseIP", "amountOfDevices", "elementType",
            "visionMgtPort", "addMultiDeviceDelay"})
    public void addMultipleDevices() throws Exception {
        try {
            HashMap<String, String> deviceProperties = new HashMap<String, String>();
            deviceProperties.put("snmpV2ReadCommunity", readCommunity);
            deviceProperties.put("deviceType", elementType.getDeviceType());
            deviceProperties.put("snmpV2WriteCommunity", writeCommunityAlteon);
            deviceProperties.put("visionMgtPort", String.valueOf(visionMgtPort));

            if (elementType.equals(SUTDeviceType.Alteon)) {
                deviceProperties.put("sshUsername", sshUserName);
                deviceProperties.put("sshPassword", sshPassword);
                deviceProperties.put("sshPort", String.valueOf(sshPort));
            }
            deviceProperties.put("httpUsername", httpUserNameAlteon);
            deviceProperties.put("httpPassword", httpPasswordAlteon);
            deviceProperties.put("httpsUsername", httpUserNameAlteon);
            deviceProperties.put("httpsPassword", httpUserNameAlteon);
            for (int i = 0; i < amountOfDevices; i++) {
                ip = "";
                managementIP = baseIP.concat(".").concat(String.valueOf(i + 1));
                ip = ip.concat(managementIP);
                deviceProperties.put("ip", ip);
                String currentDeviceName = getDeviceName().concat(String.valueOf(i + 1));
                deviceProperties.put("name", currentDeviceName);
                if (elementType.equals(SUTDeviceType.Alteon))
                    Device.addNewAlteonDevice(getVisionRestClient(), currentDeviceName, parent, deviceProperties, visionMgtPort);
                else
                    Device.addNewDefenceProDevice(getVisionRestClient(), String.valueOf(managementIP), parent, deviceProperties, visionMgtPort);
            }

        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Delete Multiple Devices - Sequential", paramsInclude = {"qcTestId", "deviceName", "amountOfDevices"})
    public void deleteMultipleDevicesSequential() throws Exception {
        try {
            for (int i = 1; i <= amountOfDevices; i++) {
                try {
                    Device.deleteDeviceByName(getVisionRestClient(), getDeviceName() + i);
                } catch (Exception e1) {
                    BaseTestUtils.report("Could not delete elements: " + getDeviceName() + i + "\n" + parseExceptionBody(e1), Reporter.FAIL);
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Could not delete all elements." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Delete Multiple Devices - By Names", paramsInclude = {"qcTestId", "deletiondeviceNames"})
    public void deleteMultipleDevicesByNames() throws Exception {
        try {
            List<String> deviceNames = Arrays.asList(deletiondeviceNames.split(","));
            for (String currentDevice : deviceNames) {
                try {
                    TopologyTreeHandler.deleteDevice(currentDevice);
                } catch (Exception e1) {
                    BaseTestUtils.report("Could not delete elements: " + currentDevice + "\n" + parseExceptionBody(e1), Reporter.FAIL);
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Could not delete all elements." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Delete Multiple Sites - By Names", paramsInclude = {"qcTestId", "deletionSiteNames"})
    public void deleteMultipleSites() throws Exception {
        try {
            List<String> siteNames = Arrays.asList(deletionSiteNames.split(","));
            for (String currentSite : siteNames) {
                Tree.deleteSiteByName(getVisionRestClient(), currentSite);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Could not delete all sites." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Delete Multiple Sites - Sequential", paramsInclude = {"qcTestId", "siteName", "amountOfSites"})
    public void deleteMultipleSitesSequential() throws Exception {
        try {
            for (int i = 1; i <= amountOfSites; i++) {
                try {
                    Tree.deleteSiteByName(getVisionRestClient(), siteName + i);
                } catch (Exception deleteException) {
                    BaseTestUtils.report("Could not delete site: " + siteName + 1 + parseExceptionBody(deleteException), Reporter.PASS);
                }
            }
        } catch (Exception e) {
            BaseTestUtils.report("Could not delete all sites." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "delete Element", paramsInclude = {"qcTestId", "elementName"})
    public void deleteDevice() throws Exception {
        try {
            TopologyTreeHandler.deleteDevice(elementName);
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Check If Device Delete From Db", paramsInclude = {"deviceName"})
    public void checkIfDeviceDeleteFromDb() throws Exception {
        RootServerCli rootUser = getRestTestBase().getRootServerCli();
        InvokeUtils.invokeCommand("mysql -sN -prad123 -e  'use vision_ng; select count(*) from site_tree_elem_abs where name=\"" + getDeviceName() + "\"'", rootUser);
        int result = Integer.parseInt(rootUser.getLastRow());
        if (result != 0) {
            BaseTestUtils.report("Device Still Exists In The Database. Result: " + result, Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "edit AppWall", paramsInclude = {"qcTestId", "deviceName", "managementIP", "visionMgtPort",
            "httpUserNameAlteon", "httpPasswordAlteon", "httpsPort",
            "registerVisionServer", "removeTargets"})
    public void editAppWall() throws Exception {
        HashMap<String, String> deviceProperties = new HashMap<String, String>(40);
        String visionServerIP = (String.valueOf(visionMgtPort)).concat(" (").concat(getVisionServerIp()).concat(")");
        try {
            setElementType(SUTDeviceType.AppWall);

            deviceProperties.put("deviceName", getDeviceName());
            deviceProperties.put("verifyHttpAccess", String.valueOf(verifyHttpAccess));
            deviceProperties.put("verifyHttpsAccess", String.valueOf(verifyHttpsAccess));
            deviceProperties.put("httpUserName", httpUserNameAlteon);
            deviceProperties.put("httpPassword", httpPasswordAlteon);
            deviceProperties.put("httpsPort", String.valueOf(getHttpsPort()));

            deviceProperties.put("registerVisionServer", String.valueOf(registerVisionServer));
            deviceProperties.put("visionServerIP", visionServerIP);
            deviceProperties.put("removeTargets", String.valueOf(removeTargets));

            TopologyTreeHandler.editAppWall(deviceProperties);

        } catch (Exception e) {
            BaseTestUtils.report(
                    "Topology Element may not have been found: \n" + "Error: " + e.getCause() + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    @Test
    @TestProperties(name = "edit Alteon", paramsInclude = {"qcTestId", "deviceName", "managementIP", "visionMgtPort", "snmpVersion", "readCommunity",
            "writeCommunityAlteon", "httpUserNameAlteon", "httpPasswordAlteon", "httpPort", "httpsPort", "verifyHttpAccess", "verifyHttpsAccess",
            "sshUserName", "sshPassword", "sshPort", "registerVisionServer", "removeTargets", "snmpV3Username", "useSnmpV3Authentication",
            "snmpV3AuthenticationProtocol", "snmpV3AuthenticationPassword", "useSnmpV3Privacy", "snmpV3PrivacyPassword"})
    public void editAlteon() throws Exception {
        HashMap<String, String> deviceProperties = new HashMap<String, String>(40);
        String visionServerIP = (String.valueOf(visionMgtPort)).concat(" (").concat(getVisionServerIp()).concat(")");
        String compareResult = "";
        try {
            setElementType(SUTDeviceType.Alteon);
            deviceProperties.put("snmpV3Username", snmpV3Username);
            deviceProperties.put("useSnmpV3Authentication", String.valueOf(useSnmpV3Authentication));
            deviceProperties.put("snmpV3AuthenticationProtocol", String.valueOf(snmpV3AuthenticationProtocol));
            deviceProperties.put("snmpV3AuthenticationPassword", snmpV3AuthenticationPassword);
            deviceProperties.put("useSnmpV3Privacy", String.valueOf(useSnmpV3Privacy));
            deviceProperties.put("snmpV3PrivacyPassword", snmpV3PrivacyPassword);
            deviceProperties.put("snmpVersion", String.valueOf(snmpVersion.toString()));

            deviceProperties.put("deviceName", getDeviceName());
            deviceProperties.put("readCommunity", readCommunity);
            deviceProperties.put("writeCommunityAlteon", writeCommunityAlteon);
            deviceProperties.put("verifyHttpAccess", String.valueOf(verifyHttpAccess));
            deviceProperties.put("verifyHttpsAccess", String.valueOf(verifyHttpsAccess));
            deviceProperties.put("httpUserName", httpUserNameAlteon);
            deviceProperties.put("httpPassword", httpPasswordAlteon);
            deviceProperties.put("httpPort", String.valueOf(getHttpPort()));
            deviceProperties.put("httpsPort", String.valueOf(getHttpsPort()));
            deviceProperties.put("sshUserName", sshUserName);
            deviceProperties.put("sshPassword", sshPassword);
            deviceProperties.put("sshPort", String.valueOf(getSshPort()));

            deviceProperties.put("registerVisionServer", String.valueOf(registerVisionServer));
            deviceProperties.put("visionServerIP", visionServerIP);
            deviceProperties.put("removeTargets", String.valueOf(removeTargets));

            TopologyTreeHandler.editAlteon(deviceProperties);

//			BasicOperationsHandler.delay(15); // Wait for the new values are updated on the Device And Vision Server
//			DevicePojo deviceFromGet = new DevicePojo();
//			deviceFromGet = DeviceUtils.getDeviceByID(getVisionRestClient(), DeviceUtils.getDeviceOrmid(getVisionRestClient(), getDeviceNameWithOutType()));
//			compareResult = compareDeviceValues(deviceFromGet);
//			if (!compareResult.equals("")) {
//				BaseTestUtils.report("Device: " + getDeviceNameWithOutType() + " was not updated correctly. " + "Non matching properties: " + compareResult, Reporter.FAIL);
//			}
        } catch (Exception e) {
            BaseTestUtils.report(
                    "Topology Element may not have been found: \n" + "Error: " + e.getCause() + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Edit alteon VX", paramsInclude = {"qcTestId", "deviceName", "managementIP", "visionMgtPort", "snmpVersion", "readCommunity",
            "writeCommunityAlteon", "httpUserNameAlteon", "httpPasswordAlteon", "httpPort", "httpsPort", "verifyHttpAccess", "verifyHttpsAccess",
            "registerVisionServer", "removeTargets", "snmpV3Username", "useSnmpV3Authentication",
            "snmpV3AuthenticationProtocol", "snmpV3AuthenticationPassword", "useSnmpV3Privacy", "snmpV3PrivacyPassword"})
    public void editAlteonVX() throws Exception {
        HashMap<String, String> deviceProperties = new HashMap<String, String>(50);
        String visionServerIP = (String.valueOf(visionMgtPort)).concat(" (").concat(getVisionServerIp()).concat(")");
        String compareResult = "";
        try {
            setElementType(SUTDeviceType.Alteon);
            setSshUserName("");
            setSshPassword("");
            setSshPort("22");
            deviceProperties.put("snmpV3Username", snmpV3Username);
            deviceProperties.put("useSnmpV3Authentication", String.valueOf(useSnmpV3Authentication));
            deviceProperties.put("snmpV3AuthenticationProtocol", String.valueOf(snmpV3AuthenticationProtocol));
            deviceProperties.put("snmpV3AuthenticationPassword", snmpV3AuthenticationPassword);
            deviceProperties.put("useSnmpV3Privacy", String.valueOf(useSnmpV3Privacy));
            deviceProperties.put("snmpV3PrivacyPassword", snmpV3PrivacyPassword);
            deviceProperties.put("snmpVersion", String.valueOf(snmpVersion.toString()));
            deviceProperties.put("deviceName", getDeviceName());
            deviceProperties.put("readCommunity", readCommunity);
            deviceProperties.put("writeCommunityAlteon", writeCommunityAlteon);

            deviceProperties.put("verifyHttpAccess", String.valueOf(verifyHttpAccess));
            deviceProperties.put("verifyHttpsAccess", String.valueOf(verifyHttpsAccess));
            deviceProperties.put("httpUserName", httpUserNameAlteon);
            deviceProperties.put("httpPassword", httpPasswordAlteon);
            deviceProperties.put("httpPort", String.valueOf(getHttpPort()));
            deviceProperties.put("httpsPort", String.valueOf(getHttpsPort()));

            deviceProperties.put("registerVisionServer", String.valueOf(registerVisionServer));
            deviceProperties.put("visionServerIP", visionServerIP);
            deviceProperties.put("removeTargets", String.valueOf(removeTargets));

            TopologyTreeHandler.editAlteonVX(deviceProperties);

//			DevicePojo deviceFromGet = new DevicePojo();
//			deviceFromGet = DeviceUtils.getDeviceByID(getVisionRestClient(), DeviceUtils.getDeviceOrmid(getVisionRestClient(), getDeviceNameWithOutType()));
//			compareResult = compareDeviceValues(deviceFromGet);
//			if (!compareResult.equals("")) {
//				BaseTestUtils.report("Device: " + getDeviceNameWithOutType() + " was not updated correctly. " + "Non matching properties: " + compareResult, Reporter.FAIL);
//			}
        } catch (Exception e) {
            BaseTestUtils.report(
                    "Topology Element may not have been found: \n" + "\n" + "Error: " + e.getCause() + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "edit DefencePro", paramsInclude = {"qcTestId", "deviceName", "managementIP", "visionMgtPort", "snmpVersion", "readCommunity",
            "writeCommunityDefencePro", "httpUserNameDefensePro", "httpPasswordDefensePro", "httpPort", "httpsPort", "verifyHttpAccess", "verifyHttpsAccess",
            "registerVisionServer", "removeTargets", "snmpV3Username", "useSnmpV3Authentication", "snmpV3AuthenticationProtocol",
            "snmpV3AuthenticationPassword", "useSnmpV3Privacy", "snmpV3PrivacyPassword"})
    public void editDefencePro() throws Exception {
        HashMap<String, String> deviceProperties = new HashMap<String, String>(40);
        String visionServerIP = (String.valueOf(visionMgtPort)).concat(" (").concat(getVisionServerIp()).concat(")");
        String compareResult = "";
        try {
            setElementType(SUTDeviceType.DefensePro);
            deviceProperties.put("snmpV3Username", snmpV3Username);
            deviceProperties.put("useSnmpV3Authentication", String.valueOf(useSnmpV3Authentication));
            deviceProperties.put("snmpV3AuthenticationProtocol", String.valueOf(snmpV3AuthenticationProtocol));
            deviceProperties.put("snmpV3AuthenticationPassword", snmpV3AuthenticationPassword);
            deviceProperties.put("useSnmpV3Privacy", String.valueOf(useSnmpV3Privacy));
            deviceProperties.put("snmpV3PrivacyPassword", snmpV3PrivacyPassword);
            deviceProperties.put("snmpVersion", String.valueOf(snmpVersion));

            deviceProperties.put("deviceName", getDeviceName());
            deviceProperties.put("readCommunity", readCommunity);
            deviceProperties.put("writeCommunityDefencePro", writeCommunityDefencePro);
            deviceProperties.put("verifyHttpAccess", String.valueOf(verifyHttpAccess));
            deviceProperties.put("verifyHttpsAccess", String.valueOf(verifyHttpsAccess));
            deviceProperties.put("httpUserName", httpUserNameDefensePro);
            deviceProperties.put("httpPassword", httpPasswordDefensePro);
            deviceProperties.put("httpPort", String.valueOf(getHttpPort()));
            deviceProperties.put("httpsPort", String.valueOf(getHttpsPort()));

            deviceProperties.put("registerVisionServer", String.valueOf(registerVisionServer));
            deviceProperties.put("visionServerIP", visionServerIP);
            deviceProperties.put("removeTargets", String.valueOf(removeTargets));

            TopologyTreeHandler.editDefencePro(deviceProperties);

//			DevicePojo deviceFromGet = new DevicePojo();
//			deviceFromGet = DeviceUtils.getDeviceByID(getVisionRestClient(), DeviceUtils.getDeviceOrmid(getVisionRestClient(), deviceName));
//			compareResult = compareDeviceValues(deviceFromGet);
//			if (!compareResult.equals("")) {
//				BaseTestUtils.report("Device: " + getDeviceNameWithOutType() + " was not updated correctly. " + "Non matching properties: " + compareResult, Reporter.FAIL);
//			}
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found: " + "\n" + "Error: " + e.getCause() + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "click Tree Element", paramsInclude = {"qcTestId", "deviceName"})
    public void clickTreeElement() throws Exception {
        try {
            TopologyTreeHandler.findTreeElement(getDeviceName());
        } catch (Exception e) {
            BaseTestUtils.report("Topology Tree may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Is Tree Node Exists", paramsInclude = {"qcTestId", "deviceName"})
    public void isTreeNodeExists() throws Exception {
        try {
            WebElement node = WebUIUtils.fluentWaitDisplayed(new ComponentLocator(How.ID, WebUIStrings.getDeviceTreeNode(getDeviceName())).getBy(), WebUIUtils.SHORT_WAIT_TIME, false);
            if (node != null) {
                BaseTestUtils.report("Topology Tree was found:\n", Reporter.PASS);
            } else {
                BaseTestUtils.report("Topology Tree was not found:\n", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Topology Tree may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "add multiple Sites", paramsInclude = {"qcTestId", "siteName", "parent", "amountOfSites"})
    public void addMultipleSites() throws Exception {
        HashMap<String, String> devicePorperties = new HashMap<String, String>();
        try {
            for (int i = 0; i < amountOfSites; i++) {
                devicePorperties.put("name", siteName.concat(String.valueOf(i + 1)));
                Tree.addNewSite(getVisionRestClient(), parent, devicePorperties);
            }

        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Tree Exapnd All", paramsInclude = {"qcTestId"})
    public void treeExpandAll() {
        try {
            TopologyTreeHandler.expandAll();
        } catch (Exception e) {
            BaseTestUtils.report("Expand all failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Tree Multi-Selection", paramsInclude = {"qcTestId", "multiSelectionItems"})
    public void treeMultiSelection() {
        try {
            List<String> treeNodes = Arrays.asList(getMultiSelectionItems().split(","));
            TopologyTreeHandler.multiSelection(treeNodes);
        } catch (Exception e) {
            BaseTestUtils.report("Expand all failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ExpandAll Physical Containers", paramsInclude = {"qcTestId"})
    public void expandAllPhysicalContainers() throws Exception {
        try {
            TopologyTreeHandler.expandAllPhysical();
        } catch (Exception e) {
            BaseTestUtils.report("ExpandAll Physical Containers may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ExpandAll Sites & Clusters", paramsInclude = {"qcTestId"})
    public void expandAllSitesAndClusters() throws Exception {
        try {
            TopologyTreeHandler.expandAllSitesClusters();
        } catch (Exception e) {
            BaseTestUtils.report("ExpandAll Sites & Clusters may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "ExpandAll Logical Groups", paramsInclude = {"qcTestId"})
    public void expandAllLogicalGroups() throws Exception {
        try {
            TopologyTreeHandler.expandAllLogicalGroups();
        } catch (Exception e) {
            BaseTestUtils.report("ExpandAll LogicalGroups may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Open Device Properties - Sites & Clusters", paramsInclude = {"qcTestId", "deviceName"})
    public void openDevicePropertiesSitesAndClusters() throws Exception {
        try {
            TopologyTreeHandler.openDeviceSitesClusters(getDeviceName());
        } catch (Exception e) {
            BaseTestUtils.report("Could not open device proprties for: " + getDeviceName() + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Open Device Properties - Physical Containers", paramsInclude = {"qcTestId", "deviceName"})
    public void openDevicePropertiesPhysicalContainers() throws Exception {
        try {
            TopologyTreeHandler.openDevicePhysical(getDeviceName());
        } catch (Exception e) {
            BaseTestUtils.report("Could not open device proprties for: " + getDeviceName() + "\n." + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "open Physical Containers", paramsInclude = {"qcTestId"})
    public void openPhysicalContainers() throws Exception {
        try {
            TopologyTreeHandler.openPhysicalContainers();
        } catch (Exception e) {
            BaseTestUtils.report("Topology Tree may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "open Sites And Clusters", paramsInclude = {"qcTestId"})
    public void openSitesAndClusters() throws Exception {
        try {
            TopologyTreeHandler.openSitesAndClusters();
        } catch (Exception e) {
            BaseTestUtils.report("Topology Tree may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "open Logical Groups", paramsInclude = {"qcTestId"})
    public void openLogicalGroups() throws Exception {
        try {
            TopologyTreeHandler.openGroups();
        } catch (Exception e) {
            BaseTestUtils.report("Logical Groups may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Wait For Device To Show Up In The Topology Tree", paramsInclude = {"treeNode", "deviceName", "timeout"})
    public void waitForDeviceToShowUp() {
        TopologyTreeHandler.waitForDeviceToShowUp(treeNode, getDeviceName(), timeout);

    }

    @Test
    @TestProperties(name = "Wait For Device Status -UI", paramsInclude = {"treeNode", "deviceName", "expectedDeviceStatus", "timeout"})
    public void waitForDeviceStatus() {
        TopologyTreeHandler.waitForDeviceStatus(treeNode, getDeviceName(), expectedDeviceStatus, timeout);
    }

    @Test
    @TestProperties(name = "Verify Device Status - Sites & Clusters", paramsInclude = {"qcTestId", "deviceName", "expectedDeviceStatus"})
    public void verifyDeviceStatusSites() throws Exception {
        try {
            String deviceStatus = TopologyTreeHandler.getDeviceStatusSites(getDeviceName());
            if (getExpectedDeviceStatus() == DeviceStatusEnum.UP_OR_MAINTENANCE) {
                if (!((deviceStatus.equals(DeviceStatusEnum.UP.getStatus())) || (deviceStatus.equals(DeviceStatusEnum.MAINTENANCE.getStatus())))) {
                    BaseTestUtils.report("Device " + getDeviceName() + " " + "did not reach status: " + getExpectedDeviceStatus() + ". " + "\nCurrent status: " + deviceStatus, Reporter.FAIL);
                }
            } else if (!(deviceStatus.equals(getExpectedDeviceStatus().getStatus()))) {
                BaseTestUtils.report("Device " + getDeviceName() + " " + "did not reach status: " + getExpectedDeviceStatus() + ". " + "\nCurrent status: " + deviceStatus, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Topology Tree may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    @Test
    @TestProperties(name = "Verify Device Status - Physical Containers", paramsInclude = {"qcTestId", "deviceName", "expectedDeviceStatus"})
    public void verifyDeviceStatusPhysical() throws Exception {
        try {
            String deviceStatus = TopologyTreeHandler.getDeviceStatusPhysical(getDeviceName());
            if (getExpectedDeviceStatus() == DeviceStatusEnum.UP_OR_MAINTENANCE) {
                if (!((deviceStatus.equals(DeviceStatusEnum.UP.getStatus())) || (deviceStatus.equals(DeviceStatusEnum.MAINTENANCE.getStatus())))) {
                    BaseTestUtils.report("Device " + getDeviceName() + " " + "did not reach status: " + getExpectedDeviceStatus() + ". " + "\nCurrent status: " + deviceStatus, Reporter.FAIL);
                }
            } else if (!(deviceStatus.equals(getExpectedDeviceStatus().getStatus()))) {
                BaseTestUtils.report("Device " + getDeviceName() + " " + "did not reach status: " + getExpectedDeviceStatus() + ". " + "\nCurrent status: " + deviceStatus, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Topology Tree may not have been open properly:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    @Test
    @TestProperties(name = "manage vADC", paramsInclude = {"qcTestId", "deviceName", "managedDeviceName", "manageVadcLocation", "visionMgtPort", "snmpVersion", "readCommunity",
            "writeCommunityAlteon", "httpUserNameAlteon", "httpPasswordAlteon", "httpPort", "httpsPort", "verifyHttpAccess", "verifyHttpsAccess",
            "sshUserName", "sshPassword", "sshPort", "registerVisionServer", "removeTargets", "snmpV3Username", "useSnmpV3Authentication",
            "snmpV3AuthenticationProtocol", "snmpV3AuthenticationPassword", "useSnmpV3Privacy", "snmpV3PrivacyPassword"})
    public void manageVADC() throws Exception {
        HashMap<String, String> deviceProperties = new HashMap<String, String>(40);
        String visionServerIP = (String.valueOf(visionMgtPort)).concat(" (").concat(getVisionServerIp()).concat(")");
        try {
            deviceProperties.put("manageVadcLocation", manageVadcLocation);
            deviceProperties.put("snmpV3Username", snmpV3Username);
            deviceProperties.put("useSnmpV3Authentication", String.valueOf(useSnmpV3Authentication));
            deviceProperties.put("snmpV3AuthenticationProtocol", String.valueOf(snmpV3AuthenticationProtocol));
            deviceProperties.put("snmpV3AuthenticationPassword", snmpV3AuthenticationPassword);
            deviceProperties.put("useSnmpV3Privacy", String.valueOf(useSnmpV3Privacy));
            deviceProperties.put("snmpV3PrivacyPassword", snmpV3PrivacyPassword);
            deviceProperties.put("snmpVersion", String.valueOf(snmpVersion));

            deviceProperties.put("deviceName", getDeviceName());
            deviceProperties.put("location", location);
            deviceProperties.put("readCommunity", readCommunity);
            deviceProperties.put("writeCommunityAlteon", writeCommunityAlteon);
            deviceProperties.put("verifyHttpAccess", String.valueOf(verifyHttpAccess));
            deviceProperties.put("verifyHttpsAccess", String.valueOf(verifyHttpsAccess));
            deviceProperties.put("httpUserName", httpUserNameAlteon);
            deviceProperties.put("httpPassword", httpPasswordAlteon);
            deviceProperties.put("httpPort", String.valueOf(getHttpPort()));
            deviceProperties.put("httpsPort", String.valueOf(getHttpsPort()));
            deviceProperties.put("sshUserName", sshUserName);
            deviceProperties.put("sshPassword", sshPassword);
            deviceProperties.put("sshPort", String.valueOf(getSshPort()));

            deviceProperties.put("registerVisionServer", String.valueOf(registerVisionServer));
            deviceProperties.put("visionServerIP", visionServerIP);
            deviceProperties.put("removeTargets", String.valueOf(removeTargets));
            deviceProperties.put("managedDeviceName", managedDeviceName);

            TopologyTreeHandler.manageVADC(deviceProperties);

            BasicOperationsHandler.delay(15);
            String existingVadcs = checkVadcDevices(new ArrayList<String>(Arrays.asList(managedDeviceName)));
            if (!existingVadcs.equals("")) {
                BaseTestUtils.report("Device: " + getDeviceName() + " was not created correctly. ", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    /**
     * this test will multiselect the devices and manage them all once.
     *
     * @throws Exception
     */

    @Test
    @TestProperties(name = "Manage All vADC", paramsInclude = {"qcTestId", "manageAllDeviceNames", "manageVadcLocation", "visionMgtPort", "snmpVersion", "readCommunity",
            "writeCommunityAlteon", "httpUserNameAlteon", "httpPasswordAlteon", "httpPort", "httpsPort", "verifyHttpAccess", "verifyHttpsAccess",
            "sshUserName", "sshPassword", "sshPort", "registerVisionServer", "removeTargets", "snmpV3Username", "useSnmpV3Authentication",
            "snmpV3AuthenticationProtocol", "snmpV3AuthenticationPassword", "useSnmpV3Privacy", "snmpV3PrivacyPassword"})
    public void manageAllVADC() throws Exception {
        HashMap<String, String> deviceProperties = new HashMap<String, String>(40);
        String visionServerIP = (String.valueOf(visionMgtPort)).concat(" (").concat(getVisionServerIp()).concat(")");
        try {
            deviceProperties.put("manageVadcLocation", manageVadcLocation);
            deviceProperties.put("snmpV3Username", snmpV3Username);
            deviceProperties.put("useSnmpV3Authentication", String.valueOf(useSnmpV3Authentication));
            deviceProperties.put("snmpV3AuthenticationProtocol", String.valueOf(snmpV3AuthenticationProtocol));
            deviceProperties.put("snmpV3AuthenticationPassword", snmpV3AuthenticationPassword);
            deviceProperties.put("useSnmpV3Privacy", String.valueOf(useSnmpV3Privacy));
            deviceProperties.put("snmpV3PrivacyPassword", snmpV3PrivacyPassword);
            deviceProperties.put("snmpVersion", String.valueOf(snmpVersion));

            deviceProperties.put("deviceName", getDeviceName());
            deviceProperties.put("location", location);
            deviceProperties.put("readCommunity", readCommunity);
            deviceProperties.put("writeCommunityAlteon", writeCommunityAlteon);
            deviceProperties.put("verifyHttpAccess", String.valueOf(verifyHttpAccess));
            deviceProperties.put("verifyHttpsAccess", String.valueOf(verifyHttpsAccess));
            deviceProperties.put("httpUserName", httpUserNameAlteon);
            deviceProperties.put("httpPassword", httpPasswordAlteon);
            deviceProperties.put("httpPort", String.valueOf(getHttpPort()));
            deviceProperties.put("httpsPort", String.valueOf(getHttpsPort()));
            deviceProperties.put("sshUserName", sshUserName);
            deviceProperties.put("sshPassword", sshPassword);
            deviceProperties.put("sshPort", String.valueOf(getSshPort()));

            deviceProperties.put("registerVisionServer", String.valueOf(registerVisionServer));
            deviceProperties.put("visionServerIP", visionServerIP);
            deviceProperties.put("removeTargets", String.valueOf(removeTargets));


            List<String> deviceNames = new ArrayList<String>(Arrays.asList(manageAllDeviceNames.split(",")));
            if (deviceNames.size() == 1) {

                throw new Exception("This test can't work with single device name");
            }
            BasicOperationsHandler.delay(15);
            TopologyTreeHandler.manageAllVADC(deviceProperties, deviceNames);
            String existingVadcs = checkVadcDevices(new ArrayList<String>(deviceNames));

            if (!existingVadcs.equals("")) {
                BaseTestUtils.report("Failed with the following errors: " + existingVadcs, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Topology Element may not have been found :" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Create DP Cluster", paramsInclude = {"qcTestId", "containedDPDevices", "clusterName", "primaryDevice", "associatedMgmtPort"})
    public void createDPCluster() {
        try {
//            List<String> targetDevices = new ArrayList<String>(Arrays.asList(containedDPDevices.split(",")));
//            DPClusterManageHandler.createDPCluster(targetDevices, clusterName, primaryDevice, associatedMgmtPort);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to create DP Cluster: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Break DP Cluster", paramsInclude = {"qcTestId", "clusterName"})
    public void breakDPCluster() {
        try {
            DPClusterManageHandler.breakDPCluster(clusterName);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to break DP Cluster: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Add New Logical Group", paramsInclude = {"qcTestId", "deviceType4Group", "groupName", "multiSelectionItems"})
    public void addNewGroup() {
        try {
            TopologyTreeHandler.addNewGroup(deviceType4Group, groupName, multiSelectionItems);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Add New Logical Group: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Edit Logical Group", paramsInclude = {"qcTestId", "groupName", "multiSelectionItems"})
    public void editGroup() {
        try {
            TopologyTreeHandler.editGroup(groupName, multiSelectionItems);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Edit Logical Group: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "Delete Logical Group", paramsInclude = {"qcTestId", "groupName"})
    public void deleteGroup() {
        try {
            TopologyTreeHandler.deleteGroup(groupName);
        } catch (Exception e) {
            BaseTestUtils.report("Failed to Delete Logical Group: " + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    private String compareDeviceValues(DevicePojo origDevice) {
        StringBuffer compareResult = new StringBuffer();

        // SNMP
        String currentSnmpVer = origDevice.getDeviceSetup().getDeviceAccess().getSnmpVersion().toString();
        if (currentSnmpVer.equals("SNMP_V1")) {
            compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getSnmpV1ReadCommunity(), getReadCommunity(),
                    "SNMPv1 Read Community"));
            compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getSnmpV1WriteCommunity(),
                    getElementType().equals(SUTDeviceType.Alteon) ? getwriteCommunityAlteon() : writeCommunityDefencePro, "SNMPv1 Write Community"));
        } else if (currentSnmpVer.equals("SNMP_V2")) {
            compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getSnmpV2ReadCommunity(), getReadCommunity(),
                    "SNMPv2 Read Community"));
            compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getSnmpV2WriteCommunity(),
                    getElementType().equals(SUTDeviceType.Alteon) ? getwriteCommunityAlteon() : writeCommunityDefencePro, "SNMPv2 Write Community"));
        } else if (currentSnmpVer.equals("SNMP_V3")) {
            compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getSnmpV3AuthenticationPassword(),
                    getSnmpV3AuthenticationPassword(), "SNMPv3 Auth Password"));
            compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getSnmpV3AuthenticationProtocol().toString(),
                    getSnmpV3AuthenticationProtocol().toString(), "SNMPv3 Auth Protocol"));
            compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getSnmpV3PrivacyPassword(), getSnmpV3PrivacyPassword(),
                    "SNMPv3 Privacy Password"));
        }

        // HTTP Access
        compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getVerifyHttpCredentials(), getVerifyHttpAccess(),
                "Verify HTTP Credentials"));
        compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getVerifyHttpsCredentials(), getVerifyHttpsAccess(),
                "Verify HTTPS Credentials"));
        compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getHttpUsername(),
                getElementType().equals(SUTDeviceType.Alteon) ? getHttpUserNameAlteon() : getHttpUserNameDefensePro(), "HTTP Username"));
        compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getHttpsUsername(),
                getElementType().equals(SUTDeviceType.Alteon) ? getHttpUserNameAlteon() : getHttpUserNameDefensePro(), "HTTPS Username"));
        compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getHttpPassword(),
                getElementType().equals(SUTDeviceType.Alteon) ? getHttpPasswordAlteon() : getHttpPasswordDefensePro(), "HTTP Password"));
        compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getHttpsPassword(),
                getElementType().equals(SUTDeviceType.Alteon) ? getHttpPasswordAlteon() : getHttpPasswordDefensePro(), "HTTPS Password"));
        compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getHttpPort().toString(), getHttpPort(), "HTTP Port"));
        compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getHttpsPort().toString(), getHttpsPort(), "HTTPS Port"));

        if (getElementType().equals(SUTDeviceType.Alteon)) {
            // SSH
            compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getCliUsername(), getSshUserName(), "SSH Username"));
            compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getCliPassword(), getSshPassword(), "SSH Password"));
            compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getCliPort().toString(), getSshPort(), "SSH Port"));
        }

        // Event Notification
        compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getRegisterDeviceEvents(), getRegisterVisionServer(),
                "Register Device Events"));
        compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getVisionMgtPort().toString(), getVisionMgtPort().toString(),
                "Vision Mgmt Port"));
        if (getRegisterVisionServer()) {
            compareResult.append(testEqualProperties(origDevice.getDeviceSetup().getDeviceAccess().getExclusivelyReceiveDeviceEvents(), getRemoveTargets(),
                    "Remove All Other Targets of Device Events"));
        }

        return compareResult.toString();
    }

    private String testEqualProperties(Object prop1, Object prop2, String propertyName) {
        String result = "";
        if (!(prop1.equals(prop2))) {
            result += propertyName + ": " + "Actual: " + prop1.toString() + ", Expected: " + prop2 + "\n";
        }
        return result;
    }

    public String checkVadcDevices(List<String> devicesNames) {

        StringBuffer existingVadcs = new StringBuffer();
        TopologyTreeHandler.openSitesAndClusters();
        BasicOperationsHandler.refresh();
//        BasicOperationsHandler.delay(1);
        DeviceProperties deviceProperties = new StandardDeviceProperties();
        for (String currentDeviceName : devicesNames) {
            try {
                BasicOperationsHandler.refresh();
//				BasicOperationsHandler.delay(0.5);
                TopologyTreeHandler.clickTreeNode(currentDeviceName);
            } catch (Exception e) {
                existingVadcs.append("Failed to find vADC: " + currentDeviceName).append("\n");
            }
        }

        return existingVadcs.toString();
    }

    @After
    public void closeDevicePropertiesDialog() {
        TopologyTreeHandler.closeDeviceEditDialog();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getElementName() {
        return elementName;
    }

    public void setElementName(String elementName) {
        this.elementName = elementName;
    }

    public String getManageAllDeviceNames() {
        return manageAllDeviceNames;
    }

    @ParameterProperties(description = "Enter the names of the devices. separate them with ','")
    public void setManageAllDeviceNames(String manageAllDeviceNames) {
        this.manageAllDeviceNames = manageAllDeviceNames;
    }

    public SUTDeviceType getElementType() {
        return elementType;
    }

    public void setElementType(SUTDeviceType deviceType) {
        this.elementType = deviceType;
    }

    public String getSiteName() {
        return siteName;
    }

    public void setSiteName(String siteName) {
        this.siteName = siteName;
    }

    public String getManagementIP() {
        return managementIP;
    }

    public void setManagementIP(String managementIP) {
        this.managementIP = managementIP;
    }

    public com.radware.vision.pojomodel.helpers.constants.ImConstants$VisionMgtPortEnumPojo getVisionMgtPort() {
        return this.visionMgtPort;
    }

    public void setVisionMgtPort
            (com.radware.vision.pojomodel.helpers.constants.ImConstants$VisionMgtPortEnumPojo visionMgtPort) {
        this.visionMgtPort = visionMgtPort;
    }

    public com.radware.vision.pojomodel.helpers.constants.ImConstants$SnmpVersionEnumPojo getSnmpVersion() {
        return snmpVersion;
    }

    public void setSnmpVersion(com.radware.vision.pojomodel.helpers.constants.ImConstants$SnmpVersionEnumPojo
                                       snmpVersion) {
        this.snmpVersion = snmpVersion;
    }

    public String getManageVadcLocation() {
        return manageVadcLocation;
    }

    public void setManageVadcLocation(String manageVadcLocation) {
        this.manageVadcLocation = manageVadcLocation;
    }

    public String getReadCommunity() {
        return readCommunity;
    }

    public void setReadCommunity(String readCommunity) {
        this.readCommunity = readCommunity;
    }

    public String getHttpUserNameAlteon() {
        return httpUserNameAlteon;
    }

    public void setHttpUserNameAlteon(String httpUserNameAlteon) {
        this.httpUserNameAlteon = httpUserNameAlteon;
    }

    public String getHttpPasswordAlteon() {
        return httpPasswordAlteon;
    }

    public void setHttpPasswordAlteon(String httpPasswordAlteon) {
        this.httpPasswordAlteon = httpPasswordAlteon;
    }

    public String getHttpUserNameDefensePro() {
        return httpUserNameDefensePro;
    }

    public void setHttpUserNameDefensePro(String httpUserNameDefensePro) {
        this.httpUserNameDefensePro = httpUserNameDefensePro;
    }

    public String getHttpPasswordDefensePro() {
        return httpPasswordDefensePro;
    }

    public void setHttpPasswordDefensePro(String httpPasswordDefensePro) {
        this.httpPasswordDefensePro = httpPasswordDefensePro;
    }

    public String getHttpPort() {
        return String.valueOf(httpPort);
    }

    public void setHttpPort(String httpPort) {
        if (httpPort != null) {
            this.httpPort = Integer.valueOf(StringUtils.fixNumeric(httpPort));
        }
    }

    public String getHttpsPort() {
        return String.valueOf(httpsPort);
    }

    public void setHttpsPort(String httpsPort) {
        if (httpsPort != null) {
            this.httpsPort = Integer.valueOf(StringUtils.fixNumeric(httpsPort));
        }
    }

    public boolean getVerifyHttpAccess() {
        return verifyHttpAccess;
    }

    public void setVerifyHttpAccess(boolean verifyHttpAccess) {
        this.verifyHttpAccess = verifyHttpAccess;
    }

    public boolean getVerifyHttpsAccess() {
        return verifyHttpsAccess;
    }

    public void setVerifyHttpsAccess(boolean verifyHttpsAccess) {
        this.verifyHttpsAccess = verifyHttpsAccess;
    }

    public String getSshUserName() {
        return sshUserName;
    }

    public void setSshUserName(String sshUserName) {
        this.sshUserName = sshUserName;
    }

    public String getSshPassword() {
        return sshPassword;
    }

    public void setSshPassword(String sshPassword) {
        this.sshPassword = sshPassword;
    }

    public String getSshPort() {
        return String.valueOf(sshPort);
    }

    public void setSshPort(String sshPort) {
        try {
            if (sshPort != null) {
                this.sshPort = Integer.valueOf(StringUtils.fixNumeric(sshPort));
            }
        } catch (Exception e) {
            this.sshPort = 0;
        }
    }

    public boolean getRegisterVisionServer() {
        return registerVisionServer;
    }

    public void setRegisterVisionServer(boolean registerVisionServer) {
        this.registerVisionServer = registerVisionServer;
    }

    public boolean getRemoveTargets() {
        return removeTargets;
    }

    public void setRemoveTargets(boolean removeTargets) {
        this.removeTargets = removeTargets;
    }

    public String getwriteCommunityAlteon() {
        return writeCommunityAlteon;
    }

    public void setwriteCommunityAlteon(String writeCommunityAlteon) {
        this.writeCommunityAlteon = writeCommunityAlteon;
    }

    public String getMultiSelectionItems() {
        return multiSelectionItems;
    }

    @ParameterProperties(description = "Fill in the list of tree items, separated by a comma")
    public void setMultiSelectionItems(String multiSelectionItems) {
        this.multiSelectionItems = multiSelectionItems;
    }

    public String getParent() {
        return parent;
    }

    @ParameterProperties(description = "The parent tree element, to which the new element will be added")
    public void setParent(String parent) {
        this.parent = parent;
    }

    public String getBaseIP() {
        return baseIP;
    }

    @ParameterProperties(description = "Base IP Address for multiple device creation. Subnet in Class C. IPs srarting from 1.")
    public void setBaseIP(String baseIP) {
        this.baseIP = baseIP;
    }

    public String getAmountOfDevices() {
        return String.valueOf(amountOfDevices);
    }

    public void setAmountOfDevices(String amountOfDevices) {
        if (amountOfDevices != null) {
            this.amountOfDevices = Integer.valueOf(StringUtils.fixNumeric(amountOfDevices));
        }
    }

    public String getAmountOfSites() {
        return String.valueOf(amountOfSites);
    }

    public void setAmountOfSites(String amountOfSites) {
        if (amountOfSites != null) {
            this.amountOfSites = Integer.valueOf(StringUtils.fixNumeric(amountOfSites));
        }
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public DeviceStatusEnum getExpectedDeviceStatus() {
        return expectedDeviceStatus;
    }

    public void setExpectedDeviceStatus(DeviceStatusEnum expectedDeviceStatus) {
        this.expectedDeviceStatus = expectedDeviceStatus;
    }

    public String getAddMultiDeviceDelay() {
        return addMultiDeviceDelay;
    }

    @ParameterProperties(description = "The delay in milliseconds after each Add Device operation.")
    public void setAddMultiDeviceDelay(String addMultiDeviceDelay) {
        this.addMultiDeviceDelay = addMultiDeviceDelay;
    }

    public String getDeletiondeviceNames() {
        return deletiondeviceNames;
    }

    public void setDeletiondeviceNames(String deletiondeviceNames) {
        this.deletiondeviceNames = deletiondeviceNames;
    }

    public String getDeletionSiteNames() {
        return deletionSiteNames;
    }

    public void setDeletionSiteNames(String deletionSiteNames) {
        this.deletionSiteNames = deletionSiteNames;
    }

    public String getClusterName() {
        return clusterName;
    }

    public void setClusterName(String clusterName) {
        this.clusterName = clusterName;
    }

    public String getPrimaryDevice() {
        return primaryDevice;
    }

    public void setPrimaryDevice(String primaryDevice) {
        this.primaryDevice = primaryDevice;
    }

    public ClusterAssociatedMgmtPorts getAssociatedMgmtPort() {
        return associatedMgmtPort;
    }

    public void setAssociatedMgmtPort(ClusterAssociatedMgmtPorts associatedMgmtPort) {
        this.associatedMgmtPort = associatedMgmtPort;
    }

    public String getContainedDPDevices() {
        return containedDPDevices;
    }

    public void setContainedDPDevices(String containedDPDevices) {
        this.containedDPDevices = containedDPDevices;
    }

    public String getSnmpV3Username() {
        return snmpV3Username;
    }

    public void setSnmpV3Username(String snmpV3Username) {
        this.snmpV3Username = snmpV3Username;
    }

    public String getSnmpV3AuthenticationPassword() {
        return snmpV3AuthenticationPassword;
    }

    public void setSnmpV3AuthenticationPassword(String snmpV3AuthenticationPassword) {
        this.snmpV3AuthenticationPassword = snmpV3AuthenticationPassword;
    }

    public String getSnmpV3PrivacyPassword() {
        return snmpV3PrivacyPassword;
    }

    public void setSnmpV3PrivacyPassword(String snmpV3PrivacyPassword) {
        this.snmpV3PrivacyPassword = snmpV3PrivacyPassword;
    }

    public boolean getUseSnmpV3Authentication() {
        return useSnmpV3Authentication;
    }

    public void setUseSnmpV3Authentication(boolean useSnmpV3Authentication) {
        this.useSnmpV3Authentication = useSnmpV3Authentication;
    }

    public boolean getUseSnmpV3Privacy() {
        return useSnmpV3Privacy;
    }

    public void setUseSnmpV3Privacy(boolean useSnmpV3Privacy) {
        this.useSnmpV3Privacy = useSnmpV3Privacy;
    }

    public SnmpV3AuthenticationProtocolEnum getSnmpV3AuthenticationProtocol() {
        return snmpV3AuthenticationProtocol;
    }

    public void setSnmpV3AuthenticationProtocol(SnmpV3AuthenticationProtocolEnum snmpV3AuthenticationProtocol) {
        this.snmpV3AuthenticationProtocol = snmpV3AuthenticationProtocol;
    }

    public String getWriteCommunityDefencePro() {
        return writeCommunityDefencePro;
    }

    public void setWriteCommunityDefencePro(String writeCommunityDefencePro) {
        this.writeCommunityDefencePro = writeCommunityDefencePro;
    }

    public String getStartIndex() {
        return String.valueOf(startIndex);
    }

    public void setStartIndex(String startIndex) {
        if (startIndex != null) {
            this.startIndex = Integer.valueOf(StringUtils.fixNumeric(startIndex));
        }
    }

    public String getSnmpReadCommunity() {
        return snmpReadCommunity;
    }

    public void setSnmpReadCommunity(String snmpReadCommunity) {
        this.snmpReadCommunity = snmpReadCommunity;
    }

    public String getSnmpWriteCommunity() {
        return snmpWriteCommunity;
    }

    public void setSnmpWriteCommunity(String snmpWriteCommunity) {
        this.snmpWriteCommunity = snmpWriteCommunity;
    }

    public DeviceType4Group getDeviceType4Group() {
        return deviceType4Group;
    }

    public void setDeviceType4Group(DeviceType4Group deviceType4Group) {
        this.deviceType4Group = deviceType4Group;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getManagedDeviceName() {
        return managedDeviceName;
    }

    @ParameterProperties(description = "insert device name that will be shown under sites and devices ")
    public void setManagedDeviceName(String managedDeviceName) {
        this.managedDeviceName = managedDeviceName;
    }

    public TopologyTreeTabs getTreeNode() {
        return treeNode;
    }

    public void setTreeNode(TopologyTreeTabs node) {
        this.treeNode = node;
    }

    public int getTimeout() {
        return timeout;
    }

    public void setTimeout(int timeout) {
        this.timeout = timeout;
    }


}
