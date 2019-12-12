package com.radware.vision.tests.Alteon.Configuration.network.layer2.spanningTree;

import com.radware.automation.tools.basetest.BaseTestUtils;
import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.tools.utils.StringUtils;
import com.radware.automation.webui.webpages.GeneralEnums;
import com.radware.automation.webui.webpages.configuration.network.layer2.Layer2Enums;
import com.radware.vision.infra.testhandlers.alteon.configuration.network.layer2.spanningTree.SpanningTreeHandler;
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
 * Created by vadyms on 6/14/2015.
 */
public class SpanningTreeTests extends AlteonTestBase {

    GeneralEnums.State MultipleSpanningTreeState;
    Layer2Enums.SpanningTree SpanningTreeMode;
    String RegionName;
    GeneralEnums.State STPonPortState;
    String PathCost;
    Layer2Enums.LinkType LinkTypeState;
    GeneralEnums.State EdgePortState;
    int RegionVersion;
    int MaximumHop;
    int BridgePriority;
    int MaximumAge;
    int ForwardDelay;
    int PortPriority;
    int HelloTime;
    int rowNumber;
    BaseTableActions externalMonitoringTableAction = BaseTableActions.NEW;
    EditTableActions dataPortAccessActions = EditTableActions.EDIT;
    BaseTableActions allowedProtocolPerNetworkActions = BaseTableActions.NEW;
    ManagementNetworks managementNetwork = ManagementNetworks.IPV4;

    @Test
    @TestProperties(name = "Spanning Tree Config", paramsInclude = {"qcTestId", "deviceIp", "deviceState", "deviceName", "parentTree",  "clickOnTableRow"
    ,"MultipleSpanningTreeState","SpanningTreeMode","RegionName","STPonPortState","PathCost"
            ,"LinkTypeState","EdgePortState","RegionVersion","MaximumHop","BridgePriority"
            ,"MaximumAge","ForwardDelay","PortPriority","HelloTime","rowNumber"
            })
    public void spanningTreeConfig() throws IOException {
        try {
            testProperties.put("MultipleSpanningTreeState", MultipleSpanningTreeState.toString());
            testProperties.put("SpanningTreeMode", SpanningTreeMode.toString());
            testProperties.put("RegionName", RegionName);
            testProperties.put("STPonPortState", STPonPortState.toString());
            testProperties.put("PathCost", PathCost);
            testProperties.put("LinkTypeState", LinkTypeState.toString());
            testProperties.put("EdgePortState", EdgePortState.toString());
            testProperties.put("RegionVersion", getRegionVersion());
            testProperties.put("MaximumHop", getMaximumHop());
            testProperties.put("BridgePriority", getBridgePriority());
            testProperties.put("MaximumAge", getMaximumAge());
            testProperties.put("ForwardDelay", getForwardDelay());
            testProperties.put("PortPriority", getPortPriority());
            testProperties.put("HelloTime", getHelloTime());
            testProperties.put("rowNumber", getRowNumber());
            SpanningTreeHandler.spanningTreeConfig(testProperties);
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

    public Layer2Enums.SpanningTree getSpanningTreeMode() {
        return SpanningTreeMode;
    }

    public void setSpanningTreeMode(Layer2Enums.SpanningTree spanningTreeMode) {
        SpanningTreeMode = spanningTreeMode;
    }

    public GeneralEnums.State getMultipleSpanningTreeState() {
        return MultipleSpanningTreeState;
    }

    public void setMultipleSpanningTreeState(GeneralEnums.State multipleSpanningTreeState) {
        MultipleSpanningTreeState = multipleSpanningTreeState;
    }

    public String getRegionName() {
        return RegionName;
    }

    public void setRegionName(String regionName) {
        RegionName = regionName;
    }

    public GeneralEnums.State getSTPonPortState() {
        return STPonPortState;
    }

    public void setSTPonPortState(GeneralEnums.State STPonPortState) {
        this.STPonPortState = STPonPortState;
    }

    public String getPathCost() {
        return PathCost;
    }
    @ParameterProperties(description = "Valid range: 0 ... 200000000, 0 for Auto")
    public void setPathCost(String pathCost) {
        PathCost = pathCost;
    }

    public Layer2Enums.LinkType getLinkTypeState() {
        return LinkTypeState;
    }

    public void setLinkTypeState(Layer2Enums.LinkType linkTypeState) {
        LinkTypeState = linkTypeState;
    }

    public GeneralEnums.State getEdgePortState() {
        return EdgePortState;
    }

    public void setEdgePortState(GeneralEnums.State edgePortState) {
        EdgePortState = edgePortState;
    }

    public String getRegionVersion() {
        return String.valueOf(RegionVersion);
    }
    @ParameterProperties(description = "Input value 0 to 65535")
    public void setRegionVersion(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 0) {
            this.RegionVersion = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 65535) {
            this.RegionVersion = 65535;
        } else{ this.RegionVersion = Integer.valueOf(StringUtils.fixNumeric(port));}

    }


    public String getMaximumHop() {
        return String.valueOf(MaximumHop);
    }
    @ParameterProperties(description = "Input value 4 to 60")
    public void setMaximumHop(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 4) {
            this.MaximumHop = 4;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 60) {
            this.MaximumHop = 60;
        } else{ this.MaximumHop = Integer.valueOf(StringUtils.fixNumeric(port));}

    }


    public String getBridgePriority() {
        return String.valueOf(BridgePriority);
    }
    @ParameterProperties(description = "Input value 1 to 65535")
    public void setBridgePriority(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 1) {
            this.BridgePriority = 1;
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


    public String getPortPriority() {
        return String.valueOf(PortPriority);
    }
    @ParameterProperties(description = "Input value 0 to 240")
    public void setPortPriority(String port) {
        if (Integer.valueOf(StringUtils.fixNumeric(port)) < 0) {
            this.PortPriority = 0;
        } else if (Integer.valueOf(StringUtils.fixNumeric(port)) > 240) {
            this.PortPriority = 240;
        } else{ this.PortPriority = Integer.valueOf(StringUtils.fixNumeric(port));}

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


}
