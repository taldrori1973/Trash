package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.config_sync.manual;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by moaada on 4/23/2017.
 */
public class Manual extends Builder {

    public Manual(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " manual";
    }


}
