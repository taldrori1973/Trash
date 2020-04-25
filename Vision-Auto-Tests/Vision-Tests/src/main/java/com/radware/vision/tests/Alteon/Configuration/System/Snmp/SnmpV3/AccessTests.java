package com.radware.vision.tests.Alteon.Configuration.System.Snmp.SnmpV3;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.webpages.configuration.system.snmp.SnmpEnums;
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
 * Created by vadyms on 6/3/2015.
 */
public class AccessTests extends WebUITestBase {

    int rowNumber;
    int groupNameRow;
    String contextPrefix;
    SnmpEnums.SecurityModel securityModel;
    SnmpEnums.AccessSecurityLevel accessSecurityLevel;
    SnmpEnums.AccessMatchType accessMatchType;
    int readViewNameRow;
    int writeViewNameRow;
    int notifyViewNameRow;
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
    @TestProperties(name = "add Access", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree", "expectedResult"
            , "clickOnTableRow","groupNameRow","contextPrefix","securityModel",
            "accessSecurityLevel","accessMatchType","readViewNameRow","writeViewNameRow",
            "notifyViewNameRow"})
    public void addAccess() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("groupNameRow", getGroupNameRow());
            testProperties.put("contextPrefix", contextPrefix);
            testProperties.put("securityModel", securityModel.toString());
            testProperties.put("accessSecurityLevel", accessSecurityLevel.toString());
            testProperties.put("accessMatchType", accessMatchType.toString());
            testProperties.put("readViewNameRow", getReadViewNameRow());
            testProperties.put("writeViewNameRow", getWriteViewNameRow());
            testProperties.put("notifyViewNameRow", getNotifyViewNameRow());
            SnmpV3TableActionHandler.addAccess(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }

    @Test
    @TestProperties(name = "del Access", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber"})
    public void delAccess() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("rowNumber", getRowNumber());
            SnmpV3TableActionHandler.delAccess(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }


    @Test
    @TestProperties(name = "view Access", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber"})
    public void viewAccess() throws IOException {
        try {
            setTestPropertiesBase();

            testProperties.put("rowNumber", getRowNumber());
            SnmpV3TableActionHandler.viewAccess(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }


    @Test
    @TestProperties(name = "duplicate Group", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            , "RowNumber","groupNameRow","contextPrefix","securityModel",
            "accessSecurityLevel","accessMatchType","readViewNameRow","writeViewNameRow",
            "notifyViewNameRow"})
    public void duplicateAccess() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("groupNameRow", getGroupNameRow());
            testProperties.put("contextPrefix", contextPrefix);
            testProperties.put("securityModel", securityModel.toString());
            testProperties.put("accessSecurityLevel", accessSecurityLevel.toString());
            testProperties.put("accessMatchType", accessMatchType.toString());
            testProperties.put("readViewNameRow", getReadViewNameRow());
            testProperties.put("writeViewNameRow", getWriteViewNameRow());
            testProperties.put("notifyViewNameRow", getNotifyViewNameRow());
            SnmpV3TableActionHandler.duplicateAccess(testProperties);
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

    public String getGroupNameRow() {
        return String.valueOf(groupNameRow);
    }
    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setGroupNameRow(String row) {
        if (Integer.valueOf(StringUtils.fixNumeric(row)) < 0) {
            this.groupNameRow = 3;
        } else {
            this.groupNameRow = Integer.valueOf(StringUtils.fixNumeric(row)+3);
        }
    }


    public String getContextPrefix() {
        return contextPrefix;
    }

    public void setContextPrefix(String contextPrefix) {
        this.contextPrefix = contextPrefix;
    }

    public SnmpEnums.SecurityModel getSecurityModel() {
        return securityModel;
    }

    public void setSecurityModel(SnmpEnums.SecurityModel securityModel) {
        this.securityModel = securityModel;
    }

    public SnmpEnums.AccessSecurityLevel getAccessSecurityLevel() {
        return accessSecurityLevel;
    }

    public void setAccessSecurityLevel(SnmpEnums.AccessSecurityLevel accessSecurityLevel) {
        this.accessSecurityLevel = accessSecurityLevel;
    }

    public SnmpEnums.AccessMatchType getAccessMatchType() {
        return accessMatchType;
    }

    public void setAccessMatchType(SnmpEnums.AccessMatchType accessMatchType) {
        this.accessMatchType = accessMatchType;
    }


    public String getReadViewNameRow() {
        return String.valueOf(readViewNameRow);
    }
    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setReadViewNameRow(String row) {
        if (Integer.valueOf(StringUtils.fixNumeric(row)) < 0) {
            this.readViewNameRow = 3;
        } else {
            this.readViewNameRow = Integer.valueOf(StringUtils.fixNumeric(row)+3);
        }
    }

    public String getWriteViewNameRow() {
        return String.valueOf(writeViewNameRow);
    }
    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setWriteViewNameRow(String row) {
        if (Integer.valueOf(StringUtils.fixNumeric(row)) < 0) {
            this.writeViewNameRow = 3;
        } else {
            this.writeViewNameRow = Integer.valueOf(StringUtils.fixNumeric(row)+3);
        }
    }

    public String getNotifyViewNameRow() {
        return String.valueOf(notifyViewNameRow);
    }
    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setNotifyViewNameRow(String row) {
        if (Integer.valueOf(StringUtils.fixNumeric(row)) < 0) {
            this.notifyViewNameRow = 3;
        } else {
            this.notifyViewNameRow = Integer.valueOf(StringUtils.fixNumeric(row)+3);
        }
    }





}
