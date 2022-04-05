package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.full.info;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by urig on 3/3/2016.
 */
public class Info extends Builder {

    public Info(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " info";
    }
}
