package com.radware.vision.infra.testhandlers.alteon.configuration.system.managementaccess;

import com.radware.automation.webui.webpages.configuration.system.managementAccess.managementProtocols.ManagementProtocols;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 5/19/2015.
 */
public class AlteonManagementProtocolsTableActionHandler extends BaseHandler {

    public static void setManagementProtocolsSettings(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        ManagementProtocols managementProtocols = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mManagementProtocols();
        managementProtocols.openPage();
        if(testProperties.get("loginNotice") != null && !testProperties.get("loginNotice").equals("")) {
            managementProtocols.setLoginNotice(testProperties.get("loginNotice"));
        }
        if(testProperties.get("loginBanner") != null && !testProperties.get("loginBanner").equals("")) {
            managementProtocols.setLoginBanner(testProperties.get("loginBanner"));
        }
        managementProtocols.setIdleTimeout(Integer.parseInt(testProperties.get("idleTimeout")));

        if (testProperties.get("Prompt").equals("Standard")) {
            managementProtocols.setPromptStandard();
        } else {
            managementProtocols.setPromptHostname();
        }
        if (testProperties.get("SSHState").equals("Enable")) {
            managementProtocols.enableSshAccess();
            if (testProperties.get("SshVersion").equals("V1+V2")) {
                managementProtocols.enableSshVersionV1_V2();
            } else {
                managementProtocols.enableSshVersionV2();
            }
            managementProtocols.setSshPort(Integer.parseInt(testProperties.get("SSHPort")));
            if (testProperties.get("SCPApplyAndSave").equals("Enable")) {
                managementProtocols.enableSshScpApplySave();
            } else {
                managementProtocols.disableSshAccess();
            }
        } else {
            managementProtocols.disableSshAccess();
            if (testProperties.get("SshVersion").equals("V1+V2")) {
                managementProtocols.enableSshVersionV1_V2();
            } else {
                managementProtocols.enableSshVersionV2();
            }
            if (testProperties.get("SCPApplyAndSave").equals("Enable")) {
                managementProtocols.enableSshScpApplySave();
            } else {
                managementProtocols.disableSshAccess();
            }
        }


        if (testProperties.get("Telnet").equals("Enable")) {
            managementProtocols.enableTelnetAccess();
        } else {
            managementProtocols.disableTelnetAccess();
        }
        managementProtocols.setTelnetPort(Integer.parseInt(testProperties.get("TelnetPort")));
        if (testProperties.get("HTTPS").equals("Enable")) {
            managementProtocols.enableHttpsAccess();
        } else {
            managementProtocols.disableHttpsAccess();
        }
        managementProtocols.setHttpsPort(Integer.parseInt(testProperties.get("HTTPSPort")));
        if (testProperties.get("XML").equals("Enable")) {
            managementProtocols.enableXmlAccess();
        } else {
            managementProtocols.disableXmlAccess();
        }
        managementProtocols.setXmlPort(Integer.parseInt(testProperties.get("XMLPort")));


        managementProtocols.submit();

    }
}
