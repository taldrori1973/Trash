package com.radware.vision.infra.testhandlers.rbac.configuration.network;

import com.radware.automation.webui.webpages.configuration.network.layer2.portTeams.PortTeams;
import com.radware.automation.webui.webpages.configuration.network.layer2.portTrunking.lacpGroup.LACPGroup;
import com.radware.automation.webui.webpages.configuration.network.layer2.portTrunking.staticTrunkGroups.StaticTrunkGroups;
import com.radware.automation.webui.webpages.configuration.network.layer2.spanningTree.spanningTreeGroup.SpanningTreeGroup;
import com.radware.automation.webui.webpages.configuration.network.layer2.vlan.Vlan;
import com.radware.automation.webui.widgets.impl.table.WebUITable;
import com.radware.vision.infra.testhandlers.rbac.RBACHandlerBase;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by stanislava on 9/18/2014.
 */
public class RBACAlteonLayer2TableActionHandler extends RBACHandlerBase {
    public static boolean verifyStaticTrunkGroupsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        StaticTrunkGroups staticTrunkGroups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTrunking().mStaticTrunkGroups();
        staticTrunkGroups.openPage();

        WebUITable table = staticTrunkGroups.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("staticTrunkGroupsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyLACPGroupTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        LACPGroup lacpGroup = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTrunking().mLACPGroup();
        lacpGroup.openPage();

        WebUITable table = lacpGroup.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("lacpGroupTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyPortTeamsTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortTeams portTeams = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTeams();
        portTeams.openPage();

        WebUITable table = portTeams.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("portTeamsTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifyVLANTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        Vlan vlan = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mVlan();
        vlan.openPage();

        WebUITable table = vlan.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("vlanTableAction"), expectedResultRBAC);
        return result;
    }

    public static boolean verifySpanningTreeGroupTableAction(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        SpanningTreeGroup spanningTreeGroup = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mSpanningTree().mSpanningTreeGroup();
        spanningTreeGroup.openPage();

        WebUITable table = spanningTreeGroup.getTable();

        clickOnRowIfRequired(table, testProperties);
        boolean result = table.isTableActionDisabled(testProperties.get("spanningTreeGroupTableAction"), expectedResultRBAC);
        return result;
    }

}
