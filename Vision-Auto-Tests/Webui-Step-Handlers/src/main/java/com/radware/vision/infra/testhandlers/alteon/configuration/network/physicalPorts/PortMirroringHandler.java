package com.radware.vision.infra.testhandlers.alteon.configuration.network.physicalPorts;

import com.radware.automation.webui.webpages.configuration.network.phPorts.portMirroring.PortMirroring;
import com.radware.vision.infra.testhandlers.BaseHandler;
import com.radware.vision.infra.utils.DeviceVisionWebUIUtils;

import java.util.HashMap;

/**
 * Created by vadyms on 6/9/2015.
 */
public class PortMirroringHandler extends BaseHandler {
    public static void addPortMirroring(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortMirroring portMirroring = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mPhysicalPorts().mPortMirroring();
        portMirroring.openPage();
        if (testProperties.get("PortMirroring").equals("Enable")){portMirroring.enablePortMirroring();}
        if (testProperties.get("PortMirroring").equals("Disable")){portMirroring.disablePortMirroring();}
        portMirroring.addPortMirroring();
        portMirroring.setMonitoringPort(testProperties.get("MonitoringPort"));
        portMirroring.setMirroredPort(testProperties.get("MirroredPort"));
        portMirroring.setTrafficDirection(testProperties.get("TrafficDirection"));
        portMirroring.selectVLAN(testProperties.get("VLANs"));
        portMirroring.submit();
    }



    public static void editPortMirroring(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortMirroring portMirroring = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mPhysicalPorts().mPortMirroring();
        portMirroring.openPage();
        if (testProperties.get("PortMirroring").equals("Enable")){portMirroring.enablePortMirroring();}
        if (testProperties.get("PortMirroring").equals("Disable")){portMirroring.disablePortMirroring();}
        portMirroring.editPortMirroring(testProperties.get("rowNumber"));
        portMirroring.setTrafficDirection(testProperties.get("TrafficDirection"));
        portMirroring.selectVLAN(testProperties.get("VLANs"));
        portMirroring.submit();
    }
    public static void duplicatePortMirroring(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortMirroring portMirroring = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mPhysicalPorts().mPortMirroring();
        portMirroring.openPage();
        if (testProperties.get("PortMirroring").equals("Enable")){portMirroring.enablePortMirroring();}
        if (testProperties.get("PortMirroring").equals("Disable")){portMirroring.disablePortMirroring();}
        portMirroring.duplicatePortMirroring(testProperties.get("rowNumber"));
        portMirroring.setMonitoringPort(testProperties.get("MonitoringPort"));
        portMirroring.setMirroredPort(testProperties.get("MirroredPort"));
        portMirroring.setTrafficDirection(testProperties.get("TrafficDirection"));
        portMirroring.selectVLAN(testProperties.get("VLANs"));
        portMirroring.submit();
    }
    public static void delPortMirroring(HashMap<String, String> testProperties) {
        initLockDevice(testProperties);
        PortMirroring portMirroring = DeviceVisionWebUIUtils.alteonUtils.alteonProduct.mConfiguration().mNetwork().mPhysicalPorts().mPortMirroring();
        portMirroring.openPage();
        portMirroring.deletePortMirroring(testProperties.get("rowNumber"));
        portMirroring.submit();
    }

}
