package com.radware.vision.tests.Alteon.Configuration.network.layer2;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.network.layer2.PortTeamsHandler;
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
 * Created by vadyms on 6/10/2015.
 */
public class PortTeamsTests extends AlteonTestBase {

    GeneralEnums.State PortTeamState;
    String PortName;
    String Ports;
    String Trunks;
    String unSelectPorts;
    String unSelectTrunks;
    int PortId;
    int rowNumber;

    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Test
    @TestProperties(name = "add Port Team", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"PortTeamState","Ports","Trunks","PortId","PortName"})
    public void addPortTeam() throws IOException {
        try {
            testProperties.put("PortTeamState", PortTeamState.toString());
            testProperties.put("Ports", Ports);
            testProperties.put("Trunks", Trunks);
            testProperties.put("PortId", getPortId());
            testProperties.put("PortName", PortName);
            PortTeamsHandler.addPortTeam(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "edit Port Team", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","PortTeamState","Ports","Trunks","PortName","unSelectPorts","unSelectTrunks"})
    public void editPortTeam() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("PortTeamState", PortTeamState.toString());
            testProperties.put("Ports", Ports);
            testProperties.put("Trunks", Trunks);
            testProperties.put("PortName", PortName);
            testProperties.put("unSelectPorts", unSelectPorts);
            testProperties.put("unSelectTrunks", unSelectTrunks);
            PortTeamsHandler.editPortTeam(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "duplicate Port Team", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","PortTeamState","Ports","Trunks","PortName","unSelectPorts","unSelectTrunks","PortId"})
    public void duplicatePortTeam() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("PortTeamState", PortTeamState.toString());
            testProperties.put("PortId", getPortId());
            testProperties.put("Ports", Ports);
            testProperties.put("Trunks", Trunks);
            testProperties.put("PortName", PortName);
            testProperties.put("unSelectPorts", unSelectPorts);
            testProperties.put("unSelectTrunks", unSelectTrunks);
            PortTeamsHandler.duplicatePortTeam(testProperties);
        } catch (Exception e) {
            BaseTestUtils.report("Failed with the following error:\n" +parseExceptionBody(e), Reporter.FAIL);
        }

    }
    @Test
    @TestProperties(name = "del Port Team", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber"})
    public void delPortTeam() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            PortTeamsHandler.delPortTeam(testProperties);
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

    public String getPortId() {
        return String.valueOf(PortId);
    }
    @ParameterProperties(description = "Input value 1 to 8")
    public void setPortId(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.PortId = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 8) {
            this.PortId = 8;
        } else{ this.PortId = Integer.valueOf(StringUtils.fixNumeric(port));}

    }


    public String getPorts() {
        return Ports;
    }
    @ParameterProperties(description = "Separate by ,")
    public void setPorts(String ports) {
        Ports = ports;
    }

    public String getPortName() {
        return PortName;
    }

    public void setPortName(String portName) {
        PortName = portName;
    }

    public GeneralEnums.State getPortTeamState() {
        return PortTeamState;
    }

    public void setPortTeamState(GeneralEnums.State portTeamState) {
        PortTeamState = portTeamState;
    }

    public String getTrunks() {
        return Trunks;
    }
    @ParameterProperties(description = "Separate by ,")
    public void setTrunks(String trunks) {
        Trunks = trunks;
    }

    public String getUnSelectPorts() {
        return unSelectPorts;
    }
    @ParameterProperties(description = "Separate by ,")
    public void setUnSelectPorts(String unSelectPorts) {
        this.unSelectPorts = unSelectPorts;
    }

    public String getUnSelectTrunks() {
        return unSelectTrunks;
    }
    @ParameterProperties(description = "Separate by ,")
    public void setUnSelectTrunks(String unSelectTrunks) {
        this.unSelectTrunks = unSelectTrunks;
    }

}
