package com.radware.vision.tests.Alteon.Configuration.System.ManagementAccess.ManagementProtocols;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.system.managementAccess.ManagementAccessEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.managementaccess.AlteonManagementProtocolsTableActionHandler;
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
 * Created by vadyms on 5/19/2015.
 */
public class ManagementProtocolsTests extends AlteonTestBase {
    String loginBanner;
    String loginNotice;
    int idleTimeout;
    int SSHPort;
    int TelnetPort;
    int HTTPSPort;
    int XMLPort;
    public ManagementAccessEnums.Prompt Prompt;
    public GeneralEnums.State SSHState;
    public GeneralEnums.State SCPApplyAndSave;
    public GeneralEnums.State Telnet;
    public GeneralEnums.State HTTPS;
    public GeneralEnums.State XML;
    public ManagementAccessEnums.SshVersion SshVersion;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;


    @Test
    @TestProperties(name = "set Management Protocols Settings", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "deviceState", "clickOnTableRow", "loginNotice", "loginBanner", "idleTimeout", "Prompt", "SSHState", "SshVersion", "SSHPort", "SCPApplyAndSave", "Telnet", "HTTPS", "XML", "TelnetPort", "HTTPSPort", "XMLPort"})
    public void setManagementProtocolsSettings() throws IOException {
        try {
            testProperties.put("loginNotice", loginNotice);
            testProperties.put("loginBanner", loginBanner);
            testProperties.put("idleTimeout", Integer.toString(idleTimeout));
            testProperties.put("Prompt", Prompt.toString());
            testProperties.put("SSHState", SSHState.toString());
            testProperties.put("SshVersion", SshVersion.toString());
            testProperties.put("SSHPort", Integer.toString(SSHPort));
            testProperties.put("SCPApplyAndSave", SCPApplyAndSave.toString());
            testProperties.put("Telnet", Telnet.toString());
            testProperties.put("HTTPS", HTTPS.toString());
            testProperties.put("XML", XML.toString());
            testProperties.put("TelnetPort", Integer.toString(TelnetPort));
            testProperties.put("HTTPSPort", Integer.toString(HTTPSPort));
            testProperties.put("XMLPort", Integer.toString(XMLPort));
            AlteonManagementProtocolsTableActionHandler.setManagementProtocolsSettings(testProperties);

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

    public String getLoginBanner() {
        return loginBanner;
    }

    public void setLoginBanner(String loginBanner) {
        this.loginBanner = loginBanner;
    }

    public String getLoginNotice() {
        return loginNotice;
    }

    public void setLoginNotice(String loginNotice) {
        this.loginNotice = loginNotice;
    }


    public String getIdleTimeout() {
        return String.valueOf(idleTimeout);
    }

    @ParameterProperties(description = "Input interval 1..10080")
    public void setIdleTimeout(String idleTimeout) {
        if (Integer.valueOf(StringUtils.fixNumeric(idleTimeout)) < 1) {
            this.idleTimeout = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(idleTimeout)) > 10080) {
            this.idleTimeout = 1;
        } else this.idleTimeout = Integer.valueOf(StringUtils.fixNumeric(idleTimeout));
    }

    public String getSSHPort() {
        return String.valueOf(SSHPort);
    }

    @ParameterProperties(description = "Input interval 1..65535")
    public void setSSHPort(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.SSHPort = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 65535) {
            this.SSHPort = 65535;
        } else this.SSHPort = Integer.valueOf(StringUtils.fixNumeric(port));
    }

    public String getTelnetPort() {
        return String.valueOf(TelnetPort);
    }

    @ParameterProperties(description = "Input interval 1..65535")
    public void setTelnetPort(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.TelnetPort = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 65535) {
            this.TelnetPort = 65535;
        } else this.TelnetPort = Integer.valueOf(StringUtils.fixNumeric(port));
    }

    public String getHTTPSPort() {
        return String.valueOf(HTTPSPort);
    }

    @ParameterProperties(description = "Input interval 1..65535")
    public void setHTTPSPort(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.HTTPSPort = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 65535) {
            this.HTTPSPort = 65535;
        } else this.HTTPSPort = Integer.valueOf(StringUtils.fixNumeric(port));
    }

    public String getXMLPort() {
        return String.valueOf(XMLPort);
    }

    @ParameterProperties(description = "Input interval 1..65535")
    public void setXMLPort(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.XMLPort = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 65535) {
            this.XMLPort = 65535;
        } else this.XMLPort = Integer.valueOf(StringUtils.fixNumeric(port));
    }


    public ManagementAccessEnums.Prompt getPrompt() {
        return Prompt;
    }

    public void setPrompt(ManagementAccessEnums.Prompt prompt) {
        Prompt = prompt;
    }

    public GeneralEnums.State getSSHState() {
        return SSHState;
    }

    public void setSSHState(GeneralEnums.State SSHState) {
        this.SSHState = SSHState;
    }


    public ManagementAccessEnums.SshVersion getSshVersion() {
        return SshVersion;
    }

    public void setSshVersion(ManagementAccessEnums.SshVersion sshVersion) {
        SshVersion = sshVersion;
    }


    public GeneralEnums.State getTelnet() {
        return Telnet;
    }

    public void setTelnet(GeneralEnums.State telnet) {
        Telnet = telnet;
    }

    public GeneralEnums.State getXML() {
        return XML;
    }

    public void setXML(GeneralEnums.State XML) {
        this.XML = XML;
    }

    public GeneralEnums.State getHTTPS() {
        return HTTPS;
    }

    public void setHTTPS(GeneralEnums.State HTTPS) {
        this.HTTPS = HTTPS;
    }


    public GeneralEnums.State getSCPApplyAndSave() {
        return SCPApplyAndSave;
    }

    public void setSCPApplyAndSave(GeneralEnums.State SCPApplyandSave) {
        this.SCPApplyAndSave = SCPApplyandSave;
    }
}


