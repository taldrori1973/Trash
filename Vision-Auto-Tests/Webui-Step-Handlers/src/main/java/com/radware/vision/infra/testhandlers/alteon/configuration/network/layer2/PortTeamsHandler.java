package com.radware.vision.infra.testhandlers.alteon.configuration.network.layer2;

import com.radware.automation.webui.webpages.configuration.network.layer2.portTeams.PortTeams;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 6/10/2015.
 */
public class PortTeamsHandler extends BaseHandler {
    public static void addPortTeam(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortTeams portTeams = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTeams();
        portTeams.openPage();
        portTeams.addPortTeams();
        if (testProperties.get("PortTeamState").equals("Enable")){portTeams.enablePortTeam();}
        if (testProperties.get("PortTeamState").equals("Disable")){portTeams.disablePortTeam();}
        portTeams.setPortTeamId(testProperties.get("PortId"));
        portTeams.setName(testProperties.get("PortName"));
        if (testProperties.get("Ports") != null || !testProperties.get("Ports").equals("")){
            portTeams.selectPorts(testProperties.get("Ports"));
        }
        if (testProperties.get("Trunks") != null || !testProperties.get("Trunks").equals("")){
            portTeams.selectTrunks(testProperties.get("Trunks"));
        }
        portTeams.submit();

    }



    public static void editPortTeam(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortTeams portTeams = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTeams();
        portTeams.openPage();
        portTeams.editPortTeams(testProperties.get("rowNumber"));
        if (testProperties.get("PortTeamState").equals("Enable")){portTeams.enablePortTeam();}
        if (testProperties.get("PortTeamState").equals("Disable")){portTeams.disablePortTeam();}
        portTeams.setName(testProperties.get("PortName"));
        if (testProperties.get("unSelectPorts") != null ||!testProperties.get("unSelectPorts").equals("")){
            portTeams.unSelectPorts(testProperties.get("unSelectPorts"));
        }
        if (testProperties.get("Ports") != null || !testProperties.get("Ports").equals("")){
            portTeams.selectPorts(testProperties.get("Ports"));
        }
        if (testProperties.get("unSelectTrunks") != null ||!testProperties.get("unSelectTrunks").equals("")){
            portTeams.unSelectTrunks(testProperties.get("unSelectTrunks"));
        }
        if (testProperties.get("Trunks") != null || !testProperties.get("Trunks").equals("")){
            portTeams.selectTrunks(testProperties.get("Trunks"));
        }

        portTeams.submit();

    }




    public static void duplicatePortTeam(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortTeams portTeams = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTeams();
        portTeams.openPage();
        portTeams.duplicatePortTeams(testProperties.get("rowNumber"));
        if (testProperties.get("PortTeamState").equals("Enable")){portTeams.enablePortTeam();}
        if (testProperties.get("PortTeamState").equals("Disable")){portTeams.disablePortTeam();}
        portTeams.setPortTeamId(testProperties.get("PortId"));
        portTeams.setName(testProperties.get("PortName"));
        if (testProperties.get("unSelectPorts") != null ||!testProperties.get("unSelectPorts").equals("")){
            portTeams.unSelectPorts(testProperties.get("unSelectPorts"));
        }
        if (testProperties.get("Ports") != null || !testProperties.get("Ports").equals("")){
            portTeams.selectPorts(testProperties.get("Ports"));
        }
        if (testProperties.get("unSelectTrunks") != null ||!testProperties.get("unSelectTrunks").equals("")){
            portTeams.unSelectTrunks(testProperties.get("unSelectTrunks"));
        }
        if (testProperties.get("Trunks") != null || !testProperties.get("Trunks").equals("")){
            portTeams.selectTrunks(testProperties.get("Trunks"));
        }

        portTeams.submit();


    }
    public static void delPortTeam(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortTeams portTeams = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mLayer2().mPortTeams();
        portTeams.openPage();
        portTeams.deletePortTeams(testProperties.get("rowNumber"));

    }
}

