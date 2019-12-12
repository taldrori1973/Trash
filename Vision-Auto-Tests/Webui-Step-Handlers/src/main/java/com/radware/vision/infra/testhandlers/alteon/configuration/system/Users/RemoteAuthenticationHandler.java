package com.radware.vision.infra.testhandlers.alteon.configuration.system.Users;

import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.system.users.remoteAuthentication.RemoteAuthentication;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by matthewt on 6/3/2015.
 */
public class RemoteAuthenticationHandler extends BaseHandler {

    private static RemoteAuthentication remoteAuthentication = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mUsers().mRemoteAuthentication();

    public static void DefinitionRemoteAuthenticationRADIUS(HashMap<String, String> testProperties, GeneralEnums.State radiusState) throws TargetWebElementNotFoundException {
        initLockDevice(testProperties);
        remoteAuthentication.openPage();
        if (radiusState.equals(GeneralEnums.State.ENABLE)) {
            remoteAuthentication.enableRadius();
        } else {
            remoteAuthentication.disableRadius();
        }

        if (testProperties.get("ipVersion").equals("IPv4")) {
            remoteAuthentication.setIpAddressRadiusPrimary(testProperties.get("ipAdress"), testProperties.get("ipVersion"));
        }
        if (testProperties.get("ipVersion").equals("IPv6")) {
            remoteAuthentication.setIpAddressRadiusPrimary(testProperties.get("ipAdress"), testProperties.get("ipVersion"));
        }
        if (testProperties.get("ipVersion2").equals("IPv4")) {
            remoteAuthentication.setIpAddressRadiusSecondary(testProperties.get("ipAdress2"), testProperties.get("ipVersion2"));
        }
        if (testProperties.get("ipVersion2").equals("IPv6")) {
            remoteAuthentication.setIpAddressRadiusSecondary(testProperties.get("ipAdress2"), testProperties.get("ipVersion2"));
        }
        remoteAuthentication.setPortRadius(testProperties.get("port"));
        remoteAuthentication.setTimeoutRadius(testProperties.get("DHCPtimeOut"));
        remoteAuthentication.setRetriesRadius(testProperties.get("retries"));
        remoteAuthentication.setServerSecretRadiusPrimary(testProperties.get("primaryServerSecret"));
        remoteAuthentication.setServerSecretRadiusSecondary(testProperties.get("secondaryServerSecret"));
        if (testProperties.get("allowLocalUserFallback").equals(GeneralEnums.State.ENABLE)) {
            remoteAuthentication.enableAllowLocalUserFallbackRadius();
        } else remoteAuthentication.disableAllowLocalUserFallbackRadius();

        remoteAuthentication.submit();
    }

    public static void DefinitionRemoteAuthenticationTACACS(HashMap<String, String> testProperties, GeneralEnums.State TACState) throws TargetWebElementNotFoundException {

        if (TACState.equals(GeneralEnums.State.ENABLE)) {
            remoteAuthentication.enableTacacs();
        } else {
            remoteAuthentication.disableTacacs();
        }

        if (testProperties.get("TACipVersion").equals("IPv4")) {
            remoteAuthentication.setIpAddressTacacsPrimary(testProperties.get("TACipAdress"), testProperties.get("TACipVersion"));
        }
        if (testProperties.get("TACipVersion").equals("IPv6")) {
            remoteAuthentication.setIpAddressTacacsPrimary(testProperties.get("TACipAdress"), testProperties.get("TACipVersion"));
        }
        if (testProperties.get("TACipVersion2").equals("IPv4")) {
            remoteAuthentication.setIpAddressTacacsSecondary(testProperties.get("TACipAdress"), testProperties.get("TACipVersion2"));
        }
        if (testProperties.get("TACipVersion2").equals("IPv6")) {
            remoteAuthentication.setIpAddressTacacsSecondary(testProperties.get("TACipAdress"), testProperties.get("TACipVersion2"));
        }
        remoteAuthentication.setPortTacacs(testProperties.get("TACport"));
        remoteAuthentication.setTimeoutTacacs(testProperties.get("TACDHCPtimeOut"));
        remoteAuthentication.setRetriesTacacs(testProperties.get("TACretries"));
        remoteAuthentication.setServerSecretTacacsPrimary("TACprimaryServerSecret");
        remoteAuthentication.setServerSecretTacacsSecondary("TACsecondaryServerSecret");
        if (testProperties.get("TACCommandAuth").equals(GeneralEnums.State.ENABLE))
            remoteAuthentication.enableCommandAuthorization();
        else
            remoteAuthentication.disableCommandAuthorization();
        if (testProperties.get("TACCommandLog").equals(GeneralEnums.State.ENABLE))
            remoteAuthentication.enableCommandLogging();
        else
            remoteAuthentication.disableCommandLogging();
        if (testProperties.get("TACNewPrivilegeLevelMapping").equals(GeneralEnums.State.ENABLE))
            remoteAuthentication.enableNewPrivilegeLevelMapping();
        else
            remoteAuthentication.disableNewPrivilegeLevelMapping();
        if (testProperties.get("TACallowLocalUserFallback").equals(GeneralEnums.State.ENABLE))
            remoteAuthentication.enableAllowLocalUserFallbackTacacs();
        else
            remoteAuthentication.disableAllowLocalUserFallbackTacacs();
        remoteAuthentication.submit();

    }

}
