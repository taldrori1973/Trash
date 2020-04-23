package com.radware.vision.tests.Alteon.Configuration.System.Snmp;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.system.snmp.SnmpEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.Snmp.SnmpHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.tests.Alteon.AlteonTestBase;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by vadyms on 5/25/2015.
 */
public class SnmpTests extends AlteonTestBase {

    SnmpEnums.SnmpAccess Access;
    SnmpEnums.SnmpVersion Version;
    String systemName;
    String location;
    String contact;
    String readComm;
    String writeComm;
    int trapSourceInterface;
    int SNMPStateMachineTimeout;
    GeneralEnums.IpVersion FirstSNMPTrapHostAddressIpVersion;
    GeneralEnums.IpVersion SecondSNMPTrapHostAddressIpVersion;
    String FirstSNMPTrapHostAddressIp;
    String SecondSNMPTrapHostAddressIp;
    GeneralEnums.State authenticationFailureTraps;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;


    @Test
    @TestProperties(name = "set SNMP Settings", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree", "clickOnTableRow"
            , "Access", "Version", "systemName", "location", "contact", "readComm", "writeComm", "trapSourceInterface", "SNMPStateMachineTimeout",
            "FirstSNMPTrapHostAddressIpVersion", "SecondSNMPTrapHostAddressIpVersion", "FirstSNMPTrapHostAddressIp", "SecondSNMPTrapHostAddressIp",
            "authenticationFailureTraps"})
    public void setSNMPSettings() throws IOException {
        try {
            testProperties.put("Access", Access.toString());
            testProperties.put("Version", Version.toString());
            testProperties.put("systemName", systemName);
            testProperties.put("location", location);
            testProperties.put("contact", contact);
            testProperties.put("readComm", readComm);
            testProperties.put("writeComm", writeComm);
            testProperties.put("trapSourceInterface", getTrapSourceInterface());
            testProperties.put("SNMPStateMachineTimeout", getSNMPStateMachineTimeout());
            testProperties.put("FirstSNMPTrapHostAddressIpVersion", FirstSNMPTrapHostAddressIpVersion.toString());
            testProperties.put("SecondSNMPTrapHostAddressIpVersion", SecondSNMPTrapHostAddressIpVersion.toString());
            testProperties.put("FirstSNMPTrapHostAddressIp", FirstSNMPTrapHostAddressIp);
            testProperties.put("SecondSNMPTrapHostAddressIp", SecondSNMPTrapHostAddressIp);
            testProperties.put("authenticationFailureTraps", authenticationFailureTraps.toString());
            SnmpHandler.setSNMPSettings(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }

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

    public ManagementNetworks getManagementNetwork() {
        return managementNetwork;
    }

    public void setManagementNetwork(ManagementNetworks managementNetwork) {
        this.managementNetwork = managementNetwork;
    }

    public HashMap<String, String> getTestProperties() {
        return testProperties;
    }

    public void setTestProperties(HashMap<String, String> testProperties) {
        this.testProperties = testProperties;
    }


    public SnmpEnums.SnmpAccess getAccess() {
        return Access;
    }

    public void setAccess(SnmpEnums.SnmpAccess access) {
        Access = access;
    }


    public SnmpEnums.SnmpVersion getVersion() {
        return Version;
    }

    public void setVersion(SnmpEnums.SnmpVersion version) {
        Version = version;
    }

    public String getSystemName() {
        return systemName;
    }

    public void setSystemName(String systemName) {
        this.systemName = systemName;
    }


    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getReadComm() {
        return readComm;
    }

    public void setReadComm(String readComm) {
        this.readComm = readComm;
    }

    public String getWriteComm() {
        return writeComm;
    }

    public void setWriteComm(String writeComm) {
        this.writeComm = writeComm;
    }

    public String getTrapSourceInterface() {
        return String.valueOf(trapSourceInterface);
    }

    @ParameterProperties(description = "Input interval 1..256")
    public void setTrapSourceInterface(String trapSourceInt) {
        if (Integer.valueOf(StringUtils.fixNumeric(trapSourceInt)) < 1) {
            this.trapSourceInterface = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(trapSourceInt)) > 256) {
            this.trapSourceInterface = 256;
        } else {
            this.trapSourceInterface = Integer.valueOf(StringUtils.fixNumeric(trapSourceInt));
        }
    }

    public String getSNMPStateMachineTimeout() {
        return String.valueOf(SNMPStateMachineTimeout);
    }

    @ParameterProperties(description = "Input interval 1..30")
    public void setSNMPStateMachineTimeout(String sNMPStateMachineTimeout) {
        if (Integer.valueOf(StringUtils.fixNumeric(sNMPStateMachineTimeout)) < 1) {
            this.SNMPStateMachineTimeout = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(sNMPStateMachineTimeout)) > 30) {
            this.SNMPStateMachineTimeout = 30;
        } else {
            this.SNMPStateMachineTimeout = Integer.valueOf(StringUtils.fixNumeric(sNMPStateMachineTimeout));
        }
    }

    public GeneralEnums.IpVersion getSecondSNMPTrapHostAddressIpVersion() {
        return SecondSNMPTrapHostAddressIpVersion;
    }

    public void setSecondSNMPTrapHostAddressIpVersion(GeneralEnums.IpVersion secondSNMPTrapHostAddressIpVersion) {
        SecondSNMPTrapHostAddressIpVersion = secondSNMPTrapHostAddressIpVersion;
    }

    public GeneralEnums.IpVersion getFirstSNMPTrapHostAddressIpVersion() {
        return FirstSNMPTrapHostAddressIpVersion;
    }

    public void setFirstSNMPTrapHostAddressIpVersion(GeneralEnums.IpVersion firstSNMPTrapHostAddressIpVersion) {
        FirstSNMPTrapHostAddressIpVersion = firstSNMPTrapHostAddressIpVersion;
    }


    public String getFirstSNMPTrapHostAddressIp() {
        return FirstSNMPTrapHostAddressIp;
    }

    public void setFirstSNMPTrapHostAddressIp(String firstSNMPTrapHostAddressIp) {
        FirstSNMPTrapHostAddressIp = firstSNMPTrapHostAddressIp;
    }

    public String getSecondSNMPTrapHostAddressIp() {
        return SecondSNMPTrapHostAddressIp;
    }

    public void setSecondSNMPTrapHostAddressIp(String secondSNMPTrapHostAddressIp) {
        SecondSNMPTrapHostAddressIp = secondSNMPTrapHostAddressIp;
    }
    public GeneralEnums.State getAuthenticationFailureTraps() {
        return authenticationFailureTraps;
    }

    public void setAuthenticationFailureTraps(GeneralEnums.State authenticationFailureTraps) {
        this.authenticationFailureTraps = authenticationFailureTraps;
    }
}
