package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full.import_;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by urig on 3/3/2016.
 */
public class Import extends Builder {

    public Import(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " import";
    }
}
