package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.service.status;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by UriG on 12/22/2014.
 */
public class Status extends Builder {

    public Status(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " status";
    }
}
