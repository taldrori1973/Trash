package com.radware.vision.tests.Alteon.Configuration.System.ManagementAccess.ManagementTrafficRouting;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.configuration.system.SystemEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.managementaccess.AlteonManagementTrafficRoutingTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.tests.Alteon.AlteonTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by vadyms on 5/20/2015.
 */
public class ManagementTrafficRoutingTests extends AlteonTestBase {

    SystemEnums.MmgmtData RADIUS;
    SystemEnums.MmgmtData TACACSPlus;
    SystemEnums.MmgmtData SYSLOG;
    SystemEnums.MmgmtData SNMPTraps;
    SystemEnums.MmgmtData FTP_TFTP_SCP;
    SystemEnums.MmgmtData NTP;
    SystemEnums.MmgmtData BWMStatistics;
    SystemEnums.MmgmtData DNS;
    SystemEnums.MmgmtData OCSP;
    SystemEnums.MmgmtData WLM;
    SystemEnums.MmgmtData SMTP;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    HashMap<String, SystemEnums.MmgmtData> testPropertiesEnums = new HashMap<String, SystemEnums.MmgmtData>();

    @Test
    @TestProperties(name = "set Management Traffic Routing", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree","deviceState", "clickOnTableRow", "RADIUS", "TACACSPlus", "SYSLOG", "SNMPTraps", "FTP_TFTP_SCP", "NTP", "BWMStatistics", "DNS", "OCSP", "WLM", "SMTP"})
    public void setManagementTrafficRoutingSettings() throws IOException {
        try {
            testPropertiesEnums.put("RADIUS", RADIUS);
            testPropertiesEnums.put("TACACSPlus", TACACSPlus);
            testPropertiesEnums.put("SYSLOG", SYSLOG);
            testPropertiesEnums.put("FTP_TFTP_SCP", FTP_TFTP_SCP);
            testPropertiesEnums.put("SNMPTraps", SNMPTraps);
            testPropertiesEnums.put("NTP", NTP);
            testPropertiesEnums.put("BWMStatistics", BWMStatistics);
            testPropertiesEnums.put("DNS", DNS);
            testPropertiesEnums.put("OCSP", OCSP);
            testPropertiesEnums.put("WLM", WLM);
            testPropertiesEnums.put("SMTP", SMTP);
            AlteonManagementTrafficRoutingTableActionHandler.setManagementTrafficRouting(testPropertiesEnums, testProperties);

        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
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


    public SystemEnums.MmgmtData getSYSLOG() {
        return SYSLOG;
    }

    public void setSYSLOG(SystemEnums.MmgmtData SYSLOG) {
        this.SYSLOG = SYSLOG;
    }

    public SystemEnums.MmgmtData getTACACSPlus() {
        return TACACSPlus;
    }

    public void setTACACSPlus(SystemEnums.MmgmtData TACACSPlus) {
        this.TACACSPlus = TACACSPlus;
    }

    public SystemEnums.MmgmtData getRADIUS() {
        return RADIUS;
    }

    public void setRADIUS(SystemEnums.MmgmtData RADIUS) {
        this.RADIUS = RADIUS;
    }

    public SystemEnums.MmgmtData getSMTP() {
        return SMTP;
    }

    public void setSMTP(SystemEnums.MmgmtData SMTP) {
        this.SMTP = SMTP;
    }

    public SystemEnums.MmgmtData getWLM() {
        return WLM;
    }

    public void setWLM(SystemEnums.MmgmtData WLM) {
        this.WLM = WLM;
    }

    public SystemEnums.MmgmtData getOCSP() {
        return OCSP;
    }

    public void setOCSP(SystemEnums.MmgmtData OCSP) {
        this.OCSP = OCSP;
    }

    public SystemEnums.MmgmtData getBWMStatistics() {
        return BWMStatistics;
    }

    public void setBWMStatistics(SystemEnums.MmgmtData BWMStatistics) {
        this.BWMStatistics = BWMStatistics;
    }

    public SystemEnums.MmgmtData getDNS() {
        return DNS;
    }

    public void setDNS(SystemEnums.MmgmtData DNS) {
        this.DNS = DNS;
    }

    public SystemEnums.MmgmtData getNTP() {
        return NTP;
    }

    public void setNTP(SystemEnums.MmgmtData NTP) {
        this.NTP = NTP;
    }

    public SystemEnums.MmgmtData getFTP_TFTP_SCP() {
        return FTP_TFTP_SCP;
    }

    public void setFTP_TFTP_SCP(SystemEnums.MmgmtData FTP_TFTP_SCP) {
        this.FTP_TFTP_SCP = FTP_TFTP_SCP;
    }

    public SystemEnums.MmgmtData getSNMPTraps() {
        return SNMPTraps;
    }

    public void setSNMPTraps(SystemEnums.MmgmtData SNMPTraps) {
        this.SNMPTraps = SNMPTraps;
    }


}
