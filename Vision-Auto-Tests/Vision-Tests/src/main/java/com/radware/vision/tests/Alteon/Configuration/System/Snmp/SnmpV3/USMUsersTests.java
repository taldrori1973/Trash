package com.radware.vision.tests.Alteon.Configuration.System.Snmp.SnmpV3;

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
import com.radware.automation.tools.basetest.Reporter;
import org.junit.Test;
import com.radware.automation.tools.utils.StringUtils;
import java.io.IOException;
import java.util.HashMap;

/**
 * Created by vadyms on 6/1/2015.
 */
public class USMUsersTests extends WebUITestBase {

    String userName;
    SnmpEnums.UsmAuthProtocol authProtocol;
    SnmpEnums.UsmPrivacyProtocol privacyProtocol;
    Integer RowNumber;
    String authenticationPassword;
    String confAuthenticationPassword;
    String privacyPassword;
    String confPrivacyPassword;
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
    @TestProperties(name = "add USM Users", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree", "expectedResult"
            , "clickOnTableRow", "userName", "authProtocol","privacyProtocol",
    "authenticationPassword","confAuthenticationPassword","privacyPassword","confPrivacyPassword"})
    public void addUSMUsers() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("userName", userName);
            testProperties.put("authProtocol", authProtocol.toString());
            testProperties.put("privacyProtocol", privacyProtocol.toString());
            testProperties.put("authenticationPassword", authenticationPassword);
            testProperties.put("confAuthenticationPassword", confAuthenticationPassword);
            testProperties.put("privacyPassword", privacyPassword);
            testProperties.put("confPrivacyPassword", confPrivacyPassword);
            SnmpV3TableActionHandler.addUSMUsers(testProperties);
        } catch (Exception e) {
            report.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }

    @Test
    @TestProperties(name = "del USM Users", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"userName"})
    public void delUSMUsers() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("userName", userName);
            SnmpV3TableActionHandler.delUSMUsers(testProperties);
        } catch (Exception e) {
            report.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }


    @Test
    @TestProperties(name = "view USM Users", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"RowNumber"})
    public void viewUSMUsers() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("RowNumber", RowNumber.toString());

            SnmpV3TableActionHandler.viewUSMUsers(testProperties);
        } catch (Exception e) {
            report.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }


    @Test
    @TestProperties(name = "duplicate USM Users", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            , "RowNumber", "userName", "authProtocol","privacyProtocol",
            "authenticationPassword","confAuthenticationPassword","privacyPassword","confPrivacyPassword"})
    public void duplicateUSMUsers() throws IOException {
        try {
            setTestPropertiesBase();
            testProperties.put("RowNumber", RowNumber.toString());
            testProperties.put("userName", userName);
            testProperties.put("authProtocol", authProtocol.toString());
            testProperties.put("privacyProtocol", privacyProtocol.toString());
            testProperties.put("authenticationPassword", authenticationPassword);
            testProperties.put("confAuthenticationPassword", confAuthenticationPassword);
            testProperties.put("privacyPassword", privacyPassword);
            testProperties.put("confPrivacyPassword", confPrivacyPassword);
            SnmpV3TableActionHandler.duplicateUSMUsers(testProperties);
        } catch (Exception e) {
            report.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
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

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }


    public SnmpEnums.UsmPrivacyProtocol getPrivacyProtocol() {
        return privacyProtocol;
    }

    public void setPrivacyProtocol(SnmpEnums.UsmPrivacyProtocol privacyProtocol) {
        this.privacyProtocol = privacyProtocol;
    }

    public SnmpEnums.UsmAuthProtocol getAuthProtocol() {
        return authProtocol;
    }

    public void setAuthProtocol(SnmpEnums.UsmAuthProtocol authProtocol) {
        this.authProtocol = authProtocol;
    }


    public String getRowNumber() {
        return String.valueOf(RowNumber);
    }

    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setRowNumber(String row) {
        if (Integer.valueOf(StringUtils.fixNumeric(row)) < 0) {
            this.RowNumber = 0;
        } else {
            this.RowNumber = Integer.valueOf(StringUtils.fixNumeric(row));
        }
    }

    public String getAuthenticationPassword() {
        return authenticationPassword;
    }

    public void setAuthenticationPassword(String authenticationPassword) {
        this.authenticationPassword = authenticationPassword;
    }

    public String getConfAuthenticationPassword() {
        return confAuthenticationPassword;
    }

    public void setConfAuthenticationPassword(String confAuthenticationPassword) {
        this.confAuthenticationPassword = confAuthenticationPassword;
    }

    public String getPrivacyPassword() {
        return privacyPassword;
    }

    public void setPrivacyPassword(String privacyPassword) {
        this.privacyPassword = privacyPassword;
    }

    public String getConfPrivacyPassword() {
        return confPrivacyPassword;
    }

    public void setConfPrivacyPassword(String confprivacyPassword) {
        this.confPrivacyPassword = confprivacyPassword;
    }

}
