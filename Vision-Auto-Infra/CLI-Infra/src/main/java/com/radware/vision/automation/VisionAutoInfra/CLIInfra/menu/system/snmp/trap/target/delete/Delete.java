package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.trap.target.delete;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by UriG on 12/22/2014.
 */
public class Delete extends Builder {
    public Delete(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " delete";
    }
}
