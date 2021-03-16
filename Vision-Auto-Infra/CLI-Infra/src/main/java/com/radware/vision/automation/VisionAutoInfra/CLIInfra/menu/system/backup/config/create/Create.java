package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.config.create;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by urig on 3/3/2016.
 */
public class Create extends Builder {

    public Create(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " create";
    }
}
