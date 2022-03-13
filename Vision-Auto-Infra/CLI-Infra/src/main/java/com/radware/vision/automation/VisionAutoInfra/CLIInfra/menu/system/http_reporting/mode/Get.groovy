package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.http_reporting.mode

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder

class Get extends Builder {

    Get(String prefix) {
        super(prefix)
    }

    @Override
    String getCommand() {
        return " get";
    }
}
