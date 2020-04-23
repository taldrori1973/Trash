package com.radware.vision.tests.Alteon.Configuration.System.Snmp.SnmpV3;

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
 * Created by vadyms on 6/4/2015.
 */
public class TargetParametersTests extends WebUITestBase {



    String targetName;
    Integer usmUserRow;
    SnmpEnums.TargetParametersSecurityLevel targetParametersSecurityLevel;
    SnmpEnums.MessageProcessingModel messageProcessingModel;
    SnmpEnums.SecurityModel securityModel;
    Integer rowNumber;

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
    @TestProperties(name = "add Target Parameters", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree", "expectedResult"
            , "clickOnTableRow", "targetName","messageProcessingModel","securityModel",
            "usmUserRow","targetParametersSecurityLevel"})
    public void addTargetParameters() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("targetName", targetName);
            testProperties.put("messageProcessingModel", messageProcessingModel.toString());
            testProperties.put("securityModel", securityModel.toString());
            testProperties.put("usmUserRow", usmUserRow.toString());
            testProperties.put("targetParametersSecurityLevel", targetParametersSecurityLevel.toString());

            SnmpV3TableActionHandler.addTargetParameters(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }

    @Test
    @TestProperties(name = "del Target Parameters", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber"})
    public void delTargetParameters() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("rowNumber", rowNumber.toString());
            SnmpV3TableActionHandler.delTargetParameters(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }


    @Test
    @TestProperties(name = "view Target Parameters", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber"})
    public void viewTargetParameters() throws IOException {
        try {
            setTestPropertiesBase();

            testProperties.put("rowNumber", rowNumber.toString());
            SnmpV3TableActionHandler.viewTargetParameters(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

    }


    @Test
    @TestProperties(name = "duplicate Target Parameters", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            , "RowNumber","targetName","messageProcessingModel","securityModel",
            "usmUserRow","targetParametersSecurityLevel"})
    public void duplicateTargetParameters() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("rowNumber", rowNumber.toString());
            testProperties.put("targetName", targetName);
            testProperties.put("messageProcessingModel", messageProcessingModel.toString());
            testProperties.put("securityModel", securityModel.toString());
            testProperties.put("usmUserRow", usmUserRow.toString());
            testProperties.put("targetParametersSecurityLevel", targetParametersSecurityLevel.toString());
            SnmpV3TableActionHandler.duplicateTargetParameters(testProperties);
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

    public String getUsmUserRow() {
        return String.valueOf(usmUserRow);
    }

    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setUsmUserRow(String row) {
        if (Integer.valueOf(StringUtils.fixNumeric(row)) < 0) {
            this.usmUserRow = 3;
        } else {
            this.usmUserRow = Integer.valueOf(StringUtils.fixNumeric(row)+3);
        }
    }


    public SnmpEnums.SecurityModel getSecurityModel() {
        return securityModel;
    }

    public void setSecurityModel(SnmpEnums.SecurityModel securityModel) {
        this.securityModel = securityModel;
    }


    public SnmpEnums.TargetParametersSecurityLevel getTargetParametersSecurityLevel() {
        return targetParametersSecurityLevel;
    }

    public void setTargetParametersSecurityLevel(SnmpEnums.TargetParametersSecurityLevel targetParametersSecurityLevel) {
        this.targetParametersSecurityLevel = targetParametersSecurityLevel;
    }

    public String getTargetName() {
        return targetName;
    }

    public void setTargetName(String targetName) {
        this.targetName = targetName;
    }

    public SnmpEnums.MessageProcessingModel getMessageProcessingModel() {
        return messageProcessingModel;
    }

    public void setMessageProcessingModel(SnmpEnums.MessageProcessingModel messageProcessingModel) {
        this.messageProcessingModel = messageProcessingModel;
    }


}
