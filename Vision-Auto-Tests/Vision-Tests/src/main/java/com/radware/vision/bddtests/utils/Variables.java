package com.radware.vision.bddtests.utils;

import com.radware.vision.automation.AutoUtils.SUT.dtos.TreeDeviceManagementDto;
import com.radware.vision.automation.base.TestBase;

import java.util.HashMap;
import java.util.Optional;

public class Variables extends TestBase {
    private static HashMap<String, String> variablesHash = new HashMap<>();

    public String getSUTValue(String variable) {
        if (variablesHash.containsKey(variable)) return variablesHash.get(variable);

        String value = "";

        if(variable.contains(":"))
        {
            String[] varSplit = variable.split(":", 2);
            switch (varSplit[0].toLowerCase())
            {
                case "setid": value=getSutManager().getTreeDeviceManagement(varSplit[1]).get().getManagementIp();break;
            }
        }
        else
        {
            switch (variable) {
                case "dfIP": value = getDfIP(); break;
                case "visionIP":  value = getVisionIP(); break;
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
}
