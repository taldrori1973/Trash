package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.config_sync.peer;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Get;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common.Set;

/**
 * Created by moaada on 4/13/2017.
 */
public class Peer extends Builder {


    public Peer(String prefix) {
        super(prefix);
    }

    public Set set() {

        return new Set(build());
    }

    public Get get() {
        return new Get(build());
    }

    @Override
    public String getCommand() {
        return " peer";
    }
}
