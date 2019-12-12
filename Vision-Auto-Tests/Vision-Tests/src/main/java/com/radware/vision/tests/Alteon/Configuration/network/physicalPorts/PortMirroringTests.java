package com.radware.vision.tests.Alteon.Configuration.network.physicalPorts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.network.phPorts.PhysicalPortsEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.network.physicalPorts.PortMirroringHandler;
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
 * Created by vadyms on 6/9/2015.
 */
public class PortMirroringTests extends AlteonTestBase {


    GeneralEnums.State  PortMirroring;
    String MonitoringPort;
    String MirroredPort;
    PhysicalPortsEnums.TrafficDirection TrafficDirection;
    String VLANs;
    int rowNumber;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Test
    @TestProperties(name = "add Port Mirroring", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"PortMirroring","MonitoringPort","MirroredPort","TrafficDirection","VLANs"})
    public void addPortMirroring() throws IOException {
        try {
            testProperties.put("PortMirroring", PortMirroring.toString());
            testProperties.put("MonitoringPort", MonitoringPort);
            testProperties.put("MirroredPort", MirroredPort);
            testProperties.put("TrafficDirection", TrafficDirection.toString());
            testProperties.put("VLANs", VLANs.toString());
            PortMirroringHandler.addPortMirroring(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "edit Port Mirroring", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","PortMirroring","TrafficDirection","VLANs"})
    public void editPortMirroring() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("PortMirroring", PortMirroring.toString());
            testProperties.put("TrafficDirection", TrafficDirection.toString());
            testProperties.put("VLANs", VLANs.toString());
            PortMirroringHandler.editPortMirroring(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "duplicate Port Mirroring", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","PortMirroring","MonitoringPort","MirroredPort","TrafficDirection","VLANs"})
    public void duplicatePortMirroring() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("PortMirroring", PortMirroring.toString());
            testProperties.put("MonitoringPort", MonitoringPort);
            testProperties.put("MirroredPort", MirroredPort);
            testProperties.put("TrafficDirection", TrafficDirection.toString());
            testProperties.put("VLANs", VLANs.toString());
            PortMirroringHandler.duplicatePortMirroring(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "del Port Mirroring", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber"})
    public void delPortMirroring() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            PortMirroringHandler.delPortMirroring(testProperties);
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


    public String getRowNumber() {
        return String.valueOf(rowNumber);
    }

    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setRowNumber(String row) {
        if (Integer.valueOf(StringUtils.fixNumeric(row)) < 0) {
            this.rowNumber = 0;
        } else {
            this.rowNumber = Integer.valueOf(StringUtils.fixNumeric(row));
        }
    }

    public GeneralEnums.State getPortMirroring() {
        return PortMirroring;
    }

    public void setPortMirroring(GeneralEnums.State portMirroring) {
        PortMirroring = portMirroring;
    }

    public String getMonitoringPort() {
        return MonitoringPort;
    }

    public void setMonitoringPort(String monitoringPort) {
        MonitoringPort = monitoringPort;
    }

    public String getMirroredPort() {
        return MirroredPort;
    }

    public void setMirroredPort(String mirroredPort) {
        MirroredPort = mirroredPort;
    }

    public PhysicalPortsEnums.TrafficDirection getTrafficDirection() {
        return TrafficDirection;
    }

    public void setTrafficDirection(PhysicalPortsEnums.TrafficDirection trafficDirection) {
        TrafficDirection = trafficDirection;
    }

    public String getVLANs() {
        return VLANs;
    }
    @ParameterProperties(description = "Separate by ,")
    public void setVLANs(String VLANs) {
        this.VLANs = VLANs;
    }


}
