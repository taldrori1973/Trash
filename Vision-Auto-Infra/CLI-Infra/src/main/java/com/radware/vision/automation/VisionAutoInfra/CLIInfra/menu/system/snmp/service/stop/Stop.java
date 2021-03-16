package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.service.stop;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by UriG on 12/22/2014.
 */
public class Stop extends Builder {

    public Stop(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " stop";
    }
}
