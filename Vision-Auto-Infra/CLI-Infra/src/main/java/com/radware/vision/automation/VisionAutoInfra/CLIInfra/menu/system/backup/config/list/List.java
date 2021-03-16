package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.backup.config.list;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by urig on 3/3/2016.
 */
public class List extends Builder {

    public List(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " list";
    }
}
