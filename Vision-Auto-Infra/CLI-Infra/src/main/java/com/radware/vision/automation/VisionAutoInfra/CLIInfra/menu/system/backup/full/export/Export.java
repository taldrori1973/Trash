package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full.export;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by urig on 3/3/2016.
 */
public class Export extends Builder {

    public Export(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " export";
    }
}
