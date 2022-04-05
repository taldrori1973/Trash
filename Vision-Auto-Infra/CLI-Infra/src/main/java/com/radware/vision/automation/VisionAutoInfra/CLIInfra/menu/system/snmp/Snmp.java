package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.ntp.service.Service;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.community.Community;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.snmp.trap.Trap;

/**
 * Created by UriG on 12/22/2014.
 */
public class Snmp extends Builder{

    public Snmp(String prefix) {
        super(prefix);
    }

    public Community community(){
        return new Community(build());
    }

    public Service service(){
        return new Service(build());
    }

    public Trap trap(){
        return new Trap(build());
    }
    @Override
    public String getCommand() {
        return " snmp";
    }
}
