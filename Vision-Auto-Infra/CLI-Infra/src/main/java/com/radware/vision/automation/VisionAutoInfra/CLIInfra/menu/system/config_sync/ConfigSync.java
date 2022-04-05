package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.config_sync;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.config_sync.interval.Interval;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.config_sync.manual.Manual;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.config_sync.mode.Mode;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.config_sync.peer.Peer;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.config_sync.status.Status;

/**
 * Created by moaada on 4/9/2017.
 */
public class ConfigSync extends Builder {

    public ConfigSync(String prefix) {
        super(prefix);
    }

    public Interval interval(){return new Interval(build());}
    public Manual manual(){return  new Manual(build());}
    public Mode mode(){return new Mode (build());}
    public Peer peer(){return  new Peer(build());}
    public Status status(){return  new Status(build());}
    public String getCommand() {
        return " config-sync";
    }

}
