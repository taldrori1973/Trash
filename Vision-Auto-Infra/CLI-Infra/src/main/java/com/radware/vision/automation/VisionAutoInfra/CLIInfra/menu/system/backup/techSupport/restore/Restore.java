package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.techSupport.restore;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by urig on 3/3/2016.
 */
public class Restore extends Builder {

    public Restore(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " restore";
    }
}
