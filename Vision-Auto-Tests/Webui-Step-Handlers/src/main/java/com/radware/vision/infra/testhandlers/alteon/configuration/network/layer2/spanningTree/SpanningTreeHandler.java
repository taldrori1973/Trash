package com.radware.vision.infra.testhandlers.alteon.configuration.network.layer2.spanningTree;

import com.radware.automation.webui.webpages.configuration.network.layer2.spanningTree.SpanningTree;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 6/14/2015.
 */
public class SpanningTreeHandler extends BaseHandler {

    public static void spanningTreeConfig(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        SpanningTree spanningTree = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mSpanningTree();
        spanningTree.openPage();
        if (testProperties.get("MultipleSpanningTreeState").equals("Enable")){spanningTree.enableMultipleSpanningTree();}
        if (testProperties.get("MultipleSpanningTreeState").equals("Disable")){spanningTree.disableMultipleSpanningTree();}
        if (testProperties.get("SpanningTreeMode").equals("RSTP")){
            spanningTree.selectSpanningTreeMode(testProperties.get("SpanningTreeMode"));
            spanningTree.submit();}
        else if (testProperties.get("SpanningTreeMode").equals("MSTP")){
            spanningTree.selectSpanningTreeMode(testProperties.get("SpanningTreeMode"));
            spanningTree.setRegionName(testProperties.get("RegionName"));
            spanningTree.setRegionVersion(testProperties.get("RegionVersion"));
            spanningTree.setMaximumHop(testProperties.get("MaximumHop"));
            spanningTree.selectCommonInternalSpanningTreeBridgeTab();
            spanningTree.setBridgePriority(testProperties.get("BridgePriority"));
            spanningTree.setMaxAge(testProperties.get("MaximumAge"));
            spanningTree.setForwardDelay(testProperties.get("ForwardDelay"));
            spanningTree.selectCommonInternalSpanningTreePortsTab();
            spanningTree.editCommonInternalSpanningTreePortsByRow(testProperties.get("rowNumber"));
            spanningTree.setPortPriority(testProperties.get("PortPriority"));
            spanningTree.setPathCost(testProperties.get("PathCost"));
            spanningTree.selectLinkType(testProperties.get("LinkTypeState"));
            spanningTree.selectEdgePortStat(testProperties.get("EdgePortState"));
            spanningTree.setHelloTime(testProperties.get("HelloTime"));
            spanningTree.submit();
            spanningTree.submit();
        }
    }

}
