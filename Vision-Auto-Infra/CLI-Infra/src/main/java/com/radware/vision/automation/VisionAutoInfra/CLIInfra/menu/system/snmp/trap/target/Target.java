package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.trap.target;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Delete;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.List;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.trap.target.add.Add;


/**
 * Created by UriG on 12/22/2014.
 */
public class Target extends Builder {
    public Target(String prefix) {
        super(prefix);
    }

    public Add add() {
        return new Add(build());
    }

    public Delete delete() {
        return new Delete(build());
    }

    public List list() {
        return new List(build());
    }

    @Override
    public String getCommand() {
        return " target";
    }
}
