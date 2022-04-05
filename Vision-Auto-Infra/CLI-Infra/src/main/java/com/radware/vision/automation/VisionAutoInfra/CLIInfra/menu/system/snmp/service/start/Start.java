package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.service.start;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by UriG on 12/22/2014.
 */
public class Start extends Builder {
    public Start(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " start";
    }

}
