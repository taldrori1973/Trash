package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.common;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

/**
 * Created by ashrafa on 9/26/2017.
 */
public class Enable extends Builder {
    public Enable(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " enable";
    }
}
