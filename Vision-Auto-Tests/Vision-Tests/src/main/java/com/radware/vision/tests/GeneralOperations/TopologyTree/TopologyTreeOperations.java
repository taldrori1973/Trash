package com.radware.vision.tests.GeneralOperations.TopologyTree;

import com.radware.automation.tools.basetest.Reporter;
import com.radware.automation.webui.WebUIUtils;
import com.radware.automation.webui.widgets.ComponentLocator;
import com.radware.vision.base.WebUITestBase;
import com.radware.vision.infra.enums.TopologyTreeButtons;
import com.radware.vision.infra.testhandlers.topologytree.TopologyTreeHandler;
import jsystem.framework.TestProperties;
import org.junit.Test;
import org.openqa.selenium.support.How;

/**
 * Created by urig on 9/9/2015.
 */
public class TopologyTreeOperations extends WebUITestBase {

    TopologyTreeButtons topologyTreeButton = TopologyTreeButtons.SELECT_TOPOLOGY_TREE_BUTTON;
    String topologyTreeItemName;

    @Test
    @TestProperties(name = "Perform TopologyTree Operation", paramsInclude = {"topologyTreeButton"})
    public void performTopologyTreeOperation() {
        try {
            if (!topologyTreeButton.getTreeButton().equals("") && topologyTreeButton != null) {
                WebUIUtils.isTriggerPopupSearchEvent4FreeTest = false;
                ComponentLocator locator = new ComponentLocator(How.ID, topologyTreeButton.getTreeButton());
                WebUIUtils.fluentWaitClick(locator.getBy(), WebUIUtils.DEFAULT_WAIT_TIME, false);
            } else {
                BaseTestUtils.report("Failed to click on the specified button : " + topologyTreeButton.toString(), Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the specified button : " + topologyTreeButton.toString(), Reporter.FAIL);
        }
        finally {
            WebUIUtils.isTriggerPopupSearchEvent4FreeTest = true;
        }
    }

    @Test
    @TestProperties(name = "select TopologyTree Node", paramsInclude = {"topologyTreeItemName"})
    public void selectTopologyTreeNode() {
        try {
            setDeviceName(topologyTreeItemName);
            if (!topologyTreeItemName.equals("") && topologyTreeItemName != null) {
                TopologyTreeHandler.findTreeElement(topologyTreeItemName);
                WebUITestBase.selectDeviceVersion(topologyTreeItemName);
            } else {
                BaseTestUtils.report("Failed to click on the tree element : " + topologyTreeItemName, Reporter.FAIL);
            }
        } catch (Exception e) {
            BaseTestUtils.report("Failed to click on the tree element : " + topologyTreeItemName, Reporter.FAIL);
        }
    }




    public TopologyTreeButtons getTopologyTreeButton() {
        return topologyTreeButton;
    }

    public void setTopologyTreeButton(TopologyTreeButtons topologyTreeButton) {
        this.topologyTreeButton = topologyTreeButton;
    }

    public String getTopologyTreeItemName() {
        return topologyTreeItemName;
    }

    public void setTopologyTreeItemName(String topologyTreeItemName) {
        this.topologyTreeItemName = topologyTreeItemName;
    }
}
