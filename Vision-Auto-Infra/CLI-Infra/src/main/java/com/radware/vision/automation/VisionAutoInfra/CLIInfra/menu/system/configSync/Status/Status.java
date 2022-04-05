package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.configSync.Status;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by ashrafa on 4/25/2017.
 */
public class Status extends Builder {
    public Status(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " status";
    }
}
