package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.configSync.Manual;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by ashrafa on 4/25/2017.
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
