package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.trap.target.add;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by UriG on 12/22/2014.
 */
public class Add extends Builder {
    public Add(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " add";
    }
}
