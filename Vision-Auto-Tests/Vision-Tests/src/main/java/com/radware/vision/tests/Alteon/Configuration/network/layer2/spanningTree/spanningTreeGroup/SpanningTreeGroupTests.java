package com.radware.vision.tests.Alteon.Configuration.network.layer2.spanningTree.spanningTreeGroup;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.network.layer2.Layer2Enums;
import com.radware.vision.infra.testhandlers.alteon.configuration.network.layer2.spanningTree.spanningTreeGroup.SpanningTreeGroupHandler;
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
 * Created by vadyms on 6/15/2015.
 */
public class SpanningTreeGroupTests extends AlteonTestBase {


    GeneralEnums.State SpanningTreeGroupState;
    GeneralEnums.State SpanningTreeGroupPortState;
    Layer2Enums.LinkType LinkType;
    GeneralEnums.State  Edge;
    GeneralEnums.State PVSTFramesOnUntaggedPortsState;
    String VLANS;
    String unSelectVLANS;
    int BridgePriority;
    int MaximumAge;
    int ForwardDelay;
    int HelloTime;
    int AgingTime;
    int PortPriority;
    int PathCost;
    int PortRowNumber;
    int rowNumber;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Test
    @TestProperties(name = "Edit Spanning Tree Group", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
            ,"rowNumber","SpanningTreeGroupState","SpanningTreeGroupPortState","LinkType","Edge"
            ,"PVSTFramesOnUntaggedPortsState","VLANS","BridgePriority","MaximumAge","ForwardDelay"
            , "HelloTime","AgingTime","PortPriority","PortRowNumber","unSelectVLANS","PathCost"
    })
    public void editSpanningTreeGroup() throws IOException {
        try {
            testProperties.put("SpanningTreeGroupState", SpanningTreeGroupState.toString());
            testProperties.put("SpanningTreeGroupPortState", SpanningTreeGroupPortState.toString());
            testProperties.put("LinkType", LinkType.toString());
            testProperties.put("Edge", Edge.toString());
            testProperties.put("PVSTFramesOnUntaggedPortsState", PVSTFramesOnUntaggedPortsState.toString());
            testProperties.put("VLANS", VLANS);
            testProperties.put("BridgePriority", getBridgePriority());
            testProperties.put("MaximumAge", getMaximumAge());
            testProperties.put("ForwardDelay", getForwardDelay());
            testProperties.put("HelloTime", getHelloTime());
            testProperties.put("AgingTime", getAgingTime());
            testProperties.put("PortPriority", getPortPriority());
            testProperties.put("PortRowNumber", getPortRowNumber());
            testProperties.put("unSelectVLANS", getUnSelectVLANS());
            testProperties.put("rowNumber", getRowNumber());
            testProperties.put("PathCost", getPathCost());
            SpanningTreeGroupHandler.editSpanningTreeGroup(testProperties);
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
    public String getPortRowNumber() {
        return String.valueOf(PortRowNumber);
    }
    @ParameterProperties(description = "Input value 0 or more, remember 0 is first row number")
    public void setPortRowNumber(String row) {
        if (Integer.valueOf(StringUtils.fixNumeric(row)) < 0) {
            this.PortRowNumber = 0;
        } else {
            this.PortRowNumber = Integer.valueOf(StringUtils.fixNumeric(row));
        }
    }

    public String getPortPriority() {
        return String.valueOf(PortPriority);
    }
    @ParameterProperties(description = "Input value 0 to 255")
    public void setPortPriority(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 0) {
            this.PortPriority = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 255) {
            this.PortPriority = 255;
        } else{ this.PortPriority = Integer.valueOf(StringUtils.fixNumeric(port));}

    }


    public String getBridgePriority() {
        return String.valueOf(BridgePriority);
    }
    @ParameterProperties(description = "Input value 0 to 65535")
    public void setBridgePriority(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 0) {
            this.BridgePriority = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 65535) {
            this.BridgePriority = 65535;
        } else{ this.BridgePriority = Integer.valueOf(StringUtils.fixNumeric(port));}

    }


    public String getMaximumAge() {
        return String.valueOf(MaximumAge);
    }
    @ParameterProperties(description = "Input value 6 to 40")
    public void setMaximumAge(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 6) {
            this.MaximumAge = 6;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 40) {
            this.MaximumAge = 40;
        } else{ this.MaximumAge = Integer.valueOf(StringUtils.fixNumeric(port));}

    }
    public String getHelloTime() {
        return String.valueOf(HelloTime);
    }
    @ParameterProperties(description = "Input value 1 to 10")
    public void setHelloTime(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.HelloTime = 1;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 10) {
            this.HelloTime = 10;
        } else{ this.HelloTime = Integer.valueOf(StringUtils.fixNumeric(port));}

    }

    public String getForwardDelay() {
        return String.valueOf(ForwardDelay);
    }
    @ParameterProperties(description = "Input value 4 to 30")
    public void setForwardDelay(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 4) {
            this.ForwardDelay = 4;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 30) {
            this.ForwardDelay = 30;
        } else{ this.ForwardDelay = Integer.valueOf(StringUtils.fixNumeric(port));}

    }


    public String getAgingTime() {
        return String.valueOf(AgingTime);
    }
    @ParameterProperties(description = "Input value 0 to 65535")
    public void setAgingTime(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 0) {
            this.AgingTime = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 65535) {
            this.AgingTime = 65535;
        } else{ this.AgingTime = Integer.valueOf(StringUtils.fixNumeric(port));}

    }
    public String getPathCost() {
        return String.valueOf(PathCost);
    }
    @ParameterProperties(description = "Input value 0 to 65535")
    public void setPathCost(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 0) {
            this.PathCost = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 65535) {
            this.PathCost = 65535;
        } else{ this.PathCost = Integer.valueOf(StringUtils.fixNumeric(port));}

    }
    public Layer2Enums.LinkType getLinkType() {
        return LinkType;
    }

    public void setLinkType(Layer2Enums.LinkType linkType) {
        LinkType = linkType;
    }

    public GeneralEnums.State getSpanningTreeGroupState() {
        return SpanningTreeGroupState;
    }

    public void setSpanningTreeGroupState(GeneralEnums.State spanningTreeGroupState) {
        SpanningTreeGroupState = spanningTreeGroupState;
    }

    public GeneralEnums.State getSpanningTreeGroupPortState() {
        return SpanningTreeGroupPortState;
    }

    public void setSpanningTreeGroupPortState(GeneralEnums.State spanningTreeGroupPortState) {
        SpanningTreeGroupPortState = spanningTreeGroupPortState;
    }

    public GeneralEnums.State getEdge() {
        return Edge;
    }

    public void setEdge(GeneralEnums.State edge) {
        Edge = edge;
    }

    public GeneralEnums.State getPVSTFramesOnUntaggedPortsState() {
        return PVSTFramesOnUntaggedPortsState;
    }

    public void setPVSTFramesOnUntaggedPortsState(GeneralEnums.State PVSTFramesOnUntaggedPortsState) {
        this.PVSTFramesOnUntaggedPortsState = PVSTFramesOnUntaggedPortsState;
    }

    public String getVLANS() {
        return VLANS;
    }
    @ParameterProperties(description = "Separate by ,")
    public void setVLANS(String VLANS) {
        this.VLANS = VLANS;
    }
    public String getUnSelectVLANS() {
        return unSelectVLANS;
    }
    @ParameterProperties(description = "Separate by ,")
    public void setUnSelectVLANS(String unSelectVLANS) {
        this.unSelectVLANS = unSelectVLANS;
    }

}
