package com.radware.vision.infra.testhandlers.alteon.configuration.system.managementaccess;

import com.radware.automation.webui.webpages.configuration.system.managementAccess.accessControls.AccessControl;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 5/25/2015.
 */
public class AlteonAccessControlTableActionHandler extends BaseHandler {
    public static void setAccessControlRateLimitSettings(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        AccessControl accessControl = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mAccessControl();
        accessControl.openPage();
        accessControl.setRateLimitArp(Integer.parseInt(testProperties.get("ARP")));
        accessControl.setRateLimitIcmp(Integer.parseInt(testProperties.get("ICMP")));
        accessControl.setRateLimitTcp(Integer.parseInt(testProperties.get("TCP")));
        accessControl.setRateLimitUdp(Integer.parseInt(testProperties.get("UPD")));
        accessControl.setRateLimitBpdu(Integer.parseInt(testProperties.get("BPDU")));
        accessControl.setRateLimitZeroTtl(Integer.parseInt(testProperties.get("ZeroTTL")));
        accessControl.submit();

    }


    public static void setRolloverDataPortAccessForManagementTraffic(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        AccessControl accessControl = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mAccessControl();
        accessControl.openPage();
        try {
            accessControl.mDataPortAccessForManagementTraffic().setRollover(Integer.parseInt(testProperties.get("RowNumber")), testProperties.get("Rollover"));
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

    public static void editPortAccessStateDataPortAccessForManagementTraffic(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        AccessControl accessControl = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mAccessControl();
        accessControl.openPage();
        accessControl.mDataPortAccessForManagementTraffic().editDataPortAccess(Integer.parseInt(testProperties.get("RowNumber")), testProperties.get("portAccess"));
        accessControl.submit();

    }


    public static void addIPV4ManagementNetworks(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        AccessControl accessControl = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mAccessControl();
        accessControl.openPage();
        accessControl.mAllowedProtocolsPerNetwork().addTableIpV4(testProperties.get("IPAddressIPv4"), testProperties.get("MaskPrefixIPv4")
                , testProperties.get("SSH"), testProperties.get("Telnet"), testProperties.get("HTTP"), testProperties.get("HTTPS"),
                testProperties.get("SNMP"));
        accessControl.submit();

    }


    public static void editIPV4ManagementNetworks(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        AccessControl accessControl = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mAccessControl();
        accessControl.openPage();
        accessControl.mAllowedProtocolsPerNetwork().editTableIpV4(Integer.parseInt(testProperties.get("RowNumber")), testProperties.get("IPAddressIPv4"), testProperties.get("MaskPrefixIPv4")
                , testProperties.get("SSH"), testProperties.get("Telnet"), testProperties.get("HTTP"), testProperties.get("HTTPS"),
                testProperties.get("SNMP"));
        accessControl.submit();

    }


    public static void delIPV4ManagementNetworks(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        AccessControl accessControl = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mAccessControl();
        accessControl.openPage();
        accessControl.mAllowedProtocolsPerNetwork().deleteTableIpV4(Integer.parseInt(testProperties.get("RowNumber")));


    }


    public static void addIPV6ManagementNetworks(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        AccessControl accessControl = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mAccessControl();
        accessControl.openPage();
        accessControl.mAllowedProtocolsPerNetwork().addTableIpV6(testProperties.get("IPAddressIPv6"), testProperties.get("MaskPrefixIPv6")
                , testProperties.get("SSH"), testProperties.get("Telnet"), testProperties.get("HTTP"), testProperties.get("HTTPS"),
                testProperties.get("SNMP"));
        accessControl.submit();

    }


    public static void editIPV6ManagementNetworks(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        AccessControl accessControl = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mAccessControl();
        accessControl.openPage();
        accessControl.mAllowedProtocolsPerNetwork().editTableIpV6(Integer.parseInt(testProperties.get("RowNumber")), testProperties.get("IPAddressIPv6"), testProperties.get("MaskPrefixIPv6")
                , testProperties.get("SSH"), testProperties.get("Telnet"), testProperties.get("HTTP"), testProperties.get("HTTPS"),
                testProperties.get("SNMP"));
        accessControl.submit();

    }


    public static void delIPV6ManagementNetworks(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        AccessControl accessControl = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mAccessControl();
        accessControl.openPage();
        accessControl.mAllowedProtocolsPerNetwork().deleteTableIpV6(Integer.parseInt(testProperties.get("RowNumber")));


    }
}
