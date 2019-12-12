package com.radware.vision.infra.testhandlers.alteon.configuration.system;

import com.radware.automation.webui.webpages.configuration.system.dnsClient.DNSClient;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by konstantinr on 6/2/2015.
 */
public class DNSClientHandler extends RBACHandlerBase {

    public static void setDNSClientSettings(HashMap<String, String> testProperties) throws TargetWebElementNotFoundException {
        initLockDevice(testProperties);
        DNSClient dnsClient = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mDNSClient();

        dnsClient.openPage();
        dnsClient.setPrimaVer(testProperties.get("primaryIPVersion"));
        dnsClient.setSecondryVer(testProperties.get("secondaryIPVersion"));


        if (testProperties.get("primaryIPVersion").equals("IPv4")) {
            dnsClient.setPrimaAddrbyId(testProperties.get("primaryIPAddress"));
        }
        if (testProperties.get("primaryIPVersion").equals("IPv6")) {
            dnsClient.setPrimaAddrbyIdV6(testProperties.get("primaryIPAddress"));
        }
        if (testProperties.get("secondaryIPVersion").equals("IPv4")) {
            dnsClient.setSecAddrbyId(testProperties.get("secondaryIPAddress"));
        }
        if (testProperties.get("secondaryIPVersion").equals("IPv6")) {
            dnsClient.setSecAddrbyIdV6(testProperties.get("secondaryIPAddress"));
        }

        if (testProperties.get("defaultDomainName")!=null){
        dnsClient.setDomName(testProperties.get("defaultDomainName"));}

        dnsClient.submit();
    }

}
