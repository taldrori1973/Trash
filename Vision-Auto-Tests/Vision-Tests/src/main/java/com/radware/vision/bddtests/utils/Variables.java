package com.radware.vision.bddtests.utils;

import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.Servers.LinuxFileServer;
import com.radware.vision.automation.base.TestBase;
import org.apache.commons.jexl3.JxltEngine;
import org.apache.uima.cas.CASException;

import java.util.HashMap;
import java.util.Locale;
import java.util.Optional;

public class Variables extends TestBase {
    private static HashMap<String, String> variablesHash = new HashMap<>();

    public String getSUTValue(String variable) {
        if (variablesHash.containsKey(variable)) return variablesHash.get(variable);

        String value = "";

        if (variable.contains(":")) {
            String[] varSplit = variable.split(":", 2);
            switch (varSplit[0].toLowerCase()) {
                case "setid":
                    value = getSutManager().getTreeDeviceManagement(varSplit[1]).get().getManagementIp();
                    break;
                case "generic_linux_server":
                    value= getGenericLinuxServer(varSplit[1]);
            }
        } else {
            switch (variable) {
                case "dfIP":
                    value = getDfIP();
                    break;
                case "visionIP":
                    value = getVisionIP();
                    break;
            }
        }

        variablesHash.put(variable, value);

        return value;
    }

    private static String getDfIP() {
        Optional<TreeDeviceManagementDto> df = sutManager.getDefenseFlow();

        if (df != null && df.isPresent())
            return df.get().getManagementIp();

        return "NO_DFIP";
    }

    private static String getVisionIP() {
        return clientConfigurations.getHostIp();
    }

    private static String getGenericLinuxServer(String info) {
        LinuxFileServer genericLinuxServer=getServersManagement().getLinuxFileServer().get();
        switch (info.toLowerCase()) {
            case "password":
                return genericLinuxServer.getPassword();
            case "username":
                return genericLinuxServer.getUser();
            case "ip":
                return genericLinuxServer.getHost();
        }
        try {
            throw new Exception(String.format("can't find the %s from GenericLinuxServer",info));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
