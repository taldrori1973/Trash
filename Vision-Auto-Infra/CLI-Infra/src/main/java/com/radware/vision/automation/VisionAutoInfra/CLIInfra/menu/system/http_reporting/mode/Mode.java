package com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.system.http_reporting.mode;

import com.radware.vision.automation.VisionAutoInfra.CLIInfra.menu.Builder;

public class Mode extends Builder {
    public Mode(String prefix) {
        super(prefix);
    }

    public Get get() {return new Get(build());}

    public SetOn setOn() {return new SetOn(build());}

    public Validate validate() {return new Validate(build());}

    @Override
    public String getCommand() {
        return " mode";
    }
}
