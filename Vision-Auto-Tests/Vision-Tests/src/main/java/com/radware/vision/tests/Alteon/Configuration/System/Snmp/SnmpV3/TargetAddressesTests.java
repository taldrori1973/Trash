package com.radware.vision.tests.Alteon.Configuration.System.Snmp.SnmpV3;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.DeviceState;
import com.radware.vision.infra.enums.TopologyTreeTabs;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.Snmp.SnmpV3.SnmpV3TableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by vadyms on 6/4/2015.
 */
public class TargetAddressesTests extends WebUITestBase {


    GeneralEnums.IpVersion ipVersion;
    String TransportIP;
    String TagList;
    String TrapFeatures;
    int TargetParametersNameRow;
    int TransportPort;
    String AddressName;
    int AddressIndex;
    int rowNumber;
    boolean clickOnTableRow = true;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    TopologyTreeTabs parentTree = TopologyTreeTabs.SitesAndClusters;
    DeviceState deviceState = DeviceState.Lock;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;
    String deviceIp;

    HashMap<String, String> testProperties = new HashMap<String, String>();



    @Test
    @TestProperties(name = "add Target Address", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree", "expectedResult"
            , "clickOnTableRow", "AddressIndex","AddressName","ipVersion","TransportIP","TransportPort","TagList","TargetParametersNameRow","TrapFeatures"})
    public void addTargetAddress() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("AddressIndex", getAddressIndex());
            testProperties.put("AddressName", AddressName);
            testProperties.put("ipVersion", ipVersion.toString());
            testProperties.put("TransportIP", TransportIP);
            testProperties.put("TransportPort", getTransportPort());
            testProperties.put("TagList", TagList);
            testProperties.put("TargetParametersNameRow", getTargetParametersNameRow());
            testProperties.put("TrapFeatures", TrapFeatures);

            SnmpV3TableActionHandler.addTargetAddress(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }

    @Test
    @TestProperties(name = "del Target Address", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber"})
    public void delTargetAddress() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("rowNumber", getRowNumber());
            SnmpV3TableActionHandler.delTargetAddress(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }


    @Test
    @TestProperties(name = "edit Target Address", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","AddressName","ipVersion","TransportIP","TransportPort","TagList","TargetParametersNameRow","TrapFeatures"})
    public void editTargetAddress() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("AddressName", AddressName);
            testProperties.put("ipVersion", ipVersion.toString());
            testProperties.put("TransportIP", TransportIP);
            testProperties.put("TransportPort", getTransportPort());
            testProperties.put("TagList", TagList);
            testProperties.put("TargetParametersNameRow", getTargetParametersNameRow());
            testProperties.put("TrapFeatures", TrapFeatures);
            SnmpV3TableActionHandler.editTargetAddress(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }


    @Test
    @TestProperties(name = "duplicate Target Address", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            , "RowNumber","AddressIndex","AddressName","ipVersion","TransportIP","TransportPort","TagList","TargetParametersNameRow","TrapFeatures"})
    public void duplicateTargetAddress() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("AddressIndex", getAddressIndex());
            testProperties.put("AddressName", AddressName);
            testProperties.put("ipVersion", ipVersion.toString());
            testProperties.put("TransportIP", TransportIP);
            testProperties.put("TransportPort", getTransportPort());
            testProperties.put("TagList", TagList);
            testProperties.put("TargetParametersNameRow", getTargetParametersNameRow());
            testProperties.put("TrapFeatures", TrapFeatures);
            SnmpV3TableActionHandler.duplicateTargetAddress(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }

    //=========== Set BASE Properties ======================
    public void setTestPropertiesBase() throws Exception {
        WebUIUtils.visionUtils.setDeviceIpIfNew(deviceIp);
        testProperties.put("deviceName", getDeviceName());
        testProperties.put("parentTree", parentTree.getTopologyTreeTab().toString());
        testProperties.put("clickOnTableRow", String.valueOf(clickOnTableRow));
        testProperties.put("deviceState", String.valueOf(deviceState));

    }
    //======================================================

    public boolean getClickOnTableRow() {
        return clickOnTableRow;
    }

    public void setClickOnTableRow(boolean clickOnTableRow) {
        this.clickOnTableRow = clickOnTableRow;
    }

    public BaseTableActions getExternalMonitoringTableAction() {
        return externalMonitoringTableAction;
    }

    public void setExternalMonitoringTableAction(BaseTableActions externalMonitoringTableAction) {
        this.externalMonitoringTableAction = externalMonitoringTableAction;
    }

    public EditTableActions getDataPortAccessActions() {
        return dataPortAccessActions;
    }

    public void setDataPortAccessActions(EditTableActions dataPortAccessActions) {
        this.dataPortAccessActions = dataPortAccessActions;
    }

    public BaseTableActions getAllowedProtocolPerNetworkActions() {
        return allowedProtocolPerNetworkActions;
    }

    public void setAllowedProtocolPerNetworkActions(BaseTableActions allowedProtocolPerNetworkActions) {
        this.allowedProtocolPerNetworkActions = allowedProtocolPerNetworkActions;
    }

    public TopologyTreeTabs getParentTree() {
        return parentTree;
    }

    public void setParentTree(TopologyTreeTabs parentTree) {
        this.parentTree = parentTree;
    }

    public DeviceState getDeviceState() {
        return deviceState;
    }

    public void setDeviceState(DeviceState deviceState) {
        this.deviceState = deviceState;
    }

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

    public String getDeviceIp() {
        return deviceIp;
    }

    public void setDeviceIp(String deviceIp) {
        this.deviceIp = deviceIp;
    }

    public HashMap<String, String> getTestProperties() {
        return testProperties;
    }

    public void setTestProperties(HashMap<String, String> testProperties) {
        this.testProperties = testProperties;
    }


    public String getRowNumber() {
        return String.valueOf(rowNumber);
    }

    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setRowNumber(String row) {
        if (Integer.valueOf(StringUtils.fixNumeric(row)) < 0) {
            this.rowNumber = 0;
        } else {
            this.rowNumber = Integer.valueOf(StringUtils.fixNumeric(row));
        }
    }




    public String getAddressIndex() {
        return String.valueOf(AddressIndex);
    }

    @ParameterProperties(description = "Input value interval from 1 .. 16")
    public void setAddressIndex(String index) {
        if (Integer.valueOf(StringUtils.fixNumeric(index)) < 1) {
            this.AddressIndex = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(index)) > 16) {
            this.AddressIndex = 16;
        } else {
            this.AddressIndex = Integer.valueOf(StringUtils.fixNumeric(index));
        }
    }




    public String getAddressName() {
        return AddressName;
    }

    public void setAddressName(String addressName) {
        AddressName = addressName;
    }




    public String getTransportPort() {
        return String.valueOf(TransportPort);
    }
    @ParameterProperties(description = "Input interval 1..65535")
    public void setTransportPort(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.TransportPort = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 65535) {
            this.TransportPort = 65535;
        } else{ this.TransportPort = Integer.valueOf(StringUtils.fixNumeric(port));}
    }

    public String getTargetParametersNameRow() {
        return String.valueOf(TargetParametersNameRow);
    }

    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setTargetParametersNameRow(String row) {
        if (Integer.valueOf(StringUtils.fixNumeric(row)) < 0) {
            this.TargetParametersNameRow = 3;
        } else {
            this.TargetParametersNameRow = Integer.valueOf(StringUtils.fixNumeric(row)+3);
        }
    }
    public String getTransportIP() {
        return TransportIP;
    }

    public void setTransportIP(String transportIP) {
        TransportIP = transportIP;
    }

    public String getTagList() {
        return TagList;
    }

    public void setTagList(String tagList) {
        TagList = tagList;
    }

    public String getTrapFeatures() {
        return TrapFeatures;
    }
    @ParameterProperties(description = "Separate by ,")
    public void setTrapFeatures(String trapFeatures) {
        TrapFeatures = trapFeatures;
    }

    public GeneralEnums.IpVersion getIpVersion() {
        return ipVersion;
    }

    public void setIpVersion(GeneralEnums.IpVersion ipVersion) {
        this.ipVersion = ipVersion;
    }

}
