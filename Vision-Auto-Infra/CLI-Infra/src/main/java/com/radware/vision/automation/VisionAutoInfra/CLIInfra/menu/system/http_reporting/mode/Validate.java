package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.http_reporting.mode;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

public class Validate extends Builder {

    public Validate(String prefix) {
        super(prefix);
    }

    @Override
    public String getCommand() {
        return " validate";
    }
}
