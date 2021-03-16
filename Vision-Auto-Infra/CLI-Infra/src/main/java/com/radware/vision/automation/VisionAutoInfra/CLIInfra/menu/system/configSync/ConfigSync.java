package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.configSync;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.configSync.Interval.Interval;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.configSync.Manual.Manual;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.configSync.Mode.Mode;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.configSync.Peer.Peer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.configSync.Status.Status;

/**
 * Created by ashrafa on 4/9/2017.
 */
public class ConfigSync extends Builder {

    public ConfigSync(String prefix) {
        super(prefix);
    }
    
    public Peer peer() {
        return new Peer(build());
    }
    public Mode mode() {
        return new Mode(build());
    }
    public Interval interval() {
        return new Interval(build());
    }
    public Manual manual(){ return new Manual(build()); }
    public Status status(){ return new Status(build()); }

    public Get get(){
        return new Get(build());
    }

    public Set set(){
        return new Set(build());
    }

    @Override
    public String getCommand() {
        return " config-sync";
    }
}
