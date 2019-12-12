package com.radware.vision.infra.testhandlers.alteon.configuration.network.layer2.spanningTree.spanningTreeGroup;

import com.radware.automation.webui.webpages.configuration.network.layer2.spanningTree.spanningTreeGroup.SpanningTreeGroup;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 6/15/2015.
 */
public class SpanningTreeGroupHandler extends BaseHandler {

    public static void editSpanningTreeGroup(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        SpanningTreeGroup spanningTreeGroup = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mSpanningTree().mSpanningTreeGroup();
        spanningTreeGroup.openPage();
        spanningTreeGroup.editSpanningTreeGroup(testProperties.get("rowNumber"));
        if (testProperties.get("SpanningTreeGroupState").equals("Enable")){spanningTreeGroup.enableSpanningTreeGroup();}
        if (testProperties.get("SpanningTreeGroupState").equals("Disable")){spanningTreeGroup.disableSpanningTreeGroup();}
        spanningTreeGroup.selectSpanningTreeGroupPortTab();
        if(spanningTreeGroup.SpanningTreeGroupPortRow()>0) {
            spanningTreeGroup.editSpanningTreeGroupPort(testProperties.get("PortRowNumber"));
            if (testProperties.get("SpanningTreeGroupPortState").equals("Enable")){spanningTreeGroup.enableSpanningTreeGroupPort();}
            if (testProperties.get("SpanningTreeGroupPortState").equals("Disable")){spanningTreeGroup.disableSpanningTreeGroupPort();}
            spanningTreeGroup.setPortPriority(testProperties.get("PortPriority"));
            spanningTreeGroup.setPortPathCost(testProperties.get("PathCost"));
            spanningTreeGroup.selectLinkType(testProperties.get("LinkType"));
            spanningTreeGroup.selectEdgePortStat(testProperties.get("Edge"));
            spanningTreeGroup.submit();
        }
        spanningTreeGroup.selectAdvancedTab();
        spanningTreeGroup.setBridgePriority(testProperties.get("BridgePriority"));
        spanningTreeGroup.setBridgeHelloTime(testProperties.get("HelloTime"));
        spanningTreeGroup.setBridgeMaxAge(testProperties.get("MaximumAge"));
        spanningTreeGroup.setBridgeForwardDelay(testProperties.get("ForwardDelay"));
        spanningTreeGroup.setBridgeAgingTime(testProperties.get("AgingTime"));
        spanningTreeGroup.enableUntaggedPort(testProperties.get("PVSTFramesOnUntaggedPortsState"));
        if (testProperties.get("unSelectVLANS") != null ||!testProperties.get("unSelectVLANS").equals("")){
            spanningTreeGroup.unSelectVLANS(testProperties.get("unSelectVLANS"));
        }
        if (testProperties.get("VLANS") != null || !testProperties.get("VLANS").equals("")){
            spanningTreeGroup.selectVLANS(testProperties.get("VLANS"));
        }
        spanningTreeGroup.submit();
    }

}
