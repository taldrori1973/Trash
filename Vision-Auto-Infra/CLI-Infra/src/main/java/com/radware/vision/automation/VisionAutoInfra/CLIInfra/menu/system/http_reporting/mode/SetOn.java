package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.http_reporting.mode;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

public class SetOn extends Builder {

    public SetOn(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " set-on";
    }
}