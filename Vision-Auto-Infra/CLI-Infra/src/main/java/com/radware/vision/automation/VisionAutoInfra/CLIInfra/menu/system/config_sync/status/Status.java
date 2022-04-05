package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.config_sync.status;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by moaada on 4/23/2017.
 */
public class Status extends Builder {

    public Status(String prefix){
        super(prefix);

    }
    @Override
    public String getCommand() {
        return " status";
    }
}
