package com.radware.vision.tests.Alteon.Configuration.network.physicalPorts;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.network.phPorts.PhysicalPortsEnums;
import com.radware.vision.infra.testhandlers.alteon.configuration.network.physicalPorts.PortSettingsHandler;
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
 * Created by vadyms on 6/8/2015.
 */
public class PortSettingsTests extends AlteonTestBase {

    GeneralEnums.State portState;
    GeneralEnums.State ipForwarding;
    String portName;
    String portAlias;
    GeneralEnums.State vLANTagging;
    int defaultPortVLANID;
    GeneralEnums.State spanningTree;
    int trafficContract;
    int nonIpTrafficContract;
    String egressLimit;
    PhysicalPortsEnums.NonIpTraffic nonIpTraffic;
    PhysicalPortsEnums.LinkUpDownTrap linkUpDownTrap;
    GeneralEnums.State RMON;

    int rowNumber;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Test
    @TestProperties(name = "edit Port Settings", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","portState","ipForwarding","portName","portAlias","vLANTagging","defaultPortVLANID",
            "spanningTree","trafficContract","nonIpTrafficContract","egressLimit","nonIpTraffic","linkUpDownTrap","RMON"})
    public void editPortSettings() throws IOException {
        try {
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("portState", portState.toString());
            testProperties.put("ipForwarding", ipForwarding.toString());
            testProperties.put("portName", portName);
            testProperties.put("portAlias", portAlias);
            testProperties.put("vLANTagging", vLANTagging.toString());
            testProperties.put("defaultPortVLANID", getDefaultPortVLANID());
            testProperties.put("spanningTree", spanningTree.toString());
            testProperties.put("trafficContract", getTrafficContract());
            testProperties.put("nonIpTrafficContract", getNonIpTrafficContract());
            testProperties.put("egressLimit", egressLimit);
            testProperties.put("nonIpTraffic", nonIpTraffic.toString());
            testProperties.put("linkUpDownTrap", linkUpDownTrap.toString());
            testProperties.put("RMON", RMON.toString());
            PortSettingsHandler.editPortSettings(testProperties);
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

    public GeneralEnums.State getIpForwarding() {
        return ipForwarding;
    }

    public void setIpForwarding(GeneralEnums.State ipForwarding) {
        this.ipForwarding = ipForwarding;
    }

    public GeneralEnums.State getPortState() {
        return portState;
    }

    public void setPortState(GeneralEnums.State portState) {
        this.portState = portState;
    }

    public String getPortName() {
        return portName;
    }

    public void setPortName(String portName) {
        this.portName = portName;
    }

    public String getPortAlias() {
        return portAlias;
    }

    public void setPortAlias(String portAlias) {
        this.portAlias = portAlias;
    }

    public GeneralEnums.State getvLANTagging() {
        return vLANTagging;
    }

    public void setvLANTagging(GeneralEnums.State vLANTagging) {
        this.vLANTagging = vLANTagging;
    }

    public GeneralEnums.State getSpanningTree() {
        return spanningTree;
    }

    public void setSpanningTree(GeneralEnums.State spanningTree) {
        this.spanningTree = spanningTree;
    }

    public String getEgressLimit() {
        return egressLimit;
    }
    @ParameterProperties(description = "Input value from 0K to 100000K or 1M to 1000M")
    public void setEgressLimit(String egressLimit) {
        this.egressLimit = egressLimit;
    }

    public PhysicalPortsEnums.NonIpTraffic getNonIpTraffic() {
        return nonIpTraffic;
    }

    public void setNonIpTraffic(PhysicalPortsEnums.NonIpTraffic nonIpTraffic) {
        this.nonIpTraffic = nonIpTraffic;
    }

    public PhysicalPortsEnums.LinkUpDownTrap getLinkUpDownTrap() {
        return linkUpDownTrap;
    }

    public void setLinkUpDownTrap(PhysicalPortsEnums.LinkUpDownTrap linkUpDownTrap) {
        this.linkUpDownTrap = linkUpDownTrap;
    }

    public GeneralEnums.State getRMON() {
        return RMON;
    }

    public void setRMON(GeneralEnums.State RMON) {
        this.RMON = RMON;
    }



    public String getDefaultPortVLANID() {
        return String.valueOf(defaultPortVLANID);
    }
    @ParameterProperties(description = "Input value 1 to 4090")
    public void setDefaultPortVLANID(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.defaultPortVLANID = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 4090) {
            this.defaultPortVLANID = 4090;
        } else{ this.defaultPortVLANID = Integer.valueOf(StringUtils.fixNumeric(port));}

    }


    public String getTrafficContract() {
        return String.valueOf(trafficContract);
    }
    @ParameterProperties(description = "Input value 1 to 1024")
    public void setTrafficContract(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.trafficContract = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 1024) {
            this.trafficContract = 1024;
        } else{ this.trafficContract = Integer.valueOf(StringUtils.fixNumeric(port));}

    }
    public String getNonIpTrafficContract() {
        return String.valueOf(nonIpTrafficContract);
    }
    @ParameterProperties(description = "Input value 1 to 1024")
    public void setNonIpTrafficContract(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.nonIpTrafficContract = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 1024) {
            this.nonIpTrafficContract = 1024;
        } else{ this.nonIpTrafficContract = Integer.valueOf(StringUtils.fixNumeric(port));}

    }

}
