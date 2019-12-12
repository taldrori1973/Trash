package com.radware.vision.infra.testhandlers.alteon.configuration.system.managementaccess;

import com.radware.automation.webui.webpages.configuration.system.managementAccess.managementPorts.ManagementPorts;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 5/18/2015.
 */
public class AlteonManagementAccessTableActionHandler extends BaseHandler {


    public static void addTCPPort(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        ManagementPorts managementPorts = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mManagementPorts();
        managementPorts.openPage();
        managementPorts.mExternalMonitoring().addTcpPort(Integer.parseInt(testProperties.get("TCPPort")));
        managementPorts.submit();
    }

    public static void delTCPPort(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        ManagementPorts managementPorts = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mManagementPorts();
        managementPorts.openPage();
        managementPorts.mExternalMonitoring().deleteTcpPort(Integer.parseInt(testProperties.get("RowNumber")));

    }
    public static void viewTCPPort(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        ManagementPorts managementPorts = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mManagementPorts();
        managementPorts.openPage();
        managementPorts.mExternalMonitoring().viewTcpPortById(Integer.parseInt(testProperties.get("RowNumber")));
    }
    public static void editTCPPort(HashMap<String, String> testProperties){
        initLockDevice(testProperties);
        ManagementPorts managementPorts = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mManagementPorts();
        managementPorts.openPage();
        managementPorts.mExternalMonitoring().editTcpPort(Integer.parseInt(testProperties.get("RowNumber")), Integer.parseInt(testProperties.get("TCPPort")));
        managementPorts.submit();
    }


    public static void setManagementPortsSettings(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        ManagementPorts managementPorts = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mSystem().mManagementAccess().mManagementPorts();
        managementPorts.openPage();
        if (testProperties.get("IpAssignment").equals("DHCP")) {
            managementPorts.setIpAssignmentDHCP();
            managementPorts.setDHCPTimeout(testProperties.get("DHCPTimeout"));
        } else {
            managementPorts.setIpAssignmentManual();
            if (testProperties.get("ManagementPort").equals("Enable")) {
                managementPorts.enableMmgmtPort();
            } else {
                managementPorts.disableMmgmtPort();
            }
            managementPorts.setDHCPTimeout(testProperties.get("DHCPTimeout"));
            managementPorts.setMmgmtIpv4(testProperties.get("IPAddressIPv4"));
            managementPorts.setMmgmtIpv4Mask(testProperties.get("MaskPrefixIPv4"));
            managementPorts.setMmgmtIpv4Gateway(testProperties.get("DefaultGatewayIPv4"));
            managementPorts.setMmgmtIpv6(testProperties.get("IPAddressIPv6"));
            managementPorts.setMmgmtIpv6Prefix(testProperties.get("MaskPrefixIPv6"));
            managementPorts.setMmgmtIpv6Gateway(testProperties.get("DefaultGatewayIPv6"));
        }

        if (testProperties.get("HealthCheckType").equals("ICMP")) {
            managementPorts.setHealthCheckTypeICMP();
        } else {
            managementPorts.setHealthCheckTypeARP();
        }
        managementPorts.setInternval(testProperties.get("Interval"));
        managementPorts.setRetries(testProperties.get("Retries"));

        if (testProperties.get("AutoNegotiation").equals("Enable")) {
            managementPorts.enableAutonegotiation();
        } else {
            managementPorts.disableAutonegotiation();
        }
        managementPorts.setSpeed(testProperties.get("Speed"));
        managementPorts.setDuplex(testProperties.get("Duplex"));

        if (testProperties.get("ExternalMonitoringOfSwitch").equals("Enable")) {
            managementPorts.mExternalMonitoring().enableExternalMonitoring();
        } else {
            managementPorts.mExternalMonitoring().disableExternalMonitoring();
        }
        managementPorts.submit();
    }

}
