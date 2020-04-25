package com.radware.vision.tests.Alteon.Configuration.System;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.system.DNSClientHandler;
import com.radware.vision.infra.testhandlers.rbac.enums.BaseTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.EditTableActions;
import com.radware.vision.infra.testhandlers.rbac.enums.ManagementNetworks;
import com.radware.vision.tests.Alteon.AlteonTestBase;
import jsystem.framework.TestProperties;
import org.junit.Test;

import java.io.IOException;
import java.util.HashMap;

/**
 * Created by konstantinr on 6/2/2015.
 */
public class DNSClientTests extends AlteonTestBase {

    GeneralEnums.IpVersion primaryIPVersion;
    GeneralEnums.IpVersion secondaryIPVersion;
    String primaryIPAddress;
    String secondaryIPAddress;
    String defaultDomainName;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Test
    @TestProperties(name = "set DNS Client Settings", paramsInclude = {"qcTestId", "deviceState", "deviceIp", "deviceName", "parentTree",
            "primaryIPVersion","secondaryIPVersion","primaryIPAddress", "secondaryIPAddress", "defaultDomainName"} )
    public void setDNSClientSettings()throws IOException {
        try{
            testProperties.put("primaryIPVersion",primaryIPVersion.toString());
            testProperties.put("secondaryIPVersion",secondaryIPVersion.toString());
            testProperties.put("primaryIPAddress",primaryIPAddress);
            testProperties.put("secondaryIPAddress",secondaryIPAddress);
            testProperties.put("defaultDomainName",defaultDomainName);
            DNSClientHandler.setDNSClientSettings(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report(parseExceptionBody(e), Reporter.FAIL);
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


    public String getDefaultDomainName() {
        return defaultDomainName;
    }

    public void setDefaultDomainName(String defaultDomainName) {
        this.defaultDomainName = defaultDomainName;
    }

    public GeneralEnums.IpVersion getPrimaryIPVersion() {
        return primaryIPVersion;
    }

    public void setPrimaryIPVersion(GeneralEnums.IpVersion primaryIPVersion) {
        this.primaryIPVersion = primaryIPVersion;
    }

    public GeneralEnums.IpVersion getSecondaryIPVersion() {
        return secondaryIPVersion;
    }

    public void setSecondaryIPVersion(GeneralEnums.IpVersion secondaryIPVersion) {
        this.secondaryIPVersion = secondaryIPVersion;
    }

    public String getPrimaryIPAddress() {
        return primaryIPAddress;
    }

    public void setPrimaryIPAddress(String primaryIPAddress) {
        this.primaryIPAddress = primaryIPAddress;
    }

    public String getSecondaryIPAddress() {
        return secondaryIPAddress;
    }

    public void setSecondaryIPAddress(String secondaryIPAddress) {
        this.secondaryIPAddress = secondaryIPAddress;
    }

}
