package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.http_reporting;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;
import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.http_reporting.mode.Mode;

public class HttpReporting extends Builder {


    public HttpReporting(String prefix) {
        super(prefix);
    }

    public Mode mode(){
        return new Mode(build());
    }

    @Override
    public String getCommand() {
        return " http-reporting";
    }
}
