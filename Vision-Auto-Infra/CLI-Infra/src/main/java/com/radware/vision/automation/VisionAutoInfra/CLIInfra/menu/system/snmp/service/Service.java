package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.service;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.service.start.Start;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.service.status.Status;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.service.stop.Stop;

/**
 * Created by UriG on 12/22/2014.
 */
public class Service extends Builder {

    public Service(String prefix) {
        super(prefix);
    }

    public Start start() {
        return new Start(build());
    }

    public Status status() {
        return new Status(build());
    }

    public Stop stop() {
        return new Stop(build());
    }

    @Override
    public String getCommand() {
        return " service";
    }

}
