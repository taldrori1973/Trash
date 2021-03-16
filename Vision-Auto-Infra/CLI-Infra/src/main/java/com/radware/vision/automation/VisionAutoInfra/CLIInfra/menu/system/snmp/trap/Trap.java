package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.trap;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.trap.target.Target;

/**
 * Created by UriG on 12/22/2014.
 */
public class Trap extends Builder {

    public Trap(String prefix) {
        super(prefix);
    }

    public Target target() {
        return new Target(build());
    }

    @Override
    public String getCommand() {
        return " trap";
    }
}
