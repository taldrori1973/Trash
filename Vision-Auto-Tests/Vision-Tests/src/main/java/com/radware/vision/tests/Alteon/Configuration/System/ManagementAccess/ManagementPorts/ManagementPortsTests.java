package com.radware.vision.tests.Alteon.Configuration.System.ManagementAccess.ManagementPorts;

import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.system.managementAccess.ManagementAccessEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.managementaccess.AlteonManagementAccessTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.tests.Alteon.AlteonTestBase;
import jsystem.framework.ParameterProperties;
import jsystem.framework.TestProperties;
import com.radware.automation.tools.basetest.Reporter;
import org.junit.Test;
import com.radware.automation.tools.utils.StringUtils;
import java.io.IOException;
import java.util.HashMap;

/**
 * Created by vadyms on 5/18/2015.
 */
public class ManagementPortsTests extends AlteonTestBase {

    String IPAddressIPv4;
    String MaskPrefixIPv4;
    String DefaultGatewayIPv4;
    String IPAddressIPv6;
    int MaskPrefixIPv6;
    String DefaultGatewayIPv6;
    int DHCPTimeout;
    int Interval;
    int Retries;
    int TCPPort;
    int RowNumber;
    public GeneralEnums.State ManagementPort;
    public ManagementAccessEnums.IpAssignment IpAssignment;
    public ManagementAccessEnums.HealthCheckType HealthCheckType;
    public ManagementAccessEnums.Speed Speed;
    public ManagementAccessEnums.Duplex Duplex;
    public GeneralEnums.State AutoNegotiation;
    public GeneralEnums.State ExternalMonitoringOfSwitch;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Test
    @TestProperties(name = "add TCP Port For External Monitoring Table", paramsInclude = {"qcTestId", "TCPPort", "deviceIp", "deviceState", "deviceName", "parentTree","clickOnTableRow"})
    public void addTCPPortForExternalMonitoringTable() throws IOException {
        try {
            testProperties.put("TCPPort", getTCPPort());
            AlteonManagementAccessTableActionHandler.addTCPPort(testProperties);
        } catch (Exception e) {
            report.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }

    @Test
    @TestProperties(name = "delete TCP Port For External Monitoring Table", paramsInclude = {"qcTestId", "RowNumber", "deviceIp", "deviceState", "deviceName", "parentTree","clickOnTableRow"})
    public void deleteTCPPortForExternalMonitoringTable() throws IOException {
        try {
            testProperties.put("RowNumber", getRowNumber());
            AlteonManagementAccessTableActionHandler.delTCPPort(testProperties);
        } catch (Exception e) {
            report.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }

    @Test
    @TestProperties(name = "view TCP Port For External Monitoring Table", paramsInclude = {"qcTestId", "RowNumber", "deviceIp", "deviceState", "deviceName", "parentTree","clickOnTableRow"})
    public void viewTCPPortForExternalMonitoringTable() throws IOException {
        try {
            testProperties.put("RowNumber", getRowNumber());
            AlteonManagementAccessTableActionHandler.viewTCPPort(testProperties);
        } catch (Exception e) {
            report.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }



    @Test
    @TestProperties(name = "edit TCP Port For External Monitoring Table", paramsInclude = {"qcTestId", "RowNumber", "TCPPort", "deviceIp", "deviceState", "deviceName", "parentTree","clickOnTableRow"})
    public void editTCPPortForExternalMonitoringTable() throws IOException {
        try {
            testProperties.put("RowNumber", getRowNumber());
            testProperties.put("TCPPort", getTCPPort());
            AlteonManagementAccessTableActionHandler.editTCPPort(testProperties);
        } catch (Exception e) {
            report.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }

    @Test
    @TestProperties(name = "set Management Ports Settings", paramsInclude = {"qcTestId", "IPAddressIPv4", "MaskPrefixIPv4", "DefaultGatewayIPv4", "IPAddressIPv6", "MaskPrefixIPv6", "DefaultGatewayIPv6", "DHCPTimeout", "deviceIp", "IpAssignment", "deviceName", "parentTree", "ManagementPort","deviceState", "clickOnTableRow", "HealthCheckType", "Interval", "Retries", "AutoNegotiation", "Speed", "Duplex", "ExternalMonitoringOfSwitch"})
    public void setManagementPortsSettings() throws IOException {
        try {
            testProperties.put("ManagementPort", ManagementPort.toString());
            testProperties.put("IpAssignment", IpAssignment.toString());
            testProperties.put("DHCPTimeout", getDHCPTimeout());
            testProperties.put("IPAddressIPv4", IPAddressIPv4);
            testProperties.put("MaskPrefixIPv4", MaskPrefixIPv4);
            testProperties.put("DefaultGatewayIPv4", DefaultGatewayIPv4);
            testProperties.put("IPAddressIPv6", IPAddressIPv6);
            testProperties.put("MaskPrefixIPv6", getMaskPrefixIPv6());
            testProperties.put("DefaultGatewayIPv6", DefaultGatewayIPv6);
            testProperties.put("HealthCheckType", HealthCheckType.toString());
            testProperties.put("Interval", getInterval());
            testProperties.put("Retries", getRetries());
            testProperties.put("AutoNegotiation", AutoNegotiation.toString());
            testProperties.put("Speed", Speed.toString());
            testProperties.put("Duplex", Duplex.toString());
            testProperties.put("ExternalMonitoringOfSwitch", ExternalMonitoringOfSwitch.toString());
            AlteonManagementAccessTableActionHandler.setManagementPortsSettings(testProperties);

        } catch (Exception e) {
            report.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
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

    public GeneralEnums.State getManagementPort() {
        return ManagementPort;
    }

    public void setManagementPort(GeneralEnums.State managementPort) {
        ManagementPort = managementPort;
    }

    public ManagementAccessEnums.IpAssignment getIpAssignment() {
        return IpAssignment;
    }

    public void setIpAssignment(ManagementAccessEnums.IpAssignment ipAssignment) {
        IpAssignment = ipAssignment;
    }
    public String getDHCPTimeout() {
        return String.valueOf(DHCPTimeout);
    }
    @ParameterProperties(description = "Input interval 4..60")
    public void setDHCPTimeout(String DHCPTimeout) {
        if (Integer.valueOf(StringUtils.fixNumeric(DHCPTimeout)) < 4) {
            this.DHCPTimeout = 4;
        } else if (Integer.valueOf(StringUtils.fixNumeric(DHCPTimeout)) > 60) {
            this.DHCPTimeout = 60;
        } else this.DHCPTimeout = Integer.valueOf(StringUtils.fixNumeric(DHCPTimeout));

    }
    public String getMaskPrefixIPv6() {
        return String.valueOf(MaskPrefixIPv6);
    }
    @ParameterProperties(description = "Input interval 0..128")
    public void setMaskPrefixIPv6(String maskPrefixIPv6) {
        if (Integer.valueOf(StringUtils.fixNumeric(maskPrefixIPv6)) < 0) {
            this.MaskPrefixIPv6 = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(maskPrefixIPv6)) > 128) {
            this.MaskPrefixIPv6 = 128;
        } else this.MaskPrefixIPv6 = Integer.valueOf(StringUtils.fixNumeric(maskPrefixIPv6));
    }



    public String getInterval() {
        return String.valueOf(Interval);
    }
    @ParameterProperties(description = "Input interval 0..60")
    public void setInterval(String interval) {
        if (Integer.valueOf(StringUtils.fixNumeric(interval)) < 0) {
            this.Interval = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(interval)) > 60) {
            this.Interval = 60;
        } else this.Interval = Integer.valueOf(StringUtils.fixNumeric(interval));
    }

    public String getRetries() {
        return String.valueOf(Retries);
    }
    @ParameterProperties(description = "Input interval 1..120")
    public void setRetries(String retries) {
        if (Integer.valueOf(StringUtils.fixNumeric(retries)) < 1) {
            this.Retries = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(retries)) > 120) {
            this.Retries = 120;
        } else this.Retries = Integer.valueOf(StringUtils.fixNumeric(retries));
    }



    public String getTCPPort() {
        return String.valueOf(TCPPort);
    }
    @ParameterProperties(description = "Input interval 2..65534")
    public void setTCPPort(String tCPPort) {
        if (Integer.valueOf(StringUtils.fixNumeric(tCPPort)) < 2) {
            this.TCPPort = 2;
        } else if (Integer.valueOf(StringUtils.fixNumeric(tCPPort)) > 65534) {
            this.TCPPort = 65534;
        } else this.TCPPort = Integer.valueOf(StringUtils.fixNumeric(tCPPort));
    }


    public String getRowNumber() {
        return String.valueOf(RowNumber);
    }
    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setRowNumber(String rowNumber) {
        if (Integer.valueOf(StringUtils.fixNumeric(rowNumber)) < 0) {
            this.RowNumber = 0;
        } else this.RowNumber = Integer.valueOf(StringUtils.fixNumeric(rowNumber));
    }

    public String getDefaultGatewayIPv4() {
        return DefaultGatewayIPv4;
    }

    public void setDefaultGatewayIPv4(String defaultGatewayIPv4) {
        DefaultGatewayIPv4 = defaultGatewayIPv4;
    }

    public String getIPAddressIPv4() {
        return IPAddressIPv4;
    }

    public void setIPAddressIPv4(String IPAddressIPv4) {
        this.IPAddressIPv4 = IPAddressIPv4;
    }

    public String getMaskPrefixIPv4() {
        return MaskPrefixIPv4;
    }

    public void setMaskPrefixIPv4(String maskPrefixIPv4) {
        MaskPrefixIPv4 = maskPrefixIPv4;
    }

    public String getIPAddressIPv6() {
        return IPAddressIPv6;
    }

    public void setIPAddressIPv6(String IPAddressIPv6) {
        this.IPAddressIPv6 = IPAddressIPv6;
    }


    public ManagementAccessEnums.HealthCheckType getHealthCheckType() {
        return HealthCheckType;
    }

    public void setHealthCheckType(ManagementAccessEnums.HealthCheckType healthCheckType) {
        HealthCheckType = healthCheckType;
    }
    public GeneralEnums.State getAutoNegotiation() {
        return AutoNegotiation;
    }

    public void setAutoNegotiation(GeneralEnums.State autoNegotiation) {
        AutoNegotiation = autoNegotiation;
    }

    public String getDefaultGatewayIPv6() {
        return DefaultGatewayIPv6;
    }

    public void setDefaultGatewayIPv6(String defaultGatewayIPv6) {
        DefaultGatewayIPv6 = defaultGatewayIPv6;
    }


    public ManagementAccessEnums.Speed getSpeed() {
        return Speed;
    }

    public void setSpeed(ManagementAccessEnums.Speed speed) {
        Speed = speed;
    }

    public ManagementAccessEnums.Duplex getDuplex() {
        return Duplex;
    }

    public void setDuplex(ManagementAccessEnums.Duplex duplex) {
        Duplex = duplex;
    }


    public GeneralEnums.State getExternalMonitoringOfSwitch() {
        return ExternalMonitoringOfSwitch;
    }

    public void setExternalMonitoringOfSwitch(GeneralEnums.State externalMonitoringOfSwitch) {
        ExternalMonitoringOfSwitch = externalMonitoringOfSwitch;
    }


}
