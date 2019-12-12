package com.radware.vision.infra.testhandlers.alteon.configuration.network.layer2.portTrunking;

import com.radware.automation.webui.webpages.configuration.network.layer2.portTrunking.staticTrunkGroups.StaticTrunkGroups;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 6/10/2015.
 */
public class StaticTrunkGroupsHandler extends BaseHandler {
    public static void addStaticTrunkGroup(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        StaticTrunkGroups staticTrunkGroups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTrunking().mStaticTrunkGroups();
        staticTrunkGroups.openPage();
        staticTrunkGroups.addStaticTrunkGroup();
        if (testProperties.get("StaticTrunkGroupState").equals("Enable")){staticTrunkGroups.enableStaticTrunkGroup();}
        if (testProperties.get("StaticTrunkGroupState").equals("Disable")){staticTrunkGroups.disableStaticTrunkGroup();}
        staticTrunkGroups.setTrunkGroupId(testProperties.get("TrunkGroupID"));
        staticTrunkGroups.setName(testProperties.get("StaticTrunkGroupName"));
        staticTrunkGroups.setTrafficContract(testProperties.get("TrafficContract"));
        staticTrunkGroups.selectPortId(testProperties.get("StaticTrunkGroupNamePorts"));
        staticTrunkGroups.submit();
    }



    public static void editStaticTrunkGroup(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        StaticTrunkGroups staticTrunkGroups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTrunking().mStaticTrunkGroups();
        staticTrunkGroups.openPage();
        staticTrunkGroups.editStaticTrunkGroup(testProperties.get("rowNumber"));
        if (testProperties.get("StaticTrunkGroupState").equals("Enable")){staticTrunkGroups.enableStaticTrunkGroup();}
        if (testProperties.get("StaticTrunkGroupState").equals("Disable")){staticTrunkGroups.disableStaticTrunkGroup();}
        staticTrunkGroups.setName(testProperties.get("StaticTrunkGroupName"));
        staticTrunkGroups.setTrafficContract(testProperties.get("TrafficContract"));
        staticTrunkGroups.selectPortId(testProperties.get("StaticTrunkGroupNamePorts"));
        if (testProperties.get("unSelectStaticTrunkGroupNamePorts") != null ||!testProperties.get("StaticTrunkGroupNamePorts").equals("")){
            staticTrunkGroups.unSelectPortId(testProperties.get("unSelectStaticTrunkGroupNamePorts"));
        }
        if (testProperties.get("StaticTrunkGroupNamePorts") != null || !testProperties.get("StaticTrunkGroupNamePorts").equals("")){
            staticTrunkGroups.selectPortId(testProperties.get("StaticTrunkGroupNamePorts"));
        }

        staticTrunkGroups.submit();
    }


    public static void duplicateStaticTrunkGroup(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        StaticTrunkGroups staticTrunkGroups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTrunking().mStaticTrunkGroups();
        staticTrunkGroups.openPage();
        staticTrunkGroups.duplicateStaticTrunkGroup(testProperties.get("rowNumber"));
        if (testProperties.get("StaticTrunkGroupState").equals("Enable")){staticTrunkGroups.enableStaticTrunkGroup();}
        if (testProperties.get("StaticTrunkGroupState").equals("Disable")){staticTrunkGroups.disableStaticTrunkGroup();}
        staticTrunkGroups.setTrunkGroupId(testProperties.get("TrunkGroupID"));
        staticTrunkGroups.setName(testProperties.get("StaticTrunkGroupName"));
        staticTrunkGroups.setTrafficContract(testProperties.get("TrafficContract"));
        if (testProperties.get("unSelectStaticTrunkGroupNamePorts") != null ||!testProperties.get("unSelectStaticTrunkGroupNamePorts").equals("")){
            staticTrunkGroups.unSelectPortId(testProperties.get("unSelectStaticTrunkGroupNamePorts"));
        }
        if (testProperties.get("StaticTrunkGroupNamePorts") != null || !testProperties.get("StaticTrunkGroupNamePorts").equals("")){
            staticTrunkGroups.selectPortId(testProperties.get("StaticTrunkGroupNamePorts"));
        }

        staticTrunkGroups.submit();
    }


    public static void delStaticTrunkGroup(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        StaticTrunkGroups staticTrunkGroups = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTrunking().mStaticTrunkGroups();
        staticTrunkGroups.openPage();
        staticTrunkGroups.delStaticTrunkGroup(testProperties.get("rowNumber"));
    }

}
