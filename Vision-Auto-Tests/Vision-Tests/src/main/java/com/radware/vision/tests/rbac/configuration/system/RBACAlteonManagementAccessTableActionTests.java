package com.radware.vision.tests.rbac.configuration.system;



import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.system.managementAccess.ManagementAccessEnums;
import com.radware.vision.infra.testhandlers.rbac.configuration.system.RBACAlteonManagementAccessTableActionHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.tests.rbac.RBACTestBase;
import jsystem.framework.TestProperties;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.MalformedURLException;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonManagementAccessTableActionTests extends RBACTestBase {

    String IPAddressIPv4;
    String MaskPrefixIPv4;
    String DefaultGatewayIPv4;
    String IPAddressIPv6;
    int MaskPrefixIPv6;
    String DefaultGatewayIPv6;
    int DHCPTimeout;
    int Interval;
    int Retries;
    public GeneralEnums.State ManagementPort;
    public ManagementAccessEnums.IpAssignment IpAssignment;
    public ManagementAccessEnums.HealthCheckType HealthCheckType;
    public ManagementAccessEnums.Speed Speed;
    public ManagementAccessEnums.Duplex Duplex;
    public GeneralEnums.State Autonegotiation;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Before
    public void setDeviceDriver()throws Exception{
        setAlteonTestPropertiesBase();
    }

    @Test
    @TestProperties(name = "verify External Monitoring Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "parentTree", "externalMonitoringTableAction", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyExternalMonitoringDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("externalMonitoringTableAction", externalMonitoringTableAction.getTableAction().toString());

            if (!(RBACAlteonManagementAccessTableActionHandler.verifyExternalMonitoringTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + externalMonitoringTableAction.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify External Monitoring Disabled Table Action failed: " + externalMonitoringTableAction.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }


    @Test
    @TestProperties(name = "verify Data Port Access Disabled Table Action", paramsInclude = {"qcTestId","deviceIp", "deviceName", "parentTree", "dataPortAccessActions", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyDataPortAccessDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("dataPortAccessActions", dataPortAccessActions.getTableAction().toString());

            if (!(RBACAlteonManagementAccessTableActionHandler.verifyDataPortAccessTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + dataPortAccessActions.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify Data Port Access Disabled Table Action failed: " + dataPortAccessActions.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
        }
    }

    @Test
    @TestProperties(name = "verify Allowed Protocol Per network Disabled Table Action", paramsInclude = {"qcTestId", "deviceIp", "deviceName", "managementNetwork", "parentTree", "allowedProtocolPerNetworkActions", "clickOnTableRow", "deviceState", "expectedResult"})
    public void verifyAllowedProtocolPerNetworkDisabledTableAction() throws MalformedURLException, FileNotFoundException, IOException {

        try {
            testProperties.put("allowedProtocolPerNetworkActions", allowedProtocolPerNetworkActions.getTableAction().toString());
            testProperties.put("managementNetwork", managementNetwork.getNetwork().toString());

            if (!(RBACAlteonManagementAccessTableActionHandler.verifyAllowedProtocolPerNetworkTableAction(testProperties))) {
                BaseTestUtils.report("The specified Table action is in an incorrect state: " + allowedProtocolPerNetworkActions.getTableAction() + "\n.", Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("verify AllowedProtocolPerNetwork Disabled Table Action failed: " + allowedProtocolPerNetworkActions.getTableAction() + "\n." + parseExceptionBody(e),
                    Reporter.FAIL);
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
    public int getDHCPTimeout() {
        return DHCPTimeout;
    }

    public void setDHCPTimeout(int DHCPTimeout) {
        if(DHCPTimeout < 4){this.DHCPTimeout = 4;}else
        if(DHCPTimeout > 60){this.DHCPTimeout = 60;}else this.DHCPTimeout = DHCPTimeout;

    }
    public int getMaskPrefixIPv6() {
        return MaskPrefixIPv6;
    }

    public void setMaskPrefixIPv6(int maskPrefixIPv6) {
        if(maskPrefixIPv6 < 0){this.MaskPrefixIPv6 = 0;}else
        if(maskPrefixIPv6 > 128){this.MaskPrefixIPv6 = 128;}else this.MaskPrefixIPv6 = maskPrefixIPv6;
    }



    public int getInterval() {
        return Interval;
    }

    public void setInterval(int interval) {
        if(interval < 0){this.Interval = 0;}else
        if(interval > 60){this.Interval = 60;}else this.Interval = interval;
    }

    public int getRetries() {
        return Retries;
    }

    public void setRetries(int retries) {
        if(retries < 1){this.Retries = 1;}else
        if(retries > 120){this.Retries = 120;}else this.Retries = retries;
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

    public void setMaskPrefixIPv4(String maskPrefixIPv4)
    {
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
    public GeneralEnums.State getAutonegotiation() {
        return Autonegotiation;
    }

    public void setAutonegotiation(GeneralEnums.State autonegotiation) {
        Autonegotiation = autonegotiation;
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
}