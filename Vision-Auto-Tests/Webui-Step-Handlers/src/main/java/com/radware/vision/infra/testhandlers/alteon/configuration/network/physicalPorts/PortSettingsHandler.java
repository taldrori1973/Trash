package com.radware.vision.infra.testhandlers.alteon.configuration.network.physicalPorts;

import com.radware.automation.webui.webpages.configuration.network.phPorts.portSettings.PortSettings;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 6/8/2015.
 */
public class PortSettingsHandler extends BaseHandler {


    public static void editPortSettings(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortSettings portSettings = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mPhysicalPorts().mPortSettings();
        portSettings.openPage();
        portSettings.editPort(Integer.valueOf(testProperties.get("rowNumber")));
        if (testProperties.get("portState").equals("Enable")){portSettings.enablePort();}
        if (testProperties.get("portState").equals("Disable")){portSettings.disablePort();}

        portSettings.openPortSettingVirtecalTab();
        if (testProperties.get("ipForwarding").equals("Enable")){portSettings.enableIPForwarding(true);}
        if (testProperties.get("ipForwarding").equals("Disable")){portSettings.enableIPForwarding(false);}
        portSettings.setPortName(testProperties.get("portName"));
        portSettings.setPortAlias(testProperties.get("portAlias"));
        if (testProperties.get("vLANTagging").equals("Enable")){portSettings.enableVLANTagging(true);}
        if (testProperties.get("vLANTagging").equals("Disable")){portSettings.enableVLANTagging(false);}
        portSettings.setDefaultPortVLANID(testProperties.get("defaultPortVLANID"));
        if (testProperties.get("spanningTree").equals("Enable")){portSettings.enableSpanningTree(true);}
        if (testProperties.get("spanningTree").equals("Disable")){portSettings.enableSpanningTree(false);}

        portSettings.openBandwidthMangementVirtecalTab();
        portSettings.setTrafficContract(testProperties.get("trafficContract"));
       portSettings.setNonIpTrafficContract(testProperties.get("nonIpTrafficContract"));
        portSettings.setEgressLimit(testProperties.get("egressLimit"));

       portSettings.openAdvancedVirtecalTab();
        if (testProperties.get("nonIpTraffic").equals("Allow")){portSettings.allowNonIPTraffic(true);}
        if (testProperties.get("nonIpTraffic").equals("Deny")){portSettings.allowNonIPTraffic(false);}
        if (testProperties.get("linkUpDownTrap").equals("Send")){portSettings.setlinkUpDownTrap(true);}
        if (testProperties.get("linkUpDownTrap").equals("Do Not Send")){portSettings.setlinkUpDownTrap(false);}
        if (testProperties.get("RMON").equals("Enable")){portSettings.enableRMON(true);}
        if (testProperties.get("RMON").equals("Disable")){portSettings.enableRMON(false);}
        portSettings.submit();
    }

}
