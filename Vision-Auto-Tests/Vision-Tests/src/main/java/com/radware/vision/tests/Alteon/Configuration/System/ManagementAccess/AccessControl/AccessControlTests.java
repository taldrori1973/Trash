package com.radware.vision.tests.Alteon.Configuration.System.ManagementAccess.AccessControl;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.system.managementAccess.ManagementAccessEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.managementaccess.AlteonAccessControlTableActionHandler;
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
 * Created by vadyms on 5/20/2015.
 */
public class AccessControlTests extends AlteonTestBase {

    int ARP;
    int ICMP;
    int TCP;
    int UPD;
    int BPDU;
    int ZeroTTL;
    int RowNumber;
    String IPAddressIPv6;
    int MaskPrefixIPv6;
    String IPAddressIPv4;
    String MaskPrefixIPv4;
    GeneralEnums.State SSH;
    GeneralEnums.State Telnet;
    GeneralEnums.State HTTP;
    GeneralEnums.State HTTPS;
    GeneralEnums.State SNMP;
    ManagementAccessEnums.Rollover Rollover;
    ManagementAccessEnums.PortAccess portAccess;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Test
    @TestProperties(name = "set Access ControlRate Limit Settings", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "deviceState", "clickOnTableRow", "ARP", "ICMP", "TCP", "UPD", "BPDU", "ZeroTTL"})
    public void setAccessControlRateLimitSettings() throws IOException {

        try {
            testProperties.put("ARP", Integer.toString(ARP));
            testProperties.put("ICMP", Integer.toString(ICMP));
            testProperties.put("TCP", Integer.toString(TCP));
            testProperties.put("UPD", Integer.toString(UPD));
            testProperties.put("BPDU", Integer.toString(BPDU));
            testProperties.put("ZeroTTL", Integer.toString(ZeroTTL));
            AlteonAccessControlTableActionHandler.setAccessControlRateLimitSettings(testProperties);

        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "set Rollover Data Port Access for Management Traffic", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "deviceState", "clickOnTableRow", "RowNumber", "Rollover"})
    public void setRolloverDataPortAccessForManagementTraffic() throws IOException {
        try {
            testProperties.put("RowNumber", Integer.toString(RowNumber));
            testProperties.put("Rollover", Rollover.toString());
            AlteonAccessControlTableActionHandler.setRolloverDataPortAccessForManagementTraffic(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "edit Port Access State Data Port Access for Management Traffic", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "deviceState", "clickOnTableRow", "RowNumber", "portAccess"})
    public void editPortAccessStateDataPortAccessForManagementTraffic() throws IOException {
        try {
            testProperties.put("RowNumber", Integer.toString(RowNumber));
            testProperties.put("portAccess", portAccess.toString());
            AlteonAccessControlTableActionHandler.editPortAccessStateDataPortAccessForManagementTraffic(testProperties);

        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "add IPV4 Management Networks", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "deviceState", "clickOnTableRow",
            "IPAddressIPv4", "MaskPrefixIPv4", "SSH", "Telnet", "HTTP", "HTTPS", "SNMP"})
    public void addIPV4ManagementNetworks() throws IOException {
        try {
            testProperties.put("IPAddressIPv4", IPAddressIPv4);
            testProperties.put("MaskPrefixIPv4", MaskPrefixIPv4);
            testProperties.put("SSH", SSH.toString());
            testProperties.put("Telnet", Telnet.toString());
            testProperties.put("HTTP", HTTP.toString());
            testProperties.put("HTTPS", HTTPS.toString());
            testProperties.put("SNMP", SNMP.toString());
            AlteonAccessControlTableActionHandler.addIPV4ManagementNetworks(testProperties);

        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "edit IPV4 Management Networks", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "deviceState", "clickOnTableRow",
            "IPAddressIPv4", "MaskPrefixIPv4", "SSH", "Telnet", "HTTP", "HTTPS", "SNMP", "RowNumber"})
    public void editIPV4ManagementNetworks() throws IOException {
        try {
            testProperties.put("RowNumber", Integer.toString(RowNumber));
            testProperties.put("IPAddressIPv4", IPAddressIPv4);
            testProperties.put("MaskPrefixIPv4", MaskPrefixIPv4);
            testProperties.put("SSH", SSH.toString());
            testProperties.put("Telnet", Telnet.toString());
            testProperties.put("HTTP", HTTP.toString());
            testProperties.put("HTTPS", HTTPS.toString());
            testProperties.put("SNMP", SNMP.toString());
            AlteonAccessControlTableActionHandler.editIPV4ManagementNetworks(testProperties);

        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "del IPV4 Management Networks", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "deviceState", "clickOnTableRow",
            "RowNumber"})
    public void delIPV4ManagementNetworks() throws IOException {
        try {
            testProperties.put("RowNumber", Integer.toString(RowNumber));
            AlteonAccessControlTableActionHandler.delIPV4ManagementNetworks(testProperties);

        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "add IPV6 Management Networks", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "deviceState", "clickOnTableRow",
            "IPAddressIPv6", "MaskPrefixIPv6", "SSH", "Telnet", "HTTP", "HTTPS", "SNMP"})
    public void addIPV6ManagementNetworks() throws IOException {
        try {
            testProperties.put("IPAddressIPv6", IPAddressIPv6);
            testProperties.put("MaskPrefixIPv6", Integer.toString(MaskPrefixIPv6));
            testProperties.put("SSH", SSH.toString());
            testProperties.put("Telnet", Telnet.toString());
            testProperties.put("HTTP", HTTP.toString());
            testProperties.put("HTTPS", HTTPS.toString());
            testProperties.put("SNMP", SNMP.toString());

            AlteonAccessControlTableActionHandler.addIPV6ManagementNetworks(testProperties);

        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "edit IPV6 Management Networks", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "deviceState", "clickOnTableRow",
            "IPAddressIPv6", "MaskPrefixIPv6", "SSH", "Telnet", "HTTP", "HTTPS", "SNMP", "RowNumber"})
    public void editIPV6ManagementNetworks() throws IOException {
        try {
            testProperties.put("RowNumber", Integer.toString(RowNumber));
            testProperties.put("IPAddressIPv6", IPAddressIPv6);
            testProperties.put("MaskPrefixIPv6", Integer.toString(MaskPrefixIPv6));
            testProperties.put("SSH", SSH.toString());
            testProperties.put("Telnet", Telnet.toString());
            testProperties.put("HTTP", HTTP.toString());
            testProperties.put("HTTPS", HTTPS.toString());
            testProperties.put("SNMP", SNMP.toString());

            AlteonAccessControlTableActionHandler.editIPV6ManagementNetworks(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" + parseExceptionBody(e), Reporter.FAIL);
        }
    }


    @Test
    @TestProperties(name = "del IPV6 Management Networks", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "deviceState", "clickOnTableRow",
            "RowNumber"})
    public void delIPV6ManagementNetworks() throws IOException {

        try {
            testProperties.put("RowNumber", Integer.toString(RowNumber));
            AlteonAccessControlTableActionHandler.delIPV6ManagementNetworks(testProperties);

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

    public String getARP() {
        return String.valueOf(ARP);
    }

    @ParameterProperties(description = "Input interval 0..65535")
    public void setARP(String ARP) {

        if (Integer.valueOf(StringUtils.fixNumeric(ARP)) < 0) {
            this.ARP = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(ARP)) > 65535) {
            this.ARP = 65535;
        } else this.ARP = Integer.valueOf(StringUtils.fixNumeric(ARP));
    }

    public String getICMP() {
        return String.valueOf(ICMP);
    }

    @ParameterProperties(description = "Input interval 0..65535")
    public void setICMP(String ICMP) {
        if (Integer.valueOf(StringUtils.fixNumeric(ICMP)) < 0) {
            this.ICMP = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(ICMP)) > 65535) {
            this.ICMP = 65535;
        } else this.ICMP = Integer.valueOf(StringUtils.fixNumeric(ICMP));
    }

    public String getTCP() {
        return String.valueOf(TCP);
    }

    @ParameterProperties(description = "Input interval 0..65535")
    public void setTCP(String TCP) {
        if (Integer.valueOf(StringUtils.fixNumeric(TCP)) < 0) {
            this.TCP = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(TCP)) > 65535) {
            this.TCP = 65535;
        } else this.TCP = Integer.valueOf(StringUtils.fixNumeric(TCP));
    }

    public String getUPD() {
        return String.valueOf(UPD);
    }

    @ParameterProperties(description = "Input interval 0..65535")
    public void setUPD(String UPD) {
        if (Integer.valueOf(StringUtils.fixNumeric(UPD)) < 0) {
            this.UPD = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(UPD)) > 65535) {
            this.UPD = 65535;
        } else this.UPD = Integer.valueOf(StringUtils.fixNumeric(UPD));
    }

    public String getBPDU() {
        return String.valueOf(BPDU);
    }

    @ParameterProperties(description = "Input interval 0..65535")
    public void setBPDU(String BPDU) {
        if (Integer.valueOf(StringUtils.fixNumeric(BPDU)) < 0) {
            this.BPDU = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(BPDU)) > 65535) {
            this.BPDU = 65535;
        } else this.BPDU = Integer.valueOf(StringUtils.fixNumeric(BPDU));
    }

    public String getZeroTTL() {
        return String.valueOf(ZeroTTL);
    }

    @ParameterProperties(description = "Input interval 0..65535")
    public void setZeroTTL(String ZeroTTL) {
        if (Integer.valueOf(StringUtils.fixNumeric(ZeroTTL)) < 0) {
            this.ZeroTTL = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(ZeroTTL)) > 65535) {
            this.ZeroTTL = 65535;
        } else this.ZeroTTL = Integer.valueOf(StringUtils.fixNumeric(ZeroTTL));
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

    public ManagementAccessEnums.Rollover getRollover() {
        return Rollover;
    }

    public void setRollover(ManagementAccessEnums.Rollover rollover) {
        Rollover = rollover;
    }

    public ManagementAccessEnums.PortAccess getPortAccess() {
        return portAccess;
    }

    public void setPortAccess(ManagementAccessEnums.PortAccess portAccess) {
        this.portAccess = portAccess;
    }

    public String getIPAddressIPv6() {
        return IPAddressIPv6;
    }

    public void setIPAddressIPv6(String IPAddressIPv6) {
        this.IPAddressIPv6 = IPAddressIPv6;
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

    public GeneralEnums.State getSSH() {
        return SSH;
    }

    public void setSSH(GeneralEnums.State SSH) {
        this.SSH = SSH;
    }

    public GeneralEnums.State getHTTP() {
        return HTTP;
    }

    public void setHTTP(GeneralEnums.State HTTP) {
        this.HTTP = HTTP;
    }

    public GeneralEnums.State getTelnet() {
        return Telnet;
    }

    public void setTelnet(GeneralEnums.State telnet) {
        Telnet = telnet;
    }

    public GeneralEnums.State getHTTPS() {
        return HTTPS;
    }

    public void setHTTPS(GeneralEnums.State HTTPS) {
        this.HTTPS = HTTPS;
    }

    public GeneralEnums.State getSNMP() {
        return SNMP;
    }

    public void setSNMP(GeneralEnums.State SNMP) {
        this.SNMP = SNMP;
    }
}
