package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.exporter.history.last;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by ashrafa on 9/27/2017.
 */
public class Last extends Builder {

    public Last(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " last";
    }

}
