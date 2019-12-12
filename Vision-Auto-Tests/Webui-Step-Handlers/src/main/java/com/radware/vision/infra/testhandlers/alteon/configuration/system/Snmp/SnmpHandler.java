package com.radware.vision.infra.testhandlers.alteon.configuration.system.Snmp;

import com.radware.automation.webui.webpages.configuration.system.snmp.SNMP;
import com.radware.vision.automation.tools.exceptions.selenium.TargetWebElementNotFoundException;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 5/25/2015.
 */
public class SnmpHandler extends BaseHandler {

    public static void setSNMPSettings(HashMap<String, String> testProperties) throws TargetWebElementNotFoundException {
        initLockDevice(testProperties);
        SNMP snmp = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mSnmp();
        snmp.openPage();
        snmp.setAccess(testProperties.get("Access"));
        snmp.setVersion(testProperties.get("Version"));
        snmp.setSystemName(testProperties.get("systemName"));
        snmp.setLocation(testProperties.get("location"));
        snmp.setContact(testProperties.get("contact"));
        snmp.setReadCommunity(testProperties.get("readComm"));
        snmp.setWriteCommunity(testProperties.get("writeComm"));
        snmp.setTrapSourceInterface(Integer.parseInt(testProperties.get("trapSourceInterface")));
        snmp.setStateMachineTimeout(Integer.parseInt(testProperties.get("SNMPStateMachineTimeout")));
        if (testProperties.get("FirstSNMPTrapHostAddressIpVersion").equals("IPv4")) {
            snmp.setFirstSnmpTrapHostIpv4Address(testProperties.get("FirstSNMPTrapHostAddressIp"));
        }
        if (testProperties.get("FirstSNMPTrapHostAddressIpVersion").equals("IPv6")) {
            snmp.setFirstSnmpTrapHostIpv6Address(testProperties.get("FirstSNMPTrapHostAddressIp"));
        }
        if (testProperties.get("SecondSNMPTrapHostAddressIpVersion").equals("IPv4")) {
            snmp.setSecondSnmpTrapHostIpv4Address(testProperties.get("SecondSNMPTrapHostAddressIp"));
        }
        if (testProperties.get("SecondSNMPTrapHostAddressIpVersion").equals("IPv6")) {
            snmp.setSecondSnmpTrapHostIpv6Address(testProperties.get("SecondSNMPTrapHostAddressIp"));
        }
        snmp.setAuthFailureTraps(testProperties.get("authenticationFailureTraps"));

        snmp.submit();
    }

}
